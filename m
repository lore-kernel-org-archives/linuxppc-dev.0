Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yY0Kp2Cb8zDrKj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 10:50:54 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id u70so625862pfa.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Nov 2017 15:50:53 -0800 (PST)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCHv4 5/6] symbol lookup: introduce dereference_symbol_descriptor()
Date: Fri, 10 Nov 2017 08:48:29 +0900
Message-Id: <20171109234830.5067-6-sergey.senozhatsky@gmail.com>
In-Reply-To: <20171109234830.5067-1-sergey.senozhatsky@gmail.com>
References: <20171109234830.5067-1-sergey.senozhatsky@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

dereference_symbol_descriptor() invokes appropriate ARCH specific
function descriptor dereference callbacks:
- dereference_kernel_function_descriptor() if the pointer is a
  kernel symbol;

- dereference_module_function_descriptor() if the pointer is a
  module symbol.

This is the last step needed to make '%pS/%ps' smart enough to
handle function descriptor dereference on affected ARCHs and
to retire '%pF/%pf'.

To refresh it:
  Some architectures (ia64, ppc64, parisc64) use an indirect pointer
  for C function pointers - the function pointer points to a function
  descriptor and we need to dereference it to get the actual function
  pointer.

  Function descriptors live in .opd elf section and all affected
  ARCHs (ia64, ppc64, parisc64) handle it properly for kernel and
  modules. So we, technically, can decide if the dereference is
  needed by simply looking at the pointer: if it belongs to .opd
  section then we need to dereference it.

  The kernel and modules have their own .opd sections, obviously,
  that's why we need to split dereference_function_descriptor()
  and use separate kernel and module dereference arch callbacks.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 Documentation/printk-formats.txt | 49 ++++++++++++++++------------------------
 include/linux/kallsyms.h         |  2 ++
 kernel/kallsyms.c                | 19 ++++++++++++++++
 lib/vsprintf.c                   |  5 ++--
 4 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/Documentation/printk-formats.txt b/Documentation/printk-formats.txt
index 361789df51ec..2f17e684b72e 100644
--- a/Documentation/printk-formats.txt
+++ b/Documentation/printk-formats.txt
@@ -50,42 +50,31 @@ Symbols/Function Pointers
 
 ::
 
-	%pF	versatile_init+0x0/0x110
-	%pf	versatile_init
-	%pS	versatile_init+0x0/0x110
-	%pSR	versatile_init+0x9/0x110
-		(with __builtin_extract_return_addr() translation)
-	%ps	versatile_init
-	%pB	prev_fn_of_versatile_init+0x88/0x88
-
-The ``F`` and ``f`` specifiers are for printing function pointers,
-for example, f->func, &gettimeofday. They have the same result as
-``S`` and ``s`` specifiers. But they do an extra conversion on
-ia64, ppc64 and parisc64 architectures where the function pointers
-are actually function descriptors.
-
-The ``S`` and ``s`` specifiers can be used for printing symbols
-from direct addresses, for example, __builtin_return_address(0),
-(void *)regs->ip. They result in the symbol name with (``S``) or
-without (``s``) offsets. If KALLSYMS are disabled then the symbol
-address is printed instead.
+        %pS     versatile_init+0x0/0x110
+        %ps     versatile_init
+        %pF     versatile_init+0x0/0x110
+        %pf     versatile_init
+        %pSR    versatile_init+0x9/0x110
+                (with __builtin_extract_return_addr() translation)
+        %pB     prev_fn_of_versatile_init+0x88/0x88
+
+The ``S`` and ``s`` specifiers are used for printing a pointer in symbolic
+format. They result in the symbol name with (``S``) or without (``s``)
+offsets. If KALLSYMS are disabled then the symbol address is printed instead.
+
+Note, that the ``F`` and ``f`` specifiers are identical to ``S`` (``s``)
+and thus deprecated. We have ``F`` and ``f`` because on ia64, ppc64 and
+parisc64 function pointers are indirect and, in fact, are function
+descriptors, which require additional dereferencing before we can lookup
+the symbol. As of now, ``S`` and ``s`` perform dereferencing on those
+platforms (when needed), so ``F`` and ``f`` exist for compatibility
+reasons only.
 
 The ``B`` specifier results in the symbol name with offsets and should be
 used when printing stack backtraces. The specifier takes into
 consideration the effect of compiler optimisations which may occur
 when tail-call``s are used and marked with the noreturn GCC attribute.
 
-Examples::
-
-	printk("Going to call: %pF\n", gettimeofday);
-	printk("Going to call: %pF\n", p->func);
-	printk("%s: called from %pS\n", __func__, (void *)_RET_IP_);
-	printk("%s: called from %pS\n", __func__,
-				(void *)__builtin_return_address(0));
-	printk("Faulted at %pS\n", (void *)regs->ip);
-	printk(" %s%pB\n", (reliable ? "" : "? "), (void *)*stack);
-
-
 Kernel Pointers
 ===============
 
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 11dd93e42580..73f7e874c3e1 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -16,6 +16,8 @@
 
 struct module;
 
+void *dereference_symbol_descriptor(void *ptr);
+
 #ifdef CONFIG_KALLSYMS
 /* Lookup the address for a symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name);
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 1966fe1c2b57..18b3dffc4b84 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -411,6 +411,25 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 	return len;
 }
 
+void *dereference_symbol_descriptor(void *ptr)
+{
+#ifdef HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR
+	struct module *mod;
+
+	ptr = dereference_kernel_function_descriptor(ptr);
+	if (is_ksym_addr((unsigned long)ptr))
+		return ptr;
+
+	preempt_disable();
+	mod = __module_address((unsigned long)ptr);
+	preempt_enable();
+
+	if (mod)
+		ptr = dereference_module_function_descriptor(mod, ptr);
+#endif
+	return ptr;
+}
+
 /**
  * sprint_symbol - Look up a kernel symbol and return it in a text buffer
  * @buffer: buffer to be stored
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 1746bae94d41..16e2eefb0f79 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -40,7 +40,6 @@
 #include "../mm/internal.h"	/* For the trace_print_flags arrays */
 
 #include <asm/page.h>		/* for PAGE_SIZE */
-#include <asm/sections.h>	/* for dereference_function_descriptor() */
 #include <asm/byteorder.h>	/* cpu_to_le16 */
 
 #include <linux/string_helpers.h>
@@ -1723,10 +1722,10 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	switch (*fmt) {
 	case 'F':
 	case 'f':
-		ptr = dereference_function_descriptor(ptr);
-		/* Fallthrough */
 	case 'S':
 	case 's':
+		ptr = dereference_symbol_descriptor(ptr);
+		/* Fallthrough */
 	case 'B':
 		return symbol_string(buf, end, ptr, spec, fmt);
 	case 'R':
-- 
2.15.0
