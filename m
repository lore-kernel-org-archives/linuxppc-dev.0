Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5N7N2k5NzDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 20:18:40 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Fengguang Wu <fengguang.wu@intel.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Date: Fri, 05 Aug 2016 12:17:27 +0200
Message-ID: <2038522.anQ279eb8I@wuerfel>
In-Reply-To: <20160805184108.7fc3dbd0@roar.ozlabs.ibm.com>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <20160804170640.GC22744@gate.crashing.org>
 <20160805184108.7fc3dbd0@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, August 5, 2016 6:41:08 PM CEST Nicholas Piggin wrote:
> On Thu, 4 Aug 2016 12:06:41 -0500
> Segher Boessenkool <segher@kernel.crashing.org> wrote:
> 
> > On Thu, Aug 04, 2016 at 06:10:57PM +0200, Arnd Bergmann wrote:
> > > On Thursday, August 4, 2016 9:47:13 PM CEST Nicholas Piggin wrote:
> > >   
> > > > +	__used							\
> > > > +	__attribute__((section("___kentry" "+" #sym ",\"a\",@note #"), used)) \  
> > > 
> > > 
> > > I've just started testing this, but the first problem I ran into
> > > is that @ and # are special characters that have an architecture
> > > specific meaning to the assembler. On ARM, you need "%note @" instead
> > > of "@note #".  
> > 
> > That comment trick (I still feel guilty about it) causes more problems
> > than it solves.  Please don't try to use it :-)
> 
> Yeah that's a funny hack. I don't think it's required though, but I'm just
> running through some more tests.
> 
> I think I found an improvement with the thin archives as well -- we were
> still building symbol table after removing the s option (that only avoids
> index). "S" is required to not build symbol table.
> 
> I'll send out an RFC on a slightly more polished patch series shortly.


I could not find Nico's patches, but based on the information in his
presentation at

https://www.linuxplumbersconf.org/2015/ocw//system/presentations/3369/original/slides.html#(1)

I created a patch for ARM that mirrors what you have for powerpc, see
below.

I have successfully built normal-sized kernels with this (not tried
running them). Unfortunately, the build time for "allyesconfig"
kernel explodes, the final link time is now in the hours instead of
minutes (no exact numbers unfortunately, it takes too long to
reproduce), and I also get link errors for the .text.fixup section
for any users of __put_user() in really large kernels:

net/batman-adv/batman-adv.o:(.text.fixup+0x4): relocation truncated to fit: R_ARM_JUMP24 against `.text.batadv_log_read'
...
drivers/scsi/sg.o:(.text.fixup+0x4): relocation truncated to fit: R_ARM_THM_JUMP24 against `.text.sg_ioctl'
drivers/scsi/sg.o:(.text.fixup+0xc): relocation truncated to fit: R_ARM_THM_JUMP24 against `.text.sg_ioctl'
drivers/scsi/sg.o:(.text.fixup+0x14): relocation truncated to fit: R_ARM_THM_JUMP24 against `.text.sg_ioctl'
...

This originates from

#define __put_user_asm(x, __pu_addr, err, instr)                \
        __asm__ __volatile__(                                   \
        "1:     " TUSER(instr) " %1, [%2], #0\n"                \
        "2:\n"                                                  \
        "       .pushsection .text.fixup,\"ax\"\n"              \
        "       .align  2\n"                                    \
        "3:     mov     %0, %3\n"                               \
        "       b       2b\n"                                   \
        "       .popsection\n"                                  \
        "       .pushsection __ex_table,\"a\"\n"                \
        "       .align  3\n"                                    \
        "       .long   1b, 3b\n"                               \
        "       .popsection"                                    \
        : "+r" (err)                                            \
        : "r" (x), "r" (__pu_addr), "i" (-EFAULT)               \
        : "cc")

	Arnd

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 842f46af5b9d..b4fc91603429 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -362,6 +362,8 @@ archclean:
 # My testing targets (bypasses dependencies)
 bp:;	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/bootpImage
 
+KBUILD_CFLAGS  += -ffunction-sections -fdata-sections
+LDFLAGS_vmlinux        += --gc-sections
 
 define archhelp
   echo  '* zImage        - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index ad325a8c7e1e..f0eca9a96005 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -11,6 +11,9 @@ CFLAGS_REMOVE_insn.o = -pg
 CFLAGS_REMOVE_patch.o = -pg
 endif
 
+ccflags-y              += -fno-function-sections -fno-data-sections
+subdir-ccflags-y       += -fno-function-sections -fno-data-sections
+
 CFLAGS_REMOVE_return_address.o = -pg
 
 # Object file lists.
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 56c8bdf776bd..ef7d8d7a997b 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -12,17 +12,17 @@
 #define PROC_INFO							\
 	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
-	*(.proc.info.init)						\
+	KEEP(*(.proc.info.init))					\
 	VMLINUX_SYMBOL(__proc_info_end) = .;
 
 #define IDMAP_TEXT							\
 	ALIGN_FUNCTION();						\
 	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
-	*(.idmap.text)							\
+	KEEP(*(.idmap.text))						\
 	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
 	. = ALIGN(PAGE_SIZE);						\
 	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
-	*(.hyp.idmap.text)						\
+	KEEP(*(.hyp.idmap.text))					\
 	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -93,7 +93,7 @@ SECTIONS
 		_stext = .;		/* Text and read-only data	*/
 			IDMAP_TEXT
 			__exception_text_start = .;
-			*(.exception.text)
+			KEEP(*(.exception.text))
 			__exception_text_end = .;
 			IRQENTRY_TEXT
 			TEXT_TEXT
@@ -114,11 +114,11 @@ SECTIONS
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
 		__start___ex_table = .;
 #ifdef CONFIG_MMU
-		*(__ex_table)
+		KEEP(*(__ex_table))
 #endif
 		__stop___ex_table = .;
 	}
-
+)
 #ifdef CONFIG_ARM_UNWIND
 	/*
 	 * Stack unwinding tables
@@ -126,12 +126,12 @@ SECTIONS
 	. = ALIGN(8);
 	.ARM.unwind_idx : {
 		__start_unwind_idx = .;
-		*(.ARM.exidx*)
+		KEEP(*(.ARM.exidx*))
 		__stop_unwind_idx = .;
 	}
 	.ARM.unwind_tab : {
 		__start_unwind_tab = .;
-		*(.ARM.extab*)
+		KEEP(*(.ARM.extab*))
 		__stop_unwind_tab = .;
 	}
 #endif
@@ -146,14 +146,14 @@ SECTIONS
 	 */
 	__vectors_start = .;
 	.vectors 0xffff0000 : AT(__vectors_start) {
-		*(.vectors)
+		KEEP(*(.vectors))
 	}
 	. = __vectors_start + SIZEOF(.vectors);
 	__vectors_end = .;
 
 	__stubs_start = .;
 	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {
-		*(.stubs)
+		KEEP(*(.stubs))
 	}
 	. = __stubs_start + SIZEOF(.stubs);
 	__stubs_end = .;
@@ -169,24 +169,24 @@ SECTIONS
 	}
 	.init.arch.info : {
 		__arch_info_begin = .;
-		*(.arch.info.init)
+		KEEP(*(.arch.info.init))
 		__arch_info_end = .;
 	}
 	.init.tagtable : {
 		__tagtable_begin = .;
-		*(.taglist.init)
+		KEEP(*(.taglist.init))
 		__tagtable_end = .;
 	}
 #ifdef CONFIG_SMP_ON_UP
 	.init.smpalt : {
 		__smpalt_begin = .;
-		*(.alt.smp.init)
+		KEEP(*(.alt.smp.init))
 		__smpalt_end = .;
 	}
 #endif
 	.init.pv_table : {
 		__pv_table_begin = .;
-		*(.pv_table)
+		KEEP(*(.pv_table))
 		__pv_table_end = .;
 	}
 	.init.data : {
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 7396a5f00c5f..61b9b8784036 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -17,7 +17,7 @@
 #define PROC_INFO							\
 	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
-	*(.proc.info.init)						\
+	KEEP(*(.proc.info.init))					\
 	VMLINUX_SYMBOL(__proc_info_end) = .;
 
 #define HYPERVISOR_TEXT							\
@@ -104,7 +104,7 @@ SECTIONS
 		_stext = .;		/* Text and read-only data	*/
 			IDMAP_TEXT
 			__exception_text_start = .;
-			*(.exception.text)
+			KEEP(*(.exception.text))
 			__exception_text_end = .;
 			IRQENTRY_TEXT
 			SOFTIRQENTRY_TEXT
@@ -169,14 +169,14 @@ SECTIONS
 	 */
 	__vectors_start = .;
 	.vectors 0xffff0000 : AT(__vectors_start) {
-		*(.vectors)
+		KEEP(*(.vectors))
 	}
 	. = __vectors_start + SIZEOF(.vectors);
 	__vectors_end = .;
 
 	__stubs_start = .;
 	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {
-		*(.stubs)
+		KEEP(*(.stubs))
 	}
 	. = __stubs_start + SIZEOF(.stubs);
 	__stubs_end = .;
@@ -192,24 +192,24 @@ SECTIONS
 	}
 	.init.arch.info : {
 		__arch_info_begin = .;
-		*(.arch.info.init)
+		KEEP(*(.arch.info.init))
 		__arch_info_end = .;
 	}
 	.init.tagtable : {
 		__tagtable_begin = .;
-		*(.taglist.init)
+		KEEP(*(.taglist.init))
 		__tagtable_end = .;
 	}
 #ifdef CONFIG_SMP_ON_UP
 	.init.smpalt : {
 		__smpalt_begin = .;
-		*(.alt.smp.init)
+		KEEP(*(.alt.smp.init))
 		__smpalt_end = .;
 	}
 #endif
 	.init.pv_table : {
 		__pv_table_begin = .;
-		*(.pv_table)
+		KEEP(*(.pv_table))
 		__pv_table_end = .;
 	}
 	.init.data : {
diff --git a/include/linux/export.h b/include/linux/export.h
index cc65d53792c0..f2b7714238f3 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -46,7 +46,7 @@ extern struct module __this_module;
 	extern __visible void *__crc_##sym __attribute__((weak));		\
 	static const unsigned long __kcrctab_##sym		\
 	__used							\
-	__attribute__((section("___kcrctab" sec "+" #sym ",\"a\",@note #"), used))	\
+	__attribute__((section("___kcrctab" sec "+" #sym ",\"a\",%note @"), used))	\
 	= (unsigned long) &__crc_##sym;
 #else
 #define __CRC_SYMBOL(sym, sec)
@@ -57,12 +57,12 @@ extern struct module __this_module;
 	extern typeof(sym) sym;					\
 	__CRC_SYMBOL(sym, sec)					\
 	static const char __kstrtab_##sym[]			\
-	__attribute__((section("__ksymtab_strings" ",\"a\",@note #"), aligned(1))) \
+	__attribute__((section("__ksymtab_strings" ",\"a\",%note @"), aligned(1))) \
 	= VMLINUX_SYMBOL_STR(sym);				\
 	extern const struct kernel_symbol __ksymtab_##sym;	\
 	__visible const struct kernel_symbol __ksymtab_##sym	\
 	__used							\
-	__attribute__((section("___ksymtab" sec "+" #sym ",\"a\",@note #"), used))	\
+	__attribute__((section("___ksymtab" sec "+" #sym ",\"a\",%note @"), used))	\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
 #if defined(__KSYM_DEPS__)
diff --git a/include/linux/init.h b/include/linux/init.h
index 30cd246ab2ad..b4f1bb5403b4 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -163,7 +163,7 @@ extern bool initcall_debug;
 	/* extern const unsigned long __kentry_##sym; */		\
 	static /* __visible */ const unsigned long __kentry_##sym		\
 	__used							\
-	__attribute__((section("___kentry" "+" #sym ",\"a\",@note #"), used)) \
+	__attribute__((section("___kentry" "+" #sym ",\"a\",%note @"), used)) \
 	= (unsigned long)&sym;
 #else
 #define LTO_REFERENCE_INITCALL(x)
