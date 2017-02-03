Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vF4w116dTzDqBg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 16:21:04 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id f144so770828pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Feb 2017 21:21:04 -0800 (PST)
Date: Fri, 3 Feb 2017 15:20:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH] powerpc/powernv: implement NMI IPI with
 OPAL_SIGNAL_SYSTEM_RESET
Message-ID: <20170203152048.2d6bee4a@roar.ozlabs.ibm.com>
In-Reply-To: <20170202142511.14158-1-npiggin@gmail.com>
References: <20170202142511.14158-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  3 Feb 2017 00:25:11 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> This goes with the previous NMI IPI series, and a new version of
> Alistair's opal API I posted to the skiboot list.

And here is the incremental bit that is required for Alistair's
hardware implementation to work.

If the opal broacast call fails with OPAL_PARTIAL, then we designate
a bouncer CPU on another core to send NMI IPIs back to our sibling
threads.

Probably needs more discussion and testing about how to detect and
handle failure cases and future compatibility for different types of
restrictions, but at least it works in mambo.

Of course the other option rather than doing this in Linux is call
into opal in the system reset handler and have it do the bouncing.
Something to consider before we finalise the API.

Thanks,
Nick

---
 arch/powerpc/platforms/powernv/smp.c | 88 +++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index f90555f75723..4241fda9df9e 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -241,8 +241,32 @@ static int pnv_cpu_bootable(unsigned int nr)
 	return smp_generic_cpu_bootable(nr);
 }
 
+static int nmi_ipi_bounce_cpu;
+static int nmi_ipi_bounce_cpu_done;
+static int nmi_ipi_bounce_target_core;
+static int nmi_ipi_bounce_target_exclude;
+
 int pnv_system_reset_exception(struct pt_regs *regs)
 {
+	smp_rmb();
+	if (nmi_ipi_bounce_cpu == smp_processor_id()) {
+		int64_t rc;
+		int c;
+
+		for_each_online_cpu(c) {
+			if (!cpumask_test_cpu(c, cpu_sibling_mask(nmi_ipi_bounce_target_core)))
+				continue;
+			if (c == nmi_ipi_bounce_target_exclude)
+				continue;
+			rc = opal_signal_system_reset(c);
+			if (rc != OPAL_SUCCESS) {
+				nmi_ipi_bounce_cpu_done = -1;
+				return 1;
+			}
+		}
+		nmi_ipi_bounce_cpu_done = 1;
+	}
+
 	if (smp_handle_nmi_ipi(regs))
 		return 1;
 	return 0;
@@ -252,13 +276,65 @@ static int pnv_cause_nmi_ipi(int cpu)
 {
 	int64_t rc;
 
-	rc = opal_signal_system_reset(cpu);
-	if (rc == OPAL_SUCCESS)
-		return 1;
+	if (cpu >= 0) {
+		rc = opal_signal_system_reset(cpu);
+		if (rc == OPAL_SUCCESS)
+			return 1;
+	} else {
+		/*
+		 * Test bounce behavior with broadcast IPI.
+		 */
+		rc = OPAL_PARTIAL;
+	}
+	if (rc == OPAL_PARTIAL) {
+		int c;
 
-	/*
-	 * Don't cope with OPAL_PARTIAL yet (just punt to regular IPI)
-	 */
+		/*
+		 * Some platforms can not send NMI to sibling threads in
+		 * the same core. We can designate one inter-core target
+		 * to bounce NMIs back to our sibling threads.
+		 */
+
+		if (cpu >= 0) {
+			/*
+			 * Don't support bouncing unicast NMIs yet (because
+			 * that would have to raise an NMI on an unrelated
+			 * CPU. Revisit this if callers start using unicast.
+			 */
+			return 0;
+		}
+
+		nmi_ipi_bounce_cpu = -1;
+		nmi_ipi_bounce_cpu_done = 0;
+		nmi_ipi_bounce_target_core = -1;
+		nmi_ipi_bounce_target_exclude = -1;
+		smp_wmb();
+
+		for_each_online_cpu(c) {
+			if (cpumask_test_cpu(c, cpu_sibling_mask(smp_processor_id())))
+				continue;
+
+			if (nmi_ipi_bounce_cpu == -1) {
+				nmi_ipi_bounce_cpu = c;
+				nmi_ipi_bounce_target_core = smp_processor_id();
+				if (cpu == NMI_IPI_ALL_OTHERS)
+					nmi_ipi_bounce_target_exclude = smp_processor_id();
+			}
+
+			rc = opal_signal_system_reset(c);
+			if (rc != OPAL_SUCCESS)
+				return 0;
+		}
+
+		if (nmi_ipi_bounce_cpu == -1)
+			return 0; /* could not find a bouncer */
+
+		while (!nmi_ipi_bounce_cpu_done)
+			cpu_relax();
+
+		if (nmi_ipi_bounce_cpu_done == 1)
+			return 1; /* bounce worked */
+	}
 
 	return 0;
 }
-- 
2.11.0
