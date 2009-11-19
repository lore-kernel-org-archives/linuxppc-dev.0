Return-Path: <nhorman@tuxdriver.com>
Received: from smtp.tuxdriver.com (charlotte.tuxdriver.com [70.61.120.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E837B6F09
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 07:48:58 +1100 (EST)
Date: Thu, 19 Nov 2009 14:52:16 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc64: re-enable kexec to allow module loads with
	CONFIG_MODVERSIONS and CONFIG_RELOCATABLE turned on
Message-ID: <20091119195216.GC11414@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, nhorman@tuxdriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey there-
	Before anyone flames me for what a oddball solution this is, let me just
say I'm trying to get the ball rolling here.  I think there may be better
solutions that can be impemented in reloc_64.S, but I've yet to make any of the
ones I've tried work successfully.  I'm open to suggestions, but this solution
is the only one so far that I've been able to get to work. thanks :)


Adjust crcs in __kcrctab_* sections if relocs are used with CONFIG_RELOCATABLE

When CONFIG_MODVERSIONS and CONFIG_RELOCATABLE are enabled on powerpc platforms,
kdump has been failing in a rather odd way.  specifically modules will not
install.  This is because when validating the crcs of symbols that the module
needs, the crc of the module never matches the crc that is stored in the kernel.

The underlying cause of this is how CONFIG_MODVERSIONS is implemented, and how
CONFIG_RELOCATABLE are implemented.  with CONFIG_MODVERSIONS enabled, for every
exported symbol in the kernel we emit 2 symbols, __crc_#sym which is declared
extern and __kcrctab_##sym, which is placed in the __kcrctab section of the
binary.  The latter has its value set equal to the address of the former
(recalling it is declared extern).  After the object file is built, genksyms is
run on the processed source, and crcs are computed for each exported symbol.
genksyms then emits a linker script which defines each of the needed __crc_##sym
symbols, and sets their addresses euqal to their respective crcs.  This script
is then used in a secondary link to the previously build object file, so that
the crcs of the missing symbol can be validated on module insert.

The problem here is that because __kcrctab_sym is set equal to &__crc_##sym, a
relocation entry is emitted by the compiler for the __kcrctab__##sym.  Normally
this is not a problem, since relocation on other arches is done without the aid
of .rel.dyn sections.  PPC however uses these relocations when
CONFIG_RELOCATABLE is enabled.  nominally, since addressing starts at 0 for ppc,
its irrelevant, but if we start at a non-zero address (like we do when booting
via kexec from reserved crashkernel memory), the ppc boot code iterates over the
relocation entries, and winds up adding that relocation offset to all symbols,
including the symbols that are actually the aforementioned crc values in the
__kcrctab_* sections.  This effectively corrupts the crcs and prevents any
module loads from happening during a kdump.

My solution is to 'undo' these relocations prior to boot up.  If
ARCH_USES_RELOC_ENTRIES is defined, we add a symbol at address zero to the
linker script for that arch (I call it reloc_start, so that &reloc_start = 0).
This symbol will then indicate the relocation offset for any given boot.  We
also add an initcall to the module code that, during boot, scans the __kcrctab_*
sections and subtracts &reloc_start from every entry in those sections,
restoring the appropriate crc value.

I've verified that this allows kexec to work properly on ppc64 systems myself.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 arch/powerpc/include/asm/local.h  |    6 ++++++
 arch/powerpc/kernel/vmlinux.lds.S |    4 ++++
 kernel/module.c                   |   30 ++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index 84b457a..9cc49e5 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -4,6 +4,12 @@
 #include <linux/percpu.h>
 #include <asm/atomic.h>
 
+#ifdef CONFIG_MODVERSIONS
+#define ARCH_USES_RELOC_ENTRIES
+
+extern unsigned long reloc_start;
+#endif
+
 typedef struct
 {
 	atomic_long_t a;
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 27735a7..2b9fb2e 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -38,6 +38,10 @@ jiffies = jiffies_64 + 4;
 #endif
 SECTIONS
 {
+	. = 0;
+	reloc_start = .;
+	. = 0;
+
 	. = KERNELBASE;
 
 /*
diff --git a/kernel/module.c b/kernel/module.c
index 8b7d880..87a4928 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -181,8 +181,11 @@ extern const struct kernel_symbol __stop___ksymtab_gpl_future[];
 extern const struct kernel_symbol __start___ksymtab_gpl_future[];
 extern const struct kernel_symbol __stop___ksymtab_gpl_future[];
 extern const unsigned long __start___kcrctab[];
+extern const unsigned long __stop___kcrctab[];
 extern const unsigned long __start___kcrctab_gpl[];
+extern const unsigned long __stop___kcrctab_gpl[];
 extern const unsigned long __start___kcrctab_gpl_future[];
+extern const unsigned long __stop___kcrctab_gpl_future[];
 #ifdef CONFIG_UNUSED_SYMBOLS
 extern const struct kernel_symbol __start___ksymtab_unused[];
 extern const struct kernel_symbol __stop___ksymtab_unused[];
@@ -3144,3 +3147,30 @@ int module_get_iter_tracepoints(struct tracepoint_iter *iter)
 	return found;
 }
 #endif
+
+#ifdef ARCH_USES_RELOC_ENTRIES
+static __init int adjust_kcrctab(void)
+{
+	int i;
+	int count;
+	unsigned long  *crc ;
+
+	count = __stop___kcrctab - __start___kcrctab;
+	crc = (unsigned long *)__start___kcrctab;
+	for (i = 0; i < count; i++) {
+		crc[i] -= (unsigned long)&reloc_start;
+	}
+	count = __stop___kcrctab_gpl - __start___kcrctab_gpl;
+	crc = (unsigned long *)__start___kcrctab_gpl;
+	for (i = 0; i < count; i++) {
+		crc[i] -= (unsigned long)&reloc_start;
+	}
+	count = __stop___kcrctab_gpl_future - __start___kcrctab_gpl_future;
+	crc = (unsigned long *)__start___kcrctab_gpl_future;
+	for (i = 0; i< count; i++) {
+                crc[i] -= (unsigned long)&reloc_start;
+	}
+	return 0;
+}
+early_initcall(adjust_kcrctab);
+#endif
