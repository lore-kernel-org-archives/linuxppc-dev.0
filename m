Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FCBD1A0746
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 15:39:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] selftests/powerpc: Add a test of the switch_endian()
 syscall
Date: Fri, 13 Mar 2015 15:39:24 +1100
Message-Id: <1426221564-15086-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1426221564-15086-1-git-send-email-mpe@ellerman.id.au>
References: <1426221564-15086-1-git-send-email-mpe@ellerman.id.au>
Cc: Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a test of the switch_endian() syscall we added in the previous
commit.

We test it by calling the endian switch syscall, and then executing some
code in the other endian to check everything went as expected. That code
checks registers we expect to be maintained are, and then writes to
stdout and then does exit(0).

If the endian switch failed to happen that code sequence will be illegal
and cause the test to abort.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/Makefile           |   2 +-
 tools/testing/selftests/powerpc/syscalls/Makefile  |  15 ++
 .../selftests/powerpc/syscalls/endian-test.S       | 247 +++++++++++++++++++++
 3 files changed, 263 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/syscalls/Makefile
 create mode 100644 tools/testing/selftests/powerpc/syscalls/endian-test.S

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 1d5e7ad2c460..5da93b7d1330 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -13,7 +13,7 @@ CFLAGS := -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CUR
 
 export CC CFLAGS
 
-TARGETS = pmu copyloops mm tm primitives stringloops
+TARGETS = pmu copyloops mm tm primitives stringloops syscalls
 
 endif
 
diff --git a/tools/testing/selftests/powerpc/syscalls/Makefile b/tools/testing/selftests/powerpc/syscalls/Makefile
new file mode 100644
index 000000000000..b74201fa4f15
--- /dev/null
+++ b/tools/testing/selftests/powerpc/syscalls/Makefile
@@ -0,0 +1,15 @@
+PROGS := endian-test
+
+endian-test: ASFLAGS += -O2 -Wall -g -nostdlib -m64
+
+all: $(PROGS)
+
+run_tests: all
+	@-for PROG in $(PROGS); do \
+		./$$PROG; \
+	done;
+
+clean:
+	rm -f $(PROGS)
+
+.PHONY: all run_tests clean
diff --git a/tools/testing/selftests/powerpc/syscalls/endian-test.S b/tools/testing/selftests/powerpc/syscalls/endian-test.S
new file mode 100644
index 000000000000..0beca323247a
--- /dev/null
+++ b/tools/testing/selftests/powerpc/syscalls/endian-test.S
@@ -0,0 +1,247 @@
+#include <ppc-asm.h>
+#include <asm/unistd.h>
+
+#ifndef __NR_switch_endian
+#define __NR_switch_endian 363
+#endif
+
+	.data
+	.balign 8
+message:
+	.ascii "success: endian-test\n"
+
+	.section .toc
+	.balign 8
+pattern:
+	.llong 0x5555AAAA5555AAAA
+
+	.text
+FUNC_START(_start)
+	/* Load some addresses to start with */
+	ld	r14, message@got(%r2)
+	ld	r15, pattern@toc(%r2)
+
+	/* Setup CR, only CR2-CR4 are maintained */
+	lis	r3, 0x00FF
+	ori	r3, r3, 0xF000
+	mtcr	r3
+
+	/* Load the pattern slightly modified into the registers */
+	mr	r3, r15
+	addi	r4, r15, 4
+
+	addi	r5, r15, 32
+	mtlr	r5
+
+	addi	r5, r15, 5
+	addi	r6, r15, 6
+	addi	r7, r15, 7
+	addi	r8, r15, 8
+
+	/* r9 - r12 are clobbered */
+
+	addi	r13, r15, 13
+
+	/* Skip r14 & r15 we're using them */
+
+	addi	r16, r15, 16
+	addi	r17, r15, 17
+	addi	r18, r15, 18
+	addi	r19, r15, 19
+	addi	r20, r15, 20
+	addi	r21, r15, 21
+	addi	r22, r15, 22
+	addi	r23, r15, 23
+	addi	r24, r15, 24
+	addi	r25, r15, 25
+	addi	r26, r15, 26
+	addi	r27, r15, 27
+	addi	r28, r15, 28
+	addi	r29, r15, 29
+	addi	r30, r15, 30
+	addi	r31, r15, 31
+
+	/*
+	 * Call the syscall to switch endian.
+	 * It clobbers r9-r12, XER, CTR and CR0-1,5-7.
+	 */
+	li r0, __NR_switch_endian
+	sc
+
+	# cmpd    r15,r3
+	.long 0x00182f7c
+	# bne     1f
+	.long 0x50018240
+	# addi    r3,r15,4
+	.long 0x04006f38
+	# cmpd    r3,r4
+	.long 0x0020237c
+	# bne     1f
+	.long 0x44018240
+	# lis     r3,0x00FF
+	.long 0xff00603c
+	# ori     r3,r3,0xF000
+	.long 0x00f06360
+	# mfcr    r4
+	.long 0x2600807c
+	# and     r4,r4,r3
+	.long 0x3818847c
+	# cmpw    r3,r4
+	.long 0x0020037c
+	# addi    r3,r15,34
+	.long 0x22006f38
+	# bne     1f
+	.long 0x28018240
+	# addi    r3,r15,32
+	.long 0x20006f38
+	# mflr    r4
+	.long 0xa602887c
+	# cmpd    r3,r4
+	.long 0x0020237c
+	# bne     1f
+	.long 0x18018240
+	# addi    r3,r15,5
+	.long 0x05006f38
+	# cmpd    r3,r5
+	.long 0x0028237c
+	# bne     1f
+	.long 0x0c018240
+	# addi    r3,r15,6
+	.long 0x06006f38
+	# cmpd    r3,r6
+	.long 0x0030237c
+	# bne     1f
+	.long 0x00018240
+	# addi    r3,r15,7
+	.long 0x07006f38
+	# cmpd    r3,r7
+	.long 0x0038237c
+	# bne     1f
+	.long 0xf4008240
+	# addi    r3,r15,8
+	.long 0x08006f38
+	# cmpd    r3,r8
+	.long 0x0040237c
+	# bne     1f
+	.long 0xe8008240
+	# addi    r3,r15,13
+	.long 0x0d006f38
+	# cmpd    r3,r13
+	.long 0x0068237c
+	# bne     1f
+	.long 0xdc008240
+	# addi    r3,r15,16
+	.long 0x10006f38
+	# cmpd    r3,r16
+	.long 0x0080237c
+	# bne     1f
+	.long 0xd0008240
+	# addi    r3,r15,17
+	.long 0x11006f38
+	# cmpd    r3,r17
+	.long 0x0088237c
+	# bne     1f
+	.long 0xc4008240
+	# addi    r3,r15,18
+	.long 0x12006f38
+	# cmpd    r3,r18
+	.long 0x0090237c
+	# bne     1f
+	.long 0xb8008240
+	# addi    r3,r15,19
+	.long 0x13006f38
+	# cmpd    r3,r19
+	.long 0x0098237c
+	# bne     1f
+	.long 0xac008240
+	# addi    r3,r15,20
+	.long 0x14006f38
+	# cmpd    r3,r20
+	.long 0x00a0237c
+	# bne     1f
+	.long 0xa0008240
+	# addi    r3,r15,21
+	.long 0x15006f38
+	# cmpd    r3,r21
+	.long 0x00a8237c
+	# bne     1f
+	.long 0x94008240
+	# addi    r3,r15,22
+	.long 0x16006f38
+	# cmpd    r3,r22
+	.long 0x00b0237c
+	# bne     1f
+	.long 0x88008240
+	# addi    r3,r15,23
+	.long 0x17006f38
+	# cmpd    r3,r23
+	.long 0x00b8237c
+	# bne     1f
+	.long 0x7c008240
+	# addi    r3,r15,24
+	.long 0x18006f38
+	# cmpd    r3,r24
+	.long 0x00c0237c
+	# bne     1f
+	.long 0x70008240
+	# addi    r3,r15,25
+	.long 0x19006f38
+	# cmpd    r3,r25
+	.long 0x00c8237c
+	# bne     1f
+	.long 0x64008240
+	# addi    r3,r15,26
+	.long 0x1a006f38
+	# cmpd    r3,r26
+	.long 0x00d0237c
+	# bne     1f
+	.long 0x58008240
+	# addi    r3,r15,27
+	.long 0x1b006f38
+	# cmpd    r3,r27
+	.long 0x00d8237c
+	# bne     1f
+	.long 0x4c008240
+	# addi    r3,r15,28
+	.long 0x1c006f38
+	# cmpd    r3,r28
+	.long 0x00e0237c
+	# bne     1f
+	.long 0x40008240
+	# addi    r3,r15,29
+	.long 0x1d006f38
+	# cmpd    r3,r29
+	.long 0x00e8237c
+	# bne     1f
+	.long 0x34008240
+	# addi    r3,r15,30
+	.long 0x1e006f38
+	# cmpd    r3,r30
+	.long 0x00f0237c
+	# bne     1f
+	.long 0x28008240
+	# addi    r3,r15,31
+	.long 0x1f006f38
+	# cmpd    r3,r31
+	.long 0x00f8237c
+	# bne     1f
+	.long 0x1c008240
+	# li      r0,4
+	.long 0x04000038
+	# li      r3,1
+	.long 0x01006038
+	# mr      r4,r14
+	.long 0x7873c47d
+	# li      r5,21
+	.long 0x1500a038
+	# sc
+	.long 0x02000044
+	# li      r3,0
+	.long 0x00006038
+	# 1:
+	# li      r0, __NR_exit
+	.long 0x01000038
+	# sc
+	.long 0x02000044
+	# b       .
+	.long 0x00000048
-- 
2.1.0
