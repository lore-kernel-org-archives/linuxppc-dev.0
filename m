Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3tLK0q7NzDqh7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Sep 2017 12:54:17 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id a7so842999pfj.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 19:54:17 -0700 (PDT)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Andrew Morton <akpm@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv3 3/7] ia64: Add .opd based function descriptor dereference
Date: Sat, 30 Sep 2017 11:53:15 +0900
Message-Id: <20170930025319.987-4-sergey.senozhatsky@gmail.com>
In-Reply-To: <20170930025319.987-1-sergey.senozhatsky@gmail.com>
References: <20170930025319.987-1-sergey.senozhatsky@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are moving towards separate kernel and module function descriptor
dereference callbacks. This patch enables it for IA64.

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
Tested-by: Helge Deller <deller@gmx.de> # parisc64
Tested-by: Santosh Sivaraj <santosh@fossix.org> # powerpc64
Acked-by: Michael Ellerman <mpe@ellerman.id.au> # powerpc64
Tested-by: Tony Luck <tony.luck@intel.com> # ia64
---
 arch/ia64/include/asm/sections.h | 10 +++++++++-
 arch/ia64/kernel/module.c        | 13 +++++++++++++
 arch/ia64/kernel/vmlinux.lds.S   |  2 ++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sections.h
index de6bfa1ef8fb..3ba7ce9d8bc8 100644
--- a/arch/ia64/include/asm/sections.h
+++ b/arch/ia64/include/asm/sections.h
@@ -37,6 +37,14 @@ static inline unsigned long dereference_function_descriptor(unsigned long ptr)
 	return ptr;
 }
 
+#undef dereference_kernel_function_descriptor
+static inline unsigned long
+dereference_kernel_function_descriptor(unsigned long addr)
+{
+	if (addr < (unsigned long)__start_opd ||
+			addr >= (unsigned long)__end_opd)
+		return addr;
+	return dereference_function_descriptor(addr);
+}
 
 #endif /* _ASM_IA64_SECTIONS_H */
-
diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
index d1d945c6bd05..0741ae6fa957 100644
--- a/arch/ia64/kernel/module.c
+++ b/arch/ia64/kernel/module.c
@@ -35,6 +35,7 @@
 
 #include <asm/patch.h>
 #include <asm/unaligned.h>
+#include <asm/sections.h>
 
 #define ARCH_MODULE_DEBUG 0
 
@@ -917,3 +918,15 @@ module_arch_cleanup (struct module *mod)
 	if (mod->arch.core_unw_table)
 		unw_remove_unwind_table(mod->arch.core_unw_table);
 }
+
+unsigned long
+dereference_module_function_descriptor(struct module *mod, unsigned long addr)
+{
+	Elf64_Shdr *opd = mod->arch.opd;
+
+	if (addr < opd->sh_addr ||
+			addr >= (opd->sh_addr + opd->sh_size))
+		return addr;
+
+	return dereference_function_descriptor(addr);
+}
diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index 798026dde52e..f872ba5ff82a 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -107,7 +107,9 @@ SECTIONS {
 	RODATA
 
 	.opd : AT(ADDR(.opd) - LOAD_OFFSET) {
+		__start_opd = .;
 		*(.opd)
+		__end_opd = .;
 	}
 
 	/*
-- 
2.14.2
