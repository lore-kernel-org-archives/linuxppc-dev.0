Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D281B1A03A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 18:36:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [RFC PATCH 2/2] selftests/powerpc: Add a test of the switch_endian()
 syscall
Date: Tue, 10 Mar 2015 18:36:46 +1100
Message-Id: <1425973006-22759-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1425973006-22759-1-git-send-email-mpe@ellerman.id.au>
References: <1425973006-22759-1-git-send-email-mpe@ellerman.id.au>
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
code in the other endian which writes to stdout and then does exit(0).

If the endian switch failed to happen that code sequence will be illegal
and cause the test to abort.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/Makefile           |  2 +-
 tools/testing/selftests/powerpc/syscalls/Makefile  | 15 ++++++++
 .../selftests/powerpc/syscalls/endian-test.S       | 43 ++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)
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
index 000000000000..ba596eb9925f
--- /dev/null
+++ b/tools/testing/selftests/powerpc/syscalls/endian-test.S
@@ -0,0 +1,43 @@
+#include <ppc-asm.h>
+#include <asm/unistd.h>
+
+	.data
+	.balign 8
+message:
+	.ascii "success: endian-test\n"
+
+	.text
+FUNC_START(_start)
+	ld r14, message@got(%r2)
+
+	/* Call the syscall to flip endian */
+	li r0, 363
+	sc
+
+	/*
+	 * The longs below encode the following code snippet, in the other
+	 * endian. We preloaded the address of message into r14 in case it
+	 * moves.
+	 *
+	 *	li r0, __NR_write
+	 *	li r3, 1	# stdout
+	 *      mr r4, r14	# Get &message
+	 *	li r5, 21	# strlen(message)
+	 *	sc
+	 *	li r0, __NR_exit
+	 *	li r3, 0	# exit(0)
+	 *	sc
+	 *	b .
+	 *
+	 * In both cases, if the endian has not been flipped the processor will
+	 * see an illegal instruction and the process will exit abnormally.
+	 */
+	.long 0x04000038
+	.long 0x01006038
+	.long 0x7873c47d
+	.long 0x1500a038
+	.long 0x02000044
+	.long 0x01000038
+	.long 0x00006038
+	.long 0x02000044
+	.long 0x00000048
-- 
2.1.0
