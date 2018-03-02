Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsxZd2tdmzF1cm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 15:46:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander.Levin@microsoft.com
Cc: stable@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	npiggin@gmail.com
Subject: [PATCH v4.1 backport 05/15] powerpc/64: Convert the syscall exit path
 to use RFI_TO_USER/KERNEL
Date: Fri,  2 Mar 2018 15:45:39 +1100
Message-Id: <20180302044549.14930-6-mpe@ellerman.id.au>
In-Reply-To: <20180302044549.14930-1-mpe@ellerman.id.au>
References: <20180302044549.14930-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

commit b8e90cb7bc04a509e821e82ab6ed7a8ef11ba333 upstream.

In the syscall exit path we may be returning to user or kernel
context. We already have a test for that, because we conditionally
restore r13. So use that existing test and branch, and bifurcate the
return based on that.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/entry_64.S | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index f7421248cbd8..36a8bf3d053b 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -223,13 +223,23 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	ACCOUNT_CPU_USER_EXIT(r11, r12)
 	HMT_MEDIUM_LOW_HAS_PPR
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
+	ld	r2,GPR2(r1)
+	ld	r1,GPR1(r1)
+	mtlr	r4
+	mtcr	r5
+	mtspr	SPRN_SRR0,r7
+	mtspr	SPRN_SRR1,r8
+	RFI_TO_USER
+	b	.	/* prevent speculative execution */
+
+	/* exit to kernel */
 1:	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
 	mtlr	r4
 	mtcr	r5
 	mtspr	SPRN_SRR0,r7
 	mtspr	SPRN_SRR1,r8
-	RFI
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
 syscall_error:	
-- 
2.14.1
