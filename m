Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7wR3RYNzDqjm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:58:30 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id d6so11320034pgv.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 05:58:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64s: Improve RFI L1-D cache flush fallback
Date: Wed, 17 Jan 2018 23:58:18 +1000
Message-Id: <20180117135818.10241-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The fallback RFI flush is used when firmware does not provide a way
to flush the cache. It's a "displacement flush" that evicts useful
data by displacing it with an uninteresting buffer.

The flush has to take care to work with implementation specific cache
replacment policies, so the recipe has been in flux. The initial
slow but conservative approach is to touch all lines of a congruence
class, with dependencies between each load. It has since been
determined that a linear pattern of loads without dependencies is
sufficient, and is significantly faster.

Measuring the speed of a null syscall with RFI fallback flush enabled
gives the relative improvement:

P8 - 1.83x
P9 - 1.75x

The flush also becomes simpler and more adaptable to different cache
geometries.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/paca.h      |  3 +-
 arch/powerpc/kernel/asm-offsets.c    |  3 +-
 arch/powerpc/kernel/exceptions-64s.S | 76 +++++++++++++++++-------------------
 arch/powerpc/kernel/setup_64.c       | 13 +-----
 4 files changed, 39 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 23ac7fc0af23..0ec7b1e383ef 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -239,8 +239,7 @@ struct paca_struct {
 	 */
 	u64 exrfi[EX_SIZE] __aligned(0x80);
 	void *rfi_flush_fallback_area;
-	u64 l1d_flush_congruence;
-	u64 l1d_flush_sets;
+	u64 l1d_flush_size;
 #endif
 };
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index f390d57cf2e1..fd99a9c6ea63 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -239,8 +239,7 @@ int main(void)
 	OFFSET(PACA_IN_NMI, paca_struct, in_nmi);
 	OFFSET(PACA_RFI_FLUSH_FALLBACK_AREA, paca_struct, rfi_flush_fallback_area);
 	OFFSET(PACA_EXRFI, paca_struct, exrfi);
-	OFFSET(PACA_L1D_FLUSH_CONGRUENCE, paca_struct, l1d_flush_congruence);
-	OFFSET(PACA_L1D_FLUSH_SETS, paca_struct, l1d_flush_sets);
+	OFFSET(PACA_L1D_FLUSH_SIZE, paca_struct, l1d_flush_size);
 
 #endif
 	OFFSET(PACAHWCPUID, paca_struct, hw_cpu_id);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 2dc10bf646b8..939445b16d58 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1455,39 +1455,37 @@ TRAMP_REAL_BEGIN(rfi_flush_fallback)
 	std	r9,PACA_EXRFI+EX_R9(r13)
 	std	r10,PACA_EXRFI+EX_R10(r13)
 	std	r11,PACA_EXRFI+EX_R11(r13)
-	std	r12,PACA_EXRFI+EX_R12(r13)
-	std	r8,PACA_EXRFI+EX_R13(r13)
 	mfctr	r9
 	ld	r10,PACA_RFI_FLUSH_FALLBACK_AREA(r13)
-	ld	r11,PACA_L1D_FLUSH_SETS(r13)
-	ld	r12,PACA_L1D_FLUSH_CONGRUENCE(r13)
-	/*
-	 * The load adresses are at staggered offsets within cachelines,
-	 * which suits some pipelines better (on others it should not
-	 * hurt).
-	 */
-	addi	r12,r12,8
+	ld	r11,PACA_L1D_FLUSH_SIZE(r13)
+	srdi	r11,r11,(7 + 3) /* 128 byte lines, unrolled 8x */
 	mtctr	r11
 	DCBT_STOP_ALL_STREAM_IDS(r11) /* Stop prefetch streams */
 
 	/* order ld/st prior to dcbt stop all streams with flushing */
 	sync
-1:	li	r8,0
-	.rept	8 /* 8-way set associative */
-	ldx	r11,r10,r8
-	add	r8,r8,r12
-	xor	r11,r11,r11	// Ensure r11 is 0 even if fallback area is not
-	add	r8,r8,r11	// Add 0, this creates a dependency on the ldx
-	.endr
-	addi	r10,r10,128 /* 128 byte cache line */
+
+	/*
+	 * The load adresses are at staggered offsets within cachelines,
+	 * which suits some pipelines better (on others it should not
+	 * hurt).
+	 */
+1:
+	ld	r11,(0x80 + 8)*0(r10)
+	ld	r11,(0x80 + 8)*1(r10)
+	ld	r11,(0x80 + 8)*2(r10)
+	ld	r11,(0x80 + 8)*3(r10)
+	ld	r11,(0x80 + 8)*4(r10)
+	ld	r11,(0x80 + 8)*5(r10)
+	ld	r11,(0x80 + 8)*6(r10)
+	ld	r11,(0x80 + 8)*7(r10)
+	addi	r10,r10,0x80*8
 	bdnz	1b
 
 	mtctr	r9
 	ld	r9,PACA_EXRFI+EX_R9(r13)
 	ld	r10,PACA_EXRFI+EX_R10(r13)
 	ld	r11,PACA_EXRFI+EX_R11(r13)
-	ld	r12,PACA_EXRFI+EX_R12(r13)
-	ld	r8,PACA_EXRFI+EX_R13(r13)
 	GET_SCRATCH0(r13);
 	rfid
 
@@ -1497,39 +1495,37 @@ TRAMP_REAL_BEGIN(hrfi_flush_fallback)
 	std	r9,PACA_EXRFI+EX_R9(r13)
 	std	r10,PACA_EXRFI+EX_R10(r13)
 	std	r11,PACA_EXRFI+EX_R11(r13)
-	std	r12,PACA_EXRFI+EX_R12(r13)
-	std	r8,PACA_EXRFI+EX_R13(r13)
 	mfctr	r9
 	ld	r10,PACA_RFI_FLUSH_FALLBACK_AREA(r13)
-	ld	r11,PACA_L1D_FLUSH_SETS(r13)
-	ld	r12,PACA_L1D_FLUSH_CONGRUENCE(r13)
-	/*
-	 * The load adresses are at staggered offsets within cachelines,
-	 * which suits some pipelines better (on others it should not
-	 * hurt).
-	 */
-	addi	r12,r12,8
+	ld	r11,PACA_L1D_FLUSH_SIZE(r13)
+	srdi	r11,r11,(7 + 3) /* 128 byte lines, unrolled 8x */
 	mtctr	r11
 	DCBT_STOP_ALL_STREAM_IDS(r11) /* Stop prefetch streams */
 
 	/* order ld/st prior to dcbt stop all streams with flushing */
 	sync
-1:	li	r8,0
-	.rept	8 /* 8-way set associative */
-	ldx	r11,r10,r8
-	add	r8,r8,r12
-	xor	r11,r11,r11	// Ensure r11 is 0 even if fallback area is not
-	add	r8,r8,r11	// Add 0, this creates a dependency on the ldx
-	.endr
-	addi	r10,r10,128 /* 128 byte cache line */
+
+	/*
+	 * The load adresses are at staggered offsets within cachelines,
+	 * which suits some pipelines better (on others it should not
+	 * hurt).
+	 */
+1:
+	ld	r11,(0x80 + 8)*0(r10)
+	ld	r11,(0x80 + 8)*1(r10)
+	ld	r11,(0x80 + 8)*2(r10)
+	ld	r11,(0x80 + 8)*3(r10)
+	ld	r11,(0x80 + 8)*4(r10)
+	ld	r11,(0x80 + 8)*5(r10)
+	ld	r11,(0x80 + 8)*6(r10)
+	ld	r11,(0x80 + 8)*7(r10)
+	addi	r10,r10,0x80*8
 	bdnz	1b
 
 	mtctr	r9
 	ld	r9,PACA_EXRFI+EX_R9(r13)
 	ld	r10,PACA_EXRFI+EX_R10(r13)
 	ld	r11,PACA_EXRFI+EX_R11(r13)
-	ld	r12,PACA_EXRFI+EX_R12(r13)
-	ld	r8,PACA_EXRFI+EX_R13(r13)
 	GET_SCRATCH0(r13);
 	hrfid
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 491be4179ddd..cc7ab8bf462c 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -867,19 +867,8 @@ static void init_fallback_flush(void)
 	memset(l1d_flush_fallback_area, 0, l1d_size * 2);
 
 	for_each_possible_cpu(cpu) {
-		/*
-		 * The fallback flush is currently coded for 8-way
-		 * associativity. Different associativity is possible, but it
-		 * will be treated as 8-way and may not evict the lines as
-		 * effectively.
-		 *
-		 * 128 byte lines are mandatory.
-		 */
-		u64 c = l1d_size / 8;
-
 		paca[cpu].rfi_flush_fallback_area = l1d_flush_fallback_area;
-		paca[cpu].l1d_flush_congruence = c;
-		paca[cpu].l1d_flush_sets = c / 128;
+		paca[cpu].l1d_flush_size = l1d_size;
 	}
 }
 
-- 
2.15.1
