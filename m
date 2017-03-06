Return-Path: <me@tobin.cc>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcD4v4bK3zDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 19:50:07 +1100 (AEDT)
From: "Tobin C. Harding" <me@tobin.cc>
To: Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 "Tobin C. Harding" <me@tobin.cc>
Subject: [PATCH] powerpc/ftrace: add ftrace.h, fix sparse warning
Date: Mon,  6 Mar 2017 19:49:46 +1100
Message-Id: <1488790186-4828-1-git-send-email-me@tobin.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sparse emits warning: symbol 'prepare_ftrace_return' was not
declared. Should it be static? prepare_ftrace_return() is called
from assembler and should not be static. Adding a header file
declaring the function will fix the sparse warning while adding
documentation to the call.

Add header file ftrace.h with single function declaration. Protect
declaration with preprocessor guard so it may be included in
assembly. Include new header in all files that call
prepare_ftrace_return() and in ftrace.c where function is defined.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

Github issue: #37 Fix sparse warnings

Tested by building on Power8.

There are a bunch of these in arch/powerpc/kernel/. Do we want to add
a header for each one, cluttering up the directory to fix the sparse
warnings? 

 arch/powerpc/kernel/entry_32.S | 2 ++
 arch/powerpc/kernel/entry_64.S | 2 ++
 arch/powerpc/kernel/ftrace.c   | 1 +
 arch/powerpc/kernel/ftrace.h   | 9 +++++++++
 4 files changed, 14 insertions(+)
 create mode 100644 arch/powerpc/kernel/ftrace.h

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 3841d74..bb7284c 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -35,6 +35,8 @@
 #include <asm/ptrace.h>
 #include <asm/export.h>
 
+#include "ftrace.h"
+
 /*
  * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
  */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6432d4b..8591026 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -40,6 +40,8 @@
 #include <asm/ppc-opcode.h>
 #include <asm/export.h>
 
+#include "ftrace.h"
+
 /*
  * System calls.
  */
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 5c9f50c..d4d3bb1 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -26,6 +26,7 @@
 #include <asm/ftrace.h>
 #include <asm/syscall.h>
 
+#include "ftrace.h"
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 static unsigned int
diff --git a/arch/powerpc/kernel/ftrace.h b/arch/powerpc/kernel/ftrace.h
new file mode 100644
index 0000000..dc27dd7
--- /dev/null
+++ b/arch/powerpc/kernel/ftrace.h
@@ -0,0 +1,9 @@
+#ifndef _FTRACE_H
+#define _FTRACE_H
+
+#ifndef __ASSEMBLER__
+
+unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip);
+
+#endif	/* __ASSEMBLER__ */
+#endif	/* _FTRACE_H */
-- 
2.7.4
