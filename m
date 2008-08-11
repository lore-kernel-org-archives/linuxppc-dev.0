Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 15D25DDE1F
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 00:39:00 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [RFC 1/3] add support for exporting symbols from .S files
Date: Mon, 11 Aug 2008 16:18:07 +0200
References: <200808111606.44103.arnd@arndb.de>
In-Reply-To: <200808111606.44103.arnd@arndb.de>
MIME-Version: 1.0
Message-Id: <200808111618.08206.arnd@arndb.de>
Content-Type: text/plain;
  charset="utf-8"
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Rusty Russell <rusty@rustcorp.com.au>, linuxppc-dev@ozlabs.org,
	Al Viro <viro@zeniv.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes it possible to export symbols from assembly files, instead
of having to export them through an extra ksyms.c file.

I found this nicer to implement using a gas macro than a cpp macro.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -1,5 +1,7 @@
 #ifndef _LINUX_MODULE_H
 #define _LINUX_MODULE_H
+
+#ifndef __ASSEMBLY__
 /*
  * Dynamic loading of modules into the kernel.
  *
@@ -605,4 +607,54 @@ static inline void module_remove_modinfo_attrs(struct module *mod)
 
 #define __MODULE_STRING(x) __stringify(x)
 
+#else /* __ASSEMBLY__ */
+#include <asm/types.h>
+
+#ifdef CONFIG_MODULES
+.macro __EXPORT_SYMBOL sym section symtab strtab
+	.section \section,"a",@progbits
+	.type \symtab, @object
+	.ifeq BITS_PER_LONG-32
+	.align 3
+\symtab:
+	.long \sym
+	.long \strtab
+	.else
+	.align 4
+\symtab:
+	.quad \sym
+	.quad \strtab
+	.endif
+	.size \symtab,.-\symtab
+	.previous
+
+	.section __ksymtab_strings,"a",@progbits
+	.type \strtab, @object
+\strtab:
+	.string "\sym"
+	.size \strtab,.-\strtab
+	.previous
+	.endm
+
+#define EXPORT_SYMBOL(sym) \
+	 __EXPORT_SYMBOL sym,__ksymtab,__ksymtab_ ## sym,__kstrtab_ ## sym
+#define EXPORT_SYMBOL_GPL(sym) \
+	 __EXPORT_SYMBOL sym,__ksymtab_gpl,__ksymtab_ ## sym,__kstrtab_ ## sym
+#define EXPORT_SYMBOL_GPL_FUTURE(sym) \
+	 __EXPORT_SYMBOL sym,__ksymtab_gpl_future,__ksymtab_ ## sym,__kstrtab_ ## sym
+#define EXPORT_UNUSED_SYMBOL(sym) \
+	 __EXPORT_SYMBOL sym,__ksymtab_unused,__ksymtab_ ## sym,__kstrtab_ ## sym
+#define EXPORT_UNUSED_SYMBOL_GPL(sym) \
+	 __EXPORT_SYMBOL sym,__ksymtab_unused_gpl,__ksymtab_ ## sym,__kstrtab_ ## sym
+
+#else /* CONFIG_MODULES... */
+#define EXPORT_SYMBOL(sym)
+#define EXPORT_SYMBOL_GPL(sym)
+#define EXPORT_SYMBOL_GPL_FUTURE(sym)
+#define EXPORT_UNUSED_SYMBOL(sym)
+#define EXPORT_UNUSED_SYMBOL_GPL(sym)
+#endif /* !CONFIG_MODULES... */
+
+#endif /* __ASSEMBLY__ */
+
 #endif /* _LINUX_MODULE_H */
