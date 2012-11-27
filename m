Return-Path: <anton@samba.org>
Date: Tue, 27 Nov 2012 14:39:03 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, amodra@gmail.com
Subject: [PATCH 1/3] powerpc: Relocate prom_init.c on 64bit
Message-ID: <20121127143903.4b5cab17@kryten>
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


The ppc64 kernel can get loaded at any address which means
our very early init code in prom_init.c must be relocatable. We do
this with a pretty nasty RELOC() macro that we wrap accesses of
variables with. It is very fragile and sometimes we forget to add a
RELOC() to an uncommon path or sometimes a compiler change breaks it.

32bit has a much more elegant solution where we build prom_init.c
with -mrelocatable and then process the relocations manually.
Unfortunately we can't do the equivalent on 64bit and we would
have to build the entire kernel relocatable (-pie), resulting in a
large increase in kernel footprint (megabytes of relocation data).
The relocation data will be marked __initdata but it still creates
more pressure on our already tight memory layout at boot.

Alan Modra pointed out that the 64bit ABI is relocatable even
if we don't build with -pie, we just need to relocate the TOC.
This patch implements that idea and relocates the TOC entries of
prom_init.c. An added bonus is there are very few relocations to
process which helps keep boot times on simulators down.

gcc does not put 64bit integer constants into the TOC but to be
safe we may want a build time script which passes through the
prom_init.c TOC entries to make sure everything looks reasonable.

Signed-off-by: Anton Blanchard <anton@samba.org>
--- 

To keep the patch small and reviewable, I separated the removal
of the RELOC macro into a follow up patch.

For simplicity I do the relocation in C but if self brain surgery
keeps people up at night we can move it into assembly.

Index: b/arch/powerpc/kernel/prom_init.c
===================================================================
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -66,8 +66,8 @@
  * is running at whatever address it has been loaded at.
  * On ppc32 we compile with -mrelocatable, which means that references
  * to extern and static variables get relocated automatically.
- * On ppc64 we have to relocate the references explicitly with
- * RELOC.  (Note that strings count as static variables.)
+ * ppc64 objects are always relocatable, we just need to relocate the
+ * TOC.
  *
  * Because OF may have mapped I/O devices into the area starting at
  * KERNELBASE, particularly on CHRP machines, we can't safely call
@@ -79,13 +79,12 @@
  * On ppc64, 64 bit values are truncated to 32 bits (and
  * fortunately don't get interpreted as two arguments).
  */
+#define RELOC(x)	(x)
+#define ADDR(x)		(u32)(unsigned long)(x)
+
 #ifdef CONFIG_PPC64
-#define RELOC(x)        (*PTRRELOC(&(x)))
-#define ADDR(x)		(u32) add_reloc_offset((unsigned long)(x))
 #define OF_WORKAROUNDS	0
 #else
-#define RELOC(x)	(x)
-#define ADDR(x)		(u32) (x)
 #define OF_WORKAROUNDS	of_workarounds
 int of_workarounds;
 #endif
@@ -334,9 +333,6 @@ static void __init prom_printf(const cha
 	struct prom_t *_prom = &RELOC(prom);
 
 	va_start(args, format);
-#ifdef CONFIG_PPC64
-	format = PTRRELOC(format);
-#endif
 	for (p = format; *p != 0; p = q) {
 		for (q = p; *q != 0 && *q != '\n' && *q != '%'; ++q)
 			;
@@ -437,9 +433,6 @@ static unsigned int __init prom_claim(un
 
 static void __init __attribute__((noreturn)) prom_panic(const char *reason)
 {
-#ifdef CONFIG_PPC64
-	reason = PTRRELOC(reason);
-#endif
 	prom_print(reason);
 	/* Do not call exit because it clears the screen on pmac
 	 * it also causes some sort of double-fault on early pmacs */
@@ -929,7 +922,7 @@ static void __init prom_send_capabilitie
 		 * (we assume this is the same for all cores) and use it to
 		 * divide NR_CPUS.
 		 */
-		cores = (u32 *)PTRRELOC(&ibm_architecture_vec[IBM_ARCH_VEC_NRCORES_OFFSET]);
+		cores = (u32 *)&ibm_architecture_vec[IBM_ARCH_VEC_NRCORES_OFFSET];
 		if (*cores != NR_CPUS) {
 			prom_printf("WARNING ! "
 				    "ibm_architecture_vec structure inconsistent: %lu!\n",
@@ -2850,6 +2843,53 @@ static void __init prom_check_initrd(uns
 #endif /* CONFIG_BLK_DEV_INITRD */
 }
 
+#ifdef CONFIG_PPC64
+#ifdef CONFIG_RELOCATABLE
+static void reloc_toc(void)
+{
+}
+
+static void unreloc_toc(void)
+{
+}
+#else
+static void __reloc_toc(void *tocstart, unsigned long offset,
+			unsigned long nr_entries)
+{
+	unsigned long i;
+	unsigned long *toc_entry = (unsigned long *)tocstart;
+
+	for (i = 0; i < nr_entries; i++) {
+		*toc_entry = *toc_entry + offset;
+		toc_entry++;
+	}
+}
+
+static void reloc_toc(void)
+{
+	unsigned long offset = reloc_offset();
+	unsigned long nr_entries =
+		(__prom_init_toc_end - __prom_init_toc_start) / sizeof(long);
+
+	/* Need to add offset to get at __prom_init_toc_start */
+	__reloc_toc(__prom_init_toc_start + offset, offset, nr_entries);
+
+	mb();
+}
+
+static void unreloc_toc(void)
+{
+	unsigned long offset = reloc_offset();
+	unsigned long nr_entries =
+		(__prom_init_toc_end - __prom_init_toc_start) / sizeof(long);
+
+	mb();
+
+	/* __prom_init_toc_start has been relocated, no need to add offset */
+	__reloc_toc(__prom_init_toc_start, -offset, nr_entries);
+}
+#endif
+#endif
 
 /*
  * We enter here early on, when the Open Firmware prom is still
@@ -2867,6 +2907,8 @@ unsigned long __init prom_init(unsigned
 #ifdef CONFIG_PPC32
 	unsigned long offset = reloc_offset();
 	reloc_got2(offset);
+#else
+	reloc_toc();
 #endif
 
 	_prom = &RELOC(prom);
@@ -3061,6 +3103,8 @@ unsigned long __init prom_init(unsigned
 
 #ifdef CONFIG_PPC32
 	reloc_got2(-offset);
+#else
+	unreloc_toc();
 #endif
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
Index: b/arch/powerpc/kernel/prom_init_check.sh
===================================================================
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -22,7 +22,7 @@ __secondary_hold_acknowledge __secondary
 strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
 reloc_got2 kernstart_addr memstart_addr linux_banner _stext
 opal_query_takeover opal_do_takeover opal_enter_rtas opal_secondary_entry
-boot_command_line"
+boot_command_line __prom_init_toc_start __prom_init_toc_end"
 
 NM="$1"
 OBJ="$2"
Index: b/arch/powerpc/kernel/vmlinux.lds.S
===================================================================
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -218,6 +218,11 @@ SECTIONS
 
 	.got : AT(ADDR(.got) - LOAD_OFFSET) {
 		__toc_start = .;
+#ifndef CONFIG_RELOCATABLE
+		__prom_init_toc_start = .;
+		arch/powerpc/kernel/prom_init.o*(.toc .got)
+		__prom_init_toc_end = .;
+#endif
 		*(.got)
 		*(.toc)
 	}
Index: b/arch/powerpc/Makefile
===================================================================
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -136,6 +136,7 @@ head-$(CONFIG_FSL_BOOKE)	:= arch/powerpc
 head-$(CONFIG_PPC64)		+= arch/powerpc/kernel/entry_64.o
 head-$(CONFIG_PPC_FPU)		+= arch/powerpc/kernel/fpu.o
 head-$(CONFIG_ALTIVEC)		+= arch/powerpc/kernel/vector.o
+head-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)  += arch/powerpc/kernel/prom_init.o
 
 core-y				+= arch/powerpc/kernel/ \
 				   arch/powerpc/mm/ \
Index: b/arch/powerpc/kernel/Makefile
===================================================================
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -91,7 +91,6 @@ obj-$(CONFIG_RELOCATABLE_PPC32)	+= reloc
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
 obj-$(CONFIG_PPC64)		+= dma-iommu.o iommu.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
-obj-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)	+= prom_init.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_SMP)		+= smp.o
@@ -142,6 +141,7 @@ GCOV_PROFILE_kprobes.o := n
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
 extra-$(CONFIG_ALTIVEC)		+= vector.o
 extra-$(CONFIG_PPC64)		+= entry_64.o
+extra-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)	+= prom_init.o
 
 extra-y				+= systbl_chk.i
 $(obj)/systbl.o:		systbl_chk
Index: b/arch/powerpc/include/asm/sections.h
===================================================================
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -10,6 +10,9 @@
 
 extern char __end_interrupts[];
 
+extern char __prom_init_toc_start[];
+extern char __prom_init_toc_end[];
+
 static inline int in_kernel_text(unsigned long addr)
 {
 	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
