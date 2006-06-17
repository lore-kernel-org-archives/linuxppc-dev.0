Return-Path: <jdl@jdl.com>
Received: from jdl.com (colo.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51FAE67B9E
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jun 2006 08:52:48 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1Frjem-0004Ou-2S
	for linuxppc-dev@ozlabs.org; Sat, 17 Jun 2006 17:52:45 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/9 v3] Add starting of secondary 86xx CPUs.
Date: Sat, 17 Jun 2006 17:52:44 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Frjem-0004Ou-2S@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Clear the high BATS during load_up_mmu if FTR_HAS_HIGH_BATS.
Allow just a bit more time for secondary CPUs to phone home.

Signed-off-by: Wei Zhang <Wei.Zhang@freescale.com>
Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

 arch/powerpc/kernel/head_32.S |   14 +++++++++++++-
 arch/powerpc/kernel/smp.c     |    2 +-
 arch/powerpc/mm/ppc_mmu_32.c  |    4 ++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index a0579e8..b25b259 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -973,6 +973,13 @@ __secondary_start_gemini:
         b       __secondary_start
 #endif /* CONFIG_GEMINI */
 
+	.globl __secondary_start_mpc86xx
+__secondary_start_mpc86xx:
+	mfspr	r3, SPRN_PIR
+	stw	r3, __secondary_hold_acknowledge@l(0)
+	mr	r24, r3			/* cpu # */
+	b	__secondary_start
+
 	.globl	__secondary_start_pmac_0
 __secondary_start_pmac_0:
 	/* NB the entries for cpus 0, 1, 2 must each occupy 8 bytes. */
@@ -1088,7 +1095,12 @@ load_up_mmu:
 	LOAD_BAT(1,r3,r4,r5)
 	LOAD_BAT(2,r3,r4,r5)
 	LOAD_BAT(3,r3,r4,r5)
-
+BEGIN_FTR_SECTION
+	LOAD_BAT(4,r3,r4,r5)
+	LOAD_BAT(5,r3,r4,r5)
+	LOAD_BAT(6,r3,r4,r5)
+	LOAD_BAT(7,r3,r4,r5)
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
 	blr
 
 /*
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 530f7db..c5d179d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -492,7 +492,7 @@ int __devinit __cpu_up(unsigned int cpu)
 	 * -- Cort
 	 */
 	if (system_state < SYSTEM_RUNNING)
-		for (c = 5000; c && !cpu_callin_map[cpu]; c--)
+		for (c = 50000; c && !cpu_callin_map[cpu]; c--)
 			udelay(100);
 #ifdef CONFIG_HOTPLUG_CPU
 	else
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index ab5cd72..2ed43a4 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -43,13 +43,13 @@ unsigned long _SDR1;
 union ubat {			/* BAT register values to be loaded */
 	BAT	bat;
 	u32	word[2];
-} BATS[4][2];			/* 4 pairs of IBAT, DBAT */
+} BATS[8][2];			/* 8 pairs of IBAT, DBAT */
 
 struct batrange {		/* stores address ranges mapped by BATs */
 	unsigned long start;
 	unsigned long limit;
 	unsigned long phys;
-} bat_addrs[4];
+} bat_addrs[8];
 
 /*
  * Return PA for this VA if it is mapped by a BAT, or 0
