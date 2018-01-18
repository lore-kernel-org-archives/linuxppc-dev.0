Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMlLB1NC2zF0lJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 00:34:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org
Cc: greg@kroah.com,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v4.14 backport 04/10] powerpc/64: Convert the syscall exit
 path to use RFI_TO_USER/KERNEL
Date: Fri, 19 Jan 2018 00:34:04 +1100
Message-Id: <20180118133410.18716-4-mpe@ellerman.id.au>
In-Reply-To: <20180118133410.18716-1-mpe@ellerman.id.au>
References: <20180118133410.18716-1-mpe@ellerman.id.au>
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
---
 arch/powerpc/kernel/entry_64.S | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 5ae0a435417d..150c402728d1 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -267,13 +267,23 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
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
 
 .Lsyscall_error:
-- 
2.14.3
