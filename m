Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Rename 64-bit PVR constants to PVR_foo
Date: Mon, 20 Aug 2012 17:44:01 +1000
Message-Id: <1345448641-16222-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have an old FIXME in reg.h which points out that we should standardise
on PVR_foo for our PVR #defines. Currently we use PVR_ on 32-bit and PV_
on 64-bit.

So do that rename and remove the FIXME.

Seeing as we're touching all but one usage of __is_processor(), rename it
to something less ugly and more indicative of what it does, which is
simply to check the PVR version.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/reg.h          |   39 +++++++++++++++----------------
 arch/powerpc/kernel/prom_init.c         |    2 +-
 arch/powerpc/oprofile/op_model_power4.c |   16 ++++++-------
 arch/powerpc/perf/core-book3s.c         |    2 +-
 drivers/scsi/ipr.c                      |   18 +++++++-------
 5 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 6386086..43bb15f 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -937,7 +937,7 @@
 #define PVR_VER(pvr)	(((pvr) >>  16) & 0xFFFF)	/* Version field */
 #define PVR_REV(pvr)	(((pvr) >>   0) & 0xFFFF)	/* Revison field */
 
-#define __is_processor(pv)	(PVR_VER(mfspr(SPRN_PVR)) == (pv))
+#define pvr_version_is(pvr)	(PVR_VER(mfspr(SPRN_PVR)) == (pvr))
 
 /*
  * IBM has further subdivided the standard PowerPC 16-bit version and
@@ -1002,25 +1002,24 @@
 #define PVR_476_ISS	0x00052000
 
 /* 64-bit processors */
-/* XXX the prefix should be PVR_, we'll do a global sweep to fix it one day */
-#define PV_NORTHSTAR	0x0033
-#define PV_PULSAR	0x0034
-#define PV_POWER4	0x0035
-#define PV_ICESTAR	0x0036
-#define PV_SSTAR	0x0037
-#define PV_POWER4p	0x0038
-#define PV_970		0x0039
-#define PV_POWER5	0x003A
-#define PV_POWER5p	0x003B
-#define PV_970FX	0x003C
-#define PV_POWER6	0x003E
-#define PV_POWER7	0x003F
-#define PV_630		0x0040
-#define PV_630p	0x0041
-#define PV_970MP	0x0044
-#define PV_970GX	0x0045
-#define PV_BE		0x0070
-#define PV_PA6T		0x0090
+#define PVR_NORTHSTAR	0x0033
+#define PVR_PULSAR	0x0034
+#define PVR_POWER4	0x0035
+#define PVR_ICESTAR	0x0036
+#define PVR_SSTAR	0x0037
+#define PVR_POWER4p	0x0038
+#define PVR_970		0x0039
+#define PVR_POWER5	0x003A
+#define PVR_POWER5p	0x003B
+#define PVR_970FX	0x003C
+#define PVR_POWER6	0x003E
+#define PVR_POWER7	0x003F
+#define PVR_630		0x0040
+#define PVR_630p	0x0041
+#define PVR_970MP	0x0044
+#define PVR_970GX	0x0045
+#define PVR_BE		0x0070
+#define PVR_PA6T	0x0090
 
 /* Macros for setting and retrieving special purpose registers */
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 0794a30..ce68278 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1691,7 +1691,7 @@ static void __init prom_initialize_tce_table(void)
 		 * else will impact performance, so we always allocate 8MB.
 		 * Anton
 		 */
-		if (__is_processor(PV_POWER4) || __is_processor(PV_POWER4p))
+		if (pvr_version_is(PVR_POWER4) || pvr_version_is(PVR_POWER4p))
 			minsize = 8UL << 20;
 		else
 			minsize = 4UL << 20;
diff --git a/arch/powerpc/oprofile/op_model_power4.c b/arch/powerpc/oprofile/op_model_power4.c
index 95ae77d..caffffa 100644
--- a/arch/powerpc/oprofile/op_model_power4.c
+++ b/arch/powerpc/oprofile/op_model_power4.c
@@ -61,10 +61,10 @@ static int power4_reg_setup(struct op_counter_config *ctr,
 	else
 		mmcr0_val |= MMCR0_PROBLEM_DISABLE;
 
-	if (__is_processor(PV_POWER4) || __is_processor(PV_POWER4p) ||
-	    __is_processor(PV_970) || __is_processor(PV_970FX) ||
-	    __is_processor(PV_970MP) || __is_processor(PV_970GX) ||
-	    __is_processor(PV_POWER5) || __is_processor(PV_POWER5p))
+	if (pvr_version_is(PVR_POWER4) || pvr_version_is(PVR_POWER4p) ||
+	    pvr_version_is(PVR_970) || pvr_version_is(PVR_970FX) ||
+	    pvr_version_is(PVR_970MP) || pvr_version_is(PVR_970GX) ||
+	    pvr_version_is(PVR_POWER5) || pvr_version_is(PVR_POWER5p))
 		use_slot_nums = 1;
 
 	return 0;
@@ -84,9 +84,9 @@ extern void ppc_enable_pmcs(void);
  */
 static inline int mmcra_must_set_sample(void)
 {
-	if (__is_processor(PV_POWER4) || __is_processor(PV_POWER4p) ||
-	    __is_processor(PV_970) || __is_processor(PV_970FX) ||
-	    __is_processor(PV_970MP) || __is_processor(PV_970GX))
+	if (pvr_version_is(PVR_POWER4) || pvr_version_is(PVR_POWER4p) ||
+	    pvr_version_is(PVR_970) || pvr_version_is(PVR_970FX) ||
+	    pvr_version_is(PVR_970MP) || pvr_version_is(PVR_970GX))
 		return 1;
 
 	return 0;
@@ -276,7 +276,7 @@ static bool pmc_overflow(unsigned long val)
 	 * PMCs because a user might set a period of less than 256 and we
 	 * don't want to mistakenly reset them.
 	 */
-	if (__is_processor(PV_POWER7) && ((0x80000000 - val) <= 256))
+	if (pvr_version_is(PVR_POWER7) && ((0x80000000 - val) <= 256))
 		return true;
 
 	return false;
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 77b49dd..331cf09 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1396,7 +1396,7 @@ static bool pmc_overflow(unsigned long val)
 	 * PMCs because a user might set a period of less than 256 and we
 	 * don't want to mistakenly reset them.
 	 */
-	if (__is_processor(PV_POWER7) && ((0x80000000 - val) <= 256))
+	if (pvr_version_is(PVR_POWER7) && ((0x80000000 - val) <= 256))
 		return true;
 
 	return false;
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 467dc38..6077c43 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -6304,14 +6304,14 @@ static struct ata_port_info sata_port_info = {
 
 #ifdef CONFIG_PPC_PSERIES
 static const u16 ipr_blocked_processors[] = {
-	PV_NORTHSTAR,
-	PV_PULSAR,
-	PV_POWER4,
-	PV_ICESTAR,
-	PV_SSTAR,
-	PV_POWER4p,
-	PV_630,
-	PV_630p
+	PVR_NORTHSTAR,
+	PVR_PULSAR,
+	PVR_POWER4,
+	PVR_ICESTAR,
+	PVR_SSTAR,
+	PVR_POWER4p,
+	PVR_630,
+	PVR_630p
 };
 
 /**
@@ -6331,7 +6331,7 @@ static int ipr_invalid_adapter(struct ipr_ioa_cfg *ioa_cfg)
 
 	if ((ioa_cfg->type == 0x5702) && (ioa_cfg->pdev->revision < 4)) {
 		for (i = 0; i < ARRAY_SIZE(ipr_blocked_processors); i++){
-			if (__is_processor(ipr_blocked_processors[i]))
+			if (pvr_version_is(ipr_blocked_processors[i]))
 				return 1;
 		}
 	}
-- 
1.7.9.5
