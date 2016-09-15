Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZXft4SKTzDrfR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 19:09:42 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id p2so1888781pap.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 02:09:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH][RFC] powerpc/64: exception exit do not reload SRR[01] if
 unchanged
Date: Thu, 15 Sep 2016 19:09:29 +1000
Message-Id: <20160915090929.1380-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is not ready yet, but it's a proof of concept for the approach to
speed up exception exit: avoid the mtspr instructions if the yare not
required. This saves 20 cycles per call on a getppid syscall
microbenchmark, so it seems worth looking into.

A few issues to be solved.

Firstly, realmode exceptions use an rfid to switch on relocation and
branch to common handler. This trashes SRR[01], so realmode exceptions
will always miss and be pessimised with this patch. We can avoid that
by doing a bctr to 0xc000... from realmode to enter the handler, and
then use mtmsrd to switch on relocation. The ISA actually suggests
this might be faster in some implementations, and on POWER8 it does
seem to be faster by about 6 cycles.

Secondly, avoiding the mfsprs would be nice if possible, and should
give a couple more cycles. We could use a byte in the paca to track
whether the SPRs are valid for the current exception. Anything
modifying SPRs including nested exceptions would clear the bit when
they're done. This is a bit more intrusive.

Finally, should gather some statistics for success vs failure.
---
 arch/powerpc/kernel/entry_64.S | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 585b9ca..c836967 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -250,12 +250,21 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
-1:	ld	r2,GPR2(r1)
+1:
+	mfspr	r11,SPRN_SRR0
+	mfspr	r12,SPRN_SRR1
+	cmpld	r7,r11
+	beq	5f
+	mtspr	SPRN_SRR0,r7
+5:
+	cmpld	r8,r12
+	beq	6f
+	mtspr	SPRN_SRR1,r8
+6:
+	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
 	mtlr	r4
 	mtcr	r5
-	mtspr	SPRN_SRR0,r7
-	mtspr	SPRN_SRR1,r8
 	RFI
 	b	.	/* prevent speculative execution */
 
@@ -859,12 +868,21 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ACCOUNT_CPU_USER_EXIT(r13, r2, r4)
 	REST_GPR(13, r1)
 1:
+	mfspr	r0,SPRN_SRR0
+	mfspr	r2,SPRN_SRR1
+	ld	r4,_NIP(r1)
+
+	cmpld	r0,r4
+	beq	5f
+	mtspr	SPRN_SRR0,r4
+5:
+	cmpld	r2,r3
+	beq	6f
 	mtspr	SPRN_SRR1,r3
+6:
 
 	ld	r2,_CCR(r1)
 	mtcrf	0xFF,r2
-	ld	r2,_NIP(r1)
-	mtspr	SPRN_SRR0,r2
 
 	ld	r0,GPR0(r1)
 	ld	r2,GPR2(r1)
-- 
2.9.3
