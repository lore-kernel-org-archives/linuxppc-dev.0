Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78A28DDF10
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:31:03 +1000 (EST)
Date: Wed, 11 Apr 2007 03:30:38 -0500 (CDT)
Subject: [PATCH kexec-tools] ppc64: use kernels slave loop for purgatory
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: <fastboot@lists.osdl.org>, Sachin Sant <sachinp@in.ibm.com>
Message-Id: <boot-4-kexec-03.miltonm@bga.com>
In-Reply-To: <boot-4-00.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Vivek Goyal <vgoyal@in.ibm.com>,
	Simon Horman <horms@verge.net.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Purgatory doesn't really care about the SMP cpus.  But if we leave them
behind, they end up getting lost when the kernel overwrites purgatory or
the previous kernel.  The current slave handling in purgatory doesn't
have any handshaking to make sure the cpus have moved on before leaving.

Instead of moving the slave cpus up to purgatory and then back down to
the kernel, just copy bytes 4-255 from the kernel and use it as the
purgatory start / slave hold block.


Signed-off-by: Milton Miller <miltonm@bga.com>

--- 
I wrote this while debugging a problem in my zImage.kexec smp code.
Since the first instruction is the branch for the master, changing it
to another branch should be safe.

We could copy the kernels original branch to 0 before jumping to the
kernel for completeness.

We could also just compute the branch for the master instead of reading
the code in the original symbol.

--- kexec-tools-testing/purgatory/arch/ppc64/v2wrap.S.orig	2007-04-10 22:29:59.000000000 -0500
+++ kexec-tools-testing/purgatory/arch/ppc64/v2wrap.S	2007-04-10 23:46:11.000000000 -0500
@@ -45,13 +45,22 @@
 	oris    rn,rn,name##@h;         \
 	ori     rn,rn,name##@l
 
-# look a bit like a Linux kernel here ...
+
 	.machine ppc64
 	.globl purgatory_start
 purgatory_start:	b	master
-	tweq	0,0
+	.org purgatory_start + 0x60     # ABI: slaves start at 60 with r3=phys
+slave:	b $
+	.org purgatory_start + 0x100    # ABI: end of copied region
+	.size purgatory_start, . - purgatory_start
+
+#
+# The above 0x100 bytes at purgatory_start are replaced with the
+# code from the kernel (or next stage) by kexec/arch/ppc64/kexec-ppc64.c
+#
+
 master:
-	or	1,1,1		# low priority to let other thread catchup
+	or	1,1,1		# low priority to let other threads catchup
 	isync
 	mr      17,3            # save cpu id to r17
 	mr      15,4            # save physical address in reg15
@@ -66,25 +75,7 @@ master:
 	bl      .purgatory
 	nop
 
-	b       81f
-	.org purgatory_start + 0x60     # ABI: slaves start at 60 with r3=phys
-slave:
-	# load slave spin code address and branch into that
-	LOADADDR(6,slave_spin)
-	ld      4,0(6)
-	mtctr 4
-	bctr
-
-spin: .long 1
-slave_spin_code:
-	lis     5,spin@ha
-	lwz     5,spin@l(5)
-	cmpwi   0,5,0
-	bne     slave_spin_code
-	ba 0x60
-
-81:				# master continues here
-	or	3,3,3		# ok back to high, lets boot
+	or	3,3,3		# ok now to high priority, lets boot
 	lis	6,0x1
 	mtctr	6		# delay a bit for slaves to catch up
 83:	bdnz	83b		# before we overwrite 0-100 again
@@ -99,30 +90,12 @@ slave_spin_code:
 80:
 	LOADADDR(6,kernel)
 	ld      4,0(6)          # load the kernel address
-
-	addi	5,4,-8		# prepare copy with update form instructions
-	li	6,0x100/8
-	mtctr	6
-	li	6,-8
-85:	ldu	7,8(5)
-	stdu	7,8(6)
-	bdnz	85b
-
 	li	5,0		# r5 will be 0 for kernel
-	dcbst	0,5		# store dcache, flush icache
-	dcbst	0,6		# 0 and 0xf8 covers us with 128 byte lines
 	mtctr	4		# prepare branch too
-	sync
-	icbi	0,5
-	icbi	0,6
-	sync
-	isync
-	lis     6,spin@ha
-	li      0,0
-	stw     0,spin@l(6)
 	mr      3,16            # restore dt address
 
-	bctr			# start kernel
-
-slave_spin: .llong  slave_spin_code
+	lwz	7,0(4)		# get the first instruction that we stole
+	stw	7,0(0)		# and put it in the slave loop at 0
+				# skip cache flush, do we care?
 
+	bctr			# start kernel
--- kexec-tools-testing/kexec/arch/ppc64/kexec-elf-ppc64.c.orig	2007-04-10 22:29:59.000000000 -0500
+++ kexec-tools-testing/kexec/arch/ppc64/kexec-elf-ppc64.c	2007-04-10 22:29:59.000000000 -0500
@@ -89,6 +89,7 @@ int elf_ppc64_load(int argc, char **argv
 	unsigned int my_panic_kernel;
 	unsigned long my_stack, my_backup_start;
 	unsigned long toc_addr;
+	unsigned int slave_code[256/sizeof (unsigned int)], master_entry;
 
 #define OPT_APPEND     (OPT_ARCH_MAX+0)
 #define OPT_RAMDISK     (OPT_ARCH_MAX+1)
@@ -281,6 +282,15 @@ int elf_ppc64_load(int argc, char **argv
 	elf_rel_set_symbol(&info->rhdr, "dt_offset", &my_dt_offset,
 				sizeof(my_dt_offset));
 
+	/* get slave code from new kernel, put in purgatory */
+	elf_rel_get_symbol(&info->rhdr, "purgatory_start", slave_code, 
+			sizeof(slave_code));
+	master_entry = slave_code[0];
+	memcpy(slave_code, info->segment[0].buf, sizeof(slave_code));
+	slave_code[0] = master_entry;
+	elf_rel_set_symbol(&info->rhdr, "purgatory_start", slave_code,
+				sizeof(slave_code));
+
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		my_panic_kernel = 1;
 		/* Set panic flag */
