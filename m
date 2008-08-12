Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (unknown [212.227.126.177])
	by ozlabs.org (Postfix) with ESMTP id EF5E8DE1CF
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 00:00:47 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC 1/3] add support for exporting symbols from .S files
Date: Tue, 12 Aug 2008 15:58:52 +0200
References: <200808111606.44103.arnd@arndb.de>
	<200808111618.08206.arnd@arndb.de>
	<20080812164352.ddcf1ef5.sfr@canb.auug.org.au>
In-Reply-To: <20080812164352.ddcf1ef5.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200808121558.53576.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>,
	David Woodhouse <dwmw2@infradead.org>
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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

On Tuesday 12 August 2008, Stephen Rothwell wrote:
> This won't be portable across architectures as .align is sometimes in
> bytes and sometimes a power of two.  You can use .balign or .p2align
> portably on gas, though.

Ok, this version uses the .balign as suggested by rusty, and also
fixes building with modversions turned on, which did not work in the
first version.

	Arnd <><

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
@@ -605,4 +607,72 @@ static inline void module_remove_modinfo_attrs(struct module *mod)
 
 #define __MODULE_STRING(x) __stringify(x)
 
+#else /* __ASSEMBLY__ */
+#include <asm/types.h>
+
+#ifdef CONFIG_MODULES
+.macro __EXPORT_SYMBOL sym section symtab strtab crctab crc
+	.section \section, "a", @progbits
+	.type \symtab, @object
+	.balign BITS_PER_LONG/8
+\symtab:
+	.ifeq BITS_PER_LONG - 32
+	.long \sym
+	.long \strtab
+	.else
+	.quad \sym
+	.quad \strtab
+	.endif
+	.size \symtab, . - \symtab
+	.previous
+
+	.section __ksymtab_strings, "a", @progbits
+	.type \strtab, @object
+\strtab:
+	.string "\sym"
+	.size \strtab, . - \strtab
+	.previous
+
+#ifdef CONFIG_MODVERSIONS
+	/*
+	 * Modversions doesn't work with assembly files,
+	 * so insert a dummy CRC.
+	 */
+	.section __kcrctab, "a", @progbits
+	.balign 4
+	.type \crctab, @object
+\crctab:
+	.long \crc
+	.size \crctab, . - \crctab
+	.set \crc, 0
+	.previous
+#endif
+	.endm
+
+#define EXPORT_SYMBOL(sym) \
+	 __EXPORT_SYMBOL sym, __ksymtab, __ksymtab_ ## sym, \
+		__kstrtab_ ## sym, __kcrctab_ ## sym, __crc_ ## sym
+#define EXPORT_SYMBOL_GPL(sym) \
+	 __EXPORT_SYMBOL sym, __ksymtab_gpl, __ksymtab_ ## sym, \
+		__kstrtab_ ## sym, __kcrctab_ ## sym, __crc_ ## sym
+#define EXPORT_SYMBOL_GPL_FUTURE(sym) \
+	 __EXPORT_SYMBOL sym, __ksymtab_gpl_future, __ksymtab_ ## sym, \
+		__kstrtab_ ## sym, __kcrctab_ ## sym, __crc_ ## sym
+#define EXPORT_UNUSED_SYMBOL(sym) \
+	 __EXPORT_SYMBOL sym, __ksymtab_unused, __ksymtab_ ## sym, \
+		__kstrtab_ ## sym, __kcrctab_ ## sym, __crc_ ## sym
+#define EXPORT_UNUSED_SYMBOL_GPL(sym) \
+	 __EXPORT_SYMBOL sym, __ksymtab_unused_gpl, __ksymtab_ ## sym, \
+		__kstrtab_ ## sym, __kcrctab_ ## sym, __crc_ ## sym
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
