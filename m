Date: Wed, 28 Jul 2004 08:24:27 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Giuliano Pochini <pochini@shiny.it>,
	LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Can't compile 2.6.7 with gcc 3.4.1
Message-ID: <20040728062427.GA12238@suse.de>
References: <20040726223832.3edafe0a.pochini@shiny.it> <20040727174707.GB10891@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20040727174707.GB10891@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Tue, Jul 27, Tom Rini wrote:

> On Mon, Jul 26, 2004 at 10:38:32PM +0200, Giuliano Pochini wrote:
>
> >
> > Is this a known problem ?  I can't compile the kernel 2.6.7 with gcc 3.4.1:
>
> You're trying to use gcc-3.4 and binutils-2.14, which is a bad
> combination.
>
> Olaf, did you ever get a chance to try the last patch I had with your
> matrix of toolchain versions?

 yes, it worked fine


diff -pruNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.8-rc1.orig/arch/ppc/Makefile linux-2.6.8-rc1/arch/ppc/Makefile
--- linux-2.6.8-rc1.orig/arch/ppc/Makefile	2004-07-12 06:02:54.000000000 +0000
+++ linux-2.6.8-rc1/arch/ppc/Makefile	2004-07-15 14:23:18.000000000 +0000
@@ -22,7 +22,7 @@ endif

 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 CPPFLAGS	+= -Iarch/$(ARCH)
-AFLAGS		+= -Iarch/$(ARCH)
+aflags-y	+= -Iarch/$(ARCH)
 cflags-y	+= -Iarch/$(ARCH) -msoft-float -pipe \
 		-ffixed-r2 -Wno-uninitialized -mmultiple
 CPP		= $(CC) -E $(CFLAGS)
@@ -31,10 +31,16 @@ ifndef CONFIG_E500
 cflags-y	+= -mstring
 endif

+aflags-$(CONFIG_4xx)		+= -m405
 cflags-$(CONFIG_4xx)		+= -Wa,-m405
+aflags-$(CONFIG_6xx)		+= -maltivec
+cflags-$(CONFIG_6xx)		+= -Wa,-maltivec
+aflags-$(CONFIG_E500)		+= -me500
 cflags-$(CONFIG_E500)		+= -Wa,-me500
+aflags-$(CONFIG_PPC64BRIDGE)	+= -mppc64bridge
 cflags-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge

+AFLAGS += $(aflags-y)
 CFLAGS += $(cflags-y)

 head-y				:= arch/ppc/kernel/head.o
@@ -106,17 +112,24 @@ GOODVER	:= 2.12.1
 else
 NEW_AS	:= 0
 endif
+# gcc-3.4 and binutils-2.14 are a fatal combination.
+GCC_VERSION	:= $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
+BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o /dev/null >/dev/null 2>&1 ; echo $$?)

-ifneq ($(NEW_AS),0)
 checkbin:
+ifeq ($(GCC_VERSION)$(BAD_GCC_AS),03041)
+	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '
+	@echo 'correctly with gcc-3.4 and your version of binutils.'
+	@echo '*** Please upgrade your binutils or downgrade your gcc'
+	@false
+endif
+ifneq ($(NEW_AS),0)
 	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '
 	@echo 'correctly with old versions of binutils.'
 	@echo '*** Please upgrade your binutils to ${GOODVER} or newer'
 	@false
-else
-checkbin:
-	@true
 endif
+	@true

 CLEAN_FILES +=	include/asm-$(ARCH)/offsets.h \
 		arch/$(ARCH)/kernel/asm-offsets.s
diff -pruNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.8-rc1.orig/arch/ppc/kernel/Makefile linux-2.6.8-rc1/arch/ppc/kernel/Makefile
--- linux-2.6.8-rc1.orig/arch/ppc/kernel/Makefile	2004-07-12 06:02:54.000000000 +0000
+++ linux-2.6.8-rc1/arch/ppc/kernel/Makefile	2004-07-15 11:23:14.000000000 +0000
@@ -2,16 +2,6 @@
 # Makefile for the linux kernel.
 #

-ifdef CONFIG_PPC64BRIDGE
-EXTRA_AFLAGS		:= -Wa,-mppc64bridge
-endif
-ifdef CONFIG_4xx
-EXTRA_AFLAGS		:= -Wa,-m405
-endif
-ifdef CONFIG_E500
-EXTRA_AFLAGS		:= -Wa,-me500
-endif
-
 extra-$(CONFIG_PPC_STD_MMU)	:= head.o
 extra-$(CONFIG_40x)		:= head_4xx.o
 extra-$(CONFIG_44x)		:= head_44x.o
@@ -35,7 +25,5 @@ obj-$(CONFIG_SMP)		+= smp.o smp-tbsync.o
 obj-$(CONFIG_TAU)		+= temp.o
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o

-ifdef CONFIG_MATH_EMULATION
-obj-$(CONFIG_8xx)		+= softemu8xx.o
-endif
-
+sw-math-emu-$(CONFIG_8xx)	+= softemu8xx.o
+obj-$(CONFIG_MATH_EMULATION)	+= $(sw-math-emu-y)
diff -pruNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.8-rc1.orig/arch/ppc/mm/Makefile linux-2.6.8-rc1/arch/ppc/mm/Makefile
--- linux-2.6.8-rc1.orig/arch/ppc/mm/Makefile	2004-07-12 06:02:54.000000000 +0000
+++ linux-2.6.8-rc1/arch/ppc/mm/Makefile	2004-07-15 11:23:14.000000000 +0000
@@ -2,10 +2,6 @@
 # Makefile for the linux ppc-specific parts of the memory manager.
 #

-ifdef CONFIG_PPC64BRIDGE
-EXTRA_AFLAGS		:= -Wa,-mppc64bridge
-endif
-
 obj-y				:= fault.o init.o mem_pieces.o \
 					mmu_context.o pgtable.o

diff -pruNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.8-rc1.orig/arch/ppc/platforms/Makefile linux-2.6.8-rc1/arch/ppc/platforms/Makefile
--- linux-2.6.8-rc1.orig/arch/ppc/platforms/Makefile	2004-07-12 06:02:54.000000000 +0000
+++ linux-2.6.8-rc1/arch/ppc/platforms/Makefile	2004-07-15 11:23:14.000000000 +0000
@@ -2,29 +2,23 @@
 # Makefile for the linux kernel.
 #

-ifdef CONFIG_PPC64BRIDGE
-EXTRA_AFLAGS		:= -Wa,-mppc64bridge
-endif
-ifdef CONFIG_40x
-EXTRA_AFLAGS		:= -Wa,-m405
-endif
-
 # Extra CFLAGS so we don't have to do relative includes
 CFLAGS_pmac_setup.o	+= -Iarch/$(ARCH)/mm

-obj-$(CONFIG_APUS)		+= apus_setup.o
-ifeq ($(CONFIG_APUS),y)
-obj-$(CONFIG_PCI)		+= apus_pci.o
-endif
+# Multiple dependancies
+apus-$(CONFIG_PCI)		+= apus_pci.o
+chrp-$(CONFIG_SMP)		+= chrp_smp.o
+pmac-$(CONFIG_NVRAM)		+= pmac_nvram.o
+pmac-$(CONFIG_CPU_FREQ_PMAC)	+= pmac_cpufreq.o
+pmac-$(CONFIG_SMP)		+= pmac_smp.o
+
+obj-$(CONFIG_APUS)		+= apus_setup.o $(apus-y)
 obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
 					pmac_feature.o pmac_pci.o pmac_sleep.o \
-					pmac_low_i2c.o
-obj-$(CONFIG_PPC_CHRP)		+= chrp_setup.o chrp_time.o chrp_pci.o
+					pmac_low_i2c.o $(pmac-y)
+obj-$(CONFIG_PPC_CHRP)		+= chrp_setup.o chrp_time.o chrp_pci.o \
+					$(chrp-y)
 obj-$(CONFIG_PPC_PREP)		+= prep_pci.o prep_setup.o
-ifeq ($(CONFIG_PPC_PMAC),y)
-obj-$(CONFIG_NVRAM)		+= pmac_nvram.o
-obj-$(CONFIG_CPU_FREQ_PMAC)	+= pmac_cpufreq.o
-endif
 obj-$(CONFIG_PMAC_BACKLIGHT)	+= pmac_backlight.o
 obj-$(CONFIG_PPC_RTAS)		+= error_log.o proc_rtas.o
 obj-$(CONFIG_PREP_RESIDUAL)	+= residual.o
@@ -48,8 +42,3 @@ obj-$(CONFIG_PRPMC800)		+= prpmc800.o
 obj-$(CONFIG_SANDPOINT)		+= sandpoint.o
 obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
-
-ifeq ($(CONFIG_SMP),y)
-obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o
-obj-$(CONFIG_PPC_CHRP)		+= chrp_smp.o
-endif
diff -pruNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.8-rc1.orig/arch/ppc/platforms/tqm8260_setup.c linux-2.6.8-rc1/arch/ppc/platforms/tqm8260_setup.c
--- linux-2.6.8-rc1.orig/arch/ppc/platforms/tqm8260_setup.c	2004-07-12 06:02:54.000000000 +0000
+++ linux-2.6.8-rc1/arch/ppc/platforms/tqm8260_setup.c	2004-07-15 11:23:14.000000000 +0000
@@ -77,3 +77,4 @@ platform_init(unsigned long r3, unsigned

 	callback_setup_arch	= ppc_md.setup_arch;
 	ppc_md.setup_arch	= tqm8260_setup_arch;
+}
diff -pruNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.8-rc1.orig/arch/ppc/syslib/Makefile linux-2.6.8-rc1/arch/ppc/syslib/Makefile
--- linux-2.6.8-rc1.orig/arch/ppc/syslib/Makefile	2004-07-12 06:02:54.000000000 +0000
+++ linux-2.6.8-rc1/arch/ppc/syslib/Makefile	2004-07-15 11:23:14.000000000 +0000
@@ -2,39 +2,27 @@
 # Makefile for the linux kernel.
 #

-ifdef CONFIG_PPC64BRIDGE
-EXTRA_AFLAGS		:= -Wa,-mppc64bridge
-endif
-ifdef CONFIG_4xx
-EXTRA_AFLAGS		:= -Wa,-m405
-endif
-ifdef CONFIG_E500
-EXTRA_AFLAGS		:= -Wa,-me500
-endif
-
 CFLAGS_prom_init.o      += -fPIC
 CFLAGS_btext.o          += -fPIC

+# Multiple dependancies
+ibm-4xx-$(CONFIG_GEN_RTC)	+= todc_time.o
+ibm-4xx-$(CONFIG_KGDB)		+= ppc4xx_kgdb.o
+ibm-40x-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o ppc405_pci.o
+mpc-8xx-$(CONFIG_PCI)		+= qspan_pci.o i8259.o
+gen550-$(CONFIG_KGDB)		+= gen550_kgdb.o gen550_dbg.o
+gen550-$(CONFIG_SERIAL_TEXT_DEBUG)	+= gen550_dbg.o
+mpc-85xx-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
+
 obj-$(CONFIG_PPCBUG_NVRAM)	+= prep_nvram.o
 obj-$(CONFIG_PPC_OCP)		+= ocp.o
 obj-$(CONFIG_IBM_OCP)		+= ibm_ocp.o
 obj-$(CONFIG_44x)		+= ibm44x_common.o
 obj-$(CONFIG_440GP)		+= ibm440gp_common.o
 obj-$(CONFIG_440GX)		+= ibm440gx_common.o
-ifeq ($(CONFIG_4xx),y)
-obj-$(CONFIG_4xx)		+= ppc4xx_pic.o
-obj-$(CONFIG_40x)		+= ppc4xx_setup.o
-obj-$(CONFIG_GEN_RTC)		+= todc_time.o
-obj-$(CONFIG_KGDB)		+= ppc4xx_kgdb.o
-ifeq ($(CONFIG_40x),y)
-obj-$(CONFIG_KGDB)		+= ppc4xx_kgdb.o
-obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o ppc405_pci.o
-endif
-endif
-obj-$(CONFIG_8xx)		+= m8xx_setup.o ppc8xx_pic.o
-ifeq ($(CONFIG_8xx),y)
-obj-$(CONFIG_PCI)		+= qspan_pci.o i8259.o
-endif
+obj-$(CONFIG_4xx)		+= ppc4xx_pic.o $(ibm-4xx-y)
+obj-$(CONFIG_40x)		+= ppc4xx_setup.o $(ibm-40x-y)
+obj-$(CONFIG_8xx)		+= m8xx_setup.o ppc8xx_pic.o $(mpc-8xx-y)
 obj-$(CONFIG_PPC_OF)		+= prom_init.o prom.o of_device.o
 obj-$(CONFIG_PPC_PMAC)		+= open_pic.o indirect_pci.o
 obj-$(CONFIG_POWER4)		+= open_pic2.o
@@ -73,16 +61,11 @@ obj-$(CONFIG_8260)		+= m8260_setup.o cpm
 obj-$(CONFIG_PCI_8260)		+= m8260_pci.o indirect_pci.o
 obj-$(CONFIG_8260_PCI9)		+= m8260_pci_erratum9.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o
-ifeq ($(CONFIG_PPC_GEN550),y)
-obj-$(CONFIG_KGDB)		+= gen550_kgdb.o gen550_dbg.o
-obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= gen550_dbg.o
-endif
+obj-$(CONFIG_PPC_GEN550)	+= $(gen550-y)
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_MPC10X_BRIDGE)     += mpc10x_common.o indirect_pci.o
 obj-$(CONFIG_MPC10X_OPENPIC)	+= open_pic.o
 obj-$(CONFIG_40x)		+= dcr.o
 obj-$(CONFIG_BOOKE)		+= dcr.o
-obj-$(CONFIG_85xx)		+= open_pic.o ppc85xx_common.o ppc85xx_setup.o
-ifeq ($(CONFIG_85xx),y)
-obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
-endif
+obj-$(CONFIG_85xx)		+= open_pic.o ppc85xx_common.o ppc85xx_setup.o \
+					$(mpc-85xx-y)
--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
