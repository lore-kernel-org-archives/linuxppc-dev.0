Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3nVz1hrwzDt8v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 22:15:23 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id u84so2148027pfj.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 04:15:23 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Shuah Khan <shuah@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Cyril Bur <cyrilbur@gmail.com>, Chris Smart <chris@distroguy.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>, Jack Miller <jack@codezen.org>,
 Rashmica Gupta <rashmicy@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: [PATCH v16 02/15] selftests/powerpc: move shared utility files into
 new utility/ dir
Date: Wed, 26 Oct 2016 19:13:44 +0800
Message-Id: <1477480437-12937-3-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1477480437-12937-1-git-send-email-wei.guo.simon@gmail.com>
References: <1477480437-12937-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

There are some functions, especially register related, which can
be shared across multiple selftests/powerpc test directories.

This patch creates a new utility directory to store those shared
functionalities, so that the file layout becomes more neat.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 tools/testing/selftests/powerpc/Makefile           |  2 +-
 tools/testing/selftests/powerpc/alignment/Makefile |  2 +-
 tools/testing/selftests/powerpc/basic_asm.h        | 70 ----------------
 .../testing/selftests/powerpc/benchmarks/Makefile  |  2 +-
 .../selftests/powerpc/benchmarks/context_switch.c  |  2 +-
 .../selftests/powerpc/context_switch/Makefile      |  2 +-
 .../testing/selftests/powerpc/copyloops/validate.c |  2 +-
 tools/testing/selftests/powerpc/fpu_asm.h          | 80 ------------------
 tools/testing/selftests/powerpc/gpr_asm.h          | 96 ----------------------
 tools/testing/selftests/powerpc/instructions.h     | 68 ---------------
 tools/testing/selftests/powerpc/math/fpu_asm.S     |  4 +-
 tools/testing/selftests/powerpc/math/vmx_asm.S     |  4 +-
 tools/testing/selftests/powerpc/math/vsx_asm.S     |  4 +-
 tools/testing/selftests/powerpc/mm/Makefile        |  2 +-
 tools/testing/selftests/powerpc/pmu/Makefile       |  4 +-
 tools/testing/selftests/powerpc/pmu/ebb/Makefile   |  2 +-
 tools/testing/selftests/powerpc/reg.h              | 89 --------------------
 tools/testing/selftests/powerpc/signal/Makefile    |  2 +-
 tools/testing/selftests/powerpc/signal/signal.S    |  2 +-
 .../testing/selftests/powerpc/stringloops/memcmp.c |  2 +-
 tools/testing/selftests/powerpc/tm/Makefile        |  2 +-
 tools/testing/selftests/powerpc/tm/tm-signal.S     | 10 +--
 tools/testing/selftests/powerpc/tm/tm.h            |  2 +-
 .../testing/selftests/powerpc/utility/basic_asm.h  | 73 ++++++++++++++++
 tools/testing/selftests/powerpc/utility/fpu_asm.h  | 80 ++++++++++++++++++
 tools/testing/selftests/powerpc/utility/gpr_asm.h  | 96 ++++++++++++++++++++++
 .../selftests/powerpc/utility/instructions.h       | 68 +++++++++++++++
 tools/testing/selftests/powerpc/utility/reg.h      | 89 ++++++++++++++++++++
 tools/testing/selftests/powerpc/utility/utils.c    | 87 ++++++++++++++++++++
 tools/testing/selftests/powerpc/utility/utils.h    | 77 +++++++++++++++++
 tools/testing/selftests/powerpc/utility/vmx_asm.h  | 96 ++++++++++++++++++++++
 tools/testing/selftests/powerpc/utility/vsx_asm.h  | 71 ++++++++++++++++
 tools/testing/selftests/powerpc/utils.c            | 87 --------------------
 tools/testing/selftests/powerpc/utils.h            | 77 -----------------
 tools/testing/selftests/powerpc/vmx_asm.h          | 96 ----------------------
 tools/testing/selftests/powerpc/vsx_asm.h          | 71 ----------------
 36 files changed, 763 insertions(+), 760 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/basic_asm.h
 delete mode 100644 tools/testing/selftests/powerpc/fpu_asm.h
 delete mode 100644 tools/testing/selftests/powerpc/gpr_asm.h
 delete mode 100644 tools/testing/selftests/powerpc/instructions.h
 delete mode 100644 tools/testing/selftests/powerpc/reg.h
 create mode 100644 tools/testing/selftests/powerpc/utility/basic_asm.h
 create mode 100644 tools/testing/selftests/powerpc/utility/fpu_asm.h
 create mode 100644 tools/testing/selftests/powerpc/utility/gpr_asm.h
 create mode 100644 tools/testing/selftests/powerpc/utility/instructions.h
 create mode 100644 tools/testing/selftests/powerpc/utility/reg.h
 create mode 100644 tools/testing/selftests/powerpc/utility/utils.c
 create mode 100644 tools/testing/selftests/powerpc/utility/utils.h
 create mode 100644 tools/testing/selftests/powerpc/utility/vmx_asm.h
 create mode 100644 tools/testing/selftests/powerpc/utility/vsx_asm.h
 delete mode 100644 tools/testing/selftests/powerpc/utils.c
 delete mode 100644 tools/testing/selftests/powerpc/utils.h
 delete mode 100644 tools/testing/selftests/powerpc/vmx_asm.h
 delete mode 100644 tools/testing/selftests/powerpc/vsx_asm.h

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index db54a33..cd65cb5 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -8,7 +8,7 @@ ifeq ($(ARCH),powerpc)
 
 GIT_VERSION = $(shell git describe --always --long --dirty || echo "unknown")
 
-CFLAGS := -std=gnu99 -Wall -O2 -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CURDIR) $(CFLAGS)
+CFLAGS := -std=gnu99 -Wall -O2 -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CURDIR) -I$(CURDIR)/utility $(CFLAGS)
 
 export CFLAGS
 
diff --git a/tools/testing/selftests/powerpc/alignment/Makefile b/tools/testing/selftests/powerpc/alignment/Makefile
index ad6a4e4..b61e5e7 100644
--- a/tools/testing/selftests/powerpc/alignment/Makefile
+++ b/tools/testing/selftests/powerpc/alignment/Makefile
@@ -2,7 +2,7 @@ TEST_PROGS := copy_unaligned copy_first_unaligned paste_unaligned paste_last_una
 
 all: $(TEST_PROGS)
 
-$(TEST_PROGS): ../harness.c ../utils.c copy_paste_unaligned_common.c
+$(TEST_PROGS): ../harness.c ../utility/utils.c copy_paste_unaligned_common.c
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/basic_asm.h b/tools/testing/selftests/powerpc/basic_asm.h
deleted file mode 100644
index 3349a07..0000000
--- a/tools/testing/selftests/powerpc/basic_asm.h
+++ /dev/null
@@ -1,70 +0,0 @@
-#ifndef _SELFTESTS_POWERPC_BASIC_ASM_H
-#define _SELFTESTS_POWERPC_BASIC_ASM_H
-
-#include <ppc-asm.h>
-#include <asm/unistd.h>
-
-#define LOAD_REG_IMMEDIATE(reg,expr) \
-	lis	reg,(expr)@highest;	\
-	ori	reg,reg,(expr)@higher;	\
-	rldicr	reg,reg,32,31;	\
-	oris	reg,reg,(expr)@high;	\
-	ori	reg,reg,(expr)@l;
-
-/*
- * Note: These macros assume that variables being stored on the stack are
- * doublewords, while this is usually the case it may not always be the
- * case for each use case.
- */
-#if defined(_CALL_ELF) && _CALL_ELF == 2
-#define STACK_FRAME_MIN_SIZE 32
-#define STACK_FRAME_TOC_POS  24
-#define __STACK_FRAME_PARAM(_param)  (32 + ((_param)*8))
-#define __STACK_FRAME_LOCAL(_num_params,_var_num)  ((STACK_FRAME_PARAM(_num_params)) + ((_var_num)*8))
-#else
-#define STACK_FRAME_MIN_SIZE 112
-#define STACK_FRAME_TOC_POS  40
-#define __STACK_FRAME_PARAM(i)  (48 + ((i)*8))
-
-/*
- * Caveat: if a function passed more than 8 doublewords, the caller will have
- * made more space... which would render the 112 incorrect.
- */
-#define __STACK_FRAME_LOCAL(_num_params,_var_num)  (112 + ((_var_num)*8))
-#endif
-
-/* Parameter x saved to the stack */
-#define STACK_FRAME_PARAM(var)    __STACK_FRAME_PARAM(var)
-
-/* Local variable x saved to the stack after x parameters */
-#define STACK_FRAME_LOCAL(num_params,var)    __STACK_FRAME_LOCAL(num_params,var)
-#define STACK_FRAME_LR_POS   16
-#define STACK_FRAME_CR_POS   8
-
-/*
- * It is very important to note here that _extra is the extra amount of
- * stack space needed. This space can be accessed using STACK_FRAME_PARAM()
- * or STACK_FRAME_LOCAL() macros.
- *
- * r1 and r2 are not defined in ppc-asm.h (instead they are defined as sp
- * and toc). Kernel programmers tend to prefer rX even for r1 and r2, hence
- * %1 and %r2. r0 is defined in ppc-asm.h and therefore %r0 gets
- * preprocessed incorrectly, hence r0.
- */
-#define PUSH_BASIC_STACK(_extra) \
-	mflr	r0; \
-	std	r0,STACK_FRAME_LR_POS(%r1); \
-	stdu	%r1,-(_extra + STACK_FRAME_MIN_SIZE)(%r1); \
-	mfcr	r0; \
-	stw	r0,STACK_FRAME_CR_POS(%r1); \
-	std	%r2,STACK_FRAME_TOC_POS(%r1);
-
-#define POP_BASIC_STACK(_extra) \
-	ld	%r2,STACK_FRAME_TOC_POS(%r1); \
-	lwz	r0,STACK_FRAME_CR_POS(%r1); \
-	mtcr	r0; \
-	addi	%r1,%r1,(_extra + STACK_FRAME_MIN_SIZE); \
-	ld	r0,STACK_FRAME_LR_POS(%r1); \
-	mtlr	r0;
-
-#endif /* _SELFTESTS_POWERPC_BASIC_ASM_H */
diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
index a9adfb7..fc55d2b 100644
--- a/tools/testing/selftests/powerpc/benchmarks/Makefile
+++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
@@ -6,7 +6,7 @@ all: $(TEST_PROGS)
 
 $(TEST_PROGS): ../harness.c
 
-context_switch: ../utils.c
+context_switch: ../utility/utils.c
 context_switch: CFLAGS += -maltivec -mvsx -mabi=altivec
 context_switch: LDLIBS += -lpthread
 
diff --git a/tools/testing/selftests/powerpc/benchmarks/context_switch.c b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
index a36883a..778f5fb 100644
--- a/tools/testing/selftests/powerpc/benchmarks/context_switch.c
+++ b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
@@ -28,7 +28,7 @@
 #ifdef __powerpc__
 #include <altivec.h>
 #endif
-#include "../utils.h"
+#include "utils.h"
 
 static unsigned int timeout = 30;
 
diff --git a/tools/testing/selftests/powerpc/context_switch/Makefile b/tools/testing/selftests/powerpc/context_switch/Makefile
index e164d14..48b558f 100644
--- a/tools/testing/selftests/powerpc/context_switch/Makefile
+++ b/tools/testing/selftests/powerpc/context_switch/Makefile
@@ -2,7 +2,7 @@ TEST_PROGS := cp_abort
 
 all: $(TEST_PROGS)
 
-$(TEST_PROGS): ../harness.c ../utils.c
+$(TEST_PROGS): ../harness.c ../utility/utils.c
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/copyloops/validate.c b/tools/testing/selftests/powerpc/copyloops/validate.c
index 1750ff5..7fb436f 100644
--- a/tools/testing/selftests/powerpc/copyloops/validate.c
+++ b/tools/testing/selftests/powerpc/copyloops/validate.c
@@ -3,7 +3,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 
-#include "../utils.h"
+#include "utils.h"
 
 #define MAX_LEN 8192
 #define MAX_OFFSET 16
diff --git a/tools/testing/selftests/powerpc/fpu_asm.h b/tools/testing/selftests/powerpc/fpu_asm.h
deleted file mode 100644
index 6a387d2..0000000
--- a/tools/testing/selftests/powerpc/fpu_asm.h
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- * Copyright 2016, Cyril Bur, IBM Corp.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef _SELFTESTS_POWERPC_FPU_ASM_H
-#define _SELFTESTS_POWERPC_FPU_ASM_H
-#include "basic_asm.h"
-
-#define PUSH_FPU(stack_size) \
-	stfd	f31,(stack_size + STACK_FRAME_MIN_SIZE)(%r1); \
-	stfd	f30,(stack_size + STACK_FRAME_MIN_SIZE - 8)(%r1); \
-	stfd	f29,(stack_size + STACK_FRAME_MIN_SIZE - 16)(%r1); \
-	stfd	f28,(stack_size + STACK_FRAME_MIN_SIZE - 24)(%r1); \
-	stfd	f27,(stack_size + STACK_FRAME_MIN_SIZE - 32)(%r1); \
-	stfd	f26,(stack_size + STACK_FRAME_MIN_SIZE - 40)(%r1); \
-	stfd	f25,(stack_size + STACK_FRAME_MIN_SIZE - 48)(%r1); \
-	stfd	f24,(stack_size + STACK_FRAME_MIN_SIZE - 56)(%r1); \
-	stfd	f23,(stack_size + STACK_FRAME_MIN_SIZE - 64)(%r1); \
-	stfd	f22,(stack_size + STACK_FRAME_MIN_SIZE - 72)(%r1); \
-	stfd	f21,(stack_size + STACK_FRAME_MIN_SIZE - 80)(%r1); \
-	stfd	f20,(stack_size + STACK_FRAME_MIN_SIZE - 88)(%r1); \
-	stfd	f19,(stack_size + STACK_FRAME_MIN_SIZE - 96)(%r1); \
-	stfd	f18,(stack_size + STACK_FRAME_MIN_SIZE - 104)(%r1); \
-	stfd	f17,(stack_size + STACK_FRAME_MIN_SIZE - 112)(%r1); \
-	stfd	f16,(stack_size + STACK_FRAME_MIN_SIZE - 120)(%r1); \
-	stfd	f15,(stack_size + STACK_FRAME_MIN_SIZE - 128)(%r1); \
-	stfd	f14,(stack_size + STACK_FRAME_MIN_SIZE - 136)(%r1);
-
-#define POP_FPU(stack_size) \
-	lfd	f31,(stack_size + STACK_FRAME_MIN_SIZE)(%r1); \
-	lfd	f30,(stack_size + STACK_FRAME_MIN_SIZE - 8)(%r1); \
-	lfd	f29,(stack_size + STACK_FRAME_MIN_SIZE - 16)(%r1); \
-	lfd	f28,(stack_size + STACK_FRAME_MIN_SIZE - 24)(%r1); \
-	lfd	f27,(stack_size + STACK_FRAME_MIN_SIZE - 32)(%r1); \
-	lfd	f26,(stack_size + STACK_FRAME_MIN_SIZE - 40)(%r1); \
-	lfd	f25,(stack_size + STACK_FRAME_MIN_SIZE - 48)(%r1); \
-	lfd	f24,(stack_size + STACK_FRAME_MIN_SIZE - 56)(%r1); \
-	lfd	f23,(stack_size + STACK_FRAME_MIN_SIZE - 64)(%r1); \
-	lfd	f22,(stack_size + STACK_FRAME_MIN_SIZE - 72)(%r1); \
-	lfd	f21,(stack_size + STACK_FRAME_MIN_SIZE - 80)(%r1); \
-	lfd	f20,(stack_size + STACK_FRAME_MIN_SIZE - 88)(%r1); \
-	lfd	f19,(stack_size + STACK_FRAME_MIN_SIZE - 96)(%r1); \
-	lfd	f18,(stack_size + STACK_FRAME_MIN_SIZE - 104)(%r1); \
-	lfd	f17,(stack_size + STACK_FRAME_MIN_SIZE - 112)(%r1); \
-	lfd	f16,(stack_size + STACK_FRAME_MIN_SIZE - 120)(%r1); \
-	lfd	f15,(stack_size + STACK_FRAME_MIN_SIZE - 128)(%r1); \
-	lfd	f14,(stack_size + STACK_FRAME_MIN_SIZE - 136)(%r1);
-
-/*
- * Careful calling this, it will 'clobber' fpu (by design)
- * Don't call this from C
- */
-FUNC_START(load_fpu)
-	lfd	f14,0(r3)
-	lfd	f15,8(r3)
-	lfd	f16,16(r3)
-	lfd	f17,24(r3)
-	lfd	f18,32(r3)
-	lfd	f19,40(r3)
-	lfd	f20,48(r3)
-	lfd	f21,56(r3)
-	lfd	f22,64(r3)
-	lfd	f23,72(r3)
-	lfd	f24,80(r3)
-	lfd	f25,88(r3)
-	lfd	f26,96(r3)
-	lfd	f27,104(r3)
-	lfd	f28,112(r3)
-	lfd	f29,120(r3)
-	lfd	f30,128(r3)
-	lfd	f31,136(r3)
-	blr
-FUNC_END(load_fpu)
-
-#endif /* _SELFTESTS_POWERPC_FPU_ASM_H */
diff --git a/tools/testing/selftests/powerpc/gpr_asm.h b/tools/testing/selftests/powerpc/gpr_asm.h
deleted file mode 100644
index f6f3885..0000000
--- a/tools/testing/selftests/powerpc/gpr_asm.h
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- * Copyright 2016, Cyril Bur, IBM Corp.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef _SELFTESTS_POWERPC_GPR_ASM_H
-#define _SELFTESTS_POWERPC_GPR_ASM_H
-
-#include "basic_asm.h"
-
-#define __PUSH_NVREGS(top_pos); \
-	std r31,(top_pos)(%r1); \
-	std r30,(top_pos - 8)(%r1); \
-	std r29,(top_pos - 16)(%r1); \
-	std r28,(top_pos - 24)(%r1); \
-	std r27,(top_pos - 32)(%r1); \
-	std r26,(top_pos - 40)(%r1); \
-	std r25,(top_pos - 48)(%r1); \
-	std r24,(top_pos - 56)(%r1); \
-	std r23,(top_pos - 64)(%r1); \
-	std r22,(top_pos - 72)(%r1); \
-	std r21,(top_pos - 80)(%r1); \
-	std r20,(top_pos - 88)(%r1); \
-	std r19,(top_pos - 96)(%r1); \
-	std r18,(top_pos - 104)(%r1); \
-	std r17,(top_pos - 112)(%r1); \
-	std r16,(top_pos - 120)(%r1); \
-	std r15,(top_pos - 128)(%r1); \
-	std r14,(top_pos - 136)(%r1)
-
-#define __POP_NVREGS(top_pos); \
-	ld r31,(top_pos)(%r1); \
-	ld r30,(top_pos - 8)(%r1); \
-	ld r29,(top_pos - 16)(%r1); \
-	ld r28,(top_pos - 24)(%r1); \
-	ld r27,(top_pos - 32)(%r1); \
-	ld r26,(top_pos - 40)(%r1); \
-	ld r25,(top_pos - 48)(%r1); \
-	ld r24,(top_pos - 56)(%r1); \
-	ld r23,(top_pos - 64)(%r1); \
-	ld r22,(top_pos - 72)(%r1); \
-	ld r21,(top_pos - 80)(%r1); \
-	ld r20,(top_pos - 88)(%r1); \
-	ld r19,(top_pos - 96)(%r1); \
-	ld r18,(top_pos - 104)(%r1); \
-	ld r17,(top_pos - 112)(%r1); \
-	ld r16,(top_pos - 120)(%r1); \
-	ld r15,(top_pos - 128)(%r1); \
-	ld r14,(top_pos - 136)(%r1)
-
-#define PUSH_NVREGS(stack_size) \
-	__PUSH_NVREGS(stack_size + STACK_FRAME_MIN_SIZE)
-
-/* 18 NV FPU REGS */
-#define PUSH_NVREGS_BELOW_FPU(stack_size) \
-	__PUSH_NVREGS(stack_size + STACK_FRAME_MIN_SIZE - (18 * 8))
-
-#define POP_NVREGS(stack_size) \
-	__POP_NVREGS(stack_size + STACK_FRAME_MIN_SIZE)
-
-/* 18 NV FPU REGS */
-#define POP_NVREGS_BELOW_FPU(stack_size) \
-	__POP_NVREGS(stack_size + STACK_FRAME_MIN_SIZE - (18 * 8))
-
-/*
- * Careful calling this, it will 'clobber' NVGPRs (by design)
- * Don't call this from C
- */
-FUNC_START(load_gpr)
-	ld	r14,0(r3)
-	ld	r15,8(r3)
-	ld	r16,16(r3)
-	ld	r17,24(r3)
-	ld	r18,32(r3)
-	ld	r19,40(r3)
-	ld	r20,48(r3)
-	ld	r21,56(r3)
-	ld	r22,64(r3)
-	ld	r23,72(r3)
-	ld	r24,80(r3)
-	ld	r25,88(r3)
-	ld	r26,96(r3)
-	ld	r27,104(r3)
-	ld	r28,112(r3)
-	ld	r29,120(r3)
-	ld	r30,128(r3)
-	ld	r31,136(r3)
-	blr
-FUNC_END(load_gpr)
-
-
-#endif /* _SELFTESTS_POWERPC_GPR_ASM_H */
diff --git a/tools/testing/selftests/powerpc/instructions.h b/tools/testing/selftests/powerpc/instructions.h
deleted file mode 100644
index 0fb0bd3..0000000
--- a/tools/testing/selftests/powerpc/instructions.h
+++ /dev/null
@@ -1,68 +0,0 @@
-#ifndef _SELFTESTS_POWERPC_INSTRUCTIONS_H
-#define _SELFTESTS_POWERPC_INSTRUCTIONS_H
-
-#include <stdio.h>
-#include <stdlib.h>
-
-/* This defines the "copy" instruction from Power ISA 3.0 Book II, section 4.4. */
-#define __COPY(RA, RB, L) \
-	(0x7c00060c | (RA) << (31-15) | (RB) << (31-20) | (L) << (31-10))
-#define COPY(RA, RB, L) \
-	.long __COPY((RA), (RB), (L))
-
-static inline void copy(void *i)
-{
-	asm volatile(str(COPY(0, %0, 0))";"
-			:
-			: "b" (i)
-			: "memory"
-		    );
-}
-
-static inline void copy_first(void *i)
-{
-	asm volatile(str(COPY(0, %0, 1))";"
-			:
-			: "b" (i)
-			: "memory"
-		    );
-}
-
-/* This defines the "paste" instruction from Power ISA 3.0 Book II, section 4.4. */
-#define __PASTE(RA, RB, L, RC) \
-	(0x7c00070c | (RA) << (31-15) | (RB) << (31-20) | (L) << (31-10) | (RC) << (31-31))
-#define PASTE(RA, RB, L, RC) \
-	.long __PASTE((RA), (RB), (L), (RC))
-
-static inline int paste(void *i)
-{
-	int cr;
-
-	asm volatile(str(PASTE(0, %1, 0, 0))";"
-			"mfcr %0;"
-			: "=r" (cr)
-			: "b" (i)
-			: "memory"
-		    );
-	return cr;
-}
-
-static inline int paste_last(void *i)
-{
-	int cr;
-
-	asm volatile(str(PASTE(0, %1, 1, 1))";"
-			"mfcr %0;"
-			: "=r" (cr)
-			: "b" (i)
-			: "memory"
-		    );
-	return cr;
-}
-
-#define PPC_INST_COPY                  __COPY(0, 0, 0)
-#define PPC_INST_COPY_FIRST            __COPY(0, 0, 1)
-#define PPC_INST_PASTE                 __PASTE(0, 0, 0, 0)
-#define PPC_INST_PASTE_LAST            __PASTE(0, 0, 1, 1)
-
-#endif /* _SELFTESTS_POWERPC_INSTRUCTIONS_H */
diff --git a/tools/testing/selftests/powerpc/math/fpu_asm.S b/tools/testing/selftests/powerpc/math/fpu_asm.S
index 241f067..8a04bb1 100644
--- a/tools/testing/selftests/powerpc/math/fpu_asm.S
+++ b/tools/testing/selftests/powerpc/math/fpu_asm.S
@@ -7,8 +7,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include "../basic_asm.h"
-#include "../fpu_asm.h"
+#include "basic_asm.h"
+#include "fpu_asm.h"
 
 FUNC_START(check_fpu)
 	mr r4,r3
diff --git a/tools/testing/selftests/powerpc/math/vmx_asm.S b/tools/testing/selftests/powerpc/math/vmx_asm.S
index fd74da4..cb1e5ae 100644
--- a/tools/testing/selftests/powerpc/math/vmx_asm.S
+++ b/tools/testing/selftests/powerpc/math/vmx_asm.S
@@ -7,8 +7,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include "../basic_asm.h"
-#include "../vmx_asm.h"
+#include "basic_asm.h"
+#include "vmx_asm.h"
 
 # Should be safe from C, only touches r4, r5 and v0,v1,v2
 FUNC_START(check_vmx)
diff --git a/tools/testing/selftests/powerpc/math/vsx_asm.S b/tools/testing/selftests/powerpc/math/vsx_asm.S
index a110dd8..8f431f6 100644
--- a/tools/testing/selftests/powerpc/math/vsx_asm.S
+++ b/tools/testing/selftests/powerpc/math/vsx_asm.S
@@ -7,8 +7,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include "../basic_asm.h"
-#include "../vsx_asm.h"
+#include "basic_asm.h"
+#include "vsx_asm.h"
 
 #long check_vsx(vector int *r3);
 #This function wraps storeing VSX regs to the end of an array and a
diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
index 3bdb96e..813797b 100644
--- a/tools/testing/selftests/powerpc/mm/Makefile
+++ b/tools/testing/selftests/powerpc/mm/Makefile
@@ -8,7 +8,7 @@ all: $(TEST_PROGS) $(TEST_FILES)
 
 $(TEST_PROGS): ../harness.c
 
-prot_sao: ../utils.c
+prot_sao: ../utility/utils.c
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index ac41a71..5ca77af 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -2,7 +2,7 @@ noarg:
 	$(MAKE) -C ../
 
 TEST_PROGS := count_instructions l3_bank_test per_event_excludes
-EXTRA_SOURCES := ../harness.c event.c lib.c ../utils.c
+EXTRA_SOURCES := ../harness.c event.c lib.c ../utility/utils.c
 
 all: $(TEST_PROGS) ebb
 
@@ -12,7 +12,7 @@ $(TEST_PROGS): $(EXTRA_SOURCES)
 count_instructions: loop.S count_instructions.c $(EXTRA_SOURCES)
 	$(CC) $(CFLAGS) -m64 -o $@ $^
 
-per_event_excludes: ../utils.c
+per_event_excludes: ../utility/utils.c
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/Makefile b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
index 6b0453e..db4a64f 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
@@ -18,7 +18,7 @@ TEST_PROGS := reg_access_test event_attributes_test cycles_test	\
 
 all: $(TEST_PROGS)
 
-$(TEST_PROGS): ../../harness.c ../../utils.c ../event.c ../lib.c \
+$(TEST_PROGS): ../../harness.c ../../utility/utils.c ../event.c ../lib.c \
 	       ebb.c ebb_handler.S trace.c busy_loop.S
 
 instruction_count_test: ../loop.S
diff --git a/tools/testing/selftests/powerpc/reg.h b/tools/testing/selftests/powerpc/reg.h
deleted file mode 100644
index f5d33db..0000000
--- a/tools/testing/selftests/powerpc/reg.h
+++ /dev/null
@@ -1,89 +0,0 @@
-/*
- * Copyright 2014, Michael Ellerman, IBM Corp.
- * Licensed under GPLv2.
- */
-
-#ifndef _SELFTESTS_POWERPC_REG_H
-#define _SELFTESTS_POWERPC_REG_H
-
-#define __stringify_1(x)        #x
-#define __stringify(x)          __stringify_1(x)
-
-#define mfspr(rn)	({unsigned long rval; \
-			 asm volatile("mfspr %0," _str(rn) \
-				    : "=r" (rval)); rval; })
-#define mtspr(rn, v)	asm volatile("mtspr " _str(rn) ",%0" : \
-				    : "r" ((unsigned long)(v)) \
-				    : "memory")
-
-#define mb()		asm volatile("sync" : : : "memory");
-
-#define SPRN_MMCR2     769
-#define SPRN_MMCRA     770
-#define SPRN_MMCR0     779
-#define   MMCR0_PMAO   0x00000080
-#define   MMCR0_PMAE   0x04000000
-#define   MMCR0_FC     0x80000000
-#define SPRN_EBBHR     804
-#define SPRN_EBBRR     805
-#define SPRN_BESCR     806     /* Branch event status & control register */
-#define SPRN_BESCRS    800     /* Branch event status & control set (1 bits set to 1) */
-#define SPRN_BESCRSU   801     /* Branch event status & control set upper */
-#define SPRN_BESCRR    802     /* Branch event status & control REset (1 bits set to 0) */
-#define SPRN_BESCRRU   803     /* Branch event status & control REset upper */
-
-#define BESCR_PMEO     0x1     /* PMU Event-based exception Occurred */
-#define BESCR_PME      (0x1ul << 32) /* PMU Event-based exception Enable */
-#define BESCR_LME      (0x1ul << 34) /* Load Monitor Enable */
-#define BESCR_LMEO     (0x1ul << 2)  /* Load Monitor Exception Occurred */
-
-#define SPRN_LMRR      813     /* Load Monitor Region Register */
-#define SPRN_LMSER     814     /* Load Monitor Section Enable Register */
-
-#define SPRN_PMC1      771
-#define SPRN_PMC2      772
-#define SPRN_PMC3      773
-#define SPRN_PMC4      774
-#define SPRN_PMC5      775
-#define SPRN_PMC6      776
-
-#define SPRN_SIAR      780
-#define SPRN_SDAR      781
-#define SPRN_SIER      768
-
-#define SPRN_TEXASR     0x82    /* Transaction Exception and Status Register */
-#define SPRN_TFIAR      0x81    /* Transaction Failure Inst Addr    */
-#define SPRN_TFHAR      0x80    /* Transaction Failure Handler Addr */
-#define SPRN_TAR        0x32f	/* Target Address Register */
-
-#define SPRN_DSCR_PRIV 0x11	/* Privilege State DSCR */
-#define SPRN_DSCR      0x03	/* Data Stream Control Register */
-#define SPRN_PPR       896	/* Program Priority Register */
-
-/* TEXASR register bits */
-#define TEXASR_FC	0xFE00000000000000
-#define TEXASR_FP	0x0100000000000000
-#define TEXASR_DA	0x0080000000000000
-#define TEXASR_NO	0x0040000000000000
-#define TEXASR_FO	0x0020000000000000
-#define TEXASR_SIC	0x0010000000000000
-#define TEXASR_NTC	0x0008000000000000
-#define TEXASR_TC	0x0004000000000000
-#define TEXASR_TIC	0x0002000000000000
-#define TEXASR_IC	0x0001000000000000
-#define TEXASR_IFC	0x0000800000000000
-#define TEXASR_ABT	0x0000000100000000
-#define TEXASR_SPD	0x0000000080000000
-#define TEXASR_HV	0x0000000020000000
-#define TEXASR_PR	0x0000000010000000
-#define TEXASR_FS	0x0000000008000000
-#define TEXASR_TE	0x0000000004000000
-#define TEXASR_ROT	0x0000000002000000
-
-/* Vector Instructions */
-#define VSX_XX1(xs, ra, rb)	(((xs) & 0x1f) << 21 | ((ra) << 16) |  \
-				 ((rb) << 11) | (((xs) >> 5)))
-#define STXVD2X(xs, ra, rb)	.long (0x7c000798 | VSX_XX1((xs), (ra), (rb)))
-#define LXVD2X(xs, ra, rb)	.long (0x7c000698 | VSX_XX1((xs), (ra), (rb)))
-
-#endif /* _SELFTESTS_POWERPC_REG_H */
diff --git a/tools/testing/selftests/powerpc/signal/Makefile b/tools/testing/selftests/powerpc/signal/Makefile
index f0eef27..285e1b0 100644
--- a/tools/testing/selftests/powerpc/signal/Makefile
+++ b/tools/testing/selftests/powerpc/signal/Makefile
@@ -2,7 +2,7 @@ TEST_PROGS := signal signal_tm
 
 all: $(TEST_PROGS)
 
-$(TEST_PROGS): ../harness.c ../utils.c signal.S
+$(TEST_PROGS): ../harness.c ../utility/utils.c signal.S
 
 CFLAGS += -maltivec
 signal_tm: CFLAGS += -mhtm
diff --git a/tools/testing/selftests/powerpc/signal/signal.S b/tools/testing/selftests/powerpc/signal/signal.S
index 7043d52..322f2f1 100644
--- a/tools/testing/selftests/powerpc/signal/signal.S
+++ b/tools/testing/selftests/powerpc/signal/signal.S
@@ -7,7 +7,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include "../basic_asm.h"
+#include "basic_asm.h"
 
 /* long signal_self(pid_t pid, int sig); */
 FUNC_START(signal_self)
diff --git a/tools/testing/selftests/powerpc/stringloops/memcmp.c b/tools/testing/selftests/powerpc/stringloops/memcmp.c
index 17417dd..30b1222 100644
--- a/tools/testing/selftests/powerpc/stringloops/memcmp.c
+++ b/tools/testing/selftests/powerpc/stringloops/memcmp.c
@@ -1,7 +1,7 @@
 #include <malloc.h>
 #include <stdlib.h>
 #include <string.h>
-#include "../utils.h"
+#include "utils.h"
 
 #define SIZE 256
 #define ITERATIONS 10000
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index c6c53c8..d7d99de 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -6,7 +6,7 @@ TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
 
 all: $(TEST_PROGS)
 
-$(TEST_PROGS): ../harness.c ../utils.c
+$(TEST_PROGS): ../harness.c ../utility/utils.c
 
 CFLAGS += -mhtm
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal.S b/tools/testing/selftests/powerpc/tm/tm-signal.S
index 4e13e8b..506a4eb 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal.S
+++ b/tools/testing/selftests/powerpc/tm/tm-signal.S
@@ -7,11 +7,11 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include "../basic_asm.h"
-#include "../gpr_asm.h"
-#include "../fpu_asm.h"
-#include "../vmx_asm.h"
-#include "../vsx_asm.h"
+#include "basic_asm.h"
+#include "gpr_asm.h"
+#include "fpu_asm.h"
+#include "vmx_asm.h"
+#include "vsx_asm.h"
 
 /*
  * Large caveat here being that the caller cannot expect the
diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
index 2c8da74..0ffff04 100644
--- a/tools/testing/selftests/powerpc/tm/tm.h
+++ b/tools/testing/selftests/powerpc/tm/tm.h
@@ -10,7 +10,7 @@
 #include <asm/cputable.h>
 #include <stdbool.h>
 
-#include "../utils.h"
+#include "utils.h"
 
 static inline bool have_htm(void)
 {
diff --git a/tools/testing/selftests/powerpc/utility/basic_asm.h b/tools/testing/selftests/powerpc/utility/basic_asm.h
new file mode 100644
index 0000000..12eaddf
--- /dev/null
+++ b/tools/testing/selftests/powerpc/utility/basic_asm.h
@@ -0,0 +1,73 @@
+#ifndef _SELFTESTS_POWERPC_BASIC_ASM_H
+#define _SELFTESTS_POWERPC_BASIC_ASM_H
+
+#include <ppc-asm.h>
+#include <asm/unistd.h>
+
+#define LOAD_REG_IMMEDIATE(reg, expr) \
+	lis	reg, (expr)@highest;	\
+	ori	reg, reg, (expr)@higher;	\
+	rldicr	reg, reg, 32, 31;	\
+	oris	reg, reg, (expr)@high;	\
+	ori	reg, reg, (expr)@l;
+
+/*
+ * Note: These macros assume that variables being stored on the stack are
+ * doublewords, while this is usually the case it may not always be the
+ * case for each use case.
+ */
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+#define STACK_FRAME_MIN_SIZE 32
+#define STACK_FRAME_TOC_POS  24
+#define __STACK_FRAME_PARAM(_param)  (32 + ((_param)*8))
+#define __STACK_FRAME_LOCAL(_num_params, _var_num)  \
+	((STACK_FRAME_PARAM(_num_params)) + ((_var_num)*8))
+#else
+#define STACK_FRAME_MIN_SIZE 112
+#define STACK_FRAME_TOC_POS  40
+#define __STACK_FRAME_PARAM(i)  (48 + ((i)*8))
+
+/*
+ * Caveat: if a function passed more than 8 doublewords, the caller will have
+ * made more space... which would render the 112 incorrect.
+ */
+#define __STACK_FRAME_LOCAL(_num_params, _var_num)  \
+	(112 + ((_var_num)*8))
+#endif
+
+/* Parameter x saved to the stack */
+#define STACK_FRAME_PARAM(var)    __STACK_FRAME_PARAM(var)
+
+/* Local variable x saved to the stack after x parameters */
+#define STACK_FRAME_LOCAL(num_params, var)    \
+	__STACK_FRAME_LOCAL(num_params, var)
+#define STACK_FRAME_LR_POS   16
+#define STACK_FRAME_CR_POS   8
+
+/*
+ * It is very important to note here that _extra is the extra amount of
+ * stack space needed. This space can be accessed using STACK_FRAME_PARAM()
+ * or STACK_FRAME_LOCAL() macros.
+ *
+ * r1 and r2 are not defined in ppc-asm.h (instead they are defined as sp
+ * and toc). Kernel programmers tend to prefer rX even for r1 and r2, hence
+ * %1 and %r2. r0 is defined in ppc-asm.h and therefore %r0 gets
+ * preprocessed incorrectly, hence r0.
+ */
+#define PUSH_BASIC_STACK(_extra) \
+	mflr	r0; \
+	std	r0, STACK_FRAME_LR_POS(%r1); \
+	stdu	%r1, -(_extra + STACK_FRAME_MIN_SIZE)(%r1); \
+	mfcr	r0; \
+	stw	r0, STACK_FRAME_CR_POS(%r1); \
+	std	%r2, STACK_FRAME_TOC_POS(%r1);
+
+#define POP_BASIC_STACK(_extra) \
+	ld	%r2, STACK_FRAME_TOC_POS(%r1); \
+	lwz	r0, STACK_FRAME_CR_POS(%r1); \
+	mtcr	r0; \
+	addi	%r1, %r1, (_extra + STACK_FRAME_MIN_SIZE); \
+	ld	r0, STACK_FRAME_LR_POS(%r1); \
+	mtlr	r0;
+
+#endif /* _SELFTESTS_POWERPC_BASIC_ASM_H */
diff --git a/tools/testing/selftests/powerpc/utility/fpu_asm.h b/tools/testing/selftests/powerpc/utility/fpu_asm.h
new file mode 100644
index 0000000..6a387d2
--- /dev/null
+++ b/tools/testing/selftests/powerpc/utility/fpu_asm.h
@@ -0,0 +1,80 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _SELFTESTS_POWERPC_FPU_ASM_H
+#define _SELFTESTS_POWERPC_FPU_ASM_H
+#include "basic_asm.h"
+
+#define PUSH_FPU(stack_size) \
+	stfd	f31,(stack_size + STACK_FRAME_MIN_SIZE)(%r1); \
+	stfd	f30,(stack_size + STACK_FRAME_MIN_SIZE - 8)(%r1); \
+	stfd	f29,(stack_size + STACK_FRAME_MIN_SIZE - 16)(%r1); \
+	stfd	f28,(stack_size + STACK_FRAME_MIN_SIZE - 24)(%r1); \
+	stfd	f27,(stack_size + STACK_FRAME_MIN_SIZE - 32)(%r1); \
+	stfd	f26,(stack_size + STACK_FRAME_MIN_SIZE - 40)(%r1); \
+	stfd	f25,(stack_size + STACK_FRAME_MIN_SIZE - 48)(%r1); \
+	stfd	f24,(stack_size + STACK_FRAME_MIN_SIZE - 56)(%r1); \
+	stfd	f23,(stack_size + STACK_FRAME_MIN_SIZE - 64)(%r1); \
+	stfd	f22,(stack_size + STACK_FRAME_MIN_SIZE - 72)(%r1); \
+	stfd	f21,(stack_size + STACK_FRAME_MIN_SIZE - 80)(%r1); \
+	stfd	f20,(stack_size + STACK_FRAME_MIN_SIZE - 88)(%r1); \
+	stfd	f19,(stack_size + STACK_FRAME_MIN_SIZE - 96)(%r1); \
+	stfd	f18,(stack_size + STACK_FRAME_MIN_SIZE - 104)(%r1); \
+	stfd	f17,(stack_size + STACK_FRAME_MIN_SIZE - 112)(%r1); \
+	stfd	f16,(stack_size + STACK_FRAME_MIN_SIZE - 120)(%r1); \
+	stfd	f15,(stack_size + STACK_FRAME_MIN_SIZE - 128)(%r1); \
+	stfd	f14,(stack_size + STACK_FRAME_MIN_SIZE - 136)(%r1);
+
+#define POP_FPU(stack_size) \
+	lfd	f31,(stack_size + STACK_FRAME_MIN_SIZE)(%r1); \
+	lfd	f30,(stack_size + STACK_FRAME_MIN_SIZE - 8)(%r1); \
+	lfd	f29,(stack_size + STACK_FRAME_MIN_SIZE - 16)(%r1); \
+	lfd	f28,(stack_size + STACK_FRAME_MIN_SIZE - 24)(%r1); \
+	lfd	f27,(stack_size + STACK_FRAME_MIN_SIZE - 32)(%r1); \
+	lfd	f26,(stack_size + STACK_FRAME_MIN_SIZE - 40)(%r1); \
+	lfd	f25,(stack_size + STACK_FRAME_MIN_SIZE - 48)(%r1); \
+	lfd	f24,(stack_size + STACK_FRAME_MIN_SIZE - 56)(%r1); \
+	lfd	f23,(stack_size + STACK_FRAME_MIN_SIZE - 64)(%r1); \
+	lfd	f22,(stack_size + STACK_FRAME_MIN_SIZE - 72)(%r1); \
+	lfd	f21,(stack_size + STACK_FRAME_MIN_SIZE - 80)(%r1); \
+	lfd	f20,(stack_size + STACK_FRAME_MIN_SIZE - 88)(%r1); \
+	lfd	f19,(stack_size + STACK_FRAME_MIN_SIZE - 96)(%r1); \
+	lfd	f18,(stack_size + STACK_FRAME_MIN_SIZE - 104)(%r1); \
+	lfd	f17,(stack_size + STACK_FRAME_MIN_SIZE - 112)(%r1); \
+	lfd	f16,(stack_size + STACK_FRAME_MIN_SIZE - 120)(%r1); \
+	lfd	f15,(stack_size + STACK_FRAME_MIN_SIZE - 128)(%r1); \
+	lfd	f14,(stack_size + STACK_FRAME_MIN_SIZE - 136)(%r1);
+
+/*
+ * Careful calling this, it will 'clobber' fpu (by design)
+ * Don't call this from C
+ */
+FUNC_START(load_fpu)
+	lfd	f14,0(r3)
+	lfd	f15,8(r3)
+	lfd	f16,16(r3)
+	lfd	f17,24(r3)
+	lfd	f18,32(r3)
+	lfd	f19,40(r3)
+	lfd	f20,48(r3)
+	lfd	f21,56(r3)
+	lfd	f22,64(r3)
+	lfd	f23,72(r3)
+	lfd	f24,80(r3)
+	lfd	f25,88(r3)
+	lfd	f26,96(r3)
+	lfd	f27,104(r3)
+	lfd	f28,112(r3)
+	lfd	f29,120(r3)
+	lfd	f30,128(r3)
+	lfd	f31,136(r3)
+	blr
+FUNC_END(load_fpu)
+
+#endif /* _SELFTESTS_POWERPC_FPU_ASM_H */
diff --git a/tools/testing/selftests/powerpc/utility/gpr_asm.h b/tools/testing/selftests/powerpc/utility/gpr_asm.h
new file mode 100644
index 0000000..f6f3885
--- /dev/null
+++ b/tools/testing/selftests/powerpc/utility/gpr_asm.h
@@ -0,0 +1,96 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _SELFTESTS_POWERPC_GPR_ASM_H
+#define _SELFTESTS_POWERPC_GPR_ASM_H
+
+#include "basic_asm.h"
+
+#define __PUSH_NVREGS(top_pos); \
+	std r31,(top_pos)(%r1); \
+	std r30,(top_pos - 8)(%r1); \
+	std r29,(top_pos - 16)(%r1); \
+	std r28,(top_pos - 24)(%r1); \
+	std r27,(top_pos - 32)(%r1); \
+	std r26,(top_pos - 40)(%r1); \
+	std r25,(top_pos - 48)(%r1); \
+	std r24,(top_pos - 56)(%r1); \
+	std r23,(top_pos - 64)(%r1); \
+	std r22,(top_pos - 72)(%r1); \
+	std r21,(top_pos - 80)(%r1); \
+	std r20,(top_pos - 88)(%r1); \
+	std r19,(top_pos - 96)(%r1); \
+	std r18,(top_pos - 104)(%r1); \
+	std r17,(top_pos - 112)(%r1); \
+	std r16,(top_pos - 120)(%r1); \
+	std r15,(top_pos - 128)(%r1); \
+	std r14,(top_pos - 136)(%r1)
+
+#define __POP_NVREGS(top_pos); \
+	ld r31,(top_pos)(%r1); \
+	ld r30,(top_pos - 8)(%r1); \
+	ld r29,(top_pos - 16)(%r1); \
+	ld r28,(top_pos - 24)(%r1); \
+	ld r27,(top_pos - 32)(%r1); \
+	ld r26,(top_pos - 40)(%r1); \
+	ld r25,(top_pos - 48)(%r1); \
+	ld r24,(top_pos - 56)(%r1); \
+	ld r23,(top_pos - 64)(%r1); \
+	ld r22,(top_pos - 72)(%r1); \
+	ld r21,(top_pos - 80)(%r1); \
+	ld r20,(top_pos - 88)(%r1); \
+	ld r19,(top_pos - 96)(%r1); \
+	ld r18,(top_pos - 104)(%r1); \
+	ld r17,(top_pos - 112)(%r1); \
+	ld r16,(top_pos - 120)(%r1); \
+	ld r15,(top_pos - 128)(%r1); \
+	ld r14,(top_pos - 136)(%r1)
+
+#define PUSH_NVREGS(stack_size) \
+	__PUSH_NVREGS(stack_size + STACK_FRAME_MIN_SIZE)
+
+/* 18 NV FPU REGS */
+#define PUSH_NVREGS_BELOW_FPU(stack_size) \
+	__PUSH_NVREGS(stack_size + STACK_FRAME_MIN_SIZE - (18 * 8))
+
+#define POP_NVREGS(stack_size) \
+	__POP_NVREGS(stack_size + STACK_FRAME_MIN_SIZE)
+
+/* 18 NV FPU REGS */
+#define POP_NVREGS_BELOW_FPU(stack_size) \
+	__POP_NVREGS(stack_size + STACK_FRAME_MIN_SIZE - (18 * 8))
+
+/*
+ * Careful calling this, it will 'clobber' NVGPRs (by design)
+ * Don't call this from C
+ */
+FUNC_START(load_gpr)
+	ld	r14,0(r3)
+	ld	r15,8(r3)
+	ld	r16,16(r3)
+	ld	r17,24(r3)
+	ld	r18,32(r3)
+	ld	r19,40(r3)
+	ld	r20,48(r3)
+	ld	r21,56(r3)
+	ld	r22,64(r3)
+	ld	r23,72(r3)
+	ld	r24,80(r3)
+	ld	r25,88(r3)
+	ld	r26,96(r3)
+	ld	r27,104(r3)
+	ld	r28,112(r3)
+	ld	r29,120(r3)
+	ld	r30,128(r3)
+	ld	r31,136(r3)
+	blr
+FUNC_END(load_gpr)
+
+
+#endif /* _SELFTESTS_POWERPC_GPR_ASM_H */
diff --git a/tools/testing/selftests/powerpc/utility/instructions.h b/tools/testing/selftests/powerpc/utility/instructions.h
new file mode 100644
index 0000000..0fb0bd3
--- /dev/null
+++ b/tools/testing/selftests/powerpc/utility/instructions.h
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
diff --git a/tools/testing/selftests/powerpc/utility/reg.h b/tools/testing/selftests/powerpc/utility/reg.h
new file mode 100644
index 0000000..f5d33db
--- /dev/null
+++ b/tools/testing/selftests/powerpc/utility/reg.h
@@ -0,0 +1,89 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#ifndef _SELFTESTS_POWERPC_REG_H
+#define _SELFTESTS_POWERPC_REG_H
+
+#define __stringify_1(x)        #x
+#define __stringify(x)          __stringify_1(x)
+
+#define mfspr(rn)	({unsigned long rval; \
+			 asm volatile("mfspr %0," _str(rn) \
+				    : "=r" (rval)); rval; })
+#define mtspr(rn, v)	asm volatile("mtspr " _str(rn) ",%0" : \
+				    : "r" ((unsigned long)(v)) \
+				    : "memory")
+
+#define mb()		asm volatile("sync" : : : "memory");
+
+#define SPRN_MMCR2     769
+#define SPRN_MMCRA     770
+#define SPRN_MMCR0     779
+#define   MMCR0_PMAO   0x00000080
+#define   MMCR0_PMAE   0x04000000
+#define   MMCR0_FC     0x80000000
+#define SPRN_EBBHR     804
+#define SPRN_EBBRR     805
+#define SPRN_BESCR     806     /* Branch event status & control register */
+#define SPRN_BESCRS    800     /* Branch event status & control set (1 bits set to 1) */
+#define SPRN_BESCRSU   801     /* Branch event status & control set upper */
+#define SPRN_BESCRR    802     /* Branch event status & control REset (1 bits set to 0) */
+#define SPRN_BESCRRU   803     /* Branch event status & control REset upper */
+
+#define BESCR_PMEO     0x1     /* PMU Event-based exception Occurred */
+#define BESCR_PME      (0x1ul << 32) /* PMU Event-based exception Enable */
+#define BESCR_LME      (0x1ul << 34) /* Load Monitor Enable */
+#define BESCR_LMEO     (0x1ul << 2)  /* Load Monitor Exception Occurred */
+
+#define SPRN_LMRR      813     /* Load Monitor Region Register */
+#define SPRN_LMSER     814     /* Load Monitor Section Enable Register */
+
+#define SPRN_PMC1      771
+#define SPRN_PMC2      772
+#define SPRN_PMC3      773
+#define SPRN_PMC4      774
+#define SPRN_PMC5      775
+#define SPRN_PMC6      776
+
+#define SPRN_SIAR      780
+#define SPRN_SDAR      781
+#define SPRN_SIER      768
+
+#define SPRN_TEXASR     0x82    /* Transaction Exception and Status Register */
+#define SPRN_TFIAR      0x81    /* Transaction Failure Inst Addr    */
+#define SPRN_TFHAR      0x80    /* Transaction Failure Handler Addr */
+#define SPRN_TAR        0x32f	/* Target Address Register */
+
+#define SPRN_DSCR_PRIV 0x11	/* Privilege State DSCR */
+#define SPRN_DSCR      0x03	/* Data Stream Control Register */
+#define SPRN_PPR       896	/* Program Priority Register */
+
+/* TEXASR register bits */
+#define TEXASR_FC	0xFE00000000000000
+#define TEXASR_FP	0x0100000000000000
+#define TEXASR_DA	0x0080000000000000
+#define TEXASR_NO	0x0040000000000000
+#define TEXASR_FO	0x0020000000000000
+#define TEXASR_SIC	0x0010000000000000
+#define TEXASR_NTC	0x0008000000000000
+#define TEXASR_TC	0x0004000000000000
+#define TEXASR_TIC	0x0002000000000000
+#define TEXASR_IC	0x0001000000000000
+#define TEXASR_IFC	0x0000800000000000
+#define TEXASR_ABT	0x0000000100000000
+#define TEXASR_SPD	0x0000000080000000
+#define TEXASR_HV	0x0000000020000000
+#define TEXASR_PR	0x0000000010000000
+#define TEXASR_FS	0x0000000008000000
+#define TEXASR_TE	0x0000000004000000
+#define TEXASR_ROT	0x0000000002000000
+
+/* Vector Instructions */
+#define VSX_XX1(xs, ra, rb)	(((xs) & 0x1f) << 21 | ((ra) << 16) |  \
+				 ((rb) << 11) | (((xs) >> 5)))
+#define STXVD2X(xs, ra, rb)	.long (0x7c000798 | VSX_XX1((xs), (ra), (rb)))
+#define LXVD2X(xs, ra, rb)	.long (0x7c000698 | VSX_XX1((xs), (ra), (rb)))
+
+#endif /* _SELFTESTS_POWERPC_REG_H */
diff --git a/tools/testing/selftests/powerpc/utility/utils.c b/tools/testing/selftests/powerpc/utility/utils.c
new file mode 100644
index 0000000..dcf7418
--- /dev/null
+++ b/tools/testing/selftests/powerpc/utility/utils.c
@@ -0,0 +1,87 @@
+/*
+ * Copyright 2013-2015, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#define _GNU_SOURCE	/* For CPU_ZERO etc. */
+
+#include <elf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <link.h>
+#include <sched.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "utils.h"
+
+static char auxv[4096];
+
+void *get_auxv_entry(int type)
+{
+	ElfW(auxv_t) *p;
+	void *result;
+	ssize_t num;
+	int fd;
+
+	fd = open("/proc/self/auxv", O_RDONLY);
+	if (fd == -1) {
+		perror("open");
+		return NULL;
+	}
+
+	result = NULL;
+
+	num = read(fd, auxv, sizeof(auxv));
+	if (num < 0) {
+		perror("read");
+		goto out;
+	}
+
+	if (num > sizeof(auxv)) {
+		printf("Overflowed auxv buffer\n");
+		goto out;
+	}
+
+	p = (ElfW(auxv_t) *)auxv;
+
+	while (p->a_type != AT_NULL) {
+		if (p->a_type == type) {
+			result = (void *)p->a_un.a_val;
+			break;
+		}
+
+		p++;
+	}
+out:
+	close(fd);
+	return result;
+}
+
+int pick_online_cpu(void)
+{
+	cpu_set_t mask;
+	int cpu;
+
+	CPU_ZERO(&mask);
+
+	if (sched_getaffinity(0, sizeof(mask), &mask)) {
+		perror("sched_getaffinity");
+		return -1;
+	}
+
+	/* We prefer a primary thread, but skip 0 */
+	for (cpu = 8; cpu < CPU_SETSIZE; cpu += 8)
+		if (CPU_ISSET(cpu, &mask))
+			return cpu;
+
+	/* Search for anything, but in reverse */
+	for (cpu = CPU_SETSIZE - 1; cpu >= 0; cpu--)
+		if (CPU_ISSET(cpu, &mask))
+			return cpu;
+
+	printf("No cpus in affinity mask?!\n");
+	return -1;
+}
diff --git a/tools/testing/selftests/powerpc/utility/utils.h b/tools/testing/selftests/powerpc/utility/utils.h
new file mode 100644
index 0000000..53405e8
--- /dev/null
+++ b/tools/testing/selftests/powerpc/utility/utils.h
@@ -0,0 +1,77 @@
+/*
+ * Copyright 2013, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#ifndef _SELFTESTS_POWERPC_UTILS_H
+#define _SELFTESTS_POWERPC_UTILS_H
+
+#define __cacheline_aligned __attribute__((aligned(128)))
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <linux/auxvec.h>
+#include "reg.h"
+
+/* Avoid headaches with PRI?64 - just use %ll? always */
+typedef unsigned long long u64;
+typedef   signed long long s64;
+
+/* Just for familiarity */
+typedef uint32_t u32;
+typedef uint16_t u16;
+typedef uint8_t u8;
+
+void test_harness_set_timeout(uint64_t time);
+int test_harness(int (test_function)(void), char *name);
+extern void *get_auxv_entry(int type);
+int pick_online_cpu(void);
+
+static inline bool have_hwcap(unsigned long ftr)
+{
+	return ((unsigned long)get_auxv_entry(AT_HWCAP) & ftr) == ftr;
+}
+
+#ifdef AT_HWCAP2
+static inline bool have_hwcap2(unsigned long ftr2)
+{
+	return ((unsigned long)get_auxv_entry(AT_HWCAP2) & ftr2) == ftr2;
+}
+#else
+static inline bool have_hwcap2(unsigned long ftr2)
+{
+	return false;
+}
+#endif
+
+/* Yes, this is evil */
+#define FAIL_IF(x)						\
+do {								\
+	if ((x)) {						\
+		fprintf(stderr,					\
+		"[FAIL] Test FAILED on line %d\n", __LINE__);	\
+		return 1;					\
+	}							\
+} while (0)
+
+/* The test harness uses this, yes it's gross */
+#define MAGIC_SKIP_RETURN_VALUE	99
+
+#define SKIP_IF(x)						\
+do {								\
+	if ((x)) {						\
+		fprintf(stderr,					\
+		"[SKIP] Test skipped on line %d\n", __LINE__);	\
+		return MAGIC_SKIP_RETURN_VALUE;			\
+	}							\
+} while (0)
+
+#define _str(s) #s
+#define str(s) _str(s)
+
+/* POWER9 feature */
+#ifndef PPC_FEATURE2_ARCH_3_00
+#define PPC_FEATURE2_ARCH_3_00 0x00800000
+#endif
+
+#endif /* _SELFTESTS_POWERPC_UTILS_H */
diff --git a/tools/testing/selftests/powerpc/utility/vmx_asm.h b/tools/testing/selftests/powerpc/utility/vmx_asm.h
new file mode 100644
index 0000000..2eaaeca
--- /dev/null
+++ b/tools/testing/selftests/powerpc/utility/vmx_asm.h
@@ -0,0 +1,96 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "basic_asm.h"
+
+/* POS MUST BE 16 ALIGNED! */
+#define PUSH_VMX(pos,reg) \
+	li	reg,pos; \
+	stvx	v20,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v21,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v22,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v23,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v24,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v25,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v26,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v27,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v28,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v29,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v30,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v31,reg,%r1;
+
+/* POS MUST BE 16 ALIGNED! */
+#define POP_VMX(pos,reg) \
+	li	reg,pos; \
+	lvx	v20,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v21,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v22,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v23,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v24,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v25,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v26,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v27,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v28,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v29,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v30,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v31,reg,%r1;
+
+/*
+ * Careful this will 'clobber' vmx (by design)
+ * Don't call this from C
+ */
+FUNC_START(load_vmx)
+	li	r5,0
+	lvx	v20,r5,r3
+	addi	r5,r5,16
+	lvx	v21,r5,r3
+	addi	r5,r5,16
+	lvx	v22,r5,r3
+	addi	r5,r5,16
+	lvx	v23,r5,r3
+	addi	r5,r5,16
+	lvx	v24,r5,r3
+	addi	r5,r5,16
+	lvx	v25,r5,r3
+	addi	r5,r5,16
+	lvx	v26,r5,r3
+	addi	r5,r5,16
+	lvx	v27,r5,r3
+	addi	r5,r5,16
+	lvx	v28,r5,r3
+	addi	r5,r5,16
+	lvx	v29,r5,r3
+	addi	r5,r5,16
+	lvx	v30,r5,r3
+	addi	r5,r5,16
+	lvx	v31,r5,r3
+	blr
+FUNC_END(load_vmx)
diff --git a/tools/testing/selftests/powerpc/utility/vsx_asm.h b/tools/testing/selftests/powerpc/utility/vsx_asm.h
new file mode 100644
index 0000000..d828bfb
--- /dev/null
+++ b/tools/testing/selftests/powerpc/utility/vsx_asm.h
@@ -0,0 +1,71 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "basic_asm.h"
+
+/*
+ * Careful this will 'clobber' vsx (by design), VSX are always
+ * volatile though so unlike vmx this isn't so much of an issue
+ * Still should avoid calling from C
+ */
+FUNC_START(load_vsx)
+	li	r5,0
+	lxvx	vs20,r5,r3
+	addi	r5,r5,16
+	lxvx	vs21,r5,r3
+	addi	r5,r5,16
+	lxvx	vs22,r5,r3
+	addi	r5,r5,16
+	lxvx	vs23,r5,r3
+	addi	r5,r5,16
+	lxvx	vs24,r5,r3
+	addi	r5,r5,16
+	lxvx	vs25,r5,r3
+	addi	r5,r5,16
+	lxvx	vs26,r5,r3
+	addi	r5,r5,16
+	lxvx	vs27,r5,r3
+	addi	r5,r5,16
+	lxvx	vs28,r5,r3
+	addi	r5,r5,16
+	lxvx	vs29,r5,r3
+	addi	r5,r5,16
+	lxvx	vs30,r5,r3
+	addi	r5,r5,16
+	lxvx	vs31,r5,r3
+	blr
+FUNC_END(load_vsx)
+
+FUNC_START(store_vsx)
+	li	r5,0
+	stxvx	vs20,r5,r3
+	addi	r5,r5,16
+	stxvx	vs21,r5,r3
+	addi	r5,r5,16
+	stxvx	vs22,r5,r3
+	addi	r5,r5,16
+	stxvx	vs23,r5,r3
+	addi	r5,r5,16
+	stxvx	vs24,r5,r3
+	addi	r5,r5,16
+	stxvx	vs25,r5,r3
+	addi	r5,r5,16
+	stxvx	vs26,r5,r3
+	addi	r5,r5,16
+	stxvx	vs27,r5,r3
+	addi	r5,r5,16
+	stxvx	vs28,r5,r3
+	addi	r5,r5,16
+	stxvx	vs29,r5,r3
+	addi	r5,r5,16
+	stxvx	vs30,r5,r3
+	addi	r5,r5,16
+	stxvx	vs31,r5,r3
+	blr
+FUNC_END(store_vsx)
diff --git a/tools/testing/selftests/powerpc/utils.c b/tools/testing/selftests/powerpc/utils.c
deleted file mode 100644
index dcf7418..0000000
--- a/tools/testing/selftests/powerpc/utils.c
+++ /dev/null
@@ -1,87 +0,0 @@
-/*
- * Copyright 2013-2015, Michael Ellerman, IBM Corp.
- * Licensed under GPLv2.
- */
-
-#define _GNU_SOURCE	/* For CPU_ZERO etc. */
-
-#include <elf.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <link.h>
-#include <sched.h>
-#include <stdio.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <unistd.h>
-
-#include "utils.h"
-
-static char auxv[4096];
-
-void *get_auxv_entry(int type)
-{
-	ElfW(auxv_t) *p;
-	void *result;
-	ssize_t num;
-	int fd;
-
-	fd = open("/proc/self/auxv", O_RDONLY);
-	if (fd == -1) {
-		perror("open");
-		return NULL;
-	}
-
-	result = NULL;
-
-	num = read(fd, auxv, sizeof(auxv));
-	if (num < 0) {
-		perror("read");
-		goto out;
-	}
-
-	if (num > sizeof(auxv)) {
-		printf("Overflowed auxv buffer\n");
-		goto out;
-	}
-
-	p = (ElfW(auxv_t) *)auxv;
-
-	while (p->a_type != AT_NULL) {
-		if (p->a_type == type) {
-			result = (void *)p->a_un.a_val;
-			break;
-		}
-
-		p++;
-	}
-out:
-	close(fd);
-	return result;
-}
-
-int pick_online_cpu(void)
-{
-	cpu_set_t mask;
-	int cpu;
-
-	CPU_ZERO(&mask);
-
-	if (sched_getaffinity(0, sizeof(mask), &mask)) {
-		perror("sched_getaffinity");
-		return -1;
-	}
-
-	/* We prefer a primary thread, but skip 0 */
-	for (cpu = 8; cpu < CPU_SETSIZE; cpu += 8)
-		if (CPU_ISSET(cpu, &mask))
-			return cpu;
-
-	/* Search for anything, but in reverse */
-	for (cpu = CPU_SETSIZE - 1; cpu >= 0; cpu--)
-		if (CPU_ISSET(cpu, &mask))
-			return cpu;
-
-	printf("No cpus in affinity mask?!\n");
-	return -1;
-}
diff --git a/tools/testing/selftests/powerpc/utils.h b/tools/testing/selftests/powerpc/utils.h
deleted file mode 100644
index 53405e8..0000000
--- a/tools/testing/selftests/powerpc/utils.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * Copyright 2013, Michael Ellerman, IBM Corp.
- * Licensed under GPLv2.
- */
-
-#ifndef _SELFTESTS_POWERPC_UTILS_H
-#define _SELFTESTS_POWERPC_UTILS_H
-
-#define __cacheline_aligned __attribute__((aligned(128)))
-
-#include <stdint.h>
-#include <stdbool.h>
-#include <linux/auxvec.h>
-#include "reg.h"
-
-/* Avoid headaches with PRI?64 - just use %ll? always */
-typedef unsigned long long u64;
-typedef   signed long long s64;
-
-/* Just for familiarity */
-typedef uint32_t u32;
-typedef uint16_t u16;
-typedef uint8_t u8;
-
-void test_harness_set_timeout(uint64_t time);
-int test_harness(int (test_function)(void), char *name);
-extern void *get_auxv_entry(int type);
-int pick_online_cpu(void);
-
-static inline bool have_hwcap(unsigned long ftr)
-{
-	return ((unsigned long)get_auxv_entry(AT_HWCAP) & ftr) == ftr;
-}
-
-#ifdef AT_HWCAP2
-static inline bool have_hwcap2(unsigned long ftr2)
-{
-	return ((unsigned long)get_auxv_entry(AT_HWCAP2) & ftr2) == ftr2;
-}
-#else
-static inline bool have_hwcap2(unsigned long ftr2)
-{
-	return false;
-}
-#endif
-
-/* Yes, this is evil */
-#define FAIL_IF(x)						\
-do {								\
-	if ((x)) {						\
-		fprintf(stderr,					\
-		"[FAIL] Test FAILED on line %d\n", __LINE__);	\
-		return 1;					\
-	}							\
-} while (0)
-
-/* The test harness uses this, yes it's gross */
-#define MAGIC_SKIP_RETURN_VALUE	99
-
-#define SKIP_IF(x)						\
-do {								\
-	if ((x)) {						\
-		fprintf(stderr,					\
-		"[SKIP] Test skipped on line %d\n", __LINE__);	\
-		return MAGIC_SKIP_RETURN_VALUE;			\
-	}							\
-} while (0)
-
-#define _str(s) #s
-#define str(s) _str(s)
-
-/* POWER9 feature */
-#ifndef PPC_FEATURE2_ARCH_3_00
-#define PPC_FEATURE2_ARCH_3_00 0x00800000
-#endif
-
-#endif /* _SELFTESTS_POWERPC_UTILS_H */
diff --git a/tools/testing/selftests/powerpc/vmx_asm.h b/tools/testing/selftests/powerpc/vmx_asm.h
deleted file mode 100644
index 2eaaeca..0000000
--- a/tools/testing/selftests/powerpc/vmx_asm.h
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- * Copyright 2015, Cyril Bur, IBM Corp.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include "basic_asm.h"
-
-/* POS MUST BE 16 ALIGNED! */
-#define PUSH_VMX(pos,reg) \
-	li	reg,pos; \
-	stvx	v20,reg,%r1; \
-	addi	reg,reg,16; \
-	stvx	v21,reg,%r1; \
-	addi	reg,reg,16; \
-	stvx	v22,reg,%r1; \
-	addi	reg,reg,16; \
-	stvx	v23,reg,%r1; \
-	addi	reg,reg,16; \
-	stvx	v24,reg,%r1; \
-	addi	reg,reg,16; \
-	stvx	v25,reg,%r1; \
-	addi	reg,reg,16; \
-	stvx	v26,reg,%r1; \
-	addi	reg,reg,16; \
-	stvx	v27,reg,%r1; \
-	addi	reg,reg,16; \
-	stvx	v28,reg,%r1; \
-	addi	reg,reg,16; \
-	stvx	v29,reg,%r1; \
-	addi	reg,reg,16; \
-	stvx	v30,reg,%r1; \
-	addi	reg,reg,16; \
-	stvx	v31,reg,%r1;
-
-/* POS MUST BE 16 ALIGNED! */
-#define POP_VMX(pos,reg) \
-	li	reg,pos; \
-	lvx	v20,reg,%r1; \
-	addi	reg,reg,16; \
-	lvx	v21,reg,%r1; \
-	addi	reg,reg,16; \
-	lvx	v22,reg,%r1; \
-	addi	reg,reg,16; \
-	lvx	v23,reg,%r1; \
-	addi	reg,reg,16; \
-	lvx	v24,reg,%r1; \
-	addi	reg,reg,16; \
-	lvx	v25,reg,%r1; \
-	addi	reg,reg,16; \
-	lvx	v26,reg,%r1; \
-	addi	reg,reg,16; \
-	lvx	v27,reg,%r1; \
-	addi	reg,reg,16; \
-	lvx	v28,reg,%r1; \
-	addi	reg,reg,16; \
-	lvx	v29,reg,%r1; \
-	addi	reg,reg,16; \
-	lvx	v30,reg,%r1; \
-	addi	reg,reg,16; \
-	lvx	v31,reg,%r1;
-
-/*
- * Careful this will 'clobber' vmx (by design)
- * Don't call this from C
- */
-FUNC_START(load_vmx)
-	li	r5,0
-	lvx	v20,r5,r3
-	addi	r5,r5,16
-	lvx	v21,r5,r3
-	addi	r5,r5,16
-	lvx	v22,r5,r3
-	addi	r5,r5,16
-	lvx	v23,r5,r3
-	addi	r5,r5,16
-	lvx	v24,r5,r3
-	addi	r5,r5,16
-	lvx	v25,r5,r3
-	addi	r5,r5,16
-	lvx	v26,r5,r3
-	addi	r5,r5,16
-	lvx	v27,r5,r3
-	addi	r5,r5,16
-	lvx	v28,r5,r3
-	addi	r5,r5,16
-	lvx	v29,r5,r3
-	addi	r5,r5,16
-	lvx	v30,r5,r3
-	addi	r5,r5,16
-	lvx	v31,r5,r3
-	blr
-FUNC_END(load_vmx)
diff --git a/tools/testing/selftests/powerpc/vsx_asm.h b/tools/testing/selftests/powerpc/vsx_asm.h
deleted file mode 100644
index d828bfb..0000000
--- a/tools/testing/selftests/powerpc/vsx_asm.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * Copyright 2015, Cyril Bur, IBM Corp.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include "basic_asm.h"
-
-/*
- * Careful this will 'clobber' vsx (by design), VSX are always
- * volatile though so unlike vmx this isn't so much of an issue
- * Still should avoid calling from C
- */
-FUNC_START(load_vsx)
-	li	r5,0
-	lxvx	vs20,r5,r3
-	addi	r5,r5,16
-	lxvx	vs21,r5,r3
-	addi	r5,r5,16
-	lxvx	vs22,r5,r3
-	addi	r5,r5,16
-	lxvx	vs23,r5,r3
-	addi	r5,r5,16
-	lxvx	vs24,r5,r3
-	addi	r5,r5,16
-	lxvx	vs25,r5,r3
-	addi	r5,r5,16
-	lxvx	vs26,r5,r3
-	addi	r5,r5,16
-	lxvx	vs27,r5,r3
-	addi	r5,r5,16
-	lxvx	vs28,r5,r3
-	addi	r5,r5,16
-	lxvx	vs29,r5,r3
-	addi	r5,r5,16
-	lxvx	vs30,r5,r3
-	addi	r5,r5,16
-	lxvx	vs31,r5,r3
-	blr
-FUNC_END(load_vsx)
-
-FUNC_START(store_vsx)
-	li	r5,0
-	stxvx	vs20,r5,r3
-	addi	r5,r5,16
-	stxvx	vs21,r5,r3
-	addi	r5,r5,16
-	stxvx	vs22,r5,r3
-	addi	r5,r5,16
-	stxvx	vs23,r5,r3
-	addi	r5,r5,16
-	stxvx	vs24,r5,r3
-	addi	r5,r5,16
-	stxvx	vs25,r5,r3
-	addi	r5,r5,16
-	stxvx	vs26,r5,r3
-	addi	r5,r5,16
-	stxvx	vs27,r5,r3
-	addi	r5,r5,16
-	stxvx	vs28,r5,r3
-	addi	r5,r5,16
-	stxvx	vs29,r5,r3
-	addi	r5,r5,16
-	stxvx	vs30,r5,r3
-	addi	r5,r5,16
-	stxvx	vs31,r5,r3
-	blr
-FUNC_END(store_vsx)
-- 
1.8.3.1
