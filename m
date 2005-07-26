Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id D33F367D16
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 02:06:26 +1000 (EST)
Received: from rhino.az.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA06844
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jul 2005 09:06:15 -0700
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1122393818.22059.38.camel@rhino.az.mvista.com>
References: <1122393448.22059.32.camel@rhino.az.mvista.com>
	<1122393818.22059.38.camel@rhino.az.mvista.com>
Content-Type: multipart/mixed; boundary="=-1ra3/wirp0dGivvVCOZ2"
Message-Id: <1122393974.10004.41.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 26 Jul 2005 09:06:14 -0700
Subject: Re: [PATCH 3/3] MTD support for the Bamboo board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--=-1ra3/wirp0dGivvVCOZ2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds MTD support for the Bamboo board.

Signed-off by: Wade Farnsworth <wfarnsworth@mvista.com>

--=-1ra3/wirp0dGivvVCOZ2
Content-Disposition: attachment; filename=440ep-mtd.patch
Content-Type: text/x-patch; name=440ep-mtd.patch
Content-Transfer-Encoding: 7bit

diff -uprN linux-2.6.12/drivers/mtd/maps/Kconfig linux-2.6.12-440ep/drivers/mtd/maps/Kconfig
--- linux-2.6.12/drivers/mtd/maps/Kconfig	2005-07-25 12:57:05.000000000 -0700
+++ linux-2.6.12-440ep/drivers/mtd/maps/Kconfig	2005-07-25 11:32:32.000000000 -0700
@@ -331,6 +331,13 @@ config MTD_OCOTEA
 	  This enables access routines for the flash chips on the IBM 440GX
 	  Ocotea board. If you have one of these boards and would like to
 	  use the flash chips on it, say 'Y'.
+config MTD_BAMBOO
+	tristate "Flash devices mapped on IBM 440EP Bamboo"
+	depends on MTD_CFI && PPC32 && 44x && BAMBOO
+	help
+	  This enables access routined for the flash chips on the IBM 440EP
+	  Bamboo board.  If you have one of these boards and would like to
+	  use the flash chips on it, say 'Y'.
 
 config MTD_REDWOOD
 	tristate "CFI Flash devices mapped on IBM Redwood"
diff -uprN linux-2.6.12/drivers/mtd/maps/Kconfig.orig linux-2.6.12-440ep/drivers/mtd/maps/Kconfig.orig
--- linux-2.6.12/drivers/mtd/maps/Kconfig.orig	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.12-440ep/drivers/mtd/maps/Kconfig.orig	2005-07-25 11:31:51.000000000 -0700
@@ -0,0 +1,628 @@
+# drivers/mtd/maps/Kconfig
+# $Id: Kconfig,v 1.55 2005/07/02 01:53:24 tpoynor Exp $
+
+menu "Mapping drivers for chip access"
+	depends on MTD!=n
+
+config MTD_COMPLEX_MAPPINGS
+	bool "Support non-linear mappings of flash chips"
+	depends on MTD
+	help
+	  This causes the chip drivers to allow for complicated
+	  paged mappings of flash chips.
+
+config MTD_PHYSMAP
+	tristate "CFI Flash device in physical memory map"
+	depends on MTD_CFI
+	help
+	  This provides a 'mapping' driver which allows the CFI probe and
+	  command set driver code to communicate with flash chips which
+	  are mapped physically into the CPU's memory. You will need to
+	  configure the physical address and size of the flash chips on
+	  your particular board as well as the bus width, either statically
+	  with config options or at run-time.
+
+config MTD_PHYSMAP_START
+	hex "Physical start address of flash mapping"
+	depends on MTD_PHYSMAP
+	default "0x8000000"
+	help
+	  This is the physical memory location at which the flash chips
+	  are mapped on your particular target board. Refer to the
+	  memory map which should hopefully be in the documentation for
+	  your board.
+	  Ignore this option if you use run-time physmap configuration
+	  (i.e., run-time calling physmap_configure()).
+
+config MTD_PHYSMAP_LEN
+	hex "Physical length of flash mapping"
+	depends on MTD_PHYSMAP
+	default "0x4000000"
+	help
+	  This is the total length of the mapping of the flash chips on
+	  your particular board. If there is space, or aliases, in the
+	  physical memory map between the chips, this could be larger
+	  than the total amount of flash present. Refer to the memory
+	  map which should hopefully be in the documentation for your
+	  board.
+	  Ignore this option if you use run-time physmap configuration
+	  (i.e., run-time calling physmap_configure()).
+
+config MTD_PHYSMAP_BANKWIDTH
+	int "Bank width in octets"
+	depends on MTD_PHYSMAP
+	default "2"
+	help
+	  This is the total width of the data bus of the flash devices
+	  in octets. For example, if you have a data bus width of 32
+	  bits, you would set the bus width octect value to 4. This is
+	  used internally by the CFI drivers.
+	  Ignore this option if you use run-time physmap configuration
+	  (i.e., run-time calling physmap_configure()).
+
+config MTD_SUN_UFLASH
+	tristate "Sun Microsystems userflash support"
+	depends on (SPARC32 || SPARC64) && MTD_CFI
+	help
+	  This provides a 'mapping' driver which supports the way in 
+	  which user-programmable flash chips are connected on various 
+	  Sun Microsystems boardsets.  This driver will require CFI support 
+	  in the kernel, so if you did not enable CFI previously, do that now.
+
+config MTD_PNC2000
+	tristate "CFI Flash device mapped on Photron PNC-2000"
+	depends on X86 && MTD_CFI && MTD_PARTITIONS
+	help
+	  PNC-2000 is the name of Network Camera product from PHOTRON
+	  Ltd. in Japan. It uses CFI-compliant flash.
+
+config MTD_SC520CDP
+	tristate "CFI Flash device mapped on AMD SC520 CDP"
+	depends on X86 && MTD_CFI
+	help
+	  The SC520 CDP board has two banks of CFI-compliant chips and one
+	  Dual-in-line JEDEC chip. This 'mapping' driver supports that
+	  arrangement, implementing three MTD devices.
+
+config MTD_NETSC520
+	tristate "CFI Flash device mapped on AMD NetSc520"
+	depends on X86 && MTD_CFI && MTD_PARTITIONS
+	help
+	  This enables access routines for the flash chips on the AMD NetSc520
+	  demonstration board. If you have one of these boards and would like 
+	  to use the flash chips on it, say 'Y'.
+
+config MTD_TS5500
+	tristate "JEDEC Flash device mapped on Technologic Systems TS-5500"
+	depends on X86 && MTD_JEDECPROBE && MTD_PARTITIONS
+	help
+	  This provides a driver for the on-board flash of the Technologic
+	  System's TS-5500 board. The flash is split into 3 partitions
+	  which are accessed as separate MTD devices.
+
+	  mtd0 and mtd2 are the two BIOS drives. Unfortunately the BIOS
+	  uses a proprietary flash translation layer from General Software,
+	  which is not supported (the drives cannot be mounted). You can
+	  create your own file system (jffs for example), but the BIOS
+	  won't be able to boot from it.
+
+	  mtd1 allows you to reprogram your BIOS. BE VERY CAREFUL.
+
+	  Note that jumper 3 ("Write Enable Drive A") must be set
+	  otherwise detection won't succeeed.
+
+config MTD_SBC_GXX
+	tristate "CFI Flash device mapped on Arcom SBC-GXx boards"
+	depends on X86 && MTD_CFI_INTELEXT && MTD_PARTITIONS && MTD_COMPLEX_MAPPINGS
+	help
+	  This provides a driver for the on-board flash of Arcom Control
+	  Systems' SBC-GXn family of boards, formerly known as SBC-MediaGX.
+	  By default the flash is split into 3 partitions which are accessed
+	  as separate MTD devices. This board utilizes Intel StrataFlash.
+	  More info at
+	  <http://www.arcomcontrols.com/products/icp/pc104/processors/SBC_GX1.htm>.
+
+config MTD_LUBBOCK
+	tristate "CFI Flash device mapped on Intel Lubbock XScale eval board"
+	depends on ARCH_LUBBOCK && MTD_CFI_INTELEXT && MTD_PARTITIONS
+	help
+	  This provides a driver for the on-board flash of the Intel
+	  'Lubbock' XScale evaluation board.
+
+config MTD_MAINSTONE
+	tristate "CFI Flash device mapped on Intel Mainstone XScale eval board"
+	depends on MACH_MAINSTONE && MTD_CFI_INTELEXT
+	select MTD_PARTITIONS
+	help
+	  This provides a driver for the on-board flash of the Intel
+	  'Mainstone PXA27x evaluation board.
+
+config MTD_OCTAGON
+	tristate "JEDEC Flash device mapped on Octagon 5066 SBC"
+	depends on X86 && MTD_JEDEC && MTD_COMPLEX_MAPPINGS
+	help
+	  This provides a 'mapping' driver which supports the way in which
+	  the flash chips are connected in the Octagon-5066 Single Board
+	  Computer. More information on the board is available at
+	  <http://www.octagonsystems.com/CPUpages/5066.html>.
+
+config MTD_VMAX
+	tristate "JEDEC Flash device mapped on Tempustech VMAX SBC301"
+	depends on X86 && MTD_JEDEC && MTD_COMPLEX_MAPPINGS
+	help
+	  This provides a 'mapping' driver which supports the way in which
+	  the flash chips are connected in the Tempustech VMAX SBC301 Single
+	  Board Computer. More information on the board is available at
+	  <http://www.tempustech.com/>.
+
+config MTD_SCx200_DOCFLASH
+	tristate "Flash device mapped with DOCCS on NatSemi SCx200"
+	depends on SCx200 && MTD_CFI && MTD_PARTITIONS
+	help
+	  Enable support for a flash chip mapped using the DOCCS signal on a
+	  National Semiconductor SCx200 processor.
+
+	  If you don't know what to do here, say N.
+
+	  If compiled as a module, it will be called scx200_docflash.
+
+config MTD_AMD76XROM
+	tristate "BIOS flash chip on AMD76x southbridge"
+	depends on X86 && MTD_JEDECPROBE
+	help
+	  Support for treating the BIOS flash chip on AMD76x motherboards
+	  as an MTD device - with this you can reprogram your BIOS.
+
+	  BE VERY CAREFUL.
+
+config MTD_ICHXROM
+	tristate "BIOS flash chip on Intel Controller Hub 2/3/4/5"
+	depends on X86 && MTD_JEDECPROBE
+	help
+	  Support for treating the BIOS flash chip on ICHX motherboards
+	  as an MTD device - with this you can reprogram your BIOS.
+
+	  BE VERY CAREFUL.
+
+config MTD_SCB2_FLASH
+	tristate "BIOS flash chip on Intel SCB2 boards"
+	depends on X86 && MTD_JEDECPROBE
+	help
+	  Support for treating the BIOS flash chip on Intel SCB2 boards
+	  as an MTD device - with this you can reprogram your BIOS.
+
+	  BE VERY CAREFUL.
+
+config MTD_TSUNAMI
+	tristate "Flash chips on Tsunami TIG bus"
+	depends on ALPHA_TSUNAMI && MTD_COMPLEX_MAPPINGS
+	help
+	  Support for the flash chip on Tsunami TIG bus.
+
+config MTD_LASAT
+	tristate "Flash chips on LASAT board"
+	depends on LASAT
+	help
+	  Support for the flash chips on the Lasat 100 and 200 boards.
+
+config MTD_NETtel
+	tristate "CFI flash device on SnapGear/SecureEdge"
+	depends on X86 && MTD_PARTITIONS && MTD_JEDECPROBE
+	help
+	  Support for flash chips on NETtel/SecureEdge/SnapGear boards.
+
+config MTD_ALCHEMY
+	tristate '  AMD Alchemy Pb1xxx/Db1xxx/RDK MTD support' 
+	depends on MIPS && SOC_AU1X00
+	help
+	  Flash memory access on AMD Alchemy Pb/Db/RDK Reference Boards
+
+config MTD_DILNETPC
+	tristate "CFI Flash device mapped on DIL/Net PC"
+	depends on X86 && MTD_CONCAT && MTD_PARTITIONS && MTD_CFI_INTELEXT
+	help
+	  MTD map driver for SSV DIL/Net PC Boards "DNP" and "ADNP".
+	  For details, see <http://www.ssv-embedded.de/ssv/pc104/p169.htm>
+ 	  and <http://www.ssv-embedded.de/ssv/pc104/p170.htm>
+
+config MTD_DILNETPC_BOOTSIZE
+	hex "Size of DIL/Net PC flash boot partition"
+	depends on MTD_DILNETPC
+	default "0x80000"
+	help
+	  The amount of space taken up by the kernel or Etherboot
+	  on the DIL/Net PC flash chips.
+
+config MTD_L440GX
+	tristate "BIOS flash chip on Intel L440GX boards"
+	depends on X86 && MTD_JEDECPROBE
+	help
+	  Support for treating the BIOS flash chip on Intel L440GX motherboards
+	  as an MTD device - with this you can reprogram your BIOS.
+
+	  BE VERY CAREFUL.
+
+config MTD_SBC8240
+	tristate "Flash device on SBC8240"
+	depends on PPC32 && MTD_JEDECPROBE && 6xx && 8260
+	help
+          Flash access on the SBC8240 board from Wind River.  See
+          <http://www.windriver.com/products/sbc8240/>
+
+config MTD_TQM8XXL
+	tristate "CFI Flash device mapped on TQM8XXL"
+	depends on MTD_CFI && PPC32 && 8xx && TQM8xxL
+	help
+	  The TQM8xxL PowerPC board has up to two banks of CFI-compliant
+	  chips, currently uses AMD one. This 'mapping' driver supports
+	  that arrangement, allowing the CFI probe and command set driver
+	  code to communicate with the chips on the TQM8xxL board. More at
+	  <http://www.denx.de/embedded-ppc-en.html>.
+
+config MTD_RPXLITE
+	tristate "CFI Flash device mapped on RPX Lite or CLLF"
+	depends on MTD_CFI && PPC32 && 8xx && (RPXCLASSIC || RPXLITE)
+	help
+	  The RPXLite PowerPC board has CFI-compliant chips mapped in
+	  a strange sparse mapping. This 'mapping' driver supports that
+	  arrangement, allowing the CFI probe and command set driver code
+	  to communicate with the chips on the RPXLite board. More at
+	  <http://www.embeddedplanet.com/>.
+
+config MTD_MBX860
+	tristate "System flash on MBX860 board"
+	depends on MTD_CFI && PPC32 && 8xx && MBX
+	help
+	  This enables access routines for the flash chips on the Motorola
+	  MBX860 board. If you have one of these boards and would like
+	  to use the flash chips on it, say 'Y'.
+
+config MTD_DBOX2
+	tristate "CFI Flash device mapped on D-Box2"
+	depends on PPC32 && 8xx && DBOX2 && MTD_CFI_INTELSTD && MTD_CFI_INTELEXT && MTD_CFI_AMDSTD
+	help
+	  This enables access routines for the flash chips on the Nokia/Sagem
+	  D-Box 2 board. If you have one of these boards and would like to use
+	  the flash chips on it, say 'Y'.
+
+config MTD_CFI_FLAGADM
+	tristate "CFI Flash device mapping on FlagaDM"
+	depends on PPC32 && 8xx && MTD_CFI
+	help
+	  Mapping for the Flaga digital module. If you don't have one, ignore
+	  this setting.
+
+config MTD_BEECH
+	tristate "CFI Flash device mapped on IBM 405LP Beech"
+	depends on MTD_CFI && PPC32 && 40x && BEECH
+	help
+	  This enables access routines for the flash chips on the IBM
+	  405LP Beech board. If you have one of these boards and would like
+	  to use the flash chips on it, say 'Y'.
+
+config MTD_ARCTIC
+	tristate "CFI Flash device mapped on IBM 405LP Arctic"
+	depends on MTD_CFI && PPC32 && 40x && ARCTIC2
+	help
+	  This enables access routines for the flash chips on the IBM 405LP
+	  Arctic board. If you have one of these boards and would like to
+	  use the flash chips on it, say 'Y'.
+
+config MTD_WALNUT
+	tristate "Flash device mapped on IBM 405GP Walnut"
+	depends on MTD_JEDECPROBE && PPC32 && 40x && WALNUT
+	help
+	  This enables access routines for the flash chips on the IBM 405GP
+	  Walnut board. If you have one of these boards and would like to
+	  use the flash chips on it, say 'Y'.
+
+config MTD_EBONY
+	tristate "Flash devices mapped on IBM 440GP Ebony"
+	depends on MTD_JEDECPROBE && PPC32 && 44x && EBONY
+	help
+	  This enables access routines for the flash chips on the IBM 440GP
+	  Ebony board. If you have one of these boards and would like to
+	  use the flash chips on it, say 'Y'.
+
+config MTD_OCOTEA
+	tristate "Flash devices mapped on IBM 440GX Ocotea"
+	depends on MTD_CFI && PPC32 && 44x && OCOTEA
+	help
+	  This enables access routines for the flash chips on the IBM 440GX
+	  Ocotea board. If you have one of these boards and would like to
+	  use the flash chips on it, say 'Y'.
+
+config MTD_REDWOOD
+	tristate "CFI Flash devices mapped on IBM Redwood"
+	depends on MTD_CFI && PPC32 && 4xx && 40x && ( REDWOOD_4 || REDWOOD_5 || REDWOOD_6 )
+	help
+	  This enables access routines for the flash chips on the IBM
+	  Redwood board. If you have one of these boards and would like to
+	  use the flash chips on it, say 'Y'.
+
+config MTD_CSTM_MIPS_IXX
+	tristate "Flash chip mapping on ITE QED-4N-S01B, Globespan IVR or custom board"
+	depends on MIPS && MTD_CFI && MTD_JEDECPROBE && MTD_PARTITIONS
+	help
+	  This provides a mapping driver for the Integrated Technology
+	  Express, Inc (ITE) QED-4N-S01B eval board and the Globespan IVR
+	  Reference Board. It provides the necessary addressing, length,
+	  buswidth, vpp code and addition setup of the flash device for
+	  these boards. In addition, this mapping driver can be used for
+	  other boards via setting of the CONFIG_MTD_CSTM_MIPS_IXX_START/
+	  LEN/BUSWIDTH parameters. This mapping will provide one mtd device
+	  using one partition. The start address can be offset from the
+	  beginning of flash and the len can be less than the total flash
+	  device size to allow a window into the flash. Both CFI and JEDEC
+	  probes are called.
+
+config MTD_CSTM_MIPS_IXX_START
+	hex "Physical start address of flash mapping"
+	depends on MTD_CSTM_MIPS_IXX
+	default "0x8000000"
+	help
+	  This is the physical memory location that the MTD driver will
+	  use for the flash chips on your particular target board. 
+	  Refer to the memory map which should hopefully be in the 
+	  documentation for your board.
+
+config MTD_CSTM_MIPS_IXX_LEN
+	hex "Physical length of flash mapping"
+	depends on MTD_CSTM_MIPS_IXX
+	default "0x4000000"
+	help
+	  This is the total length that the MTD driver will use for the 
+	  flash chips on your particular board.  Refer to the memory
+	  map which should hopefully be in the documentation for your
+	  board.
+
+config MTD_CSTM_MIPS_IXX_BUSWIDTH
+	int "Bus width in octets"
+	depends on MTD_CSTM_MIPS_IXX
+	default "2"
+	help
+	  This is the total bus width of the mapping of the flash chips
+	  on your particular board.
+
+config MTD_OCELOT
+	tristate "Momenco Ocelot boot flash device"
+	depends on MIPS && MOMENCO_OCELOT
+	help
+	  This enables access routines for the boot flash device and for the
+	  NVRAM on the Momenco Ocelot board. If you have one of these boards
+	  and would like access to either of these, say 'Y'.
+
+config MTD_SOLUTIONENGINE
+	tristate "CFI Flash device mapped on Hitachi SolutionEngine"
+	depends on SUPERH && MTD_CFI && MTD_REDBOOT_PARTS
+	help
+	  This enables access to the flash chips on the Hitachi SolutionEngine and
+	  similar boards. Say 'Y' if you are building a kernel for such a board.
+
+config MTD_ARM_INTEGRATOR
+	tristate "CFI Flash device mapped on ARM Integrator/P720T"
+	depends on ARM && MTD_CFI
+
+config MTD_CDB89712
+	tristate "Cirrus CDB89712 evaluation board mappings"
+	depends on ARM && MTD_CFI && ARCH_CDB89712
+	help
+	  This enables access to the flash or ROM chips on the CDB89712 board.
+	  If you have such a board, say 'Y'.
+
+config MTD_SA1100
+	tristate "CFI Flash device mapped on StrongARM SA11x0"
+	depends on ARM && MTD_CFI && ARCH_SA1100 && MTD_PARTITIONS
+	help
+	  This enables access to the flash chips on most platforms based on
+	  the SA1100 and SA1110, including the Assabet and the Compaq iPAQ.
+	  If you have such a board, say 'Y'.
+
+config MTD_IPAQ
+	tristate "CFI Flash device mapped on Compaq/HP iPAQ"
+	depends on ARM && IPAQ_HANDHELD && MTD_CFI
+	help
+	  This provides a driver for the on-board flash of the iPAQ.
+
+config MTD_DC21285
+	tristate "CFI Flash device mapped on DC21285 Footbridge"
+	depends on ARM && MTD_CFI && ARCH_FOOTBRIDGE && MTD_COMPLEX_MAPPINGS
+	help
+	  This provides a driver for the flash accessed using Intel's
+	  21285 bridge used with Intel's StrongARM processors. More info at
+	  <http://www.intel.com/design/bridge/docs/21285_documentation.htm>.
+
+config MTD_IQ80310
+	tristate "CFI Flash device mapped on the XScale IQ80310 board"
+	depends on ARM && MTD_CFI && ARCH_IQ80310
+	help
+	  This enables access routines for the flash chips on the Intel XScale
+	  IQ80310 evaluation board. If you have one of these boards and would 
+	  like to use the flash chips on it, say 'Y'.
+
+config MTD_IXP4XX
+	tristate "CFI Flash device mapped on Intel IXP4xx based systems"
+	depends on ARM && MTD_CFI && MTD_COMPLEX_MAPPINGS && ARCH_IXP4XX
+	help
+	  This enables MTD access to flash devices on platforms based 
+	  on Intel's IXP4xx family of network processors such as the
+	  IXDP425 and Coyote. If you have an IXP4xx based board and
+	  would like to use the flash chips on it, say 'Y'.
+
+config MTD_IXP2000
+	tristate "CFI Flash device mapped on Intel IXP2000 based systems"
+	depends on ARM && MTD_CFI && MTD_COMPLEX_MAPPINGS && ARCH_IXP2000
+	help
+	  This enables MTD access to flash devices on platforms based 
+	  on Intel's IXP2000 family of network processors such as the
+	  IXDP425 and Coyote. If you have an IXP2000 based board and
+	  would like to use the flash chips on it, say 'Y'.
+
+config MTD_EPXA10DB
+	tristate "CFI Flash device mapped on Epxa10db"
+	depends on ARM && MTD_CFI && MTD_PARTITIONS && ARCH_CAMELOT
+	help
+	  This enables support for the flash devices on the Altera
+	  Excalibur XA10 Development Board. If you are building a kernel
+	  for on of these boards then you should say 'Y' otherwise say 'N'.
+
+config MTD_FORTUNET
+	tristate "CFI Flash device mapped on the FortuNet board"
+	depends on ARM && MTD_CFI && MTD_PARTITIONS && SA1100_FORTUNET
+	help
+	  This enables access to the Flash on the FortuNet board.  If you
+	  have such a board, say 'Y'.
+
+config MTD_AUTCPU12
+	tristate "NV-RAM mapping AUTCPU12 board"
+	depends on ARM && ARCH_AUTCPU12
+	help
+	  This enables access to the NV-RAM on autronix autcpu12 board.
+	  If you have such a board, say 'Y'.
+
+config MTD_EDB7312
+	tristate "CFI Flash device mapped on EDB7312"
+	depends on ARM && MTD_CFI
+	help
+	  This enables access to the CFI Flash on the Cogent EDB7312 board.
+	  If you have such a board, say 'Y' here.
+
+config MTD_IMPA7
+	tristate "JEDEC Flash device mapped on impA7"
+	depends on ARM && MTD_JEDECPROBE
+	help
+	  This enables access to the NOR Flash on the impA7 board of
+	  implementa GmbH. If you have such a board, say 'Y' here.
+
+config MTD_CEIVA
+	tristate "JEDEC Flash device mapped on Ceiva/Polaroid PhotoMax Digital Picture Frame"
+	depends on ARM && MTD_JEDECPROBE && ARCH_CEIVA
+	help
+	  This enables access to the flash chips on the Ceiva/Polaroid
+	  PhotoMax Digital Picture Frame.
+	  If you have such a device, say 'Y'.
+
+config MTD_NOR_TOTO
+	tristate "NOR Flash device on TOTO board"
+	depends on ARM && ARCH_OMAP && OMAP_TOTO
+	help
+	  This enables access to the NOR flash on the Texas Instruments
+	  TOTO board.
+
+config MTD_H720X
+	tristate "Hynix evaluation board mappings"
+	depends on ARM && MTD_CFI && ( ARCH_H7201 || ARCH_H7202 )
+	help
+	  This enables access to the flash chips on the Hynix evaluation boards.
+	  If you have such a board, say 'Y'.
+
+config MTD_MPC1211
+	tristate "CFI Flash device mapped on Interface MPC-1211"
+	depends on SUPERH && SH_MPC1211 && MTD_CFI
+	help
+	  This enables access to the flash chips on the Interface MPC-1211(CTP/PCI/MPC-SH02).
+	  If you have such a board, say 'Y'.
+
+config MTD_OMAP_NOR
+	tristate "TI OMAP board mappings"
+	depends on MTD_CFI && ARCH_OMAP
+	help
+	  This enables access to the NOR flash chips on TI OMAP-based
+	  boards defining flash platform devices and flash platform data.
+	  These boards include the Innovator, H2, H3, OSK, Perseus2, and
+	  more.  If you have such a board, say 'Y'.
+
+# This needs CFI or JEDEC, depending on the cards found.
+config MTD_PCI
+	tristate "PCI MTD driver"
+	depends on MTD && PCI && MTD_COMPLEX_MAPPINGS
+	help
+	  Mapping for accessing flash devices on add-in cards like the Intel XScale
+	  IQ80310 card, and the Intel EBSA285 card in blank ROM programming mode
+	  (please see the manual for the link settings).
+
+	  If you are not sure, say N.
+
+config MTD_PCMCIA
+	tristate "PCMCIA MTD driver"
+	depends on MTD && PCMCIA && MTD_COMPLEX_MAPPINGS && BROKEN
+	help
+	  Map driver for accessing PCMCIA linear flash memory cards. These
+	  cards are usually around 4-16MiB in size. This does not include
+	  Compact Flash cards which are treated as IDE devices.
+
+config MTD_PCMCIA_ANONYMOUS
+	bool "Use PCMCIA MTD drivers for anonymous PCMCIA cards"
+	depends on MTD_PCMCIA
+	default N
+	help
+	  If this option is enabled, PCMCIA cards which do not report
+	  anything about themselves are assumed to be MTD cards.
+
+	  If unsure, say N.
+
+config MTD_UCLINUX
+	tristate "Generic uClinux RAM/ROM filesystem support"
+	depends on MTD_PARTITIONS && !MMU
+	help
+	  Map driver to support image based filesystems for uClinux.
+
+config MTD_WRSBC8260
+	tristate "Map driver for WindRiver PowerQUICC II MPC82xx board"
+	depends on (SBC82xx || SBC8560)
+	select MTD_PARTITIONS
+	select MTD_MAP_BANK_WIDTH_4
+	select MTD_MAP_BANK_WIDTH_1
+	select MTD_CFI_I1
+	select MTD_CFI_I4
+	help
+	  Map driver for WindRiver PowerQUICC II MPC82xx board. Drives
+	  all three flash regions on CS0, CS1 and CS6 if they are configured
+	  correctly by the boot loader.
+
+config MTD_DMV182
+        tristate "Map driver for Dy-4 SVME/DMV-182 board."
+        depends on DMV182
+        select MTD_PARTITIONS
+	select MTD_MAP_BANK_WIDTH_32
+	select MTD_CFI_I8
+	select MTD_CFI_AMDSTD
+        help
+          Map driver for Dy-4 SVME/DMV-182 board.
+
+config MTD_BAST
+	tristate "Map driver for Simtec BAST (EB2410ITX) or Thorcom VR1000"
+	depends on ARCH_BAST || MACH_VR1000
+	select MTD_PARTITIONS
+	select MTD_MAP_BANK_WIDTH_16
+	select MTD_JEDECPROBE
+	help
+	  Map driver for NOR flash on the Simtec BAST (EB2410ITX), or the
+	  Thorcom VR1000
+
+	  Note, this driver *cannot* over-ride the WP link on the
+	  board, or currently detect the state of the link.
+
+config MTD_BAST_MAXSIZE
+	int "Maximum size for BAST flash area (MiB)"
+	depends on MTD_BAST
+	default "4"
+
+config MTD_SHARP_SL
+	bool "ROM maped on Sharp SL Series"
+	depends on MTD && ARCH_PXA
+	help
+	  This enables access to the flash chip on the Sharp SL Series of PDAs.
+
+config MTD_PLATRAM
+	tristate "Map driver for platform device RAM (mtd-ram)"
+	depends on MTD
+	select MTD_RAM
+	help
+	  Map driver for RAM areas described via the platform device
+	  system.
+
+	  This selection automatically selects the map_ram driver.
+
+endmenu
+
diff -uprN linux-2.6.12/drivers/mtd/maps/Makefile linux-2.6.12-440ep/drivers/mtd/maps/Makefile
--- linux-2.6.12/drivers/mtd/maps/Makefile	2005-07-25 12:57:05.000000000 -0700
+++ linux-2.6.12-440ep/drivers/mtd/maps/Makefile	2005-07-25 11:32:32.000000000 -0700
@@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NETtel)	+= nettel.o
 obj-$(CONFIG_MTD_SCB2_FLASH)	+= scb2_flash.o
 obj-$(CONFIG_MTD_EBONY)		+= ebony.o
 obj-$(CONFIG_MTD_OCOTEA)	+= ocotea.o
+obj-$(CONFIG_MTD_BAMBOO)	+= bamboo.o
 obj-$(CONFIG_MTD_BEECH)		+= beech-mtd.o
 obj-$(CONFIG_MTD_ARCTIC)	+= arctic-mtd.o
 obj-$(CONFIG_MTD_WALNUT)        += walnut.o
diff -uprN linux-2.6.12/drivers/mtd/maps/Makefile.orig linux-2.6.12-440ep/drivers/mtd/maps/Makefile.orig
--- linux-2.6.12/drivers/mtd/maps/Makefile.orig	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.12-440ep/drivers/mtd/maps/Makefile.orig	2005-07-25 11:31:51.000000000 -0700
@@ -0,0 +1,72 @@
+#
+# linux/drivers/maps/Makefile
+#
+# $Id: Makefile.common,v 1.30 2005/07/02 01:53:24 tpoynor Exp $
+
+ifeq ($(CONFIG_MTD_COMPLEX_MAPPINGS),y)
+obj-$(CONFIG_MTD)		+= map_funcs.o
+endif
+
+# Chip mappings
+obj-$(CONFIG_MTD_CDB89712)	+= cdb89712.o
+obj-$(CONFIG_MTD_ARM_INTEGRATOR)+= integrator-flash.o
+obj-$(CONFIG_MTD_BAST)		+= bast-flash.o
+obj-$(CONFIG_MTD_CFI_FLAGADM)	+= cfi_flagadm.o
+obj-$(CONFIG_MTD_CSTM_MIPS_IXX)	+= cstm_mips_ixx.o
+obj-$(CONFIG_MTD_DC21285)	+= dc21285.o
+obj-$(CONFIG_MTD_DILNETPC)	+= dilnetpc.o
+obj-$(CONFIG_MTD_EPXA10DB)	+= epxa10db-flash.o
+obj-$(CONFIG_MTD_IQ80310)	+= iq80310.o
+obj-$(CONFIG_MTD_L440GX)	+= l440gx.o
+obj-$(CONFIG_MTD_AMD76XROM)	+= amd76xrom.o
+obj-$(CONFIG_MTD_ICHXROM)	+= ichxrom.o
+obj-$(CONFIG_MTD_TSUNAMI)	+= tsunami_flash.o
+obj-$(CONFIG_MTD_LUBBOCK)	+= lubbock-flash.o
+obj-$(CONFIG_MTD_MAINSTONE)	+= mainstone-flash.o
+obj-$(CONFIG_MTD_MBX860)	+= mbx860.o
+obj-$(CONFIG_MTD_CEIVA)		+= ceiva.o
+obj-$(CONFIG_MTD_OCTAGON)	+= octagon-5066.o
+obj-$(CONFIG_MTD_PHYSMAP)	+= physmap.o 
+obj-$(CONFIG_MTD_PNC2000)	+= pnc2000.o
+obj-$(CONFIG_MTD_PCMCIA)	+= pcmciamtd.o
+obj-$(CONFIG_MTD_RPXLITE)	+= rpxlite.o
+obj-$(CONFIG_MTD_TQM8XXL)	+= tqm8xxl.o
+obj-$(CONFIG_MTD_SA1100)	+= sa1100-flash.o
+obj-$(CONFIG_MTD_IPAQ)		+= ipaq-flash.o
+obj-$(CONFIG_MTD_SBC_GXX)	+= sbc_gxx.o
+obj-$(CONFIG_MTD_SC520CDP)	+= sc520cdp.o
+obj-$(CONFIG_MTD_NETSC520)	+= netsc520.o
+obj-$(CONFIG_MTD_TS5500)	+= ts5500_flash.o
+obj-$(CONFIG_MTD_SUN_UFLASH)	+= sun_uflash.o
+obj-$(CONFIG_MTD_VMAX)		+= vmax301.o
+obj-$(CONFIG_MTD_SCx200_DOCFLASH)+= scx200_docflash.o
+obj-$(CONFIG_MTD_DBOX2)		+= dbox2-flash.o
+obj-$(CONFIG_MTD_OCELOT)	+= ocelot.o
+obj-$(CONFIG_MTD_SOLUTIONENGINE)+= solutionengine.o
+obj-$(CONFIG_MTD_PCI)		+= pci.o
+obj-$(CONFIG_MTD_ALCHEMY)       += alchemy-flash.o
+obj-$(CONFIG_MTD_LASAT)		+= lasat.o
+obj-$(CONFIG_MTD_AUTCPU12)	+= autcpu12-nvram.o
+obj-$(CONFIG_MTD_EDB7312)	+= edb7312.o
+obj-$(CONFIG_MTD_IMPA7)		+= impa7.o
+obj-$(CONFIG_MTD_FORTUNET)	+= fortunet.o
+obj-$(CONFIG_MTD_REDWOOD)	+= redwood.o
+obj-$(CONFIG_MTD_UCLINUX)	+= uclinux.o
+obj-$(CONFIG_MTD_NETtel)	+= nettel.o
+obj-$(CONFIG_MTD_SCB2_FLASH)	+= scb2_flash.o
+obj-$(CONFIG_MTD_EBONY)		+= ebony.o
+obj-$(CONFIG_MTD_OCOTEA)	+= ocotea.o
+obj-$(CONFIG_MTD_BEECH)		+= beech-mtd.o
+obj-$(CONFIG_MTD_ARCTIC)	+= arctic-mtd.o
+obj-$(CONFIG_MTD_WALNUT)        += walnut.o
+obj-$(CONFIG_MTD_H720X)		+= h720x-flash.o
+obj-$(CONFIG_MTD_SBC8240)	+= sbc8240.o
+obj-$(CONFIG_MTD_NOR_TOTO)	+= omap-toto-flash.o
+obj-$(CONFIG_MTD_MPC1211)	+= mpc1211.o
+obj-$(CONFIG_MTD_IXP4XX)	+= ixp4xx.o
+obj-$(CONFIG_MTD_IXP2000)	+= ixp2000.o
+obj-$(CONFIG_MTD_WRSBC8260)	+= wr_sbc82xx_flash.o
+obj-$(CONFIG_MTD_DMV182)	+= dmv182.o
+obj-$(CONFIG_MTD_SHARP_SL)	+= sharpsl-flash.o
+obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
+obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
diff -uprN linux-2.6.12/drivers/mtd/maps/bamboo.c linux-2.6.12-440ep/drivers/mtd/maps/bamboo.c
--- linux-2.6.12/drivers/mtd/maps/bamboo.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.12-440ep/drivers/mtd/maps/bamboo.c	2005-07-25 11:32:32.000000000 -0700
@@ -0,0 +1,245 @@
+/*
+ * Mapping for Bamboo user flash
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ *
+ * Copyright 2005 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+#include <linux/config.h>
+#include <asm/io.h>
+#include <asm/ibm44x.h>
+#include <platforms/4xx/bamboo.h>
+
+static struct mtd_info *small_flash, *large_flash, *sram;
+
+static struct map_info bamboo_small_map = {
+	.name = "Bamboo small flash",
+	.size = BAMBOO_SMALL_FLASH_SIZE,
+	.bankwidth = 1,
+};
+
+static struct map_info bamboo_large_map = {
+	.name = "Bamboo large flash",
+	.size = BAMBOO_LARGE_FLASH_SIZE,
+	.bankwidth = 2,
+};
+
+static struct map_info bamboo_sram_map = {
+	.name = "Bamboo SRAM",
+	.size = BAMBOO_SRAM_SIZE,
+	.bankwidth = 2,
+};
+
+static struct mtd_partition bamboo_small_partitions[] = {
+	{
+		.name = "pibs",
+		.offset = 0x0,
+		.size = 0x100000,
+		.mask_flags = MTD_WRITEABLE,
+	}
+};
+
+static struct mtd_partition bamboo_large_partitions[] = {
+	{
+	 	.name = "filesystem",
+	 	.offset = 0x0,
+	 	.size = 0x400000,
+	}
+};
+
+static struct mtd_partition bamboo_sram_partitions[] = {
+	{
+	 	.name = "sram",
+	 	.offset = 0x0,
+	 	.size = 0x100000,
+	}
+};
+
+int __init
+init_bamboo(void)
+{
+	u8 setting_reg;
+	u8 *setting_adr;
+	unsigned long small_flash_base, large_flash_base, sram_base;
+	unsigned long *gpio_base;
+
+	setting_adr = ioremap64(BAMBOO_FPGA_SETTING_REG_ADDR, 8);
+	if (!setting_adr)
+		return -ENOMEM;
+	setting_reg = readb(setting_adr);
+	iounmap(setting_adr);
+
+	/* 
+	 * Some versions of PIBS don't set up the GPIO controller
+	 * for the devices on chip select 4 (large flash and sram).
+	 */
+	gpio_base = ioremap64(0x0EF600B00ULL, 0x80);
+	if (!gpio_base) {
+		printk("Failed to ioremap GPIO\n");
+		return -ENOMEM;
+	}
+	* (gpio_base + 0x02) |= 0x00001000;
+	* (gpio_base + 0x04) |= 0x00001000;
+	iounmap((void *) gpio_base);
+
+	/* 
+	 * Use the values in the FPGA Setting Register to determine where
+	 * each flash bank is located.
+	 */
+	if (!BAMBOO_BOOT_NAND_FLASH(setting_reg)) {
+		if (BAMBOO_BOOT_SMALL_FLASH(setting_reg)) {
+			small_flash_base = BAMBOO_SMALL_FLASH_HIGH;
+		} else {
+			small_flash_base = BAMBOO_SMALL_FLASH_LOW;
+		}
+
+		bamboo_small_map.phys = small_flash_base;
+		bamboo_small_map.virt = 
+			(ulong *) ioremap64(small_flash_base, 
+					    bamboo_small_map.size);
+		if (!bamboo_small_map.virt) {
+			printk("Failed to ioremap flash\n");
+			return -EIO;
+		}
+
+		simple_map_init(&bamboo_small_map);
+
+		small_flash = do_map_probe("map_rom", &bamboo_small_map);
+		if (small_flash) {
+			small_flash->owner = THIS_MODULE;
+			add_mtd_partitions(small_flash, bamboo_small_partitions,
+					   ARRAY_SIZE(bamboo_small_partitions));
+		} else {
+			printk(KERN_INFO
+			       "small flash disabled: Probe failed due to probable hardware issue\n");
+			iounmap((void *) bamboo_small_map.virt);
+			bamboo_small_map.virt = 0;
+		}
+	} else
+		bamboo_small_map.virt = 0;
+
+	/* 
+	 * Wiring to the large flash on the Rev 0 Bamboo is incorrect, so 
+	 * this should fail.
+	 *
+	 * This has been fixed on the Rev 1.
+	 */
+	if (BAMBOO_BOOT_NAND_FLASH(setting_reg) ||
+	    BAMBOO_BOOT_SMALL_FLASH(setting_reg))
+		large_flash_base = BAMBOO_LARGE_FLASH_LOW;
+	else if (BAMBOO_LARGE_FLASH_EN(setting_reg))
+		large_flash_base = BAMBOO_LARGE_FLASH_HIGH1;
+	else
+		large_flash_base = BAMBOO_LARGE_FLASH_HIGH2;
+	bamboo_large_map.phys = large_flash_base;
+	bamboo_large_map.virt = (ulong *) ioremap64(large_flash_base, 
+						    bamboo_large_map.size);
+	if (!bamboo_large_map.virt) {
+		printk("Failed to ioremap flash\n");
+		return -EIO;
+	}
+
+	simple_map_init(&bamboo_large_map);
+	large_flash = do_map_probe("cfi_probe", &bamboo_large_map);
+	if (large_flash) {
+		large_flash->owner = THIS_MODULE;
+		add_mtd_partitions(large_flash, bamboo_large_partitions,
+				   ARRAY_SIZE(bamboo_large_partitions));
+	} else {
+		printk(KERN_INFO
+		       "large flash disabled: Probe failed due to probable hardware issue\n");
+		iounmap((void *) bamboo_large_map.virt);
+		bamboo_large_map.virt = 0;
+	}
+
+	if (BAMBOO_BOOT_NAND_FLASH(setting_reg) ||
+	    BAMBOO_BOOT_SMALL_FLASH(setting_reg))
+		sram_base = BAMBOO_SRAM_LOW;
+	else if (BAMBOO_LARGE_FLASH_EN(setting_reg))
+		sram_base = BAMBOO_SRAM_HIGH2;
+	else
+		sram_base = BAMBOO_SRAM_HIGH1;
+
+	bamboo_sram_map.phys = sram_base;
+	bamboo_sram_map.virt = (ulong *) ioremap64(sram_base, 
+						   bamboo_sram_map.size);
+	if (!bamboo_sram_map.virt) {
+		printk("Failed to ioremap flash \n");
+		return -EIO;
+	}
+
+	simple_map_init(&bamboo_sram_map);
+
+	sram = do_map_probe("map_ram", &bamboo_sram_map);
+	if (sram) {
+		sram->owner = THIS_MODULE;
+		sram->erasesize = 0x10;
+		add_mtd_partitions(sram, bamboo_sram_partitions,
+				   ARRAY_SIZE(bamboo_sram_partitions));
+	} else {
+		printk(KERN_INFO
+		       "sram disabled: Probe failed due to probable hardware issue\n");
+		iounmap((void *) bamboo_sram_map.virt);
+		bamboo_sram_map.virt = 0;
+	}
+
+	if (!(small_flash || large_flash || sram))
+		return -ENXIO;
+
+	return 0;
+}
+
+static void __exit
+cleanup_bamboo(void)
+{
+	if (small_flash) {
+		del_mtd_partitions(small_flash);
+		map_destroy(small_flash);
+	}
+
+	if (large_flash) {
+		del_mtd_partitions(large_flash);
+		map_destroy(large_flash);
+	}
+
+	if (sram) {
+		del_mtd_partitions(sram);
+		map_destroy(sram);
+	}
+
+	if (bamboo_small_map.virt) {
+		iounmap((void *) bamboo_small_map.virt);
+		bamboo_small_map.virt = 0;
+	}
+
+	if (bamboo_large_map.virt) {
+		iounmap((void *) bamboo_large_map.virt);
+		bamboo_large_map.virt = 0;
+	}
+
+	if (bamboo_sram_map.virt) {
+		iounmap((void *) bamboo_sram_map.virt);
+		bamboo_sram_map.virt = 0;
+	}
+}
+
+module_init(init_bamboo);
+module_exit(cleanup_bamboo);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Wade Farnsworth <wfarnsworth@mvista.com>");
+MODULE_DESCRIPTION("MTD map and partitions for IBM 440EP Bamboo boards");
diff -uprN linux-2.6.12/drivers/mtd/nand/Kconfig linux-2.6.12-440ep/drivers/mtd/nand/Kconfig
--- linux-2.6.12/drivers/mtd/nand/Kconfig	2005-07-25 12:57:05.000000000 -0700
+++ linux-2.6.12-440ep/drivers/mtd/nand/Kconfig	2005-07-25 11:32:32.000000000 -0700
@@ -109,6 +109,13 @@ config MTD_NAND_S3C2410_HWECC
 	  currently not be able to switch to software, as there is no
 	  implementation for ECC method used by the S3C2410
 
+config MTD_NAND_BAMBOO
+	tristate "NAND flash support on IBM/AMCC 440EP Eval Board (Bamboo)"
+	depends on BAMBOO && MTD_NAND
+	help
+	  This enables the NAND flash driver on the IBM/AMCC 440EP Eval Board
+	  (Bamboo).
+
 config MTD_NAND_DISKONCHIP
 	tristate "DiskOnChip 2000, Millennium and Millennium Plus (NAND reimplementation) (EXPERIMENTAL)"
 	depends on MTD_NAND && EXPERIMENTAL
diff -uprN linux-2.6.12/drivers/mtd/nand/Kconfig.orig linux-2.6.12-440ep/drivers/mtd/nand/Kconfig.orig
--- linux-2.6.12/drivers/mtd/nand/Kconfig.orig	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.12-440ep/drivers/mtd/nand/Kconfig.orig	2005-07-25 11:31:51.000000000 -0700
@@ -0,0 +1,194 @@
+# drivers/mtd/nand/Kconfig
+# $Id: Kconfig,v 1.31 2005/06/20 12:03:21 bjd Exp $
+
+menu "NAND Flash Device Drivers"
+	depends on MTD!=n
+
+config MTD_NAND
+	tristate "NAND Device Support"
+	depends on MTD
+	select MTD_NAND_IDS
+	help
+	  This enables support for accessing all type of NAND flash
+	  devices. For further information see
+	  <http://www.linux-mtd.infradead.org/tech/nand.html>.
+
+config MTD_NAND_VERIFY_WRITE
+	bool "Verify NAND page writes"
+	depends on MTD_NAND
+	help
+	  This adds an extra check when data is written to the flash. The
+	  NAND flash device internally checks only bits transitioning
+	  from 1 to 0. There is a rare possibility that even though the
+	  device thinks the write was successful, a bit could have been
+	  flipped accidentaly due to device wear or something else.
+
+config MTD_NAND_AUTCPU12
+	tristate "SmartMediaCard on autronix autcpu12 board"
+	depends on ARM && MTD_NAND && ARCH_AUTCPU12
+	help
+	  This enables the driver for the autronix autcpu12 board to 
+	  access the SmartMediaCard.
+
+config MTD_NAND_EDB7312
+	tristate "Support for Cirrus Logic EBD7312 evaluation board"
+	depends on ARM && MTD_NAND && ARCH_EDB7312
+	help
+	  This enables the driver for the Cirrus Logic EBD7312 evaluation 
+	  board to access the onboard NAND Flash.
+
+config MTD_NAND_H1900
+	tristate "iPAQ H1900 flash"
+	depends on ARM && MTD_NAND && ARCH_PXA && MTD_PARTITIONS
+	help
+	  This enables the driver for the iPAQ h1900 flash.
+
+config MTD_NAND_SPIA
+	tristate "NAND Flash device on SPIA board"
+	depends on ARM && ARCH_P720T && MTD_NAND
+	help
+	  If you had to ask, you don't have one. Say 'N'.
+
+config MTD_NAND_TOTO
+	tristate "NAND Flash device on TOTO board"
+	depends on ARM && ARCH_OMAP && MTD_NAND
+	help
+	  Support for NAND flash on Texas Instruments Toto platform.
+
+config MTD_NAND_IDS
+	tristate
+
+config MTD_NAND_AU1550
+	tristate "Au1550 NAND support"
+	depends on SOC_AU1550 && MTD_NAND
+	help
+	  This enables the driver for the NAND flash controller on the
+	  AMD/Alchemy 1550 SOC.
+
+config MTD_NAND_RTC_FROM4
+	tristate "Renesas Flash ROM 4-slot interface board (FROM_BOARD4)"
+	depends on MTD_NAND && SH_SOLUTION_ENGINE
+	select REED_SOLOMON
+	select REED_SOLOMON_DEC8
+	help
+	  This enables the driver for the Renesas Technology AG-AND 
+	  flash interface board (FROM_BOARD4)
+
+config MTD_NAND_PPCHAMELEONEVB
+	tristate "NAND Flash device on PPChameleonEVB board"
+	depends on PPCHAMELEONEVB && MTD_NAND
+	help
+	  This enables the NAND flash driver on the PPChameleon EVB Board.
+
+config MTD_NAND_S3C2410
+	tristate "NAND Flash support for S3C2410/S3C2440 SoC"
+	depends on ARCH_S3C2410 && MTD_NAND
+	help
+	  This enables the NAND flash controller on the S3C2410 and S3C2440
+	  SoCs
+
+	  No board specfic support is done by this driver, each board
+	  must advertise a platform_device for the driver to attach. 
+
+config MTD_NAND_S3C2410_DEBUG
+	bool "S3C2410 NAND driver debug"
+	depends on MTD_NAND_S3C2410
+	help
+	  Enable debugging of the S3C2410 NAND driver
+
+config MTD_NAND_S3C2410_HWECC
+	bool "S3C2410 NAND Hardware ECC"
+	depends on MTD_NAND_S3C2410
+	help
+	  Enable the use of the S3C2410's internal ECC generator when
+	  using NAND. Early versions of the chip have had problems with
+	  incorrect ECC generation, and if using these, the default of
+	  software ECC is preferable.
+
+	  If you lay down a device with the hardware ECC, then you will
+	  currently not be able to switch to software, as there is no
+	  implementation for ECC method used by the S3C2410
+
+config MTD_NAND_DISKONCHIP
+	tristate "DiskOnChip 2000, Millennium and Millennium Plus (NAND reimplementation) (EXPERIMENTAL)"
+	depends on MTD_NAND && EXPERIMENTAL
+	select REED_SOLOMON
+	select REED_SOLOMON_DEC16
+	help
+	  This is a reimplementation of M-Systems DiskOnChip 2000,
+	  Millennium and Millennium Plus as a standard NAND device driver,
+	  as opposed to the earlier self-contained MTD device drivers.
+	  This should enable, among other things, proper JFFS2 operation on
+	  these devices.
+
+config MTD_NAND_DISKONCHIP_PROBE_ADVANCED
+        bool "Advanced detection options for DiskOnChip"
+        depends on MTD_NAND_DISKONCHIP
+        help
+          This option allows you to specify nonstandard address at which to
+          probe for a DiskOnChip, or to change the detection options.  You
+          are unlikely to need any of this unless you are using LinuxBIOS.
+          Say 'N'.
+
+config MTD_NAND_DISKONCHIP_PROBE_ADDRESS
+        hex "Physical address of DiskOnChip" if MTD_NAND_DISKONCHIP_PROBE_ADVANCED
+        depends on MTD_NAND_DISKONCHIP
+        default "0"
+        ---help---
+        By default, the probe for DiskOnChip devices will look for a
+        DiskOnChip at every multiple of 0x2000 between 0xC8000 and 0xEE000.
+        This option allows you to specify a single address at which to probe
+        for the device, which is useful if you have other devices in that
+        range which get upset when they are probed.
+
+        (Note that on PowerPC, the normal probe will only check at
+        0xE4000000.)
+
+        Normally, you should leave this set to zero, to allow the probe at
+        the normal addresses.
+
+config MTD_NAND_DISKONCHIP_PROBE_HIGH
+        bool "Probe high addresses"
+        depends on MTD_NAND_DISKONCHIP_PROBE_ADVANCED
+        help
+          By default, the probe for DiskOnChip devices will look for a
+          DiskOnChip at every multiple of 0x2000 between 0xC8000 and 0xEE000.
+          This option changes to make it probe between 0xFFFC8000 and
+          0xFFFEE000.  Unless you are using LinuxBIOS, this is unlikely to be
+          useful to you.  Say 'N'.
+
+config MTD_NAND_DISKONCHIP_BBTWRITE
+	bool "Allow BBT writes on DiskOnChip Millennium and 2000TSOP"
+	depends on MTD_NAND_DISKONCHIP
+	help
+	  On DiskOnChip devices shipped with the INFTL filesystem (Millennium
+	  and 2000 TSOP/Alon), Linux reserves some space at the end of the
+	  device for the Bad Block Table (BBT).  If you have existing INFTL
+	  data on your device (created by non-Linux tools such as M-Systems'
+	  DOS drivers), your data might overlap the area Linux wants to use for
+	  the BBT.  If this is a concern for you, leave this option disabled and
+	  Linux will not write BBT data into this area.
+	  The downside of leaving this option disabled is that if bad blocks
+	  are detected by Linux, they will not be recorded in the BBT, which
+	  could cause future problems.
+	  Once you enable this option, new filesystems (INFTL or others, created
+	  in Linux or other operating systems) will not use the reserved area.
+	  The only reason not to enable this option is to prevent damage to
+	  preexisting filesystems.
+	  Even if you leave this disabled, you can enable BBT writes at module
+	  load time (assuming you build diskonchip as a module) with the module
+	  parameter "inftl_bbt_write=1".
+	  
+ config MTD_NAND_SHARPSL
+ 	bool "Support for NAND Flash on Sharp SL Series (C7xx + others)"
+ 	depends on MTD_NAND	&& ARCH_PXA
+ 
+ config MTD_NAND_NANDSIM
+ 	bool "Support for NAND Flash Simulator"
+ 	depends on MTD_NAND && MTD_PARTITIONS
+
+	help
+	  The simulator may simulate verious NAND flash chips for the
+	  MTD nand layer.
+ 
+endmenu
diff -uprN linux-2.6.12/drivers/mtd/nand/Makefile linux-2.6.12-440ep/drivers/mtd/nand/Makefile
--- linux-2.6.12/drivers/mtd/nand/Makefile	2005-07-25 12:57:05.000000000 -0700
+++ linux-2.6.12-440ep/drivers/mtd/nand/Makefile	2005-07-25 11:32:32.000000000 -0700
@@ -13,6 +13,7 @@ obj-$(CONFIG_MTD_NAND_EDB7312)		+= edb73
 obj-$(CONFIG_MTD_NAND_AU1550)		+= au1550nd.o
 obj-$(CONFIG_MTD_NAND_PPCHAMELEONEVB)	+= ppchameleonevb.o
 obj-$(CONFIG_MTD_NAND_S3C2410)		+= s3c2410.o
+obj-$(CONFIG_MTD_NAND_BAMBOO)		+= bamboo_nand.o
 obj-$(CONFIG_MTD_NAND_DISKONCHIP)	+= diskonchip.o
 obj-$(CONFIG_MTD_NAND_H1900)		+= h1910.o
 obj-$(CONFIG_MTD_NAND_RTC_FROM4)	+= rtc_from4.o
diff -uprN linux-2.6.12/drivers/mtd/nand/Makefile.orig linux-2.6.12-440ep/drivers/mtd/nand/Makefile.orig
--- linux-2.6.12/drivers/mtd/nand/Makefile.orig	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.12-440ep/drivers/mtd/nand/Makefile.orig	2005-07-25 11:31:51.000000000 -0700
@@ -0,0 +1,22 @@
+#
+# linux/drivers/nand/Makefile
+#
+# $Id: Makefile.common,v 1.15 2004/11/26 12:28:22 dedekind Exp $
+
+obj-$(CONFIG_MTD_NAND)			+= nand.o nand_ecc.o
+obj-$(CONFIG_MTD_NAND_IDS)		+= nand_ids.o
+
+obj-$(CONFIG_MTD_NAND_SPIA)		+= spia.o
+obj-$(CONFIG_MTD_NAND_TOTO)		+= toto.o
+obj-$(CONFIG_MTD_NAND_AUTCPU12)		+= autcpu12.o
+obj-$(CONFIG_MTD_NAND_EDB7312)		+= edb7312.o
+obj-$(CONFIG_MTD_NAND_AU1550)		+= au1550nd.o
+obj-$(CONFIG_MTD_NAND_PPCHAMELEONEVB)	+= ppchameleonevb.o
+obj-$(CONFIG_MTD_NAND_S3C2410)		+= s3c2410.o
+obj-$(CONFIG_MTD_NAND_DISKONCHIP)	+= diskonchip.o
+obj-$(CONFIG_MTD_NAND_H1900)		+= h1910.o
+obj-$(CONFIG_MTD_NAND_RTC_FROM4)	+= rtc_from4.o
+obj-$(CONFIG_MTD_NAND_SHARPSL)		+= sharpsl.o
+obj-$(CONFIG_MTD_NAND_NANDSIM)		+= nandsim.o
+
+nand-objs = nand_base.o nand_bbt.o
diff -uprN linux-2.6.12/drivers/mtd/nand/bamboo_nand.c linux-2.6.12-440ep/drivers/mtd/nand/bamboo_nand.c
--- linux-2.6.12/drivers/mtd/nand/bamboo_nand.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.12-440ep/drivers/mtd/nand/bamboo_nand.c	2005-07-25 11:32:32.000000000 -0700
@@ -0,0 +1,467 @@
+/*
+ *  drivers/mtd/bamboo_nand.c
+ *
+ *  Overview:
+ *   This is a device driver for the NAND flash devices found on the
+ *   IBM 440EP Evaluation Board (Bamboo).
+ *
+ *  Author: Wade Farnsworth <wfarnsworth@mvista.com>
+ *
+ *  Copyright 2005 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/mtd/partitions.h>
+#include <linux/config.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <asm/io.h>
+#include <asm/ibm44x.h>
+#include <platforms/4xx/bamboo.h>
+
+struct ppc440ep_ndfc_regs {
+	uint cmd;
+	uint addr;
+	uint data;
+	uint reserved1;
+	uint ecc0;
+	uint ecc1;
+	uint ecc2;
+	uint ecc3;
+	uint ecc4;
+	uint ecc5;
+	uint ecc6;
+	uint ecc7;
+	uint b0cr;
+	uint b1cr;
+	uint b2cr;
+	uint b3cr;
+	uint cr;
+	uint sr;
+	uint hwctl;
+	uint reserved2;
+	uint revid;
+};
+
+static struct mtd_info *bamboo_nand0_mtd;
+static struct mtd_info *bamboo_nand1_mtd;
+static u8 hwctl;
+static struct ppc440ep_ndfc_regs *bamboo_ndfc;
+
+#define NAND0_NUM_PARTITIONS 1
+static struct mtd_partition nand0_partition_info[] = {
+	{
+	 	.name = "filesystem",
+	 	.offset = 0x0,
+	 	.size = 0x4000000,
+	 },
+};
+
+#define NAND1_NUM_PARTITIONS 1
+static struct mtd_partition nand1_partition_info[] = {
+	{
+		.name = "filesystem",
+		.offset = 0x0,
+		.size = 0x10000000,
+	}
+};
+
+/* 
+ * The 440EP has a NAND Flash Controller (NDFC) that handles all accesses to 
+ * the NAND devices.  The NDFC has command, address and data registers that 
+ * when accessed will set up the NAND flash pins appropriately.  We'll use the 
+ * hwcontrol function to save the configuration in a global variable.  
+ * We can then use this information in the read and write functions to 
+ * determine which NDFC register to access. For the NCE commands, we'll just
+ * set or clear the Bank Enable bit in the NDFC Bank Config registers.
+ *
+ * There are 2 NAND devices on the board, a Samsung K9F1208U0A (64 MB) and a
+ * Samsung K9K2G08U0M (256 MB).
+ */
+static void
+bamboo_hwcontrol(struct mtd_info *mtd, int cmd)
+{
+	switch (cmd) {
+	case NAND_CTL_SETCLE:
+		hwctl |= 0x1;
+		break;
+	case NAND_CTL_CLRCLE:
+		hwctl &= ~0x1;
+		break;
+	case NAND_CTL_SETALE:
+		hwctl |= 0x2;
+		break;
+	case NAND_CTL_CLRALE:
+		hwctl &= ~0x2;
+		break;
+	}
+}
+
+static void
+bamboo_nand0_hwcontrol(struct mtd_info *mtd, int cmd)
+{
+	switch(cmd) {
+	case NAND_CTL_SETNCE:
+		bamboo_ndfc->b1cr |= 0x80000000;
+		break;
+	case NAND_CTL_CLRNCE:
+		bamboo_ndfc->b1cr &= ~0x80000000;
+		break;
+	default:
+		bamboo_hwcontrol(mtd, cmd);
+	}
+}
+
+static void
+bamboo_nand1_hwcontrol(struct mtd_info *mtd, int cmd)
+{
+	switch(cmd) {
+	case NAND_CTL_SETNCE:
+		bamboo_ndfc->b2cr |= 0x80000000;
+		break;
+	case NAND_CTL_CLRNCE:
+		bamboo_ndfc->b2cr &= ~0x80000000;
+		break;
+	default:
+		bamboo_hwcontrol(mtd, cmd);
+	}
+}
+
+static void
+bamboo_nand0_enable(void)
+{
+	bamboo_ndfc->cr = 0x01001000;
+}
+
+static void
+bamboo_nand1_enable(void)
+{
+	bamboo_ndfc->cr = 0x02003000;
+}
+
+static void
+bamboo_write_byte(struct mtd_info *mtd, u_char byte)
+{
+	if (hwctl & 0x1)
+		writeb(byte, &(bamboo_ndfc->cmd));
+	else if (hwctl & 0x2)
+		writeb(byte, &(bamboo_ndfc->addr));
+	else
+		writeb(byte, &(bamboo_ndfc->data));
+}
+
+static void
+bamboo_nand0_write_byte(struct mtd_info *mtd, u_char byte)
+{
+	bamboo_nand0_enable();
+	bamboo_write_byte(mtd, byte);
+}
+
+static void
+bamboo_nand1_write_byte(struct mtd_info *mtd, u_char byte)
+{
+	bamboo_nand1_enable();
+	bamboo_write_byte(mtd,byte);
+}
+
+static u_char
+bamboo_read_byte(struct mtd_info *mtd)
+{
+	u_char retval;
+	if (hwctl & 0x1)
+		retval = readb(&(bamboo_ndfc->cmd));
+	else if (hwctl & 0x2)
+		retval = readb(&(bamboo_ndfc->addr));
+	else
+		retval = readb(&(bamboo_ndfc->data));
+	return retval;
+}
+
+static u_char
+bamboo_nand0_read_byte(struct mtd_info *mtd)
+{
+	bamboo_nand0_enable();
+	return bamboo_read_byte(mtd);
+}
+
+static u_char
+bamboo_nand1_read_byte(struct mtd_info *mtd)
+{
+	bamboo_nand1_enable();
+	return bamboo_read_byte(mtd);
+}
+
+static void
+bamboo_nand_write_buf(struct mtd_info *mtd, const u_char * buf, int len)
+{
+	int i;
+	for (i = 0; i < len; i++) {
+		if (hwctl & 0x1)
+			writeb(buf[i], &(bamboo_ndfc->cmd));
+		else if (hwctl & 0x2)
+			writeb(buf[i], &(bamboo_ndfc->addr));
+		else
+			writeb(buf[i], &(bamboo_ndfc->data));
+	}
+}
+
+static void
+bamboo_nand0_write_buf(struct mtd_info *mtd, const u_char * buf, int len)
+{
+	bamboo_nand0_enable();
+	bamboo_nand_write_buf(mtd, buf, len);
+}
+
+static void
+bamboo_nand1_write_buf(struct mtd_info *mtd, const u_char * buf, int len)
+{
+	bamboo_nand1_enable();
+	bamboo_nand_write_buf(mtd, buf, len);
+}
+
+static void
+bamboo_nand_read_buf(struct mtd_info *mtd, u_char * buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (hwctl & 0x1)
+			buf[i] = readb(&(bamboo_ndfc->cmd));
+		else if (hwctl & 0x2)
+			buf[i] = readb(&(bamboo_ndfc->addr));
+		else
+			buf[i] = readb(&(bamboo_ndfc->data));
+	}
+}
+
+static void
+bamboo_nand0_read_buf(struct mtd_info *mtd, u_char * buf, int len)
+{
+	bamboo_nand0_enable();
+	bamboo_nand_read_buf(mtd, buf, len);
+}
+
+static void
+bamboo_nand1_read_buf(struct mtd_info *mtd, u_char * buf, int len)
+{
+	bamboo_nand1_enable();
+	bamboo_nand_read_buf(mtd, buf, len);
+}
+
+static int
+bamboo_nand_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (hwctl & 0x1) {
+			if (buf[i] != readb(&(bamboo_ndfc->cmd)))
+				return i;
+		} else if (hwctl & 0x2) {
+			if (buf[i] != readb(&(bamboo_ndfc->addr)))
+				return i;
+		} else {
+			if (buf[i] != readb(&(bamboo_ndfc->data)))
+				return i;
+		}
+
+	}
+
+	return 0;
+}
+
+static int
+bamboo_nand0_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
+{
+	bamboo_nand0_enable();
+	return bamboo_nand_verify_buf(mtd, buf, len);
+}
+
+static int
+bamboo_nand1_verify_buf(struct mtd_info *mtd, const u_char *buf, int len)
+{
+	bamboo_nand1_enable();
+	return bamboo_nand_verify_buf(mtd, buf, len);
+}
+
+static int
+bamboo_dev_ready(struct mtd_info *mtd)
+{
+	return ((bamboo_ndfc->sr) & 0x01000000) ? 1 : 0; 
+}
+
+int __init
+bamboo_init(void)
+{
+	struct nand_chip *this;
+	uint * selection1_base, * gpio_base;
+	u8 selection1_val;
+	int err = 0;
+	
+	hwctl = 0;
+
+	/* 
+	 * Bank 0 was set up by the firmware already.  Bank 1 wasn't, so set it
+	 * up now. 
+	 */
+
+	selection1_base = ioremap64(BAMBOO_FPGA_SELECTION1_REG_ADDR, 8);
+	if(!selection1_base){
+		printk("Ioremap to access FPGA Selection Register 1 failed \n");
+		err = -EIO;
+		goto out;
+	}
+	selection1_val = readb(selection1_base);
+	selection1_val |= 0x02;
+	writeb(selection1_val, selection1_base);
+	iounmap((void *)(selection1_base));
+
+	SDR_WRITE(DCRN_SDR_CUST0, SDR_READ(DCRN_SDR_CUST0) | 0x2);
+
+	gpio_base = ioremap64(0x0EF600B00ULL, 0x80);
+	if(!gpio_base) {
+		printk("Ioremap to access GPIO Registers failed \n");
+		err = -EIO;
+		goto out;
+	}
+	*(uint *) (gpio_base + 0x2) |= 0x00010000;
+	*(uint *) (gpio_base + 0x4) |= 0x00010000;
+	iounmap((void *) gpio_base);
+	
+	bamboo_nand0_mtd = kmalloc(sizeof(struct mtd_info) +
+				   sizeof(struct nand_chip),
+				   GFP_KERNEL);
+	
+	bamboo_nand1_mtd = kmalloc(sizeof (struct mtd_info) +
+				   sizeof (struct nand_chip),
+				   GFP_KERNEL);
+	if (!bamboo_nand1_mtd) {
+		printk("Unable to allocate NAND 1 MTD device structure.\n");
+		err = -ENOMEM;
+		goto out_mtd0;
+	}
+
+	bamboo_ndfc = ioremap64(BAMBOO_NAND_FLASH_REG_ADDR, 
+			        BAMBOO_NAND_FLASH_REG_SIZE); 
+	if (!bamboo_ndfc) {
+		printk("Ioremap to access NDFC Registers failed \n");
+		err = -EIO;
+		goto out_mtd1;
+	}
+	bamboo_ndfc->b2cr = 0xC0007777;
+
+	/* Initialize structures */
+	memset((char *) bamboo_nand0_mtd, 0,
+	       sizeof (struct mtd_info) + sizeof (struct nand_chip));
+
+	memset((char *) bamboo_nand1_mtd, 0,
+	       sizeof (struct mtd_info) + sizeof (struct nand_chip));
+
+	/* Get pointer to private data */
+	this = (struct nand_chip *) (&bamboo_nand0_mtd[1]);
+	/* Link the private data with the MTD structure */
+	bamboo_nand0_mtd->priv = this;
+
+	/* Set address of NAND IO lines (Using Linear Data Access Region) */
+	this->IO_ADDR_R = (void __iomem *) ((ulong) bamboo_ndfc + 0x1000);
+	this->IO_ADDR_W = (void __iomem *) ((ulong) bamboo_ndfc + 0x1000);
+	/* Reference hardware control function */
+	this->hwcontrol  = bamboo_nand0_hwcontrol;
+	/* Set command delay time */
+	this->chip_delay = 12;
+	this->eccmode    = NAND_ECC_SOFT;
+	this->write_byte = bamboo_nand0_write_byte;
+	this->read_byte  = bamboo_nand0_read_byte;
+	this->write_buf  = bamboo_nand0_write_buf;
+	this->read_buf   = bamboo_nand0_read_buf;
+	this->verify_buf = bamboo_nand0_verify_buf;
+	this->dev_ready  = bamboo_dev_ready;
+
+	/* Scan to find existance of the device */
+	if (nand_scan(bamboo_nand0_mtd, 1)) {
+		err = -ENXIO;
+		goto out_ior;
+	}
+
+	/* Get pointer to private data */
+	this = (struct nand_chip *) (&bamboo_nand1_mtd[1]);
+	/* Link the private data with the MTD structure */
+	bamboo_nand1_mtd->priv = this;
+
+	/* Set address of NAND IO lines (Using Linear Data Access Region) */
+	this->IO_ADDR_R = (void __iomem *) ((ulong) bamboo_ndfc + 0x1000);
+	this->IO_ADDR_W = (void __iomem *) ((ulong) bamboo_ndfc + 0x1000);
+	/* Reference hardware control function */
+	this->hwcontrol  = bamboo_nand1_hwcontrol;
+	/* Set command delay time */
+	this->chip_delay = 25;
+	this->eccmode    = NAND_ECC_SOFT;
+	this->write_byte = bamboo_nand1_write_byte;
+	this->read_byte  = bamboo_nand1_read_byte;
+	this->write_buf  = bamboo_nand1_write_buf;
+	this->read_buf   = bamboo_nand1_read_buf;
+	this->verify_buf = bamboo_nand1_verify_buf;
+	this->dev_ready  = NULL;
+
+	/* Scan to find existance of the device */
+	if (nand_scan(bamboo_nand1_mtd, 1)) {
+		err = -ENXIO;
+		goto out_ior;
+	}
+
+	
+	add_mtd_partitions(bamboo_nand0_mtd, nand0_partition_info, 
+			   NAND0_NUM_PARTITIONS);
+
+	add_mtd_partitions(bamboo_nand1_mtd, nand1_partition_info, 
+			   NAND1_NUM_PARTITIONS);
+	goto out;
+
+out_ior:
+	iounmap((void *)bamboo_ndfc);
+out_mtd1:
+	kfree(bamboo_nand1_mtd);
+out_mtd0:
+	kfree(bamboo_nand0_mtd);
+out:
+	return err;
+}
+
+static void __exit
+bamboo_cleanup(void)
+{
+	/* Unregister partitions */
+	del_mtd_partitions(bamboo_nand0_mtd);
+	del_mtd_partitions(bamboo_nand1_mtd);
+
+	/* Release resources, unregister device */
+	del_mtd_device(bamboo_nand0_mtd);
+	del_mtd_device(bamboo_nand1_mtd);
+
+	/* unmap physical address */
+	iounmap((void *) bamboo_ndfc);
+
+	/* Free the MTD device structure */
+	kfree(bamboo_nand0_mtd);
+	kfree(bamboo_nand1_mtd);
+}
+
+module_init(bamboo_init);
+module_exit(bamboo_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Wade Farnsworth <wfarnsworth@mvista.com>");
+MODULE_DESCRIPTION
+    ("Board-specific glue layer for NAND flash on IBM 440EP eval board");

--=-1ra3/wirp0dGivvVCOZ2--
