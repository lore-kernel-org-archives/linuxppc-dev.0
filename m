Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slbCf58FczDvLw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 12:35:58 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id oz2so4141832pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 19:35:58 -0700 (PDT)
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
Subject: [PATCH v15 02/15] selftests/powerpc: move shared utility files into
 new utility/ dir
Date: Fri, 30 Sep 2016 10:32:51 +0800
Message-Id: <1475202784-5653-3-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1475202784-5653-1-git-send-email-wei.guo.simon@gmail.com>
References: <1475202784-5653-1-git-send-email-wei.guo.simon@gmail.com>
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
 tools/testing/selftests/powerpc/basic_asm.h        | 70 -----------------
 .../testing/selftests/powerpc/benchmarks/Makefile  |  2 +-
 .../selftests/powerpc/benchmarks/context_switch.c  |  2 +-
 .../selftests/powerpc/context_switch/Makefile      |  2 +-
 .../testing/selftests/powerpc/copyloops/validate.c |  2 +-
 tools/testing/selftests/powerpc/instructions.h     | 68 -----------------
 tools/testing/selftests/powerpc/math/fpu_asm.S     |  2 +-
 tools/testing/selftests/powerpc/math/vmx_asm.S     |  2 +-
 tools/testing/selftests/powerpc/mm/Makefile        |  2 +-
 tools/testing/selftests/powerpc/pmu/Makefile       |  4 +-
 tools/testing/selftests/powerpc/pmu/ebb/Makefile   |  2 +-
 tools/testing/selftests/powerpc/reg.h              | 89 ----------------------
 .../testing/selftests/powerpc/stringloops/memcmp.c |  2 +-
 tools/testing/selftests/powerpc/tm/Makefile        |  2 +-
 tools/testing/selftests/powerpc/tm/tm.h            |  2 +-
 .../testing/selftests/powerpc/utility/basic_asm.h  | 73 ++++++++++++++++++
 .../selftests/powerpc/utility/instructions.h       | 68 +++++++++++++++++
 tools/testing/selftests/powerpc/utility/reg.h      | 89 ++++++++++++++++++++++
 tools/testing/selftests/powerpc/utility/utils.c    | 87 +++++++++++++++++++++
 tools/testing/selftests/powerpc/utility/utils.h    | 70 +++++++++++++++++
 tools/testing/selftests/powerpc/utils.c            | 87 ---------------------
 tools/testing/selftests/powerpc/utils.h            | 70 -----------------
 24 files changed, 402 insertions(+), 399 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/basic_asm.h
 delete mode 100644 tools/testing/selftests/powerpc/instructions.h
 delete mode 100644 tools/testing/selftests/powerpc/reg.h
 create mode 100644 tools/testing/selftests/powerpc/utility/basic_asm.h
 create mode 100644 tools/testing/selftests/powerpc/utility/instructions.h
 create mode 100644 tools/testing/selftests/powerpc/utility/reg.h
 create mode 100644 tools/testing/selftests/powerpc/utility/utils.c
 create mode 100644 tools/testing/selftests/powerpc/utility/utils.h
 delete mode 100644 tools/testing/selftests/powerpc/utils.c
 delete mode 100644 tools/testing/selftests/powerpc/utils.h

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 1cc6d64..b6eb817 100644
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
index f3711d8..8d4eb96 100644
--- a/tools/testing/selftests/powerpc/math/fpu_asm.S
+++ b/tools/testing/selftests/powerpc/math/fpu_asm.S
@@ -7,7 +7,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include "../basic_asm.h"
+#include "basic_asm.h"
 
 #define PUSH_FPU(pos) \
 	stfd	f14,pos(sp); \
diff --git a/tools/testing/selftests/powerpc/math/vmx_asm.S b/tools/testing/selftests/powerpc/math/vmx_asm.S
index 1b8c248..1b6fd53 100644
--- a/tools/testing/selftests/powerpc/math/vmx_asm.S
+++ b/tools/testing/selftests/powerpc/math/vmx_asm.S
@@ -7,7 +7,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include "../basic_asm.h"
+#include "basic_asm.h"
 
 # POS MUST BE 16 ALIGNED!
 #define PUSH_VMX(pos,reg) \
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
index 9d301d7..8b69f1f 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -3,7 +3,7 @@ TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
 
 all: $(TEST_PROGS)
 
-$(TEST_PROGS): ../harness.c ../utils.c
+$(TEST_PROGS): ../harness.c ../utility/utils.c
 
 CFLAGS += -mhtm
 
diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
index 60318ba..5cafbc3 100644
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
index 0000000..fbd33e5
--- /dev/null
+++ b/tools/testing/selftests/powerpc/utility/utils.h
@@ -0,0 +1,70 @@
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
+
+int test_harness(int (test_function)(void), char *name);
+extern void *get_auxv_entry(int type);
+int pick_online_cpu(void);
+
+static inline bool have_hwcap(unsigned long ftr)
+{
+	return ((unsigned long)get_auxv_entry(AT_HWCAP) & ftr) == ftr;
+}
+
+static inline bool have_hwcap2(unsigned long ftr2)
+{
+	return ((unsigned long)get_auxv_entry(AT_HWCAP2) & ftr2) == ftr2;
+}
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
index fbd33e5..0000000
--- a/tools/testing/selftests/powerpc/utils.h
+++ /dev/null
@@ -1,70 +0,0 @@
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
-
-int test_harness(int (test_function)(void), char *name);
-extern void *get_auxv_entry(int type);
-int pick_online_cpu(void);
-
-static inline bool have_hwcap(unsigned long ftr)
-{
-	return ((unsigned long)get_auxv_entry(AT_HWCAP) & ftr) == ftr;
-}
-
-static inline bool have_hwcap2(unsigned long ftr2)
-{
-	return ((unsigned long)get_auxv_entry(AT_HWCAP2) & ftr2) == ftr2;
-}
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
-- 
1.8.3.1
