Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17352.57423.119068.737164@cargo.ozlabs.ibm.com>
Date: Sat, 14 Jan 2006 22:28:15 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Remove powermac support from ARCH=ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes it possible to build kernels for PReP and/or CHRP
with ARCH=ppc by removing the (non-building) powermac support.
It's now also possible to select PReP and CHRP independently.
Powermac users should now build with ARCH=powerpc instead of
ARCH=ppc.

This patch doesn't actually remove all the powermac files under
arch/ppc, but they could go.

This means, BTW, that it will no longer be possible to build 32-bit
kernels for Apple G5 machines.  Also, miboot users (are there any
still?) are out of luck until I move the miboot stuff over to
arch/powerpc/boot.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index d658101..11899f0 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -58,11 +58,11 @@ config 6xx
 	help
 	  There are four types of PowerPC chips supported.  The more common
 	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
-	  versions (821, 823, 850, 855, 860, 52xx, 82xx, 83xx), the IBM embedded
-	  versions (403 and 405) and the high end 64 bit Power processors
-	  (POWER 3, POWER4, and IBM 970 also known as G5)
+	  versions (821, 823, 850, 855, 860, 52xx, 82xx, 83xx), the IBM
+	  embedded versions (403 and 405) and the POWER3 processor.
+	  (For support for more recent 64-bit processors, set ARCH=powerpc.)
 	  Unless you are building a kernel for one of the embedded processor
-	  systems, 64 bit IBM RS/6000 or an Apple G5, choose 6xx.
+	  systems or a POWER3-based IBM RS/6000, choose 6xx.
 	  Note that the kernel runs in 32-bit mode even on 64-bit chips.
 	  Also note that because the 52xx, 82xx, & 83xx family has a 603e core,
 	  specific support for that chipset is asked later on.
@@ -77,10 +77,6 @@ config POWER3
 	select PPC_FPU
 	bool "POWER3"
 
-config POWER4
-	select PPC_FPU
-	bool "POWER4 and 970 (G5)"
-
 config 8xx
 	bool "8xx"
 
@@ -123,7 +119,7 @@ config PHYS_64BIT
 
 config ALTIVEC
 	bool "AltiVec Support"
-	depends on 6xx || POWER4
+	depends on 6xx
 	depends on !8260 && !83xx
 	---help---
 	  This option enables kernel support for the Altivec extensions to the
@@ -235,18 +231,9 @@ config KEXEC
 
 source "drivers/cpufreq/Kconfig"
 
-config CPU_FREQ_PMAC
-	bool "Support for Apple PowerBooks"
-	depends on CPU_FREQ && ADB_PMU
-	select CPU_FREQ_TABLE
-	help
-	  This adds support for frequency switching on Apple PowerBooks,
-	  this currently includes some models of iBook & Titanium
-	  PowerBook.
-
 config PPC601_SYNC_FIX
 	bool "Workarounds for PPC601 bugs"
-	depends on 6xx && (PPC_PREP || PPC_PMAC)
+	depends on 6xx && PPC_PREP
 	help
 	  Some versions of the PPC601 (the first PowerPC chip) have bugs which
 	  mean that extra synchronization instructions are required near
@@ -258,26 +245,17 @@ config PPC601_SYNC_FIX
 
 	  If in doubt, say Y here.
 
-config HOTPLUG_CPU
-	bool "Support for enabling/disabling CPUs"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && PPC_PMAC
-	---help---
-	  Say Y here to be able to disable and re-enable individual
-	  CPUs at runtime on SMP machines.
-
-	  Say N if you are unsure.
-
 source arch/ppc/platforms/4xx/Kconfig
 source arch/ppc/platforms/85xx/Kconfig
 
 config PPC64BRIDGE
 	bool
-	depends on POWER3 || POWER4
+	depends on POWER3
 	default y
 
 config PPC_STD_MMU
 	bool
-	depends on 6xx || POWER3 || POWER4
+	depends on 6xx || POWER3
 	default y
 
 config NOT_COHERENT_CACHE
@@ -505,7 +483,7 @@ endchoice
 
 choice
 	prompt "Machine Type"
-	depends on 6xx || POWER3 || POWER4
+	depends on 6xx || POWER3
 	default PPC_MULTIPLATFORM
 	---help---
 	  Linux currently supports several different kinds of PowerPC-based
@@ -516,11 +494,15 @@ choice
 	  Platform) machines (including all of the recent IBM RS/6000 and
 	  pSeries machines), and several embedded PowerPC systems containing
 	  4xx, 6xx, 7xx, 8xx, 74xx, and 82xx processors.  Currently, the
-	  default option is to build a kernel which works on the first three.
+	  default option is to build a kernel which works on PReP and CHRP.
 
-	  Select CHRP/PowerMac/PReP if configuring for an IBM RS/6000 or
-	  pSeries machine, a Power Macintosh (including iMacs, iBooks and
-	  Powerbooks), or a PReP machine.
+	  Note that support for Apple machines is now only available with
+	  ARCH=powerpc, and has been removed from this menu.  If you wish
+	  to build a kernel for an Apple machine, exit this configuration
+	  process and re-run it with ARCH=powerpc.
+
+	  Select CHRP/PReP if configuring for an IBM RS/6000 or
+	  pSeries machine, or a PReP machine.
 
 	  Select Gemini if configuring for a Synergy Microsystems' Gemini
 	  series Single Board Computer.  More information is available at:
@@ -530,7 +512,7 @@ choice
 	  available at: <http://linux-apus.sourceforge.net/>.
 
 config PPC_MULTIPLATFORM
-	bool "CHRP/PowerMac/PReP"
+	bool "CHRP/PReP"
 
 config APUS
 	bool "Amiga-APUS"
@@ -768,25 +750,14 @@ config CPM2
 	  on it (826x, 827x, 8560).
 
 config PPC_CHRP
-	bool
+	bool "Support for CHRP (Common Hardware Reference Platform) machines"
 	depends on PPC_MULTIPLATFORM
 	select PPC_I8259
 	select PPC_INDIRECT_PCI
 	default y
 
-config PPC_PMAC
-	bool
-	depends on PPC_MULTIPLATFORM
-	select PPC_INDIRECT_PCI
-	default y
-
-config PPC_PMAC64
-	bool
-	depends on PPC_PMAC && POWER4
-	default y
-
 config PPC_PREP
-	bool
+	bool "Support for PReP (PowerPC Reference Platform) machines"
 	depends on PPC_MULTIPLATFORM
 	select PPC_I8259
 	select PPC_INDIRECT_PCI
@@ -794,7 +765,7 @@ config PPC_PREP
 
 config PPC_OF
 	bool
-	depends on PPC_PMAC || PPC_CHRP
+	depends on PPC_CHRP
 	default y
 
 config PPC_GEN550
@@ -1166,7 +1137,7 @@ config ISA
 
 config GENERIC_ISA_DMA
 	bool
-	depends on POWER3 || POWER4 || 6xx && !CPM2
+	depends on POWER3 || 6xx && !CPM2
 	default y
 
 config PPC_I8259
diff --git a/arch/ppc/boot/Makefile b/arch/ppc/boot/Makefile
index 995f89b..efd8ce5 100644
--- a/arch/ppc/boot/Makefile
+++ b/arch/ppc/boot/Makefile
@@ -18,7 +18,7 @@ BOOT_TARGETS	= zImage zImage.initrd znet
 bootdir-y			:= simple
 bootdir-$(CONFIG_PPC_OF)	+= openfirmware
 subdir-y			:= lib common images
-subdir-$(CONFIG_PPC_OF)		+= of1275
+subdir-$(CONFIG_PPC_MULTIPLATFORM)	+= of1275
 
 # for cleaning
 subdir-				+= simple openfirmware
diff --git a/arch/ppc/boot/openfirmware/Makefile b/arch/ppc/boot/openfirmware/Makefile
index 83a6433..34e805f 100644
--- a/arch/ppc/boot/openfirmware/Makefile
+++ b/arch/ppc/boot/openfirmware/Makefile
@@ -21,26 +21,16 @@ bootlib	:= $(boot)/lib
 of1275	:= $(boot)/of1275
 images	:= $(boot)/images
 
-OBJCOPY_ARGS	:= -O aixcoff-rs6000 -R .stab -R .stabstr -R .comment
-COFF_LD_ARGS	:= -T $(srctree)/$(boot)/ld.script -e _start -Ttext 0x00500000 \
-			-Bstatic
 CHRP_LD_ARGS	:= -T $(srctree)/$(boot)/ld.script -e _start -Ttext 0x00800000
-NEWWORLD_LD_ARGS:= -T $(srctree)/$(boot)/ld.script -e _start -Ttext 0x01000000
 
 COMMONOBJS	:= start.o misc.o common.o
-COFFOBJS	:= coffcrt0.o $(COMMONOBJS) coffmain.o
 CHRPOBJS	:= crt0.o     $(COMMONOBJS) chrpmain.o
-NEWWORLDOBJS	:= crt0.o     $(COMMONOBJS) newworldmain.o
 
-targets 	:= $(COFFOBJS) $(CHRPOBJS) $(NEWWORLDOBJS) dummy.o
-COFFOBJS	:= $(addprefix $(obj)/, $(COFFOBJS))
+targets 	:= $(CHRPOBJS) dummy.o
 CHRPOBJS	:= $(addprefix $(obj)/, $(CHRPOBJS))
-NEWWORLDOBJS	:= $(addprefix $(obj)/, $(NEWWORLDOBJS))
 
 LIBS		:= lib/lib.a $(bootlib)/lib.a $(of1275)/lib.a $(common)/lib.a
 
-HACKCOFF := $(utils)/hack-coff
-
 ifdef CONFIG_SMP
 END := .smp
 endif
@@ -72,56 +62,11 @@ targets += image.initrd.o
 $(obj)/image.initrd.o: $(obj)/image.o $(images)/ramdisk.image.gz FORCE
 	$(call if_changed,genimage-initrd)
 
-# Create the note section for New-World PowerMacs.
-quiet_cmd_mknote = MKNOTE  $@
-     cmd_mknote  = $(utils)/mknote > $@
-targets		+= note
-$(obj)/note: $(utils)/mknote FORCE
-	$(call if_changed,mknote)
-
 
-$(obj)/coffcrt0.o: EXTRA_AFLAGS := -DXCOFF
-targets += coffcrt0.o crt0.o
-$(obj)/coffcrt0.o $(obj)/crt0.o: $(common)/crt0.S FORCE
+targets += crt0.o
+$(obj)/crt0.o: $(common)/crt0.S FORCE
 	$(call if_changed_dep,as_o_S)
 
-quiet_cmd_gencoffb = COFF    $@
-      cmd_gencoffb = $(LD) -o $@ $(COFF_LD_ARGS) $(COFFOBJS) $< $(LIBS) && \
-                     $(OBJCOPY) $@ $@ -R .comment $(del-ramdisk-sec)
-targets += coffboot
-$(obj)/coffboot: $(obj)/image.o $(COFFOBJS) $(LIBS) $(srctree)/$(boot)/ld.script FORCE
-	$(call if_changed,gencoffb)
-targets += coffboot.initrd
-$(obj)/coffboot.initrd: $(obj)/image.initrd.o $(COFFOBJS) $(LIBS) \
-			$(srctree)/$(boot)/ld.script FORCE
-	$(call if_changed,gencoffb)
-
-
-quiet_cmd_gen-coff = COFF    $@
-      cmd_gen-coff = $(OBJCOPY) $(OBJCOPY_ARGS) $< $@ && \
-			$(HACKCOFF) $@ && \
-			ln -sf $(notdir $@) $(images)/zImage$(initrd).pmac
-
-$(images)/vmlinux.coff: $(obj)/coffboot
-	$(call cmd,gen-coff)
-
-$(images)/vmlinux.initrd.coff: $(obj)/coffboot.initrd
-	$(call cmd,gen-coff)
-
-quiet_cmd_gen-elf-pmac = ELF     $@
-      cmd_gen-elf-pmac = $(LD) $(NEWWORLD_LD_ARGS) -o $@ \
-				$(NEWWORLDOBJS) $(LIBS) $< && \
-			$(OBJCOPY) $@ $@ --add-section=.note=$(obj)/note \
-					 -R .comment $(del-ramdisk-sec)
-
-$(images)/vmlinux.elf-pmac: $(obj)/image.o $(NEWWORLDOBJS) $(LIBS) \
-			$(obj)/note $(srctree)/$(boot)/ld.script
-	$(call cmd,gen-elf-pmac)
-$(images)/vmlinux.initrd.elf-pmac: $(obj)/image.initrd.o $(NEWWORLDOBJS) \
-				   $(LIBS) $(obj)/note \
-				   $(srctree)/$(boot)/ld.script
-	$(call cmd,gen-elf-pmac)
-
 quiet_cmd_gen-chrp = CHRP    $@
       cmd_gen-chrp = $(LD) $(CHRP_LD_ARGS) -o $@ $(CHRPOBJS) $< $(LIBS) && \
 			$(OBJCOPY) $@ $@ -R .comment $(del-ramdisk-sec)
@@ -151,15 +96,11 @@ $(images)/miboot.initrd.image: $(images)
 # The targets used on the make command-line
 
 .PHONY: zImage zImage.initrd
-zImage:		 $(images)/vmlinux.coff 	\
-		 $(images)/vmlinux.elf-pmac	\
-		 $(images)/zImage.chrp		\
+zImage:		 $(images)/zImage.chrp		\
 		 $(images)/zImage.chrp-rs6k	\
 		 $(images)/miboot.image
 	@echo '  kernel: $@ is ready ($<)'
-zImage.initrd:	 $(images)/vmlinux.initrd.coff 		\
-		 $(images)/vmlinux.initrd.elf-pmac	\
-		 $(images)/zImage.initrd.chrp		\
+zImage.initrd:	 $(images)/zImage.initrd.chrp		\
 		 $(images)/zImage.initrd.chrp-rs6k	\
 		 $(images)/miboot.initrd.image
 	@echo '  kernel: $@ is ready ($<)'
@@ -167,18 +108,10 @@ zImage.initrd:	 $(images)/vmlinux.initrd
 TFTPIMAGE	:= /tftpboot/zImage
 
 .PHONY: znetboot znetboot.initrd
-znetboot:	$(images)/vmlinux.coff		\
-		$(images)/vmlinux.elf-pmac	\
-		$(images)/zImage.chrp
-	cp $(images)/vmlinux.coff     $(TFTPIMAGE).pmac$(END)
-	cp $(images)/vmlinux.elf-pmac $(TFTPIMAGE).pmac$(END).elf
+znetboot:	$(images)/zImage.chrp
 	cp $(images)/zImage.chrp      $(TFTPIMAGE).chrp$(END)
 	@echo '  kernel: $@ is ready ($<)'
-znetboot.initrd:$(images)/vmlinux.initrd.coff		\
-		$(images)/vmlinux.initrd.elf-pmac	\
-		$(images)/zImage.initrd.chrp
-	cp $(images)/vmlinux.initrd.coff     $(TFTPIMAGE).pmac$(END)
-	cp $(images)/vmlinux.initrd.elf-pmac $(TFTPIMAGE).pmac$(END).elf
+znetboot.initrd:$(images)/zImage.initrd.chrp
 	cp $(images)/zImage.initrd.chrp      $(TFTPIMAGE).chrp$(END)
 	@echo '  kernel: $@ is ready ($<)'
 
diff --git a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
index ca02013..647da4c 100644
--- a/arch/ppc/kernel/Makefile
+++ b/arch/ppc/kernel/Makefile
@@ -9,7 +9,6 @@ extra-$(CONFIG_44x)		:= head_44x.o
 extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-$(CONFIG_6xx)		+= idle_6xx.o
-extra-$(CONFIG_POWER4)		+= idle_power4.o
 extra-y				+= vmlinux.lds
 
 obj-y				:= entry.o traps.o idle.o time.o misc.o \
@@ -17,7 +16,6 @@ obj-y				:= entry.o traps.o idle.o time.
 					ppc_htab.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
-obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-mapping.o
 obj-$(CONFIG_PCI)		+= pci.o
diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
index e707c6f..c08ab43 100644
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -1,5 +1,5 @@
 /*
- * Common prep/pmac/chrp boot and setup code.
+ * Common prep/chrp boot and setup code.
  */
 
 #include <linux/config.h>
@@ -35,7 +35,6 @@
 #include <asm/machdep.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
-#include <asm/pmac_feature.h>
 #include <asm/sections.h>
 #include <asm/nvram.h>
 #include <asm/xmon.h>
@@ -55,7 +54,6 @@
 
 extern void platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7);
-extern void bootx_init(unsigned long r4, unsigned long phys);
 extern void identify_cpu(unsigned long offset, unsigned long cpu);
 extern void do_cpu_ftr_fixups(unsigned long offset);
 extern void reloc_got2(unsigned long offset);
@@ -80,8 +78,6 @@ EXPORT_SYMBOL(_machine);
 
 extern void prep_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7);
-extern void pmac_init(unsigned long r3, unsigned long r4,
-		unsigned long r5, unsigned long r6, unsigned long r7);
 extern void chrp_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7);
 
@@ -324,20 +320,15 @@ early_init(int r3, int r4, int r5)
 	identify_cpu(offset, 0);
 	do_cpu_ftr_fixups(offset);
 
-#if defined(CONFIG_PPC_MULTIPLATFORM)
+#if defined(CONFIG_PPC_OF)
 	reloc_got2(offset);
 
-	/* If we came here from BootX, clear the screen,
-	 * set up some pointers and return. */
-	if ((r3 == 0x426f6f58) && (r5 == 0))
-		bootx_init(r4, phys);
-
 	/*
 	 * don't do anything on prep
 	 * for now, don't use bootinfo because it breaks yaboot 0.5
 	 * and assume that if we didn't find a magic number, we have OF
 	 */
-	else if (*(unsigned long *)(0) != 0xdeadc0de)
+	if (*(unsigned long *)(0) != 0xdeadc0de)
 		phys = prom_init(r3, r4, (prom_entry)r5);
 
 	reloc_got2(-offset);
@@ -424,6 +415,7 @@ platform_init(unsigned long r3, unsigned
 	}
 #endif
 
+#ifdef CONFIG_PPC_OF
 	have_of = 1;
 
 	/* prom_init has already been called from __start */
@@ -495,19 +487,17 @@ platform_init(unsigned long r3, unsigned
 #endif /* CONFIG_ADB */
 
 	switch (_machine) {
-#ifdef CONFIG_PPC_PMAC
-	case _MACH_Pmac:
-		pmac_init(r3, r4, r5, r6, r7);
-		break;
-#endif
 #ifdef CONFIG_PPC_CHRP
 	case _MACH_chrp:
 		chrp_init(r3, r4, r5, r6, r7);
 		break;
 #endif
 	}
+#endif /* CONFIG_PPC_OF */
 }
+#endif /* CONFIG_PPC_MULTIPLATFORM */
 
+#ifdef CONFIG_PPC_OF
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
 extern char *of_stdout_device;
 
@@ -564,7 +554,7 @@ static int __init set_preferred_console(
 }
 console_initcall(set_preferred_console);
 #endif /* CONFIG_SERIAL_CORE_CONSOLE */
-#endif /* CONFIG_PPC_MULTIPLATFORM */
+#endif /* CONFIG_PPC_OF */
 
 struct bi_record *find_bootinfo(void)
 {
@@ -747,14 +737,6 @@ void __init setup_arch(char **cmdline_p)
 	if (ppc_md.init_early)
 		ppc_md.init_early();
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
-	/* This could be called "early setup arch", it must be done
-	 * now because xmon need it
-	 */
-	if (_machine == _MACH_Pmac)
-		pmac_feature_init();	/* New cool way */
-#endif
-
 #ifdef CONFIG_XMON
 	xmon_init(1);
 	if (strstr(cmd_line, "xmon"))
diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
index 7c5cdab..51430e2 100644
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -3,26 +3,18 @@
 #
 
 # Extra CFLAGS so we don't have to do relative includes
-CFLAGS_pmac_setup.o	+= -Iarch/$(ARCH)/mm
+CFLAGS_chrp_setup.o	+= -Iarch/$(ARCH)/mm
 
 obj-$(CONFIG_APUS)		+= apus_setup.o
 ifeq ($(CONFIG_APUS),y)
 obj-$(CONFIG_PCI)		+= apus_pci.o
 endif
-obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
-					pmac_feature.o pmac_pci.o pmac_sleep.o \
-					pmac_low_i2c.o pmac_cache.o
 obj-$(CONFIG_PPC_CHRP)		+= chrp_setup.o chrp_time.o chrp_pci.o \
 					chrp_pegasos_eth.o
 ifeq ($(CONFIG_PPC_CHRP),y)
 obj-$(CONFIG_NVRAM)		+= chrp_nvram.o
 endif
 obj-$(CONFIG_PPC_PREP)		+= prep_pci.o prep_setup.o
-ifeq ($(CONFIG_PPC_PMAC),y)
-obj-$(CONFIG_NVRAM)		+= pmac_nvram.o
-obj-$(CONFIG_CPU_FREQ_PMAC)	+= pmac_cpufreq.o
-endif
-obj-$(CONFIG_PMAC_BACKLIGHT)	+= pmac_backlight.o
 obj-$(CONFIG_PREP_RESIDUAL)	+= residual.o
 obj-$(CONFIG_PQ2ADS)		+= pq2ads.o
 obj-$(CONFIG_TQM8260)		+= tqm8260_setup.o
@@ -47,6 +39,5 @@ obj-$(CONFIG_LITE5200)		+= lite5200.o
 obj-$(CONFIG_EV64360)		+= ev64360.o
 
 ifeq ($(CONFIG_SMP),y)
-obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o
 obj-$(CONFIG_PPC_CHRP)		+= chrp_smp.o
 endif
diff --git a/arch/ppc/platforms/chrp_pci.c b/arch/ppc/platforms/chrp_pci.c
index bd047aa..c7fe618 100644
--- a/arch/ppc/platforms/chrp_pci.c
+++ b/arch/ppc/platforms/chrp_pci.c
@@ -275,7 +275,7 @@ chrp_find_bridges(void)
 			setup_python(hose, dev);
 		} else if (is_mot
 			   || strncmp(model, "Motorola, Grackle", 17) == 0) {
-			setup_grackle(hose);
+			setup_indirect_pci(hose, 0xfec00000, 0xfee00000);
 		} else if (is_longtrail) {
 			void __iomem *p = ioremap(GG2_PCI_CONFIG_BASE, 0x80000);
 			hose->ops = &gg2_pci_ops;
diff --git a/arch/ppc/platforms/chrp_setup.c b/arch/ppc/platforms/chrp_setup.c
index 056ac2a..48996b7 100644
--- a/arch/ppc/platforms/chrp_setup.c
+++ b/arch/ppc/platforms/chrp_setup.c
@@ -53,6 +53,7 @@
 #include <asm/i8259.h>
 #include <asm/open_pic.h>
 #include <asm/xmon.h>
+#include "mem_pieces.h"
 
 unsigned long chrp_get_rtc_time(void);
 int chrp_set_rtc_time(unsigned long nowtime);
@@ -65,7 +66,6 @@ void rtas_display_progress(char *, unsig
 void rtas_indicator_progress(char *, unsigned short);
 void btext_progress(char *, unsigned short);
 
-extern unsigned long pmac_find_end_of_memory(void);
 extern int of_show_percpuinfo(struct seq_file *, int);
 
 int _chrp_type;
@@ -467,6 +467,75 @@ chrp_init2(void)
 		ppc_md.progress("  Have fun!    ", 0x7777);
 }
 
+static struct device_node *memory_node;
+
+static int __init get_mem_prop(char *name, struct mem_pieces *mp)
+{
+	struct reg_property *rp;
+	int i, s;
+	unsigned int *ip;
+	int nac = prom_n_addr_cells(memory_node);
+	int nsc = prom_n_size_cells(memory_node);
+
+	ip = (unsigned int *) get_property(memory_node, name, &s);
+	if (ip == NULL) {
+		printk(KERN_ERR "error: couldn't get %s property on /memory\n",
+		       name);
+		return 0;
+	}
+	s /= (nsc + nac) * 4;
+	rp = mp->regions;
+	for (i = 0; i < s; ++i, ip += nac+nsc) {
+		if (nac >= 2 && ip[nac-2] != 0)
+			continue;
+		rp->address = ip[nac-1];
+		if (nsc >= 2 && ip[nac+nsc-2] != 0)
+			rp->size = ~0U;
+		else
+			rp->size = ip[nac+nsc-1];
+		++rp;
+	}
+	mp->n_regions = rp - mp->regions;
+
+	/* Make sure the pieces are sorted. */
+	mem_pieces_sort(mp);
+	mem_pieces_coalesce(mp);
+	return 1;
+}
+
+static unsigned long __init chrp_find_end_of_memory(void)
+{
+	unsigned long a, total;
+	struct mem_pieces phys_mem;
+
+	/*
+	 * Find out where physical memory is, and check that it
+	 * starts at 0 and is contiguous.  It seems that RAM is
+	 * always physically contiguous on Power Macintoshes.
+	 *
+	 * Supporting discontiguous physical memory isn't hard,
+	 * it just makes the virtual <-> physical mapping functions
+	 * more complicated (or else you end up wasting space
+	 * in mem_map).
+	 */
+	memory_node = find_devices("memory");
+	if (memory_node == NULL || !get_mem_prop("reg", &phys_mem)
+	    || phys_mem.n_regions == 0)
+		panic("No RAM??");
+	a = phys_mem.regions[0].address;
+	if (a != 0)
+		panic("RAM doesn't start at physical address 0");
+	total = phys_mem.regions[0].size;
+
+	if (phys_mem.n_regions > 1) {
+		printk("RAM starting at 0x%x is not contiguous\n",
+		       phys_mem.regions[1].address);
+		printk("Using RAM from 0 to 0x%lx\n", total-1);
+	}
+
+	return total;
+}
+
 void __init
 chrp_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	  unsigned long r6, unsigned long r7)
@@ -525,7 +594,7 @@ chrp_init(unsigned long r3, unsigned lon
 	ppc_md.get_rtc_time   = chrp_get_rtc_time;
 	ppc_md.calibrate_decr = chrp_calibrate_decr;
 
-	ppc_md.find_end_of_memory = pmac_find_end_of_memory;
+	ppc_md.find_end_of_memory = chrp_find_end_of_memory;
 
 	if (rtas_data) {
 		struct device_node *rtas;
diff --git a/arch/ppc/platforms/chrp_time.c b/arch/ppc/platforms/chrp_time.c
index 29d074c..57753a5 100644
--- a/arch/ppc/platforms/chrp_time.c
+++ b/arch/ppc/platforms/chrp_time.c
@@ -163,13 +163,75 @@ unsigned long chrp_get_rtc_time(void)
 	return mktime(year, mon, day, hour, min, sec);
 }
 
+/*
+ * Calibrate the decrementer frequency with the VIA timer 1.
+ */
+#define VIA_TIMER_FREQ_6	4700000	/* time 1 frequency * 6 */
+
+/* VIA registers */
+#define RS		0x200		/* skip between registers */
+#define T1CL		(4*RS)		/* Timer 1 ctr/latch (low 8 bits) */
+#define T1CH		(5*RS)		/* Timer 1 counter (high 8 bits) */
+#define T1LL		(6*RS)		/* Timer 1 latch (low 8 bits) */
+#define T1LH		(7*RS)		/* Timer 1 latch (high 8 bits) */
+#define ACR		(11*RS)		/* Auxiliary control register */
+#define IFR		(13*RS)		/* Interrupt flag register */
+
+/* Bits in ACR */
+#define T1MODE		0xc0		/* Timer 1 mode */
+#define T1MODE_CONT	0x40		/*  continuous interrupts */
+
+/* Bits in IFR and IER */
+#define T1_INT		0x40		/* Timer 1 interrupt */
+
+static int __init chrp_via_calibrate_decr(void)
+{
+	struct device_node *vias;
+	volatile unsigned char __iomem *via;
+	int count = VIA_TIMER_FREQ_6 / 100;
+	unsigned int dstart, dend;
+
+	vias = find_devices("via-cuda");
+	if (vias == 0)
+		vias = find_devices("via");
+	if (vias == 0 || vias->n_addrs == 0)
+		return 0;
+	via = ioremap(vias->addrs[0].address, vias->addrs[0].size);
+
+	/* set timer 1 for continuous interrupts */
+	out_8(&via[ACR], (via[ACR] & ~T1MODE) | T1MODE_CONT);
+	/* set the counter to a small value */
+	out_8(&via[T1CH], 2);
+	/* set the latch to `count' */
+	out_8(&via[T1LL], count);
+	out_8(&via[T1LH], count >> 8);
+	/* wait until it hits 0 */
+	while ((in_8(&via[IFR]) & T1_INT) == 0)
+		;
+	dstart = get_dec();
+	/* clear the interrupt & wait until it hits 0 again */
+	in_8(&via[T1CL]);
+	while ((in_8(&via[IFR]) & T1_INT) == 0)
+		;
+	dend = get_dec();
+
+	tb_ticks_per_jiffy = (dstart - dend) / ((6 * HZ)/100);
+	tb_to_us = mulhwu_scale_factor(dstart - dend, 60000);
+
+	printk(KERN_INFO "via_calibrate_decr: ticks per jiffy = %u (%u ticks)\n",
+	       tb_ticks_per_jiffy, dstart - dend);
+
+	iounmap(via);
+	
+	return 1;
+}
 
 void __init chrp_calibrate_decr(void)
 {
 	struct device_node *cpu;
 	unsigned int freq, *fp;
 
-	if (via_calibrate_decr())
+	if (chrp_via_calibrate_decr())
 		return;
 
 	/*
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index 84ef030..159dcd9 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -39,8 +39,6 @@ obj-$(CONFIG_8xx)		+= m8xx_setup.o ppc8x
 				   ppc_sys.o mpc8xx_devices.o mpc8xx_sys.o
 obj-$(CONFIG_PCI_QSPAN)		+= qspan_pci.o
 obj-$(CONFIG_PPC_OF)		+= prom_init.o prom.o
-obj-$(CONFIG_PPC_PMAC)		+= open_pic.o
-obj-$(CONFIG_POWER4)		+= open_pic2.o
 obj-$(CONFIG_PPC_CHRP)		+= open_pic.o
 obj-$(CONFIG_PPC_PREP)		+= open_pic.o todc_time.o
 obj-$(CONFIG_BAMBOO)		+= pci_auto.o todc_time.o
diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
index 097d668..556895e 100644
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -2734,7 +2734,7 @@ void radeonfb_pm_init(struct radeonfb_in
 	 * BIOS does tho. Right now, all this PM stuff is pmac-only for that
 	 * reason. --BenH
 	 */
-#if defined(CONFIG_PM) && defined(CONFIG_PPC_OF)
+#if defined(CONFIG_PM) && defined(CONFIG_PPC_PMAC)
 	if (_machine == _MACH_Pmac && rinfo->of_node) {
 		if (rinfo->is_mobility && rinfo->pm_reg &&
 		    rinfo->family <= CHIP_FAMILY_RV250)
@@ -2778,12 +2778,12 @@ void radeonfb_pm_init(struct radeonfb_in
 		OUTREG(TV_DAC_CNTL, INREG(TV_DAC_CNTL) | 0x07000000);
 #endif
 	}
-#endif /* defined(CONFIG_PM) && defined(CONFIG_PPC_OF) */
+#endif /* defined(CONFIG_PM) && defined(CONFIG_PPC_PMAC) */
 }
 
 void radeonfb_pm_exit(struct radeonfb_info *rinfo)
 {
-#if defined(CONFIG_PM) && defined(CONFIG_PPC_OF)
+#if defined(CONFIG_PM) && defined(CONFIG_PPC_PMAC)
 	if (rinfo->pm_mode != radeon_pm_none)
 		pmac_set_early_video_resume(NULL, NULL);
 #endif
diff --git a/include/asm-ppc/prom.h b/include/asm-ppc/prom.h
index eb317a0..6d431d6 100644
--- a/include/asm-ppc/prom.h
+++ b/include/asm-ppc/prom.h
@@ -167,6 +167,14 @@ extern int of_address_to_resource(struct
 extern int of_pci_address_to_resource(struct device_node *dev, int bar,
 				      struct resource *r);
 
+#ifndef CONFIG_PPC_OF
+/*
+ * Fallback definitions for builds where we don't have prom.c included.
+ */
+#define machine_is_compatible(x)		0
+#define of_find_compatible_node(f, t, c)	NULL
+#define get_property(p, n, l)			NULL
+#endif
 
 #endif /* _PPC_PROM_H */
 #endif /* __KERNEL__ */
