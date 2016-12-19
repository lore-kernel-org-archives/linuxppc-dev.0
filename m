Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj8cR4yjnzDwPb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:30:47 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id b1so9172695pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 10:30:47 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 09/10] powerpc/pseries: implement NMI IPI with
 H_SIGNAL_SYS_RESET
Date: Tue, 20 Dec 2016 04:30:10 +1000
Message-Id: <20161219183011.28310-10-npiggin@gmail.com>
In-Reply-To: <20161219183011.28310-1-npiggin@gmail.com>
References: <20161219183011.28310-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/pseries/ras.c |  4 ++++
 arch/powerpc/platforms/pseries/smp.c | 23 ++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 904a677208d1..bb70b26334f0 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -386,6 +386,10 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
 		}
 		fwnmi_release_errinfo();
 	}
+
+	if (smp_handle_nmi_ipi(regs))
+		return 1;
+
 	return 0; /* need to perform reset */
 }
 
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 0f6522c6518b..fac59c212bc4 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -196,6 +196,27 @@ static void pSeries_cause_ipi_mux(int cpu, unsigned long data)
 		xics_cause_ipi(cpu, data);
 }
 
+static int pseries_cause_nmi_ipi(int cpu)
+{
+	int hwcpu;
+
+	if (cpu == NMI_IPI_ALL_OTHERS) {
+		hwcpu = H_SIGNAL_SYS_RESET_ALL_OTHERS;
+	} else {
+		if (cpu < 0) {
+			WARN_ONCE(true, "incorrect cpu parameter %d", cpu);
+			return 0;
+		}
+
+		hwcpu = get_hard_smp_processor_id(cpu);
+	}
+
+	if (plapr_signal_sys_reset(hwcpu) == H_SUCCESS)
+		return 1;
+
+	return 0;
+}
+
 static __init void pSeries_smp_probe(void)
 {
 	xics_smp_probe();
@@ -209,7 +230,7 @@ static __init void pSeries_smp_probe(void)
 static struct smp_ops_t pseries_smp_ops = {
 	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= NULL,	/* Filled at runtime by pSeries_smp_probe() */
-	.cause_nmi_ipi	= NULL,
+	.cause_nmi_ipi	= pseries_cause_nmi_ipi,
 	.probe		= pSeries_smp_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_setup_cpu,
-- 
2.11.0
