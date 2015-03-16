Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6337B1A06F5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 17:57:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v3 2/2] selftests/powerpc: Add a test of the switch_endian()
 syscall
Date: Mon, 16 Mar 2015 17:57:10 +1100
Message-Id: <1426489030-26025-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1426489030-26025-1-git-send-email-mpe@ellerman.id.au>
References: <1426489030-26025-1-git-send-email-mpe@ellerman.id.au>
Cc: linuxram@us.ibm.com, Jeremy Kerr <jk@ozlabs.org>,
 khandual@linux.vnet.ibm.com
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
stdout. If the endian switch failed to happen that code sequence will be
illegal and cause the test to abort.

We then switch back to the original endian, do the same checks and
finally write a success message and exit(0).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

---
v3: Have the test switch back to the original endian.

 tools/testing/selftests/powerpc/Makefile           |   2 +-
 .../selftests/powerpc/switch_endian/Makefile       |  23 +++++
 .../selftests/powerpc/switch_endian/check.S        | 101 +++++++++++++++++++++
 .../selftests/powerpc/switch_endian/common.h       |   6 ++
 .../powerpc/switch_endian/switch_endian_test.S     |  92 +++++++++++++++++++
 5 files changed, 223 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/switch_endian/Makefile
 create mode 100644 tools/testing/selftests/powerpc/switch_endian/check.S
 create mode 100644 tools/testing/selftests/powerpc/switch_endian/common.h
 create mode 100644 tools/testing/selftests/powerpc/switch_endian/switch_endian_test.S

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 1d5e7ad2c460..85c24a2210b5 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -13,7 +13,7 @@ CFLAGS := -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CUR
 
 export CC CFLAGS
 
-TARGETS = pmu copyloops mm tm primitives stringloops
+TARGETS = pmu copyloops mm tm primitives stringloops switch_endian
 
 endif
 
diff --git a/tools/testing/selftests/powerpc/switch_endian/Makefile b/tools/testing/selftests/powerpc/switch_endian/Makefile
new file mode 100644
index 000000000000..c7fefbf880b5
--- /dev/null
+++ b/tools/testing/selftests/powerpc/switch_endian/Makefile
@@ -0,0 +1,23 @@
+PROGS := switch_endian_test
+
+ASFLAGS += -O2 -Wall -g -nostdlib -m64
+
+all: $(PROGS)
+
+switch_endian_test: check-reversed.S
+
+check-reversed.o: check.o
+	objcopy -j .text --reverse-bytes=4 -O binary $< $@
+
+check-reversed.S: check-reversed.o
+	hexdump -v -e '/1 ".byte 0x%02X\n"' $< > $@
+
+run_tests: all
+	@-for PROG in $(PROGS); do \
+		./$$PROG; \
+	done;
+
+clean:
+	rm -f $(PROGS) *.o check-reversed.S
+
+.PHONY: all run_tests clean
diff --git a/tools/testing/selftests/powerpc/switch_endian/check.S b/tools/testing/selftests/powerpc/switch_endian/check.S
new file mode 100644
index 000000000000..671d20ab9cf9
--- /dev/null
+++ b/tools/testing/selftests/powerpc/switch_endian/check.S
@@ -0,0 +1,101 @@
+#include "common.h"
+
+/*
+ * Checks that registers contain what we expect, ie. they were not clobbered by
+ * the syscall. If that all works we then print a message.
+ *
+ * r14: address of message to print (size is hardcoded at 25 bytes)
+ * r15: pattern to check registers against.
+ *
+ * At the end r3 == 0 if everything's OK.
+ */
+	nop	# guaranteed to be illegal in reverse-endian
+	cmpd    r15,r3
+	bne     1f
+	addi    r3,r15,4
+	cmpd    r3,r4
+	bne     1f
+	lis     r3,0x00FF
+	ori     r3,r3,0xF000
+	mfcr    r4
+	and     r4,r4,r3
+	cmpw    r3,r4
+	addi    r3,r15,34
+	bne     1f
+	addi    r3,r15,32
+	mflr    r4
+	cmpd    r3,r4
+	bne     1f
+	addi    r3,r15,5
+	cmpd    r3,r5
+	bne     1f
+	addi    r3,r15,6
+	cmpd    r3,r6
+	bne     1f
+	addi    r3,r15,7
+	cmpd    r3,r7
+	bne     1f
+	addi    r3,r15,8
+	cmpd    r3,r8
+	bne     1f
+	addi    r3,r15,13
+	cmpd    r3,r13
+	bne     1f
+	addi    r3,r15,16
+	cmpd    r3,r16
+	bne     1f
+	addi    r3,r15,17
+	cmpd    r3,r17
+	bne     1f
+	addi    r3,r15,18
+	cmpd    r3,r18
+	bne     1f
+	addi    r3,r15,19
+	cmpd    r3,r19
+	bne     1f
+	addi    r3,r15,20
+	cmpd    r3,r20
+	bne     1f
+	addi    r3,r15,21
+	cmpd    r3,r21
+	bne     1f
+	addi    r3,r15,22
+	cmpd    r3,r22
+	bne     1f
+	addi    r3,r15,23
+	cmpd    r3,r23
+	bne     1f
+	addi    r3,r15,24
+	cmpd    r3,r24
+	bne     1f
+	addi    r3,r15,25
+	cmpd    r3,r25
+	bne     1f
+	addi    r3,r15,26
+	cmpd    r3,r26
+	bne     1f
+	addi    r3,r15,27
+	cmpd    r3,r27
+	bne     1f
+	addi    r3,r15,28
+	cmpd    r3,r28
+	bne     1f
+	addi    r3,r15,29
+	cmpd    r3,r29
+	bne     1f
+	addi    r3,r15,30
+	cmpd    r3,r30
+	bne     1f
+	addi    r3,r15,31
+	cmpd    r3,r31
+	bne     1f
+	li      r0,4
+	li      r3,1	/* stdout */
+	mr      r4,r14
+	li      r5,25	/* strlen(message) */
+	sc
+	b	2f
+1:	li	r0, __NR_exit
+	sc
+2:	li	r0, __NR_switch_endian
+	nop
diff --git a/tools/testing/selftests/powerpc/switch_endian/common.h b/tools/testing/selftests/powerpc/switch_endian/common.h
new file mode 100644
index 000000000000..69e399698c64
--- /dev/null
+++ b/tools/testing/selftests/powerpc/switch_endian/common.h
@@ -0,0 +1,6 @@
+#include <ppc-asm.h>
+#include <asm/unistd.h>
+
+#ifndef __NR_switch_endian
+#define __NR_switch_endian 363
+#endif
diff --git a/tools/testing/selftests/powerpc/switch_endian/switch_endian_test.S b/tools/testing/selftests/powerpc/switch_endian/switch_endian_test.S
new file mode 100644
index 000000000000..f26475a9f811
--- /dev/null
+++ b/tools/testing/selftests/powerpc/switch_endian/switch_endian_test.S
@@ -0,0 +1,92 @@
+#include "common.h"
+
+	.data
+	.balign 8
+message1:
+	.ascii "Hello wrong-endian world\n\0"
+
+message2:
+	.ascii "Hello right-endian world\n\0"
+
+message3:
+	.ascii "success: switch_endian_test\n\0"
+
+	.section ".toc"
+	.balign 8
+pattern:
+	.llong 0x5555AAAA5555AAAA
+
+	.text
+FUNC_START(_start)
+	/* Load some addresses to start with */
+	ld	r14, message1@got(%r2)
+	ld	r15, pattern@TOC(%r2)
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
+#include "check-reversed.S"
+
+	/* Flip back, r0 already has the switch syscall number */
+	.long	0x02000044	/* sc */
+
+	ld	r14, message2@got(%r2)
+	mr	r3, r15
+	addi	r4, r15, 4
+	addi	r5, r15, 5
+
+#include "check.S"
+
+	li	r0, __NR_write
+	li	r3, 1	/* stdout */
+	ld	r4, message3@got(%r2)
+	li	r5, 28	/* strlen(message3) */
+	sc
+	li      r0, __NR_exit
+	li	r3, 0
+	sc
+	b       .
-- 
2.1.0
