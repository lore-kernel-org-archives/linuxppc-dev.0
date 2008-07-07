Return-Path: <zippel@linux-m68k.org>
Received: from smtp-vbr10.xs4all.nl (smtp-vbr10.xs4all.nl [194.109.24.30])
	by ozlabs.org (Postfix) with ESMTP id 7A2D6DED55
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 02:25:34 +1000 (EST)
Date: Mon, 7 Jul 2008 18:13:55 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: kbuild tree build failure
In-Reply-To: <20080707184038.aaeb8d40.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0807071424240.6791@localhost.localdomain>
References: <20080707184038.aaeb8d40.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linux-next@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Mon, 7 Jul 2008, Stephen Rothwell wrote:

> Hi Sam,
> 
> Today's linux-next build (powerpc ppc64_defconfig) failed like this:
> 
> arch/powerpc/platforms/cell/spu_base.c: In function '__spu_trap_data_seg':
> arch/powerpc/platforms/cell/spu_base.c:194: error: duplicate case value
> arch/powerpc/platforms/cell/spu_base.c:177: error: previously used here

I guess there also has been a kconfig warning somewhere. :)
I should have gone through all archs to test this, sorry about that.
Luckily it's only powerpc that uses 64bit values. I would prefer to 
standardize on 32bit values, as it doesn't really make sense to expect 
from the user to input full 64bit values and it's easy to generate the 
full value in a header. This would also ease on any portability issues 
(kconfig is compiled with the host compiler not the target compiler).

Below is a patch that fixes this for all archs (generated against the git 
tree). The powerpc parts need a more careful review, the rest isn't really 
critical.

bye, Roman

Fix remaining warnings generated kconfig to normalize all constant values.
Generate powerpc 64bit page offset via header instead of kconfig.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---
 arch/arm/Kconfig                   |    4 ++--
 arch/arm/Kconfig-nommu             |   10 +++++-----
 arch/arm/mm/Kconfig                |    4 ++--
 arch/blackfin/Kconfig              |   12 ++++++------
 arch/blackfin/mach-bf548/Kconfig   |    8 ++++----
 arch/cris/arch-v10/Kconfig         |   26 +++++++++++++-------------
 arch/cris/arch-v10/drivers/Kconfig |   14 +++++++-------
 arch/cris/arch-v32/Kconfig         |   28 ++++++++++++++--------------
 arch/cris/arch-v32/drivers/Kconfig |   30 ++++++++++++------------------
 arch/cris/arch-v32/mach-a3/Kconfig |   14 +++++++-------
 arch/cris/arch-v32/mach-fs/Kconfig |   32 ++++++++++++++++----------------
 arch/frv/Kconfig                   |    4 ++--
 arch/m32r/Kconfig                  |   36 ++++++++++++++++++------------------
 arch/powerpc/Kconfig               |   16 ++++++----------
 arch/ppc/Kconfig                   |    8 ++++----
 arch/sh/Kconfig                    |   10 +++++-----
 arch/sh/Kconfig.debug              |    2 +-
 arch/sh/mm/Kconfig                 |    6 +++---
 include/asm-powerpc/page.h         |   10 ++++++++--
 19 files changed, 135 insertions(+), 139 deletions(-)

Index: linux-2.6/arch/arm/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/Kconfig
+++ linux-2.6/arch/arm/Kconfig
@@ -168,7 +168,7 @@ config VECTORS_BASE
 	hex
 	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
 	default DRAM_BASE if REMAP_VECTORS_TO_RAM
-	default 0x00000000
+	default 0
 	help
 	  The base address of exception vectors.
 
@@ -924,7 +924,7 @@ config XIP_KERNEL
 config XIP_PHYS_ADDR
 	hex "XIP Kernel Physical Location"
 	depends on XIP_KERNEL
-	default "0x00080000"
+	default "0x80000"
 	help
 	  This is the physical address in your flash memory the kernel will
 	  be linked for and stored to.  This address is dependent on your
Index: linux-2.6/arch/arm/Kconfig-nommu
===================================================================
--- linux-2.6.orig/arch/arm/Kconfig-nommu
+++ linux-2.6/arch/arm/Kconfig-nommu
@@ -11,23 +11,23 @@ config SET_MEM_PARAM
 
 config DRAM_BASE
 	hex '(S)DRAM Base Address' if SET_MEM_PARAM
-	default 0x00800000
+	default 0x800000
 
 config DRAM_SIZE
 	hex '(S)DRAM SIZE' if SET_MEM_PARAM
-	default 0x00800000
+	default 0x800000
 
 config FLASH_MEM_BASE
 	hex 'FLASH Base Address' if SET_MEM_PARAM
-	default 0x00400000
+	default 0x400000
 
 config FLASH_SIZE
 	hex 'FLASH Size' if SET_MEM_PARAM
-	default 0x00400000
+	default 0x400000
 
 config PROCESSOR_ID
 	hex 'Hard wire the processor ID'
-	default 0x00007700
+	default 0x7700
 	depends on !CPU_CP15
 	help
 	  If processor has no CP15 register, this processor ID is
Index: linux-2.6/arch/arm/mm/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/mm/Kconfig
+++ linux-2.6/arch/arm/mm/Kconfig
@@ -649,8 +649,8 @@ config CPU_DCACHE_DISABLE
 config CPU_DCACHE_SIZE
 	hex
 	depends on CPU_ARM740T || CPU_ARM946E
-	default 0x00001000 if CPU_ARM740T
-	default 0x00002000 # default size for ARM946E-S
+	default 0x1000 if CPU_ARM740T
+	default 0x2000 # default size for ARM946E-S
 	help
 	  Some cores are synthesizable to have various sized cache. For
 	  ARM946E-S case, it can vary from 0KB to 1MB.
Index: linux-2.6/arch/blackfin/Kconfig
===================================================================
--- linux-2.6.orig/arch/blackfin/Kconfig
+++ linux-2.6/arch/blackfin/Kconfig
@@ -819,20 +819,20 @@ endmenu
 menu "EBIU_AMBCTL Control"
 config BANK_0
 	hex "Bank 0"
-	default 0x7BB0
+	default 0x7bb0
 
 config BANK_1
 	hex "Bank 1"
-	default 0x7BB0
+	default 0x7bb0
 	default 0x5558 if BF54x
 
 config BANK_2
 	hex "Bank 2"
-	default 0x7BB0
+	default 0x7bb0
 
 config BANK_3
 	hex "Bank 3"
-	default 0x99B3
+	default 0x99b3
 endmenu
 
 config EBIU_MBSCTLVAL
@@ -843,12 +843,12 @@ config EBIU_MBSCTLVAL
 config EBIU_MODEVAL
 	hex "Flash Memory Mode Control Register"
 	depends on BF54x
-	default 1
+	default 0x1
 
 config EBIU_FCTLVAL
 	hex "Flash Memory Bank Control Register"
 	depends on BF54x
-	default 6
+	default 0x6
 endmenu
 
 #############################################################################
Index: linux-2.6/arch/blackfin/mach-bf548/Kconfig
===================================================================
--- linux-2.6.orig/arch/blackfin/mach-bf548/Kconfig
+++ linux-2.6/arch/blackfin/mach-bf548/Kconfig
@@ -304,19 +304,19 @@ config PINTx_REASSIGN
 config PINT0_ASSIGN
 	hex "PINT0_ASSIGN"
 	depends on PINTx_REASSIGN
-	default 0x00000101
+	default 0x101
 config PINT1_ASSIGN
 	hex "PINT1_ASSIGN"
 	depends on PINTx_REASSIGN
-	default 0x01010000
+	default 0x1010000
 config PINT2_ASSIGN
 	hex "PINT2_ASSIGN"
 	depends on PINTx_REASSIGN
-	default 0x07000101
+	default 0x7000101
 config PINT3_ASSIGN
 	hex "PINT3_ASSIGN"
 	depends on PINTx_REASSIGN
-	default 0x02020303
+	default 0x2020303
 
 endmenu
 
Index: linux-2.6/arch/cris/arch-v10/Kconfig
===================================================================
--- linux-2.6.orig/arch/cris/arch-v10/Kconfig
+++ linux-2.6/arch/cris/arch-v10/Kconfig
@@ -11,8 +11,8 @@ config CRIS_LOW_MAP
 config ETRAX_DRAM_VIRTUAL_BASE
 	hex
 	depends on ETRAX_ARCH_V10
-	default "c0000000" if !ETRAX100LX
-	default "60000000" if ETRAX100LX
+	default "0xc0000000" if !ETRAX100LX
+	default "0x60000000" if ETRAX100LX
 
 choice
 	prompt "Product LED port"
@@ -262,7 +262,7 @@ endchoice
 config ETRAX_DEF_R_WAITSTATES
 	hex "R_WAITSTATES"
 	depends on ETRAX_ARCH_V10
-	default "95a6"
+	default "0x95a6"
 	help
 	  Waitstates for SRAM, Flash and peripherals (not DRAM).  95f8 is a
 	  good choice for most Axis products...
@@ -270,7 +270,7 @@ config ETRAX_DEF_R_WAITSTATES
 config ETRAX_DEF_R_BUS_CONFIG
 	hex "R_BUS_CONFIG"
 	depends on ETRAX_ARCH_V10
-	default "104"
+	default "0x104"
 	help
 	  Assorted bits controlling write mode, DMA burst length etc.  104 is
 	  a good choice for most Axis products...
@@ -285,7 +285,7 @@ config ETRAX_SDRAM
 config ETRAX_DEF_R_DRAM_CONFIG
 	hex "R_DRAM_CONFIG"
 	depends on ETRAX_ARCH_V10 && !ETRAX_SDRAM
-	default "1a200040"
+	default "0x1a200040"
 	help
 	  The R_DRAM_CONFIG register specifies everything on how the DRAM
 	  chips in the system are connected to the ETRAX CPU.  This is
@@ -296,7 +296,7 @@ config ETRAX_DEF_R_DRAM_CONFIG
 config ETRAX_DEF_R_DRAM_TIMING
 	hex "R_DRAM_TIMING"
 	depends on ETRAX_ARCH_V10 && !ETRAX_SDRAM
-	default "5611"
+	default "0x5611"
 	help
 	  Different DRAM chips have different speeds.  Current Axis products
 	  use 50ns DRAM chips which can use the timing: 5611.
@@ -304,7 +304,7 @@ config ETRAX_DEF_R_DRAM_TIMING
 config ETRAX_DEF_R_SDRAM_CONFIG
 	hex "R_SDRAM_CONFIG"
 	depends on ETRAX_ARCH_V10 && ETRAX_SDRAM
-	default "d2fa7878"
+	default "0xd2fa7878"
 	help
 	  The R_SDRAM_CONFIG register specifies everything on how the SDRAM
 	  chips in the system are connected to the ETRAX CPU.  This is
@@ -315,14 +315,14 @@ config ETRAX_DEF_R_SDRAM_CONFIG
 config ETRAX_DEF_R_SDRAM_TIMING
 	hex "R_SDRAM_TIMING"
 	depends on ETRAX_ARCH_V10 && ETRAX_SDRAM
-	default "80004801"
+	default "0x80004801"
 	help
 	  Different SDRAM chips have different timing.
 
 config ETRAX_DEF_R_PORT_PA_DIR
 	hex "R_PORT_PA_DIR"
 	depends on ETRAX_ARCH_V10
-	default "1c"
+	default "0x1c"
 	help
 	  Configures the direction of general port A bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -336,7 +336,7 @@ config ETRAX_DEF_R_PORT_PA_DIR
 config ETRAX_DEF_R_PORT_PA_DATA
 	hex "R_PORT_PA_DATA"
 	depends on ETRAX_ARCH_V10
-	default "00"
+	default "0"
 	help
 	  Configures the initial data for the general port A bits.  Most
 	  products should use 00 here.
@@ -344,7 +344,7 @@ config ETRAX_DEF_R_PORT_PA_DATA
 config ETRAX_DEF_R_PORT_PB_CONFIG
 	hex "R_PORT_PB_CONFIG"
 	depends on ETRAX_ARCH_V10
-	default "00"
+	default "0"
 	help
 	  Configures the type of the general port B bits.  1 is chip select,
 	  0 is port.  Most products should use 00 here.
@@ -352,7 +352,7 @@ config ETRAX_DEF_R_PORT_PB_CONFIG
 config ETRAX_DEF_R_PORT_PB_DIR
 	hex "R_PORT_PB_DIR"
 	depends on ETRAX_ARCH_V10
-	default "00"
+	default "0"
 	help
 	  Configures the direction of general port B bits. 1 is out, 0 is in.
 	  This is often totally different depending on the product used.  Bits
@@ -365,7 +365,7 @@ config ETRAX_DEF_R_PORT_PB_DIR
 config ETRAX_DEF_R_PORT_PB_DATA
 	hex "R_PORT_PB_DATA"
 	depends on ETRAX_ARCH_V10
-	default "ff"
+	default "0xff"
 	help
 	  Configures the initial data for the general port A bits.  Most
 	  products should use FF here.
Index: linux-2.6/arch/cris/arch-v10/drivers/Kconfig
===================================================================
--- linux-2.6.orig/arch/cris/arch-v10/drivers/Kconfig
+++ linux-2.6/arch/cris/arch-v10/drivers/Kconfig
@@ -531,20 +531,20 @@ config ETRAX_GPIO
 config ETRAX_PA_BUTTON_BITMASK
 	hex "PA-buttons bitmask"
 	depends on ETRAX_GPIO
-	default "02"
+	default "0x2"
 	help
 	  This is a bitmask with information about what bits on PA that
 	  are used for buttons.
 	  Most products has a so called TEST button on PA1, if that's true
-	  use 02 here.
-	  Use 00 if there are no buttons on PA.
+	  use 0x2 here.
+	  Use 0x0 if there are no buttons on PA.
 	  If the bitmask is <> 00 a button driver will be included in the gpio
 	  driver. ETRAX general I/O support must be enabled.
 
 config ETRAX_PA_CHANGEABLE_DIR
 	hex "PA user changeable dir mask"
 	depends on ETRAX_GPIO
-	default "00"
+	default "0"
 	help
 	  This is a bitmask with information of what bits in PA that a user
 	  can change direction on using ioctl's.
@@ -554,7 +554,7 @@ config ETRAX_PA_CHANGEABLE_DIR
 config ETRAX_PA_CHANGEABLE_BITS
 	hex "PA user changeable bits mask"
 	depends on ETRAX_GPIO
-	default "FF"
+	default "0xff"
 	help
 	  This is a bitmask with information of what bits in PA that a user
 	  can change the value on using ioctl's.
@@ -564,7 +564,7 @@ config ETRAX_PA_CHANGEABLE_BITS
 config ETRAX_PB_CHANGEABLE_DIR
 	hex "PB user changeable dir mask"
 	depends on ETRAX_GPIO
-	default "00"
+	default "0"
 	help
 	  This is a bitmask with information of what bits in PB that a user
 	  can change direction on using ioctl's.
@@ -574,7 +574,7 @@ config ETRAX_PB_CHANGEABLE_DIR
 config ETRAX_PB_CHANGEABLE_BITS
 	hex "PB user changeable bits mask"
 	depends on ETRAX_GPIO
-	default "FF"
+	default "0xff"
 	help
 	  This is a bitmask with information of what bits in PB that a user
 	  can change the value on using ioctl's.
Index: linux-2.6/arch/cris/arch-v32/Kconfig
===================================================================
--- linux-2.6.orig/arch/cris/arch-v32/Kconfig
+++ linux-2.6/arch/cris/arch-v32/Kconfig
@@ -8,7 +8,7 @@ source drivers/cpufreq/Kconfig
 config ETRAX_DRAM_VIRTUAL_BASE
 	hex
 	depends on ETRAX_ARCH_V32
-	default "c0000000"
+	default "0xc0000000"
 
 choice
 	prompt "Nbr of Ethernet LED groups"
@@ -119,7 +119,7 @@ endchoice
 config ETRAX_MEM_GRP1_CONFIG
 	hex "MEM_GRP1_CONFIG"
 	depends on ETRAX_ARCH_V32
-	default "4044a"
+	default "0x4044a"
 	help
 	  Waitstates for flash. The default value is suitable for the
 	  standard flashes used in axis products (120 ns).
@@ -150,7 +150,7 @@ config ETRAX_MEM_GRP4_CONFIG
 config ETRAX_SDRAM_GRP0_CONFIG
 	hex "SDRAM_GRP0_CONFIG"
 	depends on ETRAX_ARCH_V32
-	default "336"
+	default "0x336"
 	help
 	  SDRAM configuration for group 0. The value depends on the
 	  hardware configuration. The default value is suitable
@@ -170,7 +170,7 @@ config ETRAX_SDRAM_GRP1_CONFIG
 config ETRAX_SDRAM_TIMING
 	hex "SDRAM_TIMING"
 	depends on ETRAX_ARCH_V32
-	default "104a"
+	default "0x104a"
 	help
 	  SDRAM timing parameters. The default value is ok for
 	  most hardwares but large SDRAMs may require a faster
@@ -189,7 +189,7 @@ config ETRAX_SDRAM_COMMAND
 config ETRAX_DEF_GIO_PA_OE
 	hex "GIO_PA_OE"
 	depends on ETRAX_ARCH_V32
-	default "1c"
+	default "0x1c"
 	help
 	  Configures the direction of general port A bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -203,7 +203,7 @@ config ETRAX_DEF_GIO_PA_OE
 config ETRAX_DEF_GIO_PA_OUT
 	hex "GIO_PA_OUT"
 	depends on ETRAX_ARCH_V32
-	default "00"
+	default "0"
 	help
 	  Configures the initial data for the general port A bits.  Most
 	  products should use 00 here.
@@ -211,7 +211,7 @@ config ETRAX_DEF_GIO_PA_OUT
 config ETRAX_DEF_GIO_PB_OE
 	hex "GIO_PB_OE"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the direction of general port B bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -225,7 +225,7 @@ config ETRAX_DEF_GIO_PB_OE
 config ETRAX_DEF_GIO_PB_OUT
 	hex "GIO_PB_OUT"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the initial data for the general port B bits.  Most
 	  products should use 00000 here.
@@ -233,7 +233,7 @@ config ETRAX_DEF_GIO_PB_OUT
 config ETRAX_DEF_GIO_PC_OE
 	hex "GIO_PC_OE"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the direction of general port C bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -247,7 +247,7 @@ config ETRAX_DEF_GIO_PC_OE
 config ETRAX_DEF_GIO_PC_OUT
 	hex "GIO_PC_OUT"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the initial data for the general port C bits.  Most
 	  products should use 00000 here.
@@ -255,7 +255,7 @@ config ETRAX_DEF_GIO_PC_OUT
 config ETRAX_DEF_GIO_PD_OE
 	hex "GIO_PD_OE"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the direction of general port D bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -269,7 +269,7 @@ config ETRAX_DEF_GIO_PD_OE
 config ETRAX_DEF_GIO_PD_OUT
 	hex "GIO_PD_OUT"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the initial data for the general port D bits.  Most
 	  products should use 00000 here.
@@ -277,7 +277,7 @@ config ETRAX_DEF_GIO_PD_OUT
 config ETRAX_DEF_GIO_PE_OE
 	hex "GIO_PE_OE"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the direction of general port E bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -291,7 +291,7 @@ config ETRAX_DEF_GIO_PE_OE
 config ETRAX_DEF_GIO_PE_OUT
 	hex "GIO_PE_OUT"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the initial data for the general port E bits.  Most
 	  products should use 00000 here.
Index: linux-2.6/arch/cris/arch-v32/drivers/Kconfig
===================================================================
--- linux-2.6.orig/arch/cris/arch-v32/drivers/Kconfig
+++ linux-2.6/arch/cris/arch-v32/drivers/Kconfig
@@ -513,8 +513,7 @@ config ETRAX_VIRTUAL_GPIO_INTERRUPT_PA_P
 config ETRAX_PA_CHANGEABLE_DIR
 	hex "PA user changeable dir mask"
 	depends on ETRAX_GPIO
-	default "0x00" if ETRAXFS
-	default "0x00000000" if !ETRAXFS
+	default "0"
 	help
 	  This is a bitmask (8 bits) with information of what bits in PA that a
 	  user can change direction on using ioctl's.
@@ -524,8 +523,7 @@ config ETRAX_PA_CHANGEABLE_DIR
 config ETRAX_PA_CHANGEABLE_BITS
 	hex "PA user changeable bits mask"
 	depends on ETRAX_GPIO
-	default "0x00" if ETRAXFS
-	default "0x00000000" if !ETRAXFS
+	default "0"
 	help
 	  This is a bitmask (8 bits) with information of what bits in PA
 	  that a user can change the value on using ioctl's.
@@ -534,8 +532,7 @@ config ETRAX_PA_CHANGEABLE_BITS
 config ETRAX_PB_CHANGEABLE_DIR
 	hex "PB user changeable dir mask"
 	depends on ETRAX_GPIO
-	default "0x00000" if ETRAXFS
-	default "0x00000000" if !ETRAXFS
+	default "0"
 	help
 	  This is a bitmask (18 bits) with information of what bits in PB
 	  that a user can change direction on using ioctl's.
@@ -545,8 +542,7 @@ config ETRAX_PB_CHANGEABLE_DIR
 config ETRAX_PB_CHANGEABLE_BITS
 	hex "PB user changeable bits mask"
 	depends on ETRAX_GPIO
-	default "0x00000" if ETRAXFS
-	default "0x00000000" if !ETRAXFS
+	default "0"
 	help
 	  This is a bitmask (18 bits) with information of what bits in PB
 	  that a user can change the value on using ioctl's.
@@ -555,8 +551,7 @@ config ETRAX_PB_CHANGEABLE_BITS
 config ETRAX_PC_CHANGEABLE_DIR
 	hex "PC user changeable dir mask"
 	depends on ETRAX_GPIO
-	default "0x00000" if ETRAXFS
-	default "0x00000000" if !ETRAXFS
+	default "0"
 	help
 	  This is a bitmask (18 bits) with information of what bits in PC
 	  that a user can change direction on using ioctl's.
@@ -566,8 +561,7 @@ config ETRAX_PC_CHANGEABLE_DIR
 config ETRAX_PC_CHANGEABLE_BITS
 	hex "PC user changeable bits mask"
 	depends on ETRAX_GPIO
-	default "0x00000" if ETRAXFS
-	default "0x00000000" if ETRAXFS
+	default "0"
 	help
 	  This is a bitmask (18 bits) with information of what bits in PC
 	  that a user can change the value on using ioctl's.
@@ -576,7 +570,7 @@ config ETRAX_PC_CHANGEABLE_BITS
 config ETRAX_PD_CHANGEABLE_DIR
 	hex "PD user changeable dir mask"
 	depends on ETRAX_GPIO && ETRAXFS
-	default "0x00000"
+	default "0"
 	help
 	  This is a bitmask (18 bits) with information of what bits in PD
 	  that a user can change direction on using ioctl's.
@@ -586,7 +580,7 @@ config ETRAX_PD_CHANGEABLE_DIR
 config ETRAX_PD_CHANGEABLE_BITS
 	hex "PD user changeable bits mask"
 	depends on ETRAX_GPIO && ETRAXFS
-	default "0x00000"
+	default "0"
 	help
 	  This is a bitmask (18 bits) with information of what bits in PD
 	  that a user can change the value on using ioctl's.
@@ -595,7 +589,7 @@ config ETRAX_PD_CHANGEABLE_BITS
 config ETRAX_PE_CHANGEABLE_DIR
 	hex "PE user changeable dir mask"
 	depends on ETRAX_GPIO && ETRAXFS
-	default "0x00000"
+	default "0"
 	help
 	  This is a bitmask (18 bits) with information of what bits in PE
 	  that a user can change direction on using ioctl's.
@@ -605,7 +599,7 @@ config ETRAX_PE_CHANGEABLE_DIR
 config ETRAX_PE_CHANGEABLE_BITS
 	hex "PE user changeable bits mask"
  	depends on ETRAX_GPIO && ETRAXFS
-	default "0x00000"
+	default "0"
 	help
 	  This is a bitmask (18 bits) with information of what bits in PE
 	  that a user can change the value on using ioctl's.
@@ -614,7 +608,7 @@ config ETRAX_PE_CHANGEABLE_BITS
 config ETRAX_PV_CHANGEABLE_DIR
 	hex "PV user changeable dir mask"
 	depends on ETRAX_VIRTUAL_GPIO
-	default "0x0000"
+	default "0"
 	help
 	  This is a bitmask (16 bits) with information of what bits in PV
 	  that a user can change direction on using ioctl's.
@@ -624,7 +618,7 @@ config ETRAX_PV_CHANGEABLE_DIR
 config ETRAX_PV_CHANGEABLE_BITS
 	hex "PV user changeable bits mask"
 	depends on ETRAX_VIRTUAL_GPIO
-	default "0x0000"
+	default "0"
 	help
 	  This is a bitmask (16 bits) with information of what bits in PV
 	  that a user can change the value on using ioctl's.
Index: linux-2.6/arch/cris/arch-v32/mach-a3/Kconfig
===================================================================
--- linux-2.6.orig/arch/cris/arch-v32/mach-a3/Kconfig
+++ linux-2.6/arch/cris/arch-v32/mach-a3/Kconfig
@@ -5,7 +5,7 @@ menu "Artpec-3 options"
 
 config ETRAX_DRAM_VIRTUAL_BASE
 	hex
-	default "c0000000"
+	default "0xc0000000"
 
 config ETRAX_L2CACHE
        bool
@@ -47,7 +47,7 @@ config ETRAX_PIO_CE2_CFG
 
 config ETRAX_DEF_GIO_PA_OE
 	hex "GIO_PA_OE"
-	default "00000000"
+	default "0"
 	help
 	  Configures the direction of general port A bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -60,14 +60,14 @@ config ETRAX_DEF_GIO_PA_OE
 
 config ETRAX_DEF_GIO_PA_OUT
 	hex "GIO_PA_OUT"
-	default "00000000"
+	default "0"
 	help
 	  Configures the initial data for the general port A bits.  Most
 	  products should use 00 here.
 
 config ETRAX_DEF_GIO_PB_OE
 	hex "GIO_PB_OE"
-	default "000000000"
+	default "0"
 	help
 	  Configures the direction of general port B bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -80,14 +80,14 @@ config ETRAX_DEF_GIO_PB_OE
 
 config ETRAX_DEF_GIO_PB_OUT
 	hex "GIO_PB_OUT"
-	default "000000000"
+	default "0"
 	help
 	  Configures the initial data for the general port B bits.  Most
 	  products should use 00000 here.
 
 config ETRAX_DEF_GIO_PC_OE
 	hex "GIO_PC_OE"
-	default "00000"
+	default "0"
 	help
 	  Configures the direction of general port C bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -100,7 +100,7 @@ config ETRAX_DEF_GIO_PC_OE
 
 config ETRAX_DEF_GIO_PC_OUT
 	hex "GIO_PC_OUT"
-	default "00000"
+	default "0"
 	help
 	  Configures the initial data for the general port C bits.  Most
 	  products should use 00000 here.
Index: linux-2.6/arch/cris/arch-v32/mach-fs/Kconfig
===================================================================
--- linux-2.6.orig/arch/cris/arch-v32/mach-fs/Kconfig
+++ linux-2.6/arch/cris/arch-v32/mach-fs/Kconfig
@@ -6,7 +6,7 @@ menu "ETRAX FS options"
 config ETRAX_DRAM_VIRTUAL_BASE
 	hex
 	depends on ETRAX_ARCH_V32
-	default "c0000000"
+	default "0xc0000000"
 
 config ETRAX_SERIAL_PORTS
        int
@@ -15,7 +15,7 @@ config ETRAX_SERIAL_PORTS
 config ETRAX_MEM_GRP1_CONFIG
 	hex "MEM_GRP1_CONFIG"
 	depends on ETRAX_ARCH_V32
-	default "4044a"
+	default "0x4044a"
 	help
 	  Waitstates for flash. The default value is suitable for the
 	  standard flashes used in axis products (120 ns).
@@ -46,7 +46,7 @@ config ETRAX_MEM_GRP4_CONFIG
 config ETRAX_SDRAM_GRP0_CONFIG
 	hex "SDRAM_GRP0_CONFIG"
 	depends on ETRAX_ARCH_V32
-	default "336"
+	default "0x336"
 	help
 	  SDRAM configuration for group 0. The value depends on the
 	  hardware configuration. The default value is suitable
@@ -66,7 +66,7 @@ config ETRAX_SDRAM_GRP1_CONFIG
 config ETRAX_SDRAM_TIMING
 	hex "SDRAM_TIMING"
 	depends on ETRAX_ARCH_V32
-	default "104a"
+	default "0x104a"
 	help
 	  SDRAM timing parameters. The default value is ok for
 	  most hardwares but large SDRAMs may require a faster
@@ -85,7 +85,7 @@ config ETRAX_SDRAM_COMMAND
 config ETRAX_DEF_GIO_PA_OE
 	hex "GIO_PA_OE"
 	depends on ETRAX_ARCH_V32
-	default "1c"
+	default "0x1c"
 	help
 	  Configures the direction of general port A bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -99,7 +99,7 @@ config ETRAX_DEF_GIO_PA_OE
 config ETRAX_DEF_GIO_PA_OUT
 	hex "GIO_PA_OUT"
 	depends on ETRAX_ARCH_V32
-	default "00"
+	default "0"
 	help
 	  Configures the initial data for the general port A bits.  Most
 	  products should use 00 here.
@@ -107,7 +107,7 @@ config ETRAX_DEF_GIO_PA_OUT
 config ETRAX_DEF_GIO_PB_OE
 	hex "GIO_PB_OE"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the direction of general port B bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -121,7 +121,7 @@ config ETRAX_DEF_GIO_PB_OE
 config ETRAX_DEF_GIO_PB_OUT
 	hex "GIO_PB_OUT"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the initial data for the general port B bits.  Most
 	  products should use 00000 here.
@@ -129,7 +129,7 @@ config ETRAX_DEF_GIO_PB_OUT
 config ETRAX_DEF_GIO_PC_OE
 	hex "GIO_PC_OE"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the direction of general port C bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -143,7 +143,7 @@ config ETRAX_DEF_GIO_PC_OE
 config ETRAX_DEF_GIO_PC_OUT
 	hex "GIO_PC_OUT"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the initial data for the general port C bits.  Most
 	  products should use 00000 here.
@@ -151,7 +151,7 @@ config ETRAX_DEF_GIO_PC_OUT
 config ETRAX_DEF_GIO_PD_OE
 	hex "GIO_PD_OE"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the direction of general port D bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -165,7 +165,7 @@ config ETRAX_DEF_GIO_PD_OE
 config ETRAX_DEF_GIO_PD_OUT
 	hex "GIO_PD_OUT"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the initial data for the general port D bits.  Most
 	  products should use 00000 here.
@@ -173,7 +173,7 @@ config ETRAX_DEF_GIO_PD_OUT
 config ETRAX_DEF_GIO_PE_OE
 	hex "GIO_PE_OE"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the direction of general port E bits.  1 is out, 0 is in.
 	  This is often totally different depending on the product used.
@@ -187,7 +187,7 @@ config ETRAX_DEF_GIO_PE_OE
 config ETRAX_DEF_GIO_PE_OUT
 	hex "GIO_PE_OUT"
 	depends on ETRAX_ARCH_V32
-	default "00000"
+	default "0"
 	help
 	  Configures the initial data for the general port E bits.  Most
 	  products should use 00000 here.
@@ -195,7 +195,7 @@ config ETRAX_DEF_GIO_PE_OUT
 config ETRAX_DEF_GIO_PV_OE
 	hex "GIO_PV_OE"
 	depends on ETRAX_VIRTUAL_GPIO
-	default "0000"
+	default "0"
 	help
 	  Configures the direction of virtual general port V bits. 1 is out,
 	  0 is in. This is often totally different depending on the product
@@ -206,7 +206,7 @@ config ETRAX_DEF_GIO_PV_OE
 config ETRAX_DEF_GIO_PV_OUT
 	hex "GIO_PV_OUT"
 	depends on ETRAX_VIRTUAL_GPIO
-	default "0000"
+	default "0"
 	help
 	  Configures the initial data for the virtual general port V bits.
 	  Most products should use 0000 here.
Index: linux-2.6/arch/frv/Kconfig
===================================================================
--- linux-2.6.orig/arch/frv/Kconfig
+++ linux-2.6/arch/frv/Kconfig
@@ -149,8 +149,8 @@ config PAGE_OFFSET
 	default 0x40000000 if UCPAGE_OFFSET_40000000
 	default 0x60000000 if UCPAGE_OFFSET_60000000
 	default 0x80000000 if UCPAGE_OFFSET_80000000
-	default 0xA0000000 if UCPAGE_OFFSET_A0000000
-	default 0xC0000000
+	default 0xa0000000 if UCPAGE_OFFSET_A0000000
+	default 0xc0000000
 
 config PROTECT_KERNEL
 	bool "Protect core kernel against userspace"
Index: linux-2.6/arch/m32r/Kconfig
===================================================================
--- linux-2.6.orig/arch/m32r/Kconfig
+++ linux-2.6/arch/m32r/Kconfig
@@ -199,22 +199,22 @@ config CPU_LITTLE_ENDIAN
 
 config MEMORY_START
 	hex "Physical memory start address (hex)"
-	default "08000000" if PLAT_MAPPI || PLAT_MAPPI2 || PLAT_MAPPI3
-	default "08000000" if PLAT_USRV
-	default "08000000" if PLAT_M32700UT
-	default "08000000" if PLAT_OPSPUT
-	default "04000000" if PLAT_M32104UT
-	default "01000000" if PLAT_OAKS32R
+	default "0x8000000" if PLAT_MAPPI || PLAT_MAPPI2 || PLAT_MAPPI3
+	default "0x8000000" if PLAT_USRV
+	default "0x8000000" if PLAT_M32700UT
+	default "0x8000000" if PLAT_OPSPUT
+	default "0x4000000" if PLAT_M32104UT
+	default "0x1000000" if PLAT_OAKS32R
 
 config MEMORY_SIZE
 	hex "Physical memory size (hex)"
-	default "08000000" if PLAT_MAPPI3
-	default "04000000" if PLAT_MAPPI || PLAT_MAPPI2
-	default "02000000" if PLAT_USRV
-	default "01000000" if PLAT_M32700UT
-	default "01000000" if PLAT_OPSPUT
-	default "01000000" if PLAT_M32104UT
-	default "00800000" if PLAT_OAKS32R
+	default "0x8000000" if PLAT_MAPPI3
+	default "0x4000000" if PLAT_MAPPI || PLAT_MAPPI2
+	default "0x2000000" if PLAT_USRV
+	default "0x1000000" if PLAT_M32700UT
+	default "0x1000000" if PLAT_OPSPUT
+	default "0x1000000" if PLAT_M32104UT
+	default "0x800000" if PLAT_OAKS32R
 
 config NOHIGHMEM
 	bool
@@ -229,16 +229,16 @@ source "mm/Kconfig"
 
 config IRAM_START
 	hex "Internal memory start address (hex)"
-	default "00f00000" if !CHIP_M32104
-	default "00700000" if CHIP_M32104
+	default "0xf00000" if !CHIP_M32104
+	default "0x700000" if CHIP_M32104
 	depends on (CHIP_M32700 || CHIP_M32102 || CHIP_VDEC2 || CHIP_OPSP || CHIP_M32104) && DISCONTIGMEM
 
 config IRAM_SIZE
 	hex "Internal memory size (hex)"
 	depends on (CHIP_M32700 || CHIP_M32102 || CHIP_VDEC2 || CHIP_OPSP || CHIP_M32104) && DISCONTIGMEM
-	default "00080000" if CHIP_M32700
-	default "00010000" if CHIP_M32102 || CHIP_OPSP || CHIP_M32104
-	default "00008000" if CHIP_VDEC2
+	default "0x80000" if CHIP_M32700
+	default "0x10000" if CHIP_M32102 || CHIP_OPSP || CHIP_M32104
+	default "0x8000" if CHIP_VDEC2
 
 #
 # Define implied options from the CPU selection here
Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
@@ -714,8 +714,8 @@ config PHYSICAL_START_BOOL
 
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if PHYSICAL_START_BOOL
-	default "0x02000000" if PPC_STD_MMU && CRASH_DUMP
-	default "0x00000000"
+	default "0x2000000" if PPC_STD_MMU && CRASH_DUMP
+	default "0"
 
 config PHYSICAL_ALIGN
 	hex
@@ -763,7 +763,7 @@ config CONSISTENT_SIZE_BOOL
 
 config CONSISTENT_SIZE
 	hex "Size of consistent memory pool" if CONSISTENT_SIZE_BOOL
-	default "0x00200000" if NOT_COHERENT_CACHE
+	default "0x200000" if NOT_COHERENT_CACHE
 
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
@@ -773,15 +773,11 @@ endmenu
 if PPC64
 config PAGE_OFFSET
 	hex
-	default "0xc000000000000000"
-config KERNEL_START
-	hex
-	default "0xc000000002000000" if CRASH_DUMP
-	default "0xc000000000000000"
+	default "0xc0000000"
 config PHYSICAL_START
 	hex
-	default "0x02000000" if CRASH_DUMP
-	default "0x00000000"
+	default "0x2000000" if CRASH_DUMP
+	default "0"
 endif
 
 source "net/Kconfig"
Index: linux-2.6/arch/ppc/Kconfig
===================================================================
--- linux-2.6.orig/arch/ppc/Kconfig
+++ linux-2.6/arch/ppc/Kconfig
@@ -1120,7 +1120,7 @@ config CONSISTENT_SIZE_BOOL
 
 config CONSISTENT_SIZE
 	hex "Size of consistent memory pool" if CONSISTENT_SIZE_BOOL
-	default "0x00200000" if NOT_COHERENT_CACHE
+	default "0x200000" if NOT_COHERENT_CACHE
 
 config BOOT_LOAD_BOOL
 	bool "Set the boot link/load address"
@@ -1134,9 +1134,9 @@ config BOOT_LOAD_BOOL
 
 config BOOT_LOAD
 	hex "Link/load address for booting" if BOOT_LOAD_BOOL
-	default "0x00400000" if 40x || 8xx || 8260
-	default "0x01000000" if 44x
-	default "0x00800000"
+	default "0x400000" if 40x || 8xx || 8260
+	default "0x1000000" if 44x
+	default "0x800000"
 
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
Index: linux-2.6/arch/sh/Kconfig
===================================================================
--- linux-2.6.orig/arch/sh/Kconfig
+++ linux-2.6/arch/sh/Kconfig
@@ -753,16 +753,16 @@ menu "Boot options"
 
 config ZERO_PAGE_OFFSET
 	hex "Zero page offset"
-	default "0x00004000" if SH_SH03
-	default "0x00010000" if PAGE_SIZE_64KB
-	default "0x00002000" if PAGE_SIZE_8KB
-	default "0x00001000"
+	default "0x4000" if SH_SH03
+	default "0x10000" if PAGE_SIZE_64KB
+	default "0x2000" if PAGE_SIZE_8KB
+	default "0x1000"
 	help
 	  This sets the default offset of zero page.
 
 config BOOT_LINK_OFFSET
 	hex "Link address offset for booting"
-	default "0x00800000"
+	default "0x800000"
 	help
 	  This option allows you to set the link address offset of the zImage.
 	  This can be useful if you are on a board which has a small amount of
Index: linux-2.6/arch/sh/Kconfig.debug
===================================================================
--- linux-2.6.orig/arch/sh/Kconfig.debug
+++ linux-2.6/arch/sh/Kconfig.debug
@@ -41,7 +41,7 @@ config EARLY_SCIF_CONSOLE_PORT
 	default "0xffea0000" if CPU_SUBTYPE_SH7785
 	default "0xfffe8000" if CPU_SUBTYPE_SH7203
 	default "0xfffe9800" if CPU_SUBTYPE_SH7206 || CPU_SUBTYPE_SH7263
-	default "0x00000000"
+	default "0"
 
 config EARLY_PRINTK
 	bool "Early printk support"
Index: linux-2.6/arch/sh/mm/Kconfig
===================================================================
--- linux-2.6.orig/arch/sh/mm/Kconfig
+++ linux-2.6/arch/sh/mm/Kconfig
@@ -19,11 +19,11 @@ config PAGE_OFFSET
 	hex
 	default "0x80000000" if MMU && SUPERH32
 	default "0x20000000" if MMU && SUPERH64
-	default "0x00000000"
+	default "0"
 
 config MEMORY_START
 	hex "Physical memory start address"
-	default "0x08000000"
+	default "0x8000000"
 	---help---
 	  Computers built with Hitachi SuperH processors always
 	  map the ROM starting at address zero.  But the processor
@@ -39,7 +39,7 @@ config MEMORY_START
 
 config MEMORY_SIZE
 	hex "Physical memory size"
-	default "0x04000000"
+	default "0x4000000"
 	help
 	  This sets the default memory size assumed by your SH kernel. It can
 	  be overridden as normal by the 'mem=' argument on the kernel command
Index: linux-2.6/include/asm-powerpc/page.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/page.h
+++ linux-2.6/include/asm-powerpc/page.h
@@ -67,9 +67,15 @@
  * If you want to test if something's a kernel address, use is_kernel_addr().
  */
 
-#define KERNELBASE      ASM_CONST(CONFIG_KERNEL_START)
+#ifdef CONFIG_PPC64
+#define PAGE_OFFSET	(ASM_CONST(CONFIG_PAGE_OFFSET) << 32)
+#define KERNELBASE	(PAGE_OFFSET+ASM_CONST(CONFIG_PHYSICAL_START))
+#define LOAD_OFFSET	PAGE_OFFSET
+#else
+#define KERNELBASE	ASM_CONST(CONFIG_KERNEL_START)
 #define PAGE_OFFSET	ASM_CONST(CONFIG_PAGE_OFFSET)
-#define LOAD_OFFSET	ASM_CONST((CONFIG_KERNEL_START-CONFIG_PHYSICAL_START))
+#define LOAD_OFFSET	(ASM_CONST(CONFIG_KERNEL_START)-ASM_CONST(CONFIG_PHYSICAL_START))
+#endif
 
 #if defined(CONFIG_RELOCATABLE) && defined(CONFIG_FLATMEM)
 #ifndef __ASSEMBLY__
