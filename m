Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvJRY4c6JzDrnl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 13:59:05 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id m30so2240752pgn.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 20:59:05 -0700 (PDT)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "James E . J . Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH 4/5] parisc64: Add .opd based function descriptor dereference
Date: Sat, 16 Sep 2017 12:53:46 +0900
Message-Id: <20170916035347.19705-5-sergey.senozhatsky@gmail.com>
In-Reply-To: <20170916035347.19705-1-sergey.senozhatsky@gmail.com>
References: <20170916035347.19705-1-sergey.senozhatsky@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are moving towards separate kernel and module function descriptor
dereference callbacks. This patch enables it for parisc64.

For pointers that belong to the kernel
-  Added __start_opd and __end_opd pointers, to track the kernel
   .opd section address range;

-  Added dereference_kernel_function_descriptor(). Now we
   will dereference only function pointers that are within
   [__start_opd, __end_opd];

For pointers that belong to a module
-  Added dereference_module_function_descriptor() to handle module
   function descriptor dereference. Now we will dereference only
   pointers that are within [module->opd.start, module->opd.end].

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/parisc/boot/compressed/vmlinux.lds.S |  2 ++
 arch/parisc/include/asm/sections.h        |  3 +++
 arch/parisc/kernel/module.c               | 14 ++++++++++++++
 arch/parisc/kernel/process.c              | 10 ++++++++++
 arch/parisc/kernel/vmlinux.lds.S          |  2 ++
 5 files changed, 31 insertions(+)

diff --git a/arch/parisc/boot/compressed/vmlinux.lds.S b/arch/parisc/boot/compressed/vmlinux.lds.S
index a4ce3314e78e..4ebd4e65524c 100644
--- a/arch/parisc/boot/compressed/vmlinux.lds.S
+++ b/arch/parisc/boot/compressed/vmlinux.lds.S
@@ -29,7 +29,9 @@ SECTIONS
 	. = ALIGN(16);
 	/* Linkage tables */
 	.opd : {
+		__start_opd = .;
 		*(.opd)
+		__end_opd = .;
 	} PROVIDE (__gp = .);
 	.plt : {
 		*(.plt)
diff --git a/arch/parisc/include/asm/sections.h b/arch/parisc/include/asm/sections.h
index 9d13c3507ad6..e3cde650b2f9 100644
--- a/arch/parisc/include/asm/sections.h
+++ b/arch/parisc/include/asm/sections.h
@@ -6,7 +6,10 @@
 
 #ifdef CONFIG_64BIT
 #undef dereference_function_descriptor
+#undef dereference_kernel_function_descriptor
+
 void *dereference_function_descriptor(void *);
+void *dereference_kernel_function_descriptor(void *);
 #endif
 
 #endif
diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
index f1a76935a314..bc2eae8634fd 100644
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -954,3 +954,17 @@ void module_arch_cleanup(struct module *mod)
 {
 	deregister_unwind_table(mod);
 }
+
+#ifdef CONFIG_64BIT
+unsigned long dereference_module_function_descriptor(struct module *mod,
+					     unsigned long addr)
+{
+	void *opd_sz = mod->arch.fdesc_offset +
+		       mod->arch.fdesc_max * sizeof(Elf64_Fdesc);
+
+	if (addr < mod->arch.fdesc_offset || opd_sz < addr)
+		return addr;
+
+	return dereference_function_descriptor(addr);
+}
+#endif
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 30f92391a93e..f30776bdaa79 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -267,6 +267,8 @@ get_wchan(struct task_struct *p)
 }
 
 #ifdef CONFIG_64BIT
+extern char __start_opd[], __end_opd[];
+
 void *dereference_function_descriptor(void *ptr)
 {
 	Elf64_Fdesc *desc = ptr;
@@ -276,6 +278,14 @@ void *dereference_function_descriptor(void *ptr)
 		ptr = p;
 	return ptr;
 }
+
+void *dereference_kernel_function_descriptor(void *ptr)
+{
+	if (ptr < (void *)__start_opd || (void *)__end_opd < ptr)
+		return ptr;
+
+	return dereference_function_descriptor(ptr);
+}
 #endif
 
 static inline unsigned long brk_rnd(void)
diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index ffe2cbf52d1a..ab030895dd1e 100644
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -99,7 +99,9 @@ SECTIONS
 	. = ALIGN(16);
 	/* Linkage tables */
 	.opd : {
+		__start_opd = .;
 		*(.opd)
+		__end_opd = .;
 	} PROVIDE (__gp = .);
 	.plt : {
 		*(.plt)
-- 
2.14.1
