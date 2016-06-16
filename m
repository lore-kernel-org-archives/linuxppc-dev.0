Return-Path: <chris@distroguy.com>
Received: from mx-out01.mykolab.com (mx01.mykolab.com [95.128.36.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW09H22BkzDr1t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 09:34:59 +1000 (AEST)
Received: from mx03.mykolab.com (mx03.mykolab.com [10.20.7.101])
 by mx-out01.mykolab.com (Postfix) with ESMTPS id 194C7615E4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 01:34:54 +0200 (CEST)
Date: Fri, 17 Jun 2016 09:34:47 +1000
From: Chris Smart <chris@distroguy.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [Patch v2 2/2] selftests/powerpc: Test unaligned copy and paste
Message-ID: <20160616233442.GA14583@distroguy.com>
References: <e37b8e320e55954bfaa36593197a2fa35db109cf.1466119782.git.chris@distroguy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <e37b8e320e55954bfaa36593197a2fa35db109cf.1466119782.git.chris@distroguy.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Test that an ISA 3.0 compliant machine performing an unaligned copy,
copy_first, paste or paste_last is sent a SIGBUS.

Signed-off-by: Chris Smart <chris@distroguy.com>
---

Changes since v1:
 - check that the instruction we trapped on was the one we want
 - split out tests into common code

 tools/testing/selftests/powerpc/Makefile           |  3 +-
 .../testing/selftests/powerpc/alignment/.gitignore |  5 ++
 tools/testing/selftests/powerpc/alignment/Makefile | 11 ++++
 .../powerpc/alignment/copy_first_unaligned.c       | 41 +++++++++++++
 .../alignment/copy_paste_unaligned_common.c        | 53 +++++++++++++++++
 .../alignment/copy_paste_unaligned_common.h        | 26 +++++++++
 .../selftests/powerpc/alignment/copy_unaligned.c   | 41 +++++++++++++
 .../powerpc/alignment/paste_last_unaligned.c       | 43 ++++++++++++++
 .../selftests/powerpc/alignment/paste_unaligned.c  | 43 ++++++++++++++
 tools/testing/selftests/powerpc/instructions.h     | 68 ++++++++++++++++++++++
 10 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/alignment/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/alignment/Makefile
 create mode 100644 tools/testing/selftests/powerpc/alignment/copy_first_unaligned.c
 create mode 100644 tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.c
 create mode 100644 tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.h
 create mode 100644 tools/testing/selftests/powerpc/alignment/copy_unaligned.c
 create mode 100644 tools/testing/selftests/powerpc/alignment/paste_last_unaligned.c
 create mode 100644 tools/testing/selftests/powerpc/alignment/paste_unaligned.c
 create mode 100644 tools/testing/selftests/powerpc/instructions.h

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 4ca83fe80654..3c40c9d0e6c7 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -12,7 +12,8 @@ CFLAGS := -Wall -O2 -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CURDIR) $
 
 export CFLAGS
 
-SUB_DIRS = benchmarks 		\
+SUB_DIRS = alignment		\
+	   benchmarks		\
 	   copyloops		\
 	   context_switch	\
 	   dscr			\
diff --git a/tools/testing/selftests/powerpc/alignment/.gitignore b/tools/testing/selftests/powerpc/alignment/.gitignore
new file mode 100644
index 000000000000..1d980e3d7039
--- /dev/null
+++ b/tools/testing/selftests/powerpc/alignment/.gitignore
@@ -0,0 +1,5 @@
+copy_unaligned
+copy_first_unaligned
+paste_unaligned
+paste_last_unaligned
+copy_paste_unaligned_common
diff --git a/tools/testing/selftests/powerpc/alignment/Makefile b/tools/testing/selftests/powerpc/alignment/Makefile
new file mode 100644
index 000000000000..8e5619a8029b
--- /dev/null
+++ b/tools/testing/selftests/powerpc/alignment/Makefile
@@ -0,0 +1,11 @@
+TEST_PROGS := copy_unaligned copy_first_unaligned paste_unaligned paste_last_unaligned
+
+all: $(TEST_PROGS)
+
+$(TEST_PROGS): ../harness.c ../utils.c copy_paste_unaligned_common.c
+
+include ../../lib.mk
+
+clean:
+	rm -f $(TEST_PROGS)
+
diff --git a/tools/testing/selftests/powerpc/alignment/copy_first_unaligned.c b/tools/testing/selftests/powerpc/alignment/copy_first_unaligned.c
new file mode 100644
index 000000000000..47b73b3a08bd
--- /dev/null
+++ b/tools/testing/selftests/powerpc/alignment/copy_first_unaligned.c
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2016, Chris Smart, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Calls to copy_first which are not 128-byte aligned should be
+ * caught and sent a SIGBUS.
+ *
+ */
+
+#include <string.h>
+#include <unistd.h>
+#include "utils.h"
+#include "instructions.h"
+#include "copy_paste_unaligned_common.h"
+
+unsigned int expected_instruction = PPC_INST_COPY_FIRST;
+unsigned int instruction_mask = 0xfc2007fe;
+
+int test_copy_first_unaligned(void)
+{
+	/* Only run this test on a P9 or later */
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
+
+	/* Register our signal handler with SIGBUS */
+	setup_signal_handler();
+
+	/* +1 makes buf unaligned */
+	copy_first(cacheline_buf+1);
+
+	/* We should not get here */
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_copy_first_unaligned, "test_copy_first_unaligned");
+}
diff --git a/tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.c b/tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.c
new file mode 100644
index 000000000000..d35fa5f5d2d3
--- /dev/null
+++ b/tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.c
@@ -0,0 +1,53 @@
+/*
+ * Copyright 2016, Chris Smart, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Common code for copy, copy_first, paste and paste_last unaligned
+ * tests.
+ *
+ */
+
+#include <signal.h>
+#include <string.h>
+#include <unistd.h>
+#include "utils.h"
+#include "instructions.h"
+#include "copy_paste_unaligned_common.h"
+
+unsigned int expected_instruction;
+unsigned int instruction_mask;
+
+char cacheline_buf[128] __cacheline_aligned;
+
+void signal_action_handler(int signal_num, siginfo_t *info, void *ptr)
+{
+	ucontext_t *ctx = ptr;
+#if defined(__powerpc64__)
+	unsigned int *pc = (unsigned int *)ctx->uc_mcontext.gp_regs[PT_NIP];
+#else
+	unsigned int *pc = (unsigned int *)ctx->uc_mcontext.uc_regs->gregs[PT_NIP];
+#endif
+
+	/*
+	 * Check that the signal was on the correct instruction, using a
+	 * mask because the compiler assigns the register at RB.
+	 */
+	if ((*pc & instruction_mask) == expected_instruction)
+		_exit(0); /* We hit the right instruction */
+
+	_exit(1);
+}
+
+void setup_signal_handler(void)
+{
+	struct sigaction signal_action;
+
+	memset(&signal_action, 0, sizeof(signal_action));
+	signal_action.sa_sigaction = signal_action_handler;
+	signal_action.sa_flags = SA_SIGINFO;
+	sigaction(SIGBUS, &signal_action, NULL);
+}
diff --git a/tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.h b/tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.h
new file mode 100644
index 000000000000..053899fe506e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright 2016, Chris Smart, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Declarations for common code for copy, copy_first, paste and
+ * paste_last unaligned tests.
+ *
+ */
+
+#ifndef _SELFTESTS_POWERPC_COPY_PASTE_H
+#define _SELFTESTS_POWERPC_COPY_PASTE_H
+
+#include <signal.h>
+
+int main(int argc, char *argv[]);
+void signal_action_handler(int signal_num, siginfo_t *info, void *ptr);
+void setup_signal_handler(void);
+extern char cacheline_buf[128] __cacheline_aligned;
+extern unsigned int expected_instruction;
+extern unsigned int instruction_mask;
+
+#endif /* _SELFTESTS_POWERPC_COPY_PASTE_H */
diff --git a/tools/testing/selftests/powerpc/alignment/copy_unaligned.c b/tools/testing/selftests/powerpc/alignment/copy_unaligned.c
new file mode 100644
index 000000000000..3a4e26461554
--- /dev/null
+++ b/tools/testing/selftests/powerpc/alignment/copy_unaligned.c
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2016, Chris Smart, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Calls to copy which are not 128-byte aligned should be caught
+ * and sent a SIGBUS.
+ *
+ */
+
+#include <string.h>
+#include <unistd.h>
+#include "utils.h"
+#include "instructions.h"
+#include "copy_paste_unaligned_common.h"
+
+unsigned int expected_instruction = PPC_INST_COPY;
+unsigned int instruction_mask = 0xfc0007fe;
+
+int test_copy_unaligned(void)
+{
+	/* Only run this test on a P9 or later */
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
+
+	/* Register our signal handler with SIGBUS */
+	setup_signal_handler();
+
+	/* +1 makes buf unaligned */
+	copy(cacheline_buf+1);
+
+	/* We should not get here */
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_copy_unaligned, "test_copy_unaligned");
+}
diff --git a/tools/testing/selftests/powerpc/alignment/paste_last_unaligned.c b/tools/testing/selftests/powerpc/alignment/paste_last_unaligned.c
new file mode 100644
index 000000000000..6e0ad045fcc3
--- /dev/null
+++ b/tools/testing/selftests/powerpc/alignment/paste_last_unaligned.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright 2016, Chris Smart, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Calls to paste_last which are not 128-byte aligned should be
+ * caught and sent a SIGBUS.
+ *
+ */
+
+#include <string.h>
+#include <unistd.h>
+#include "utils.h"
+#include "instructions.h"
+#include "copy_paste_unaligned_common.h"
+
+unsigned int expected_instruction = PPC_INST_PASTE_LAST;
+unsigned int instruction_mask = 0xfc2007ff;
+
+int test_paste_last_unaligned(void)
+{
+	/* Only run this test on a P9 or later */
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
+
+	/* Register our signal handler with SIGBUS */
+	setup_signal_handler();
+
+	copy(cacheline_buf);
+
+	/* +1 makes buf unaligned */
+	paste_last(cacheline_buf+1);
+
+	/* We should not get here */
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_paste_last_unaligned, "test_paste_last_unaligned");
+}
diff --git a/tools/testing/selftests/powerpc/alignment/paste_unaligned.c b/tools/testing/selftests/powerpc/alignment/paste_unaligned.c
new file mode 100644
index 000000000000..6f982b45e4bd
--- /dev/null
+++ b/tools/testing/selftests/powerpc/alignment/paste_unaligned.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright 2016, Chris Smart, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Calls to paste which are not 128-byte aligned should be caught
+ * and sent a SIGBUS.
+ *
+ */
+
+#include <string.h>
+#include <unistd.h>
+#include "utils.h"
+#include "instructions.h"
+#include "copy_paste_unaligned_common.h"
+
+unsigned int expected_instruction = PPC_INST_PASTE;
+unsigned int instruction_mask = 0xfc0007fe;
+
+int test_paste_unaligned(void)
+{
+	/* Only run this test on a P9 or later */
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
+
+	/* Register our signal handler with SIGBUS */
+	setup_signal_handler();
+
+	copy(cacheline_buf);
+
+	/* +1 makes buf unaligned */
+	paste(cacheline_buf+1);
+
+	/* We should not get here */
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_paste_unaligned, "test_paste_unaligned");
+}
diff --git a/tools/testing/selftests/powerpc/instructions.h b/tools/testing/selftests/powerpc/instructions.h
new file mode 100644
index 000000000000..0fb0bd3b28c9
--- /dev/null
+++ b/tools/testing/selftests/powerpc/instructions.h
@@ -0,0 +1,68 @@
+#ifndef _SELFTESTS_POWERPC_INSTRUCTIONS_H
+#define _SELFTESTS_POWERPC_INSTRUCTIONS_H
+
+#include <stdio.h>
+#include <stdlib.h>
+
+/* This defines the "copy" instruction from Power ISA 3.0 Book II, section 4.4. */
+#define __COPY(RA, RB, L) \
+	(0x7c00060c | (RA) << (31-15) | (RB) << (31-20) | (L) << (31-10))
+#define COPY(RA, RB, L) \
+	.long __COPY((RA), (RB), (L))
+
+static inline void copy(void *i)
+{
+	asm volatile(str(COPY(0, %0, 0))";"
+			:
+			: "b" (i)
+			: "memory"
+		    );
+}
+
+static inline void copy_first(void *i)
+{
+	asm volatile(str(COPY(0, %0, 1))";"
+			:
+			: "b" (i)
+			: "memory"
+		    );
+}
+
+/* This defines the "paste" instruction from Power ISA 3.0 Book II, section 4.4. */
+#define __PASTE(RA, RB, L, RC) \
+	(0x7c00070c | (RA) << (31-15) | (RB) << (31-20) | (L) << (31-10) | (RC) << (31-31))
+#define PASTE(RA, RB, L, RC) \
+	.long __PASTE((RA), (RB), (L), (RC))
+
+static inline int paste(void *i)
+{
+	int cr;
+
+	asm volatile(str(PASTE(0, %1, 0, 0))";"
+			"mfcr %0;"
+			: "=r" (cr)
+			: "b" (i)
+			: "memory"
+		    );
+	return cr;
+}
+
+static inline int paste_last(void *i)
+{
+	int cr;
+
+	asm volatile(str(PASTE(0, %1, 1, 1))";"
+			"mfcr %0;"
+			: "=r" (cr)
+			: "b" (i)
+			: "memory"
+		    );
+	return cr;
+}
+
+#define PPC_INST_COPY                  __COPY(0, 0, 0)
+#define PPC_INST_COPY_FIRST            __COPY(0, 0, 1)
+#define PPC_INST_PASTE                 __PASTE(0, 0, 0, 0)
+#define PPC_INST_PASTE_LAST            __PASTE(0, 0, 1, 1)
+
+#endif /* _SELFTESTS_POWERPC_INSTRUCTIONS_H */
-- 
2.7.4
