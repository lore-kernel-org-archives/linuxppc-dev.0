Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFhH468ymzF0Pv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 03:55:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
 npiggin@gmail.com, anton@samba.org, mikey@neuling.org, oohall@gmail.com,
 paulus@samba.org
Subject: [PATCH 04/11] powerpc/64: Convert the syscall exit path to use
 RFI_TO_USER/KERNEL
Date: Tue,  9 Jan 2018 03:54:46 +1100
Message-Id: <20180108165453.26066-4-mpe@ellerman.id.au>
In-Reply-To: <20180108165453.26066-1-mpe@ellerman.id.au>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

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
index 567d8f487f2f..b20c6cb0fa7f 100644
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
