Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
 [209.85.220.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsV2q5Y1gzDqR2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 12:03:31 +1000 (AEST)
Received: by mail-pa0-f66.google.com with SMTP id q2so8556304pap.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 19:03:31 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Shuah Khan <shuahkh@osg.samsung.com>,
 Anton Blanchard <anton@samba.org>, Cyril Bur <cyrilbur@gmail.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v11 13/27] selftests/powerpc: Add more SPR numbers,
 TM & VMX instructions to 'reg.h'
Date: Sun, 17 Jul 2016 09:59:46 +0800
Message-Id: <1468720800-2950-14-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1468720800-2950-1-git-send-email-wei.guo.simon@gmail.com>
References: <1468720800-2950-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch adds SPR number for TAR, PPR, DSCR special
purpose registers. It also adds TM, VSX, VMX related
instructions which will then be used by patches later
in the series.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Cyril Bur <cyrilbur@gmail.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Simon Guo <wei.guo.simon@gmail.com>
Cc: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Rashmica Gupta <rashmicy@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>
Cc: Jessica Yu <jeyu@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Chris Smart <chris@distroguy.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 tools/testing/selftests/powerpc/reg.h              | 42 ++++++++++++++++++++--
 .../powerpc/tm/tm-signal-context-chk-fpu.c         |  3 --
 .../powerpc/tm/tm-signal-context-chk-gpr.c         |  3 --
 .../powerpc/tm/tm-signal-context-chk-vmx.c         |  3 --
 .../powerpc/tm/tm-signal-context-chk-vsx.c         |  3 --
 .../selftests/powerpc/tm/tm-signal-context-chk.c   |  3 --
 6 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/powerpc/reg.h b/tools/testing/selftests/powerpc/reg.h
index 65bfdee..5183349 100644
--- a/tools/testing/selftests/powerpc/reg.h
+++ b/tools/testing/selftests/powerpc/reg.h
@@ -18,6 +18,19 @@
 
 #define mb()		asm volatile("sync" : : : "memory");
 
+/* Vector Instructions */
+#define VSX_XX1(xs, ra, rb)	(((xs) & 0x1f) << 21 | ((ra) << 16) |  \
+				 ((rb) << 11) | (((xs) >> 5)))
+#define STXVD2X(xs, ra, rb)	.long (0x7c000798 | VSX_XX1((xs), (ra), (rb)))
+#define LXVD2X(xs, ra, rb)	.long (0x7c000698 | VSX_XX1((xs), (ra), (rb)))
+
+/* TM instructions */
+#define TBEGIN		".long 0x7C00051D;"
+#define TABORT		".long 0x7C00071D;"
+#define TEND		".long 0x7C00055D;"
+#define TSUSPEND	".long 0x7C0005DD;"
+#define TRESUME		".long 0x7C2005DD;"
+
 #define SPRN_MMCR2     769
 #define SPRN_MMCRA     770
 #define SPRN_MMCR0     779
@@ -46,10 +59,33 @@
 #define SPRN_SDAR      781
 #define SPRN_SIER      768
 
-#define SPRN_TEXASR     0x82
+#define SPRN_TEXASR     0x82    /* Transaction Exception and Status Register */
 #define SPRN_TFIAR      0x81    /* Transaction Failure Inst Addr    */
 #define SPRN_TFHAR      0x80    /* Transaction Failure Handler Addr */
-#define TEXASR_FS       0x08000000
-#define SPRN_TAR        0x32f
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
 
 #endif /* _SELFTESTS_POWERPC_REG_H */
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c
index 776457d..ee70c50 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c
@@ -23,9 +23,6 @@
 #include "utils.h"
 #include "tm.h"
 
-#define TBEGIN          ".long 0x7C00051D ;"
-#define TSUSPEND        ".long 0x7C0005DD ;"
-#define TRESUME         ".long 0x7C2005DD ;"
 #define MAX_ATTEMPT 100
 
 #define NV_FPU_REGS 18
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
index 22abe48..22f5fe4 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
@@ -25,9 +25,6 @@
 #include "utils.h"
 #include "tm.h"
 
-#define TBEGIN          ".long 0x7C00051D ;"
-#define TSUSPEND        ".long 0x7C0005DD ;"
-#define TRESUME         ".long 0x7C2005DD ;"
 #define MAX_ATTEMPT 100
 
 #define NV_GPR_REGS 18
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vmx.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vmx.c
index fd58369..3ef34d3 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vmx.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vmx.c
@@ -26,9 +26,6 @@
 #include "utils.h"
 #include "tm.h"
 
-#define TBEGIN          ".long 0x7C00051D ;"
-#define TSUSPEND        ".long 0x7C0005DD ;"
-#define TRESUME         ".long 0x7C2005DD ;"
 #define MAX_ATTEMPT 100
 
 extern long tm_signal_self_context_load(pid_t pid, long *gps, double *fps, vector int *vms, vector int *vss);
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c
index 9685881..d9eba6f 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c
@@ -26,9 +26,6 @@
 #include "utils.h"
 #include "tm.h"
 
-#define TBEGIN          ".long 0x7C00051D ;"
-#define TSUSPEND        ".long 0x7C0005DD ;"
-#define TRESUME         ".long 0x7C2005DD ;"
 #define MAX_ATTEMPT 100
 
 extern long tm_signal_self_context_load(pid_t pid, long *gps, double *fps, vector int *vms, vector int *vss);
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c
index 4c906cf..b9cfcdf 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c
@@ -23,9 +23,6 @@
 #include "utils.h"
 #include "tm.h"
 
-#define TBEGIN          ".long 0x7C00051D ;"
-#define TSUSPEND        ".long 0x7C0005DD ;"
-#define TRESUME         ".long 0x7C2005DD ;"
 #define MAX_ATTEMPT 100
 
 static double fps[] = { 1, 2, 3, 4, 5, 6, 7, 8,
-- 
1.8.3.1
