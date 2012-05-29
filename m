Return-Path: <anton@samba.org>
Date: Tue, 29 May 2012 18:14:32 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 amodra@bigpond.net.au
Subject: [PATCH] powerpc: Use enhanced touch instructions in POWER7
 copy_to_user/copy_from_user
Message-ID: <20120529181432.2038c1a3@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Version 2.06 of the POWER ISA introduced enhanced touch instructions,
allowing us to specify a number of attributes including the length of
a stream.

This patch adds a software stream for both loads and stores in the
POWER7 copy_tofrom_user loop. Since the setup is quite complicated
and we have to use an eieio to ensure correct ordering of the "GO"
command we only do this for copies above 4kB.

To quantify any performance improvements we need a working set
bigger than the caches so we operate on a 1GB file:

# dd if=/dev/zero of=/tmp/foo bs=1M count=1024

And we compare how fast we can read the file:

# dd if=/tmp/foo of=/dev/null bs=1M

before: 7.7 GB/s
after:  9.6 GB/s

A 25% improvement.

The worst case for this patch will be a completely L1 cache contained
copy of just over 4kB. We can test this with the copy_to_user
testcase we used to tune copy_tofrom_user originally:

http://ozlabs.org/~anton/junkcode/copy_to_user.c

# time ./copy_to_user2 -l 4224 -i 10000000

before: 6.807 s
after:  6.946 s

A 2% slowdown, which seems reasonable considering our data is unlikely
to be completely L1 contained.

Signed-off-by: Anton Blanchard <anton@samba.org>  
---

Index: linux-build/arch/powerpc/lib/copyuser_power7.S
===================================================================
--- linux-build.orig/arch/powerpc/lib/copyuser_power7.S	2012-03-01 16:15:31.073813523 +1100
+++ linux-build/arch/powerpc/lib/copyuser_power7.S	2012-05-29 16:14:44.129704887 +1000
@@ -298,6 +298,37 @@ err1;	stb	r0,0(r3)
 	ld	r5,STACKFRAMESIZE+64(r1)
 	mtlr	r0
 
+	/*
+	 * We prefetch both the source and destination using enhanced touch
+	 * instructions. We use a stream ID of 0 for the load side and
+	 * 1 for the store side.
+	 */
+	clrrdi	r6,r4,7
+	clrrdi	r9,r3,7
+	ori	r9,r9,1		/* stream=1 */
+
+	srdi	r7,r5,7		/* length in cachelines, capped at 0x3FF */
+	cmpldi	r7,0x3FF
+	ble	1f
+	li	r7,0x3FF
+1:	lis	r0,0x0E00	/* depth=7 */
+	sldi	r7,r7,7
+	or	r7,r7,r0
+	ori	r10,r7,1	/* stream=1 */
+
+	lis	r8,0x8000	/* GO=1 */
+	clrldi	r8,r8,32
+
+.machine push
+.machine "power4"
+	dcbt	r0,r6,0b01000
+	dcbt	r0,r7,0b01010
+	dcbtst	r0,r9,0b01000
+	dcbtst	r0,r10,0b01010
+	eieio
+	dcbt	r0,r8,0b01010	/* GO */
+.machine pop
+
 	beq	.Lunwind_stack_nonvmx_copy
 
 	/*
