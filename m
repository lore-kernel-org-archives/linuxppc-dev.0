Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 869A61A0140
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 22:37:52 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 12 Dec 2014 11:37:48 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 29ECE17D8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 11:38:09 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBCBbkNf61014114
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 11:37:46 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBCBbi5M015694
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 04:37:45 -0700
Subject: [PATCH] powerpc/powernv: force all CPUs to be bootable
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Dec 2014 12:37:40 +0100
Message-ID: <20141212113627.12778.47915.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The subcore logic needs all the CPUs declared in the DT to be bootable,
otherwise the kernel hangs at boot time. Since subcore support starts
with POWER8, we can keep the current behaviour for older CPUs.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---

Since smt-enabled is still needed by Freescale, the choice was made to fix
powernv only. I could test that smt-enabled is still honored on POWER7 and
ignored on POWER8, as expected.

 arch/powerpc/platforms/powernv/smp.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index b716f66..5b6e002 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -198,13 +198,24 @@ static void pnv_smp_cpu_kill_self(void)
 
 #endif /* CONFIG_HOTPLUG_CPU */
 
+static int pnv_cpu_bootable(unsigned int nr)
+{
+	/* Starting with POWER8, all CPUs need to be booted to avoid hangs
+	 * during subcore init.
+	 */
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		return 1;
+
+	return smp_generic_cpu_bootable(nr);
+}
+
 static struct smp_ops_t pnv_smp_ops = {
 	.message_pass	= smp_muxed_ipi_message_pass,
 	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
 	.probe		= xics_smp_probe,
 	.kick_cpu	= pnv_smp_kick_cpu,
 	.setup_cpu	= pnv_smp_setup_cpu,
-	.cpu_bootable	= smp_generic_cpu_bootable,
+	.cpu_bootable	= pnv_cpu_bootable,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_disable	= pnv_smp_cpu_disable,
 	.cpu_die	= generic_cpu_die,
