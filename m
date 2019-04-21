Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8383C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:12:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1552820859
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1552820859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nCqm6glZzDqLF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:12:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBhZ4tlszDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:21:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBhX2Bb1z9sB3; Mon, 22 Apr 2019 00:21:00 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBhV72SNz9sLt; Mon, 22 Apr 2019 00:20:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 02/52] powerpc/64s: Improve RFI L1-D cache flush
 fallback
Date: Mon, 22 Apr 2019 00:19:47 +1000
Message-Id: <20190421142037.21881-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190421142037.21881-1-mpe@ellerman.id.au>
References: <20190421142037.21881-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de,
 npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Nicholas Piggin <npiggin@gmail.com>

commit bdcb1aefc5b3f7d0f1dc8b02673602bca2ff7a4b upstream.

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
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/paca.h      |  3 +-
 arch/powerpc/kernel/asm-offsets.c    |  3 +-
 arch/powerpc/kernel/exceptions-64s.S | 76 +++++++++++++---------------
 arch/powerpc/kernel/setup_64.c       | 13 +----
 arch/powerpc/xmon/xmon.c             |  2 -
 5 files changed, 39 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 45e2aefece16..08e5df3395fa 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -199,8 +199,7 @@ struct paca_struct {
 	 */
 	u64 exrfi[13] __aligned(0x80);
 	void *rfi_flush_fallback_area;
-	u64 l1d_flush_congruence;
-	u64 l1d_flush_sets;
+	u64 l1d_flush_size;
 #endif
 };
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index d92705e3a0c1..de3c29c51503 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -245,8 +245,7 @@ int main(void)
 	DEFINE(PACA_IN_MCE, offsetof(struct paca_struct, in_mce));
 	DEFINE(PACA_RFI_FLUSH_FALLBACK_AREA, offsetof(struct paca_struct, rfi_flush_fallback_area));
 	DEFINE(PACA_EXRFI, offsetof(struct paca_struct, exrfi));
-	DEFINE(PACA_L1D_FLUSH_CONGRUENCE, offsetof(struct paca_struct, l1d_flush_congruence));
-	DEFINE(PACA_L1D_FLUSH_SETS, offsetof(struct paca_struct, l1d_flush_sets));
+	DEFINE(PACA_L1D_FLUSH_SIZE, offsetof(struct paca_struct, l1d_flush_size));
 #endif
 	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
 	DEFINE(PACAKEXECSTATE, offsetof(struct paca_struct, kexec_state));
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 938a30fef031..d2ff233ddc53 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1571,39 +1571,37 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
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
 
@@ -1614,39 +1612,37 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
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
index 9eb469bed22b..1d2712d628c3 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -902,19 +902,8 @@ static void init_fallback_flush(void)
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
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 5f0c17b043de..83619ebede93 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2146,8 +2146,6 @@ static void dump_one_paca(int cpu)
 		printf(" slb_cache[%d]:        = 0x%016lx\n", i, p->slb_cache[i]);
 
 	DUMP(p, rfi_flush_fallback_area, "px");
-	DUMP(p, l1d_flush_congruence, "llx");
-	DUMP(p, l1d_flush_sets, "llx");
 #endif
 	DUMP(p, dscr_default, "llx");
 #ifdef CONFIG_PPC_BOOK3E
-- 
2.20.1

