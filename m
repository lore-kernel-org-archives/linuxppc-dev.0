Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zYz8P1qwyzF0T4
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 16:01:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH v4.4 backport 10/16] powerpc/64s: Convert slb_miss_common to
 use RFI_TO_USER/KERNEL
Date: Sun,  4 Feb 2018 16:00:04 +1100
Message-Id: <20180204050010.13669-11-mpe@ellerman.id.au>
In-Reply-To: <20180204050010.13669-1-mpe@ellerman.id.au>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

commit c7305645eb0c1621351cfc104038831ae87c0053 upstream.

In the SLB miss handler we may be returning to user or kernel. We need
to add a check early on and save the result in the cr4 register, and
then we bifurcate the return path based on that.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[mpe: Backport to 4.4 based on patch from Balbir]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e3a3b81df363..2c6494351604 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1503,6 +1503,8 @@ slb_miss_realmode:
 
 	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
 	beq-	2f
+	andi.	r10,r12,MSR_PR	/* check for user mode (PR != 0) */
+	bne	1f
 
 .machine	push
 .machine	"power4"
@@ -1516,7 +1518,23 @@ slb_miss_realmode:
 	ld	r11,PACA_EXSLB+EX_R11(r13)
 	ld	r12,PACA_EXSLB+EX_R12(r13)
 	ld	r13,PACA_EXSLB+EX_R13(r13)
-	rfid
+	RFI_TO_KERNEL
+	b	.	/* prevent speculative execution */
+
+1:
+.machine	push
+.machine	"power4"
+	mtcrf	0x80,r9
+	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
+.machine	pop
+
+	RESTORE_PPR_PACA(PACA_EXSLB, r9)
+	ld	r9,PACA_EXSLB+EX_R9(r13)
+	ld	r10,PACA_EXSLB+EX_R10(r13)
+	ld	r11,PACA_EXSLB+EX_R11(r13)
+	ld	r12,PACA_EXSLB+EX_R12(r13)
+	ld	r13,PACA_EXSLB+EX_R13(r13)
+	RFI_TO_USER
 	b	.	/* prevent speculative execution */
 
 2:	mfspr	r11,SPRN_SRR0
@@ -1525,7 +1543,7 @@ slb_miss_realmode:
 	mtspr	SPRN_SRR0,r10
 	ld	r10,PACAKMSR(r13)
 	mtspr	SPRN_SRR1,r10
-	rfid
+	RFI_TO_KERNEL
 	b	.
 
 unrecov_slb:
-- 
2.14.1
