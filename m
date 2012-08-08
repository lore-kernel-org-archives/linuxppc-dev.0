Return-Path: <anton@samba.org>
Date: Wed, 8 Aug 2012 13:50:46 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/2] powerpc: POWER7 copy_to_user/copy_from_user patch
 applied twice
Message-ID: <20120808135046.06056d11@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


"powerpc: Use enhanced touch instructions in POWER7
copy_to_user/copy_from_user" was applied twice. Remove one.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/lib/copyuser_power7.S
===================================================================
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -326,37 +326,6 @@ err1;	stb	r0,0(r3)
 	dcbt	r0,r8,0b01010	/* GO */
 .machine pop
 
-	/*
-	 * We prefetch both the source and destination using enhanced touch
-	 * instructions. We use a stream ID of 0 for the load side and
-	 * 1 for the store side.
-	 */
-	clrrdi	r6,r4,7
-	clrrdi	r9,r3,7
-	ori	r9,r9,1		/* stream=1 */
-
-	srdi	r7,r5,7		/* length in cachelines, capped at 0x3FF */
-	cmpldi	cr1,r7,0x3FF
-	ble	cr1,1f
-	li	r7,0x3FF
-1:	lis	r0,0x0E00	/* depth=7 */
-	sldi	r7,r7,7
-	or	r7,r7,r0
-	ori	r10,r7,1	/* stream=1 */
-
-	lis	r8,0x8000	/* GO=1 */
-	clrldi	r8,r8,32
-
-.machine push
-.machine "power4"
-	dcbt	r0,r6,0b01000
-	dcbt	r0,r7,0b01010
-	dcbtst	r0,r9,0b01000
-	dcbtst	r0,r10,0b01010
-	eieio
-	dcbt	r0,r8,0b01010	/* GO */
-.machine pop
-
 	beq	.Lunwind_stack_nonvmx_copy
 
 	/*
