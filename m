Date: Wed, 14 Jul 2004 16:23:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040714232336.GO21856@smtp.west.cox.net>
References: <20040712090618.GB32413@suse.de> <20040712151119.GL28002@smtp.west.cox.net> <20040712180321.GB16877@smtp.west.cox.net> <20040713134945.GA5104@suse.de> <20040713140127.GJ16877@smtp.west.cox.net> <20040713140220.GA20213@suse.de> <20040713142015.GK16877@smtp.west.cox.net> <20040713151854.GA7858@suse.de> <20040713152633.GL16877@smtp.west.cox.net> <20040713152950.GB7858@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040713152950.GB7858@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 13, 2004 at 05:29:50PM +0200, Olaf Hering wrote:

>  On Tue, Jul 13, Tom Rini wrote:
>
> > On Tue, Jul 13, 2004 at 05:18:54PM +0200, Olaf Hering wrote:
> > >  On Tue, Jul 13, Tom Rini wrote:
> > >
> > > > OK.  Perhaps gcc should be refusing to build with older binutils
> > > > perhaps?  It sounds like gcc-3.4 + binutils-2.14 or older won't work
> > > > unless we ensure that any -mppc/altivec/etc type flags that gcc itself
> > > > would pass, excluding -many, are re-passed by the kernel itself.
> > >
> > > Its just the 2.14 + gcc 3.4 combo that does not work.
> > > binutils 2.12, 2.13  and 2.15 works ok with gcc 3.4.
> >
> > Does gcc not pass down -many with 2.12/2.13, or does -many actually work
> > there?

OK.  The following hasn't been tested on all binutils/gcc combinations
yet, but should, in the case of binutils-2.14 and gcc-3.4 tell the user
there will be a problem and stop.  Olaf, can you run this past your
matrix of toolchains?  Thanks.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.55/arch/ppc/Makefile	2004-07-05 03:27:10 -07:00
+++ edited/arch/ppc/Makefile	2004-07-14 16:22:58 -07:00
@@ -22,7 +22,7 @@

 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 CPPFLAGS	+= -Iarch/$(ARCH)
-AFLAGS		+= -Iarch/$(ARCH)
+aflags-y	+= -Iarch/$(ARCH)
 cflags-y	+= -Iarch/$(ARCH) -msoft-float -pipe \
 		-ffixed-r2 -Wno-uninitialized -mmultiple
 CPP		= $(CC) -E $(CFLAGS)
@@ -31,10 +31,16 @@
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
@@ -106,17 +112,23 @@
 else
 NEW_AS	:= 0
 endif
+# gcc-3.4 and binutils-2.14 are a fatal combination.
+GCC_VERSION	:= $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
+BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o /dev/null 2>/dev/null 2>&1 && echo 0 || echo 1)

-ifneq ($(NEW_AS),0)
 checkbin:
+ifeq ($(GCC_VERSION)$(BAD_GCC_AS),03041)
+	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no lonber build '
+	@echo 'correctly with gcc-3.4 and your version of binutils.'
+	@echo '*** Please upgrade your binutils or downgrade your gcc'
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
--- 1.47/arch/ppc/kernel/Makefile	2004-06-17 23:41:08 -07:00
+++ edited/arch/ppc/kernel/Makefile	2004-07-12 08:22:12 -07:00
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
@@ -35,7 +25,5 @@
 obj-$(CONFIG_TAU)		+= temp.o
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o

-ifdef CONFIG_MATH_EMULATION
-obj-$(CONFIG_8xx)		+= softemu8xx.o
-endif
-
+sw-math-emu-$(CONFIG_8xx)	+= softemu8xx.o
+obj-$(CONFIG_MATH_EMULATION)	+= $(sw-math-emu-y)
--- 1.17/arch/ppc/mm/Makefile	2004-06-17 23:41:08 -07:00
+++ edited/arch/ppc/mm/Makefile	2004-07-12 08:22:21 -07:00
@@ -2,10 +2,6 @@
 # Makefile for the linux ppc-specific parts of the memory manager.
 #

-ifdef CONFIG_PPC64BRIDGE
-EXTRA_AFLAGS		:= -Wa,-mppc64bridge
-endif
-
 obj-y				:= fault.o init.o mem_pieces.o \
 					mmu_context.o pgtable.o

--- 1.31/arch/ppc/platforms/Makefile	2004-06-16 11:22:35 -07:00
+++ edited/arch/ppc/platforms/Makefile	2004-07-12 08:22:27 -07:00
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
@@ -48,8 +42,3 @@
 obj-$(CONFIG_SANDPOINT)		+= sandpoint.o
 obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
-
-ifeq ($(CONFIG_SMP),y)
-obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o
-obj-$(CONFIG_PPC_CHRP)		+= chrp_smp.o
-endif
--- 1.3/arch/ppc/platforms/tqm8260_setup.c	2004-06-16 10:56:13 -07:00
+++ edited/arch/ppc/platforms/tqm8260_setup.c	2004-07-12 08:17:30 -07:00
@@ -77,3 +77,4 @@

 	callback_setup_arch	= ppc_md.setup_arch;
 	ppc_md.setup_arch	= tqm8260_setup_arch;
+}
--- 1.29/arch/ppc/syslib/Makefile	2004-07-01 22:23:46 -07:00
+++ edited/arch/ppc/syslib/Makefile	2004-07-12 08:22:30 -07:00
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
@@ -73,16 +61,11 @@
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
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
