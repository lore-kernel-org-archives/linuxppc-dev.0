Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0bXN026mzDvWg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 17:35:32 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 128so7733911pfz.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 23:35:31 -0700 (PDT)
Date: Fri, 21 Oct 2016 17:35:17 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 0/7] build updates (and RFC on one-pass kallsyms
 generation)
Message-ID: <20161021173517.1f715fda@roar.ozlabs.ibm.com>
In-Reply-To: <20161019184422.50f4d08b@roar.ozlabs.ibm.com>
References: <20161019031600.17933-1-npiggin@gmail.com>
 <20161019184422.50f4d08b@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 19 Oct 2016 18:44:22 +1100
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Wed, 19 Oct 2016 14:15:53 +1100
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > [*] Building allyesconfig still requires KALLSYMS_EXTRA_PASS=1, which
> >     I'm yet to look into.  
> 
> Oh, it's because the kallsyms payload increases kernel image size and that
> causes more linker stubs to be generated, which have symbols, which go into
> kallsyms... What a nightmare.
> 
> We can use --no-emit-stub-syms, but it's kind of nice to have names for
> things.

This is a real quick hack at a way to improve it.

Even if we don't go with the kbuild change (which causes a slight
regression in a handful of symbols), I'll pursue the .kallsyms section
and powerpc change to move it toward the end: that should be enough to
avoid the build failures, and it moves a huge blob of cold data from the
middle of the image.

    kbuild: put kallsyms into its own section
    
    With example linker script implementation for powerpc. This allows
    us to put the kallsyms section at the end of the image rather than
    in the middle, which doesn't jumble all our offsets when linking it
    in, or causing liker to add more stubs. Which means we can do kallsyms
    generation in one pass. A few values (_end, and some kallsyms_ variables)
    do move, so they don't get correct symbols.

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 115a44e..9ebe1df 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -294,6 +294,10 @@ SECTIONS
 
 	BSS_SECTION(0, 0, 0)
 
+	.kallsyms : AT(ADDR(.kallsyms) - LOAD_OFFSET) {
+		KEEP(*(.kallsyms))
+	}
+
 	. = ALIGN(PAGE_SIZE);
 	_end = . ;
 	PROVIDE32 (end = .);
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index fafd1a3..311fe07 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -37,24 +37,30 @@
  * These will be re-linked against their real values
  * during the second link stage.
  */
-extern const unsigned long kallsyms_addresses[] __weak;
-extern const int kallsyms_offsets[] __weak;
-extern const u8 kallsyms_names[] __weak;
+extern const unsigned long kallsyms_addresses[]
+__attribute__((weak, section(".kallsyms")));
+extern const int kallsyms_offsets[]
+__attribute__((weak, section(".kallsyms")));
+extern const u8 kallsyms_names[]
+__attribute__((weak, section(".kallsyms")));
 
 /*
  * Tell the compiler that the count isn't in the small data section if the arch
  * has one (eg: FRV).
  */
 extern const unsigned long kallsyms_num_syms
-__attribute__((weak, section(".rodata")));
+__attribute__((weak, section(".kallsyms")));
 
 extern const unsigned long kallsyms_relative_base
-__attribute__((weak, section(".rodata")));
+__attribute__((weak, section(".kallsyms")));
 
-extern const u8 kallsyms_token_table[] __weak;
-extern const u16 kallsyms_token_index[] __weak;
+extern const u8 kallsyms_token_table[]
+__attribute__((weak, section(".kallsyms")));
+extern const u16 kallsyms_token_index[]
+__attribute__((weak, section(".kallsyms")));
 
-extern const unsigned long kallsyms_markers[] __weak;
+extern const unsigned long kallsyms_markers[]
+__attribute__((weak, section(".kallsyms")));
 
 static inline int is_kernel_inittext(unsigned long addr)
 {
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 1f22a18..4327d80 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -349,7 +349,7 @@ static void write_src(void)
 	printf("#define ALGN .align 4\n");
 	printf("#endif\n");
 
-	printf("\t.section .rodata, \"a\"\n");
+	printf("\t.section .kallsyms, \"a\"\n");
 
 	/* Provide proper symbols relocatability by their relativeness
 	 * to a fixed anchor point in the runtime image, either '_text'
commit 61502b241e9b597a60d6032a5f5a4c1dfbcafece
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Wed Oct 19 19:56:26 2016 +1100

    kbuild: one-pass kallsyms generation
    
    With kallsyms at the end of the image, linking kallsyms doesn't
    change around all offsets or cause linker stubs to be added. This
    means kallsyms generation can be done in just one pass, and it
    won't fail due to linker stubs.

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 9ebe1df..534c8df 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -190,29 +190,6 @@ SECTIONS
 		*(.machine.desc)
 		__machine_desc_end = . ;
 	}
-#ifdef CONFIG_RELOCATABLE
-	. = ALIGN(8);
-	.dynsym : AT(ADDR(.dynsym) - LOAD_OFFSET)
-	{
-#ifdef CONFIG_PPC32
-		__dynamic_symtab = .;
-#endif
-		*(.dynsym)
-	}
-	.dynstr : AT(ADDR(.dynstr) - LOAD_OFFSET) { *(.dynstr) }
-	.dynamic : AT(ADDR(.dynamic) - LOAD_OFFSET)
-	{
-		__dynamic_start = .;
-		*(.dynamic)
-	}
-	.hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }
-	.interp : AT(ADDR(.interp) - LOAD_OFFSET) { *(.interp) }
-	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
-	{
-		__rela_dyn_start = .;
-		*(.rela*)
-	}
-#endif
 	/* .exit.data is discarded at runtime, not link time,
 	 * to deal with references from .exit.text
 	 */
@@ -294,9 +271,35 @@ SECTIONS
 
 	BSS_SECTION(0, 0, 0)
 
+#ifdef CONFIG_RELOCATABLE
+	. = ALIGN(8);
+	.dynsym : AT(ADDR(.dynsym) - LOAD_OFFSET)
+	{
+#ifdef CONFIG_PPC32
+		__dynamic_symtab = .;
+#endif
+		*(.dynsym)
+	}
+	.dynstr : AT(ADDR(.dynstr) - LOAD_OFFSET) { *(.dynstr) }
+	.dynamic : AT(ADDR(.dynamic) - LOAD_OFFSET)
+	{
+		__dynamic_start = .;
+		*(.dynamic)
+	}
+	.hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }
+	.interp : AT(ADDR(.interp) - LOAD_OFFSET) { *(.interp) }
+	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
+	{
+		__rela_dyn_start = .;
+		*(.rela*)
+	}
+#endif
+
+#ifdef CONFIG_KALLSYMS
 	.kallsyms : AT(ADDR(.kallsyms) - LOAD_OFFSET) {
 		KEEP(*(.kallsyms))
 	}
+#endif
 
 	. = ALIGN(PAGE_SIZE);
 	_end = . ;
@@ -313,5 +316,6 @@ SECTIONS
 		*(.gnu.version*)
 		*(.gnu.attributes)
 		*(.eh_frame)
+		*(.kallsyms)
 	}
 }
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index f742c65..b37a62b 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -209,15 +209,6 @@ case "${KCONFIG_CONFIG}" in
 	. "./${KCONFIG_CONFIG}"
 esac
 
-archive_builtin
-
-#link vmlinux.o
-info LD vmlinux.o
-modpost_link vmlinux.o
-
-# modpost vmlinux.o to check for section mismatches
-${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
-
 # Update version
 info GEN .version
 if [ ! -r .version ]; then
@@ -231,54 +222,26 @@ fi;
 # final build of init/
 ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init GCC_PLUGINS_CFLAGS="${GCC_PLUGINS_CFLAGS}"
 
+archive_builtin
+
+# link vmlinux.o
+info LD vmlinux.o
+modpost_link vmlinux.o
+
+# modpost vmlinux.o to check for section mismatches
+${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
+
 kallsymso=""
-kallsyms_vmlinux=""
 if [ -n "${CONFIG_KALLSYMS}" ]; then
-
-	# kallsyms support
-	# Generate section listing all symbols and add it into vmlinux
-	# It's a three step process:
-	# 1)  Link .tmp_vmlinux1 so it has all symbols and sections,
-	#     but __kallsyms is empty.
-	#     Running kallsyms on that gives us .tmp_kallsyms1.o with
-	#     the right size
-	# 2)  Link .tmp_vmlinux2 so it now has a __kallsyms section of
-	#     the right size, but due to the added section, some
-	#     addresses have shifted.
-	#     From here, we generate a correct .tmp_kallsyms2.o
-	# 2a) We may use an extra pass as this has been necessary to
-	#     woraround some alignment related bugs.
-	#     KALLSYMS_EXTRA_PASS=1 is used to trigger this.
-	# 3)  The correct ${kallsymso} is linked into the final vmlinux.
-	#
-	# a)  Verify that the System.map from vmlinux matches the map from
-	#     ${kallsymso}.
-
-	kallsymso=.tmp_kallsyms2.o
-	kallsyms_vmlinux=.tmp_vmlinux2
-
-	# step 1
-	vmlinux_link "" .tmp_vmlinux1
-	kallsyms .tmp_vmlinux1 .tmp_kallsyms1.o
-
-	# step 2
-	vmlinux_link .tmp_kallsyms1.o .tmp_vmlinux2
-	kallsyms .tmp_vmlinux2 .tmp_kallsyms2.o
-
-	# step 2a
-	if [ -n "${KALLSYMS_EXTRA_PASS}" ]; then
-		kallsymso=.tmp_kallsyms3.o
-		kallsyms_vmlinux=.tmp_vmlinux3
-
-		vmlinux_link .tmp_kallsyms2.o .tmp_vmlinux3
-
-		kallsyms .tmp_vmlinux3 .tmp_kallsyms3.o
-	fi
+        vmlinux_link "${kallsymso}" .tmp_vmlinux
+	kallsyms .tmp_vmlinux kallsyms.o
+	kallsymso="kallsyms.o"
 fi
 
 info LD vmlinux
 vmlinux_link "${kallsymso}" vmlinux
 
+
 if [ -n "${CONFIG_BUILDTIME_EXTABLE_SORT}" ]; then
 	info SORTEX vmlinux
 	sortextable vmlinux
@@ -287,16 +250,5 @@ fi
 info SYSMAP System.map
 mksysmap vmlinux System.map
 
-# step a (see comment above)
-if [ -n "${CONFIG_KALLSYMS}" ]; then
-	mksysmap ${kallsyms_vmlinux} .tmp_System.map
-
-	if ! cmp -s System.map .tmp_System.map; then
-		echo >&2 Inconsistent kallsyms data
-		echo >&2 Try "make KALLSYMS_EXTRA_PASS=1" as a workaround
-		exit 1
-	fi
-fi
-
 # We made a new kernel - delete old version file
 rm -f .old_version
