Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFhH8172xzF0Pp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 03:55:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
 npiggin@gmail.com, anton@samba.org, mikey@neuling.org, oohall@gmail.com,
 paulus@samba.org
Subject: [PATCH 05/11] powerpc/64: Convert fast_exception_return to use
 RFI_TO_USER/KERNEL
Date: Tue,  9 Jan 2018 03:54:47 +1100
Message-Id: <20180108165453.26066-5-mpe@ellerman.id.au>
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

Similar to the syscall return path, in fast_exception_return we may be
returning to user or kernel context. We already have a test for that,
because we conditionally restore r13. So use that existing test and
branch, and bifurcate the return based on that.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/entry_64.S | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index b20c6cb0fa7f..fde89f04f276 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -892,7 +892,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ACCOUNT_CPU_USER_EXIT(r13, r2, r4)
 	REST_GPR(13, r1)
-1:
+
 	mtspr	SPRN_SRR1,r3
 
 	ld	r2,_CCR(r1)
@@ -905,8 +905,22 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r3,GPR3(r1)
 	ld	r4,GPR4(r1)
 	ld	r1,GPR1(r1)
+	RFI_TO_USER
+	b	.	/* prevent speculative execution */
+
+1:	mtspr	SPRN_SRR1,r3
+
+	ld	r2,_CCR(r1)
+	mtcrf	0xFF,r2
+	ld	r2,_NIP(r1)
+	mtspr	SPRN_SRR0,r2
 
-	rfid
+	ld	r0,GPR0(r1)
+	ld	r2,GPR2(r1)
+	ld	r3,GPR3(r1)
+	ld	r4,GPR4(r1)
+	ld	r1,GPR1(r1)
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
 #endif /* CONFIG_PPC_BOOK3E */
-- 
2.14.3
