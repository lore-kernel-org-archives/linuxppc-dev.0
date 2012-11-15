Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B55B62C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:50:06 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Nov 2012 14:45:01 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAF4daY536831480
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:39:37 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAF4o0Xg029746
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:50:00 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 7/7] powerpc: Hook up doorbells on server
Date: Thu, 15 Nov 2012 15:49:50 +1100
Message-Id: <1352954990-2858-8-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1352954990-2858-1-git-send-email-imunsie@au1.ibm.com>
References: <1352954990-2858-1-git-send-email-imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch actually hooks up doorbell interrupts on POWER8:

- Select the PPC_DOORBELL Kconfig option from PPC_PSERIES

- Add the doorbell CPU feature bit to POWER8

- We define a new pSeries_cause_ipi_mux() function that issues a
  doorbell interrupt if the recipient is another thread within the same
  core as the sender. If the recipient is in a different core it falls
  back to using XICS to deliver the IPI as before.

- During pSeries_smp_probe() at boot, we check if doorbell interrupts
  are supported. If they are we set the cause_ipi function pointer to
  the above mentioned function, otherwise we leave it as whichever XICS
  cause_ipi function was determined by xics_smp_probe().

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Tested-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/cputable.h    |    3 ++-
 arch/powerpc/platforms/pseries/Kconfig |    1 +
 arch/powerpc/platforms/pseries/smp.c   |   33 ++++++++++++++++++++++++++++++--
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 76f81bd..fc4d2c5 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -408,7 +408,8 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY)
+	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
+	    CPU_FTR_DBELL)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 837cf49..9a0941b 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -17,6 +17,7 @@ config PPC_PSERIES
 	select PPC_NATIVE
 	select PPC_PCI_CHOICE if EXPERT
 	select ZLIB_DEFLATE
+	select PPC_DOORBELL
 	default y
 
 config PPC_SPLPAR
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 9fc0a49..32c82c2 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -42,6 +42,7 @@
 #include <asm/vdso_datapage.h>
 #include <asm/cputhreads.h>
 #include <asm/xics.h>
+#include <asm/dbell.h>
 
 #include "plpar_wrappers.h"
 #include "pseries.h"
@@ -54,6 +55,11 @@
  */
 static cpumask_var_t of_spin_mask;
 
+/*
+ * If we multiplex IPI mechanisms, store the appropriate XICS IPI mechanism here
+ */
+static void  (*xics_cause_ipi)(int cpu, unsigned long data);
+
 /* Query where a cpu is now.  Return codes #defined in plpar_wrappers.h */
 int smp_query_cpu_stopped(unsigned int pcpu)
 {
@@ -137,6 +143,8 @@ static void __devinit smp_xics_setup_cpu(int cpu)
 {
 	if (cpu != boot_cpuid)
 		xics_setup_cpu();
+	if (cpu_has_feature(CPU_FTR_DBELL))
+		doorbell_setup_this_cpu();
 
 	if (firmware_has_feature(FW_FEATURE_SPLPAR))
 		vpa_init(cpu);
@@ -195,6 +203,27 @@ static int smp_pSeries_cpu_bootable(unsigned int nr)
 	return 1;
 }
 
+/* Only used on systems that support multiple IPI mechanisms */
+static void pSeries_cause_ipi_mux(int cpu, unsigned long data)
+{
+	if (cpumask_test_cpu(cpu, cpu_sibling_mask(smp_processor_id())))
+		doorbell_cause_ipi(cpu, data);
+	else
+		xics_cause_ipi(cpu, data);
+}
+
+static __init int pSeries_smp_probe(void)
+{
+	int ret = xics_smp_probe();
+
+	if (cpu_has_feature(CPU_FTR_DBELL)) {
+		xics_cause_ipi = smp_ops->cause_ipi;
+		smp_ops->cause_ipi = pSeries_cause_ipi_mux;
+	}
+
+	return ret;
+}
+
 static struct smp_ops_t pSeries_mpic_smp_ops = {
 	.message_pass	= smp_mpic_message_pass,
 	.probe		= smp_mpic_probe,
@@ -204,8 +233,8 @@ static struct smp_ops_t pSeries_mpic_smp_ops = {
 
 static struct smp_ops_t pSeries_xics_smp_ops = {
 	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
-	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
-	.probe		= xics_smp_probe,
+	.cause_ipi	= NULL,	/* Filled at runtime by pSeries_smp_probe() */
+	.probe		= pSeries_smp_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_xics_setup_cpu,
 	.cpu_bootable	= smp_pSeries_cpu_bootable,
-- 
1.7.10.4
