Return-Path: <anton@samba.org>
Date: Tue, 27 Nov 2012 14:41:08 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, amodra@gmail.com
Subject: [PATCH 3/3] powerpc: Build kernel with -mcmodel=medium
Message-ID: <20121127144108.5b448ff5@kryten>
In-Reply-To: <20121127143903.4b5cab17@kryten>
References: <20121127143903.4b5cab17@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Finally remove the two level TOC and build with -mcmodel=medium.

Unfortunately we can't build modules with -mcmodel=medium due to
the tricks the kernel module loader plays with percpu data:

# -mcmodel=medium breaks modules because it uses 32bit offsets from
# the TOC pointer to create pointers where possible. Pointers into the
# percpu data area are created by this method.
#
# The kernel module loader relocates the percpu data section from the
# original location (starting with 0xd...) to somewhere in the base
# kernel percpu data space (starting with 0xc...). We need a full
# 64bit relocation for this to work, hence -mcmodel=large.

On older kernels we fall back to the two level TOC (-mminimal-toc)

Signed-off-by: Anton Blanchard <anton@samba.org>
--- 

Index: b/arch/powerpc/Makefile
===================================================================
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -67,7 +67,24 @@ LDFLAGS_vmlinux-y := -Bstatic
 LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
 
-CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=no -mcall-aixdesc
+ifeq ($(CONFIG_PPC64),y)
+ifeq ($(call cc-option-yn,-mcmodel=medium),y)
+	# -mcmodel=medium breaks modules because it uses 32bit offsets from
+	# the TOC pointer to create pointers where possible. Pointers into the
+	# percpu data area are created by this method.
+	#
+	# The kernel module loader relocates the percpu data section from the
+	# original location (starting with 0xd...) to somewhere in the base
+	# kernel percpu data space (starting with 0xc...). We need a full
+	# 64bit relocation for this to work, hence -mcmodel=large.
+	KBUILD_CFLAGS_MODULE += -mcmodel=large
+else
+	export NO_MINIMAL_TOC := -mno-minimal-toc
+endif
+endif
+
+CFLAGS-$(CONFIG_PPC64)	:= -mtraceback=no -mcall-aixdesc
+CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,-mminimal-toc)
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 -mmultiple
 
 CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power7,-mtune=power4)
Index: b/arch/powerpc/kernel/Makefile
===================================================================
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -7,7 +7,7 @@ CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UT
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ifeq ($(CONFIG_PPC64),y)
-CFLAGS_prom_init.o	+= -mno-minimal-toc
+CFLAGS_prom_init.o	+= $(NO_MINIMAL_TOC)
 endif
 ifeq ($(CONFIG_PPC32),y)
 CFLAGS_prom_init.o      += -fPIC
Index: b/arch/powerpc/lib/Makefile
===================================================================
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -4,7 +4,7 @@
 
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
-ccflags-$(CONFIG_PPC64)	:= -mno-minimal-toc
+ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 CFLAGS_REMOVE_code-patching.o = -pg
 CFLAGS_REMOVE_feature-fixups.o = -pg
Index: b/arch/powerpc/mm/Makefile
===================================================================
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -4,7 +4,7 @@
 
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
-ccflags-$(CONFIG_PPC64)	:= -mno-minimal-toc
+ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 obj-y				:= fault.o mem.o pgtable.o gup.o \
 				   init_$(CONFIG_WORD_SIZE).o \
Index: b/arch/powerpc/oprofile/Makefile
===================================================================
--- a/arch/powerpc/oprofile/Makefile
+++ b/arch/powerpc/oprofile/Makefile
@@ -1,6 +1,6 @@
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
-ccflags-$(CONFIG_PPC64)	:= -mno-minimal-toc
+ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 obj-$(CONFIG_OPROFILE) += oprofile.o
 
Index: b/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -1,4 +1,4 @@
-ccflags-$(CONFIG_PPC64)			:= -mno-minimal-toc
+ccflags-$(CONFIG_PPC64)			:= $(NO_MINIMAL_TOC)
 ccflags-$(CONFIG_PPC_PSERIES_DEBUG)	+= -DDEBUG
 
 obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
Index: b/arch/powerpc/sysdev/Makefile
===================================================================
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -1,6 +1,6 @@
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
-ccflags-$(CONFIG_PPC64)		:= -mno-minimal-toc
+ccflags-$(CONFIG_PPC64)		:= $(NO_MINIMAL_TOC)
 
 mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o mpic_pasemi_msi.o
 obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
Index: b/arch/powerpc/xmon/Makefile
===================================================================
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -4,7 +4,7 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -
 
 GCOV_PROFILE := n
 
-ccflags-$(CONFIG_PPC64) := -mno-minimal-toc
+ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
 
 obj-y			+= xmon.o nonstdio.o
 
Index: b/arch/powerpc/platforms/wsp/Makefile
===================================================================
--- a/arch/powerpc/platforms/wsp/Makefile
+++ b/arch/powerpc/platforms/wsp/Makefile
@@ -1,4 +1,4 @@
-ccflags-y			+= -mno-minimal-toc
+ccflags-y			+= $(NO_MINIMAL_TOC)
 
 obj-y				+= setup.o ics.o wsp.o
 obj-$(CONFIG_PPC_PSR2)		+= psr2.o
Index: b/arch/powerpc/kernel/head_64.S
===================================================================
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -169,6 +169,7 @@ _GLOBAL(generic_secondary_thread_init)
 
 	/* get a valid TOC pointer, wherever we're mapped at */
 	bl	.relative_toc
+	tovirt(r2,r2)
 
 #ifdef CONFIG_PPC_BOOK3E
 	/* Book3E initialization */
@@ -195,6 +196,7 @@ _GLOBAL(generic_secondary_smp_init)
 
 	/* get a valid TOC pointer, wherever we're mapped at */
 	bl	.relative_toc
+	tovirt(r2,r2)
 
 #ifdef CONFIG_PPC_BOOK3E
 	/* Book3E initialization */
@@ -531,6 +533,7 @@ _GLOBAL(pmac_secondary_start)
 
 	/* get TOC pointer (real address) */
 	bl	.relative_toc
+	tovirt(r2,r2)
 
 	/* Copy some CPU settings from CPU 0 */
 	bl	.__restore_cpu_ppc970
@@ -665,6 +668,13 @@ _GLOBAL(enable_64b_mode)
  * This puts the TOC pointer into r2, offset by 0x8000 (as expected
  * by the toolchain).  It computes the correct value for wherever we
  * are running at the moment, using position-independent code.
+ *
+ * Note: The compiler constructs pointers using offsets from the
+ * TOC in -mcmodel=medium mode. After we relocate to 0 but before
+ * the MMU is on we need our TOC to be a virtual address otherwise
+ * these pointers will be real addresses which may get stored and
+ * accessed later with the MMU on. We use tovirt() at the call
+ * sites to handle this.
  */
 _GLOBAL(relative_toc)
 	mflr	r0
@@ -681,8 +691,9 @@ p_toc:	.llong	__toc_start + 0x8000 - 0b
  * This is where the main kernel code starts.
  */
 _INIT_STATIC(start_here_multiplatform)
-	/* set up the TOC (real address) */
-	bl	.relative_toc
+	/* set up the TOC */
+	bl      .relative_toc
+	tovirt(r2,r2)
 
 	/* Clear out the BSS. It may have been done in prom_init,
 	 * already but that's irrelevant since prom_init will soon
Index: b/arch/powerpc/kernel/module_64.c
===================================================================
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -386,6 +386,14 @@ int apply_relocate_add(Elf64_Shdr *sechd
 				| (value & 0xffff);
 			break;
 
+		case R_PPC64_TOC16_LO:
+			/* Subtract TOC pointer */
+			value -= my_r2(sechdrs, me);
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xffff)
+				| (value & 0xffff);
+			break;
+
 		case R_PPC64_TOC16_DS:
 			/* Subtract TOC pointer */
 			value -= my_r2(sechdrs, me);
@@ -399,6 +407,28 @@ int apply_relocate_add(Elf64_Shdr *sechd
 				| (value & 0xfffc);
 			break;
 
+		case R_PPC64_TOC16_LO_DS:
+			/* Subtract TOC pointer */
+			value -= my_r2(sechdrs, me);
+			if ((value & 3) != 0) {
+				printk("%s: bad TOC16_LO_DS relocation (%lu)\n",
+				       me->name, value);
+				return -ENOEXEC;
+			}
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xfffc)
+				| (value & 0xfffc);
+			break;
+
+		case R_PPC64_TOC16_HA:
+			/* Subtract TOC pointer */
+			value -= my_r2(sechdrs, me);
+			value = ((value + 0x8000) >> 16);
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xffff)
+				| (value & 0xffff);
+			break;
+
 		case R_PPC_REL24:
 			/* FIXME: Handle weak symbols here --RR */
 			if (sym->st_shndx == SHN_UNDEF) {
