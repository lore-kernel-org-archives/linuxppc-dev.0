Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Partial revert of "Context switch more PMU related
 SPRs"
Date: Thu,  6 Jun 2013 14:03:36 +1000
Message-Id: <1370491416-1807-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 59affcd I added context switching of more PMU SPRs, because
they are potentially exposed to userspace on Power8. However despite me
being a smart arse in the commit message it's actually not correct. In
particular it interacts badly with a global perf record.

We will have to do something more complicated, but that will have to
wait for 3.11.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/entry_64.S |   28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 246b11c..8741c85 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -465,20 +465,6 @@ BEGIN_FTR_SECTION
 	std	r0, THREAD_EBBHR(r3)
 	mfspr	r0, SPRN_EBBRR
 	std	r0, THREAD_EBBRR(r3)
-
-	/* PMU registers made user read/(write) by EBB */
-	mfspr	r0, SPRN_SIAR
-	std	r0, THREAD_SIAR(r3)
-	mfspr	r0, SPRN_SDAR
-	std	r0, THREAD_SDAR(r3)
-	mfspr	r0, SPRN_SIER
-	std	r0, THREAD_SIER(r3)
-	mfspr	r0, SPRN_MMCR0
-	std	r0, THREAD_MMCR0(r3)
-	mfspr	r0, SPRN_MMCR2
-	std	r0, THREAD_MMCR2(r3)
-	mfspr	r0, SPRN_MMCRA
-	std	r0, THREAD_MMCRA(r3)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 #endif
 
@@ -581,20 +567,6 @@ BEGIN_FTR_SECTION
 	ld	r0, THREAD_EBBRR(r4)
 	mtspr	SPRN_EBBRR, r0
 
-	/* PMU registers made user read/(write) by EBB */
-	ld	r0, THREAD_SIAR(r4)
-	mtspr	SPRN_SIAR, r0
-	ld	r0, THREAD_SDAR(r4)
-	mtspr	SPRN_SDAR, r0
-	ld	r0, THREAD_SIER(r4)
-	mtspr	SPRN_SIER, r0
-	ld	r0, THREAD_MMCR0(r4)
-	mtspr	SPRN_MMCR0, r0
-	ld	r0, THREAD_MMCR2(r4)
-	mtspr	SPRN_MMCR2, r0
-	ld	r0, THREAD_MMCRA(r4)
-	mtspr	SPRN_MMCRA, r0
-
 	ld	r0,THREAD_TAR(r4)
 	mtspr	SPRN_TAR,r0
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
-- 
1.7.10.4
