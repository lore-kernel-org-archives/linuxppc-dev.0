Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GsQL0c99zF1bP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 15:51:21 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id 61-v6so15711619plb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 22:51:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/64s: Fix dt_cpu_ftrs to have restore_cpu clear
 unwanted LPCR bits
Date: Thu,  5 Apr 2018 15:50:49 +1000
Message-Id: <20180405055049.21883-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Presently the dt_cpu_ftrs restore_cpu will only add bits to the LPCR
for secondaries, but some bits must be removed (e.g., UPRT for HPT).
Not clearing these bits on secondaries causes checkstops when booting
with disable_radix.

restore_cpu can not just set LPCR, because it is also called by the
idle wakeup code which relies on opal_slw_set_reg to restore the value
of LPCR, at least on P8 which does not save LPCR to stack in the idle
code.

Fix this by including a mask of bits to clear from LPCR as well, which
is used by restore_cpu.

This is a little messy now, but it's a minimal fix that can be
backported.  Longer term, the idle SPR save/restore code can be
reworked to completely avoid calls to restore_cpu, then restore_cpu
would be able to unconditionally set LPCR to match boot processor
environment.

Fixes: 5a61ef74f269f ("powerpc/64s: Support new device tree binding for discovering CPU features")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

I tested this fix and it boots a POWER9 with disable_radix, where
previously it checkstopped. Deeper idle states seem to work too,
after they're enabled with a firmware override.


 arch/powerpc/kernel/dt_cpu_ftrs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 11a3a4fed3fb..ed7605d8fd2d 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -83,6 +83,7 @@ static int hv_mode;
 
 static struct {
 	u64	lpcr;
+	u64	lpcr_clear;
 	u64	hfscr;
 	u64	fscr;
 } system_registers;
@@ -91,6 +92,8 @@ static void (*init_pmu_registers)(void);
 
 static void __restore_cpu_cpufeatures(void)
 {
+	u64 lpcr;
+
 	/*
 	 * LPCR is restored by the power on engine already. It can be changed
 	 * after early init e.g., by radix enable, and we have no unified API
@@ -103,8 +106,10 @@ static void __restore_cpu_cpufeatures(void)
 	 * The best we can do to accommodate secondary boot and idle restore
 	 * for now is "or" LPCR with existing.
 	 */
-
-	mtspr(SPRN_LPCR, system_registers.lpcr | mfspr(SPRN_LPCR));
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr |= system_registers.lpcr;
+	lpcr &= ~system_registers.lpcr_clear;
+	mtspr(SPRN_LPCR, lpcr);
 	if (hv_mode) {
 		mtspr(SPRN_LPID, 0);
 		mtspr(SPRN_HFSCR, system_registers.hfscr);
@@ -324,8 +329,9 @@ static int __init feat_enable_mmu_hash_v3(struct dt_cpu_feature *f)
 {
 	u64 lpcr;
 
+	system_registers.lpcr_clear |= (LPCR_ISL | LPCR_UPRT | LPCR_HR);
 	lpcr = mfspr(SPRN_LPCR);
-	lpcr &= ~LPCR_ISL;
+	lpcr &= ~(LPCR_ISL | LPCR_UPRT | LPCR_HR);
 	mtspr(SPRN_LPCR, lpcr);
 
 	cur_cpu_spec->mmu_features |= MMU_FTRS_HASH_BASE;
-- 
2.16.3
