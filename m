Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 2875EDE3FA
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 00:40:09 +1000 (EST)
Message-Id: <20080610142948.104214530@arndb.de>
References: <20080610142702.354823071@arndb.de>
Date: Tue, 10 Jun 2008 16:27:06 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [PATCH 4/5] powerpc: remove references to dead platforms
Cc: linux-pcmcia@lists.infradead.org, linuxppc-dev@ozlabs.org,
	linux-m68k@lists.linux-m68k.org, linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The SPRUCE, LOPEC, SANDPOINT, PPC_GEN550 and PPLUS Kconfig
symbols were only defined for platforms in arch/ppc that are
no longer there with arch/powerpc. All compile time
switches based on these symbols can now be removed.

Cc: linux-input@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-pcmcia@lists.infradead.org
Cc: Vitaly Bordug <vitb@kernel.crashing.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/Kconfig              |    4 -
 arch/powerpc/Kconfig.debug        |    2 +-
 drivers/ide/pci/sl82c105.c        |    4 -
 drivers/input/serio/i8042-ppcio.h |   75 --------------------
 drivers/net/Kconfig               |    3 +-
 drivers/net/fec.c                 |   35 +---------
 drivers/net/smc91x.h              |   37 +----------
 drivers/pcmcia/m8xx_pcmcia.c      |  136 -------------------------------------
 include/asm-m68knommu/commproc.h  |   58 ----------------
 include/asm-powerpc/ide.h         |   12 ---
 10 files changed, 4 insertions(+), 362 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3934e26..9cf9efc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -327,10 +327,6 @@ config PHYP_DUMP
 
 	  If unsure, say "N"
 
-config PPCBUG_NVRAM
-	bool "Enable reading PPCBUG NVRAM during boot" if PPLUS || LOPEC
-	default y if PPC_PREP
-
 config IRQ_ALL_CPUS
 	bool "Distribute interrupts on all CPUs by default"
 	depends on SMP && !MV64360
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index a7d24e6..8fdc3f7 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -50,7 +50,7 @@ config DEBUGGER
 
 config KGDB
 	bool "Include kgdb kernel debugger"
-	depends on DEBUGGER && (BROKEN || PPC_GEN550 || 4xx)
+	depends on DEBUGGER && (BROKEN || 4xx)
 	select DEBUG_INFO
 	help
 	  Include in-kernel hooks for kgdb, the Linux kernel source level
diff --git a/drivers/ide/pci/sl82c105.c b/drivers/ide/pci/sl82c105.c
index ce84fa0..e0a4ada 100644
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -307,10 +307,6 @@ static const struct ide_port_info sl82c105_chipset __devinitdata = {
 	.dma_ops	= &sl82c105_dma_ops,
 	.host_flags	= IDE_HFLAG_IO_32BIT |
 			  IDE_HFLAG_UNMASK_IRQS |
-/* FIXME: check for Compatibility mode in generic IDE PCI code */
-#if defined(CONFIG_LOPEC) || defined(CONFIG_SANDPOINT)
-			  IDE_HFLAG_FORCE_LEGACY_IRQS |
-#endif
 			  IDE_HFLAG_SERIALIZE_DMA |
 			  IDE_HFLAG_NO_AUTODMA,
 	.pio_mask	= ATA_PIO5,
diff --git a/drivers/input/serio/i8042-ppcio.h b/drivers/input/serio/i8042-ppcio.h
index 2906e1b..f708c75 100644
--- a/drivers/input/serio/i8042-ppcio.h
+++ b/drivers/input/serio/i8042-ppcio.h
@@ -52,81 +52,6 @@ static inline void i8042_platform_exit(void)
 {
 }
 
-#elif defined(CONFIG_SPRUCE)
-
-#define I8042_KBD_IRQ 22
-#define I8042_AUX_IRQ 21
-
-#define I8042_KBD_PHYS_DESC "spruceps2/serio0"
-#define I8042_AUX_PHYS_DESC "spruceps2/serio1"
-#define I8042_MUX_PHYS_DESC "spruceps2/serio%d"
-
-#define I8042_COMMAND_REG 0xff810000
-#define I8042_DATA_REG 0xff810001
-
-static inline int i8042_read_data(void)
-{
-	unsigned long kbd_data;
-
-	__raw_writel(0x00000088, 0xff500008);
-	eieio();
-
-	__raw_writel(0x03000000, 0xff50000c);
-	eieio();
-
-	asm volatile("lis     7,0xff88        \n\
-		      lswi    6,7,0x8         \n\
-		      mr      %0,6"
-	              : "=r" (kbd_data) :: "6", "7");
-
-	__raw_writel(0x00000000, 0xff50000c);
-	eieio();
-
-	return (unsigned char)(kbd_data >> 24);
-}
-
-static inline int i8042_read_status(void)
-{
-	unsigned long kbd_status;
-
-	__raw_writel(0x00000088, 0xff500008);
-	eieio();
-
-	__raw_writel(0x03000000, 0xff50000c);
-	eieio();
-
-	asm volatile("lis     7,0xff88        \n\
-		      ori     7,7,0x8         \n\
-		      lswi    6,7,0x8         \n\
-		      mr      %0,6"
-		      : "=r" (kbd_status) :: "6", "7");
-
-	__raw_writel(0x00000000, 0xff50000c);
-	eieio();
-
-	return (unsigned char)(kbd_status >> 24);
-}
-
-static inline void i8042_write_data(int val)
-{
-	*((unsigned char *)0xff810000) = (char)val;
-}
-
-static inline void i8042_write_command(int val)
-{
-	*((unsigned char *)0xff810001) = (char)val;
-}
-
-static inline int i8042_platform_init(void)
-{
-	i8042_reset = 1;
-	return 0;
-}
-
-static inline void i8042_platform_exit(void)
-{
-}
-
 #else
 
 #include "i8042-io.h"
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 8e3e968..40bc655 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -891,8 +891,7 @@ config SMC91X
 	tristate "SMC 91C9x/91C1xxx support"
 	select CRC32
 	select MII
-	depends on ARM || REDWOOD_5 || REDWOOD_6 || M32R || SUPERH || \
-		SOC_AU1X00 || BLACKFIN || MN10300
+	depends on ARM || M32R || SUPERH || SOC_AU1X00 || BLACKFIN || MN10300
 	help
 	  This is a driver for SMC's 91x series of Ethernet chipsets,
 	  including the SMC91C94 and the SMC91C111. Say Y if you want it
diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index 32a4f17..fe28d52 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -67,7 +67,7 @@
 #define	FEC_MAX_PORTS	1
 #endif
 
-#if defined(CONFIG_FADS) || defined(CONFIG_RPXCLASSIC) || defined(CONFIG_M5272)
+#if defined(CONFIG_FADS) || defined(CONFIG_M5272)
 #define HAVE_mii_link_interrupt
 #endif
 
@@ -1235,14 +1235,9 @@ static phy_info_t const * const phy_info[] = {
 
 /* ------------------------------------------------------------------------- */
 #ifdef HAVE_mii_link_interrupt
-#ifdef CONFIG_RPXCLASSIC
-static void
-mii_link_interrupt(void *dev_id);
-#else
 static irqreturn_t
 mii_link_interrupt(int irq, void * dev_id);
 #endif
-#endif
 
 #if defined(CONFIG_M5272)
 /*
@@ -1796,19 +1791,6 @@ static void __inline__ fec_request_intrs(struct net_device *dev)
 	if (request_8xxirq(FEC_INTERRUPT, fec_enet_interrupt, 0, "fec", dev) != 0)
 		panic("Could not allocate FEC IRQ!");
 
-#ifdef CONFIG_RPXCLASSIC
-	/* Make Port C, bit 15 an input that causes interrupts.
-	*/
-	immap->im_ioport.iop_pcpar &= ~0x0001;
-	immap->im_ioport.iop_pcdir &= ~0x0001;
-	immap->im_ioport.iop_pcso &= ~0x0001;
-	immap->im_ioport.iop_pcint |= 0x0001;
-	cpm_install_handler(CPMVEC_PIO_PC15, mii_link_interrupt, dev);
-
-	/* Make LEDS reflect Link status.
-	*/
-	*((uint *) RPX_CSR_ADDR) &= ~BCSR2_FETHLEDMODE;
-#endif
 #ifdef CONFIG_FADS
 	if (request_8xxirq(SIU_IRQ2, mii_link_interrupt, 0, "mii", dev) != 0)
 		panic("Could not allocate MII IRQ!");
@@ -1821,16 +1803,6 @@ static void __inline__ fec_get_mac(struct net_device *dev)
 
 	bd = (bd_t *)__res;
 	memcpy(dev->dev_addr, bd->bi_enetaddr, ETH_ALEN);
-
-#ifdef CONFIG_RPXCLASSIC
-	/* The Embedded Planet boards have only one MAC address in
-	 * the EEPROM, but can have two Ethernet ports.  For the
-	 * FEC port, we create another address by setting one of
-	 * the address bits above something that would have (up to
-	 * now) been allocated.
-	 */
-	dev->dev_adrd[3] |= 0x80;
-#endif
 }
 
 static void __inline__ fec_set_mii(struct net_device *dev, struct fec_enet_private *fep)
@@ -2109,13 +2081,8 @@ mii_discover_phy(uint mii_reg, struct net_device *dev)
 /* This interrupt occurs when the PHY detects a link change.
 */
 #ifdef HAVE_mii_link_interrupt
-#ifdef CONFIG_RPXCLASSIC
-static void
-mii_link_interrupt(void *dev_id)
-#else
 static irqreturn_t
 mii_link_interrupt(int irq, void * dev_id)
-#endif
 {
 	struct	net_device *dev = dev_id;
 	struct fec_enet_private *fep = netdev_priv(dev);
diff --git a/drivers/net/smc91x.h b/drivers/net/smc91x.h
index 69e97a1..22506e3 100644
--- a/drivers/net/smc91x.h
+++ b/drivers/net/smc91x.h
@@ -106,44 +106,9 @@
 			random_ether_addr(addr);		\
 		}						\
 	} while (0)
-#elif defined(CONFIG_REDWOOD_5) || defined(CONFIG_REDWOOD_6)
-
-/* We can only do 16-bit reads and writes in the static memory space. */
-#define SMC_CAN_USE_8BIT	0
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	0
-#define SMC_NOWAIT		1
-
-#define SMC_IO_SHIFT		0
-
-#define SMC_inw(a, r)		in_be16((volatile u16 *)((a) + (r)))
-#define SMC_outw(v, a, r)	out_be16((volatile u16 *)((a) + (r)), v)
-#define SMC_insw(a, r, p, l) 						\
-	do {								\
-		unsigned long __port = (a) + (r);			\
-		u16 *__p = (u16 *)(p);					\
-		int __l = (l);						\
-		insw(__port, __p, __l);					\
-		while (__l > 0) {					\
-			*__p = swab16(*__p);				\
-			__p++;						\
-			__l--;						\
-		}							\
-	} while (0)
-#define SMC_outsw(a, r, p, l) 						\
-	do {								\
-		unsigned long __port = (a) + (r);			\
-		u16 *__p = (u16 *)(p);					\
-		int __l = (l);						\
-		while (__l > 0) {					\
-			/* Believe it or not, the swab isn't needed. */	\
-			outw( /* swab16 */ (*__p++), __port);		\
-			__l--;						\
-		}							\
-	} while (0)
-#define SMC_IRQ_FLAGS		(0)
 
 #elif defined(CONFIG_SA1100_PLEB)
+
 /* We can only do 16-bit reads and writes in the static memory space. */
 #define SMC_CAN_USE_8BIT	1
 #define SMC_CAN_USE_16BIT	1
diff --git a/drivers/pcmcia/m8xx_pcmcia.c b/drivers/pcmcia/m8xx_pcmcia.c
index ac70d2c..3545b08 100644
--- a/drivers/pcmcia/m8xx_pcmcia.c
+++ b/drivers/pcmcia/m8xx_pcmcia.c
@@ -81,12 +81,6 @@ MODULE_LICENSE("Dual MPL/GPL");
 
 #if !defined(CONFIG_PCMCIA_SLOT_A) && !defined(CONFIG_PCMCIA_SLOT_B)
 
-/* The RPX series use SLOT_B */
-#if defined(CONFIG_RPXCLASSIC) || defined(CONFIG_RPXLITE)
-#define CONFIG_PCMCIA_SLOT_B
-#define CONFIG_BD_IS_MHZ
-#endif
-
 /* The ADS board use SLOT_A */
 #ifdef CONFIG_ADS
 #define CONFIG_PCMCIA_SLOT_A
@@ -270,77 +264,6 @@ static irqreturn_t m8xx_interrupt(int irq, void *dev);
 /* board specific stuff:                                                     */
 /* voltage_set(), hardware_enable() and hardware_disable()                   */
 /* ------------------------------------------------------------------------- */
-/* RPX Boards from Embedded Planet                                           */
-
-#if defined(CONFIG_RPXCLASSIC) || defined(CONFIG_RPXLITE)
-
-/* The RPX boards seems to have it's bus monitor timeout set to 6*8 clocks.
- * SYPCR is write once only, therefore must the slowest memory be faster
- * than the bus monitor or we will get a machine check due to the bus timeout.
- */
-
-#define PCMCIA_BOARD_MSG "RPX CLASSIC or RPX LITE"
-
-#undef PCMCIA_BMT_LIMIT
-#define PCMCIA_BMT_LIMIT (6*8)
-
-static int voltage_set(int slot, int vcc, int vpp)
-{
-	u32 reg = 0;
-
-	switch (vcc) {
-	case 0:
-		break;
-	case 33:
-		reg |= BCSR1_PCVCTL4;
-		break;
-	case 50:
-		reg |= BCSR1_PCVCTL5;
-		break;
-	default:
-		return 1;
-	}
-
-	switch (vpp) {
-	case 0:
-		break;
-	case 33:
-	case 50:
-		if (vcc == vpp)
-			reg |= BCSR1_PCVCTL6;
-		else
-			return 1;
-		break;
-	case 120:
-		reg |= BCSR1_PCVCTL7;
-	default:
-		return 1;
-	}
-
-	if (!((vcc == 50) || (vcc == 0)))
-		return 1;
-
-	/* first, turn off all power */
-
-	out_be32(((u32 *) RPX_CSR_ADDR),
-		 in_be32(((u32 *) RPX_CSR_ADDR)) & ~(BCSR1_PCVCTL4 |
-						     BCSR1_PCVCTL5 |
-						     BCSR1_PCVCTL6 |
-						     BCSR1_PCVCTL7));
-
-	/* enable new powersettings */
-
-	out_be32(((u32 *) RPX_CSR_ADDR), in_be32(((u32 *) RPX_CSR_ADDR)) | reg);
-
-	return 0;
-}
-
-#define socket_get(_slot_) PCMCIA_SOCKET_KEY_5V
-#define hardware_enable(_slot_)	/* No hardware to enable */
-#define hardware_disable(_slot_)	/* No hardware to disable */
-
-#endif				/* CONFIG_RPXCLASSIC */
-
 /* FADS Boards from Motorola                                               */
 
 #if defined(CONFIG_FADS)
@@ -432,65 +355,6 @@ static inline int voltage_set(int slot, int vcc, int vpp)
 
 #endif
 
-/* ------------------------------------------------------------------------- */
-/* Motorola MBX860                                                           */
-
-#if defined(CONFIG_MBX)
-
-#define PCMCIA_BOARD_MSG "MBX"
-
-static int voltage_set(int slot, int vcc, int vpp)
-{
-	u8 reg = 0;
-
-	switch (vcc) {
-	case 0:
-		break;
-	case 33:
-		reg |= CSR2_VCC_33;
-		break;
-	case 50:
-		reg |= CSR2_VCC_50;
-		break;
-	default:
-		return 1;
-	}
-
-	switch (vpp) {
-	case 0:
-		break;
-	case 33:
-	case 50:
-		if (vcc == vpp)
-			reg |= CSR2_VPP_VCC;
-		else
-			return 1;
-		break;
-	case 120:
-		if ((vcc == 33) || (vcc == 50))
-			reg |= CSR2_VPP_12;
-		else
-			return 1;
-	default:
-		return 1;
-	}
-
-	/* first, turn off all power */
-	out_8((u8 *) MBX_CSR2_ADDR,
-	      in_8((u8 *) MBX_CSR2_ADDR) & ~(CSR2_VCC_MASK | CSR2_VPP_MASK));
-
-	/* enable new powersettings */
-	out_8((u8 *) MBX_CSR2_ADDR, in_8((u8 *) MBX_CSR2_ADDR) | reg);
-
-	return 0;
-}
-
-#define socket_get(_slot_) PCMCIA_SOCKET_KEY_5V
-#define hardware_enable(_slot_)	/* No hardware to enable */
-#define hardware_disable(_slot_)	/* No hardware to disable */
-
-#endif				/* CONFIG_MBX */
-
 #if defined(CONFIG_PRxK)
 #include <asm/cpld.h>
 extern volatile fpga_pc_regs *fpga_pc;
diff --git a/include/asm-m68knommu/commproc.h b/include/asm-m68knommu/commproc.h
index 36e870b..48f5466 100644
--- a/include/asm-m68knommu/commproc.h
+++ b/include/asm-m68knommu/commproc.h
@@ -480,64 +480,6 @@ typedef struct scc_enet {
 #define SICR_ENET_CLKRT	((uint)0x0000003d)
 #endif
 
-#ifdef CONFIG_RPXLITE
-/* This ENET stuff is for the MPC850 with ethernet on SCC2.  Some of
- * this may be unique to the RPX-Lite configuration.
- * Note TENA is on Port B.
- */
-#define PA_ENET_RXD	((ushort)0x0004)
-#define PA_ENET_TXD	((ushort)0x0008)
-#define PA_ENET_TCLK	((ushort)0x0200)
-#define PA_ENET_RCLK	((ushort)0x0800)
-#define PB_ENET_TENA	((uint)0x00002000)
-#define PC_ENET_CLSN	((ushort)0x0040)
-#define PC_ENET_RENA	((ushort)0x0080)
-
-#define SICR_ENET_MASK	((uint)0x0000ff00)
-#define SICR_ENET_CLKRT	((uint)0x00003d00)
-#endif
-
-#ifdef CONFIG_BSEIP
-/* This ENET stuff is for the MPC823 with ethernet on SCC2.
- * This is unique to the BSE ip-Engine board.
- */
-#define PA_ENET_RXD	((ushort)0x0004)
-#define PA_ENET_TXD	((ushort)0x0008)
-#define PA_ENET_TCLK	((ushort)0x0100)
-#define PA_ENET_RCLK	((ushort)0x0200)
-#define PB_ENET_TENA	((uint)0x00002000)
-#define PC_ENET_CLSN	((ushort)0x0040)
-#define PC_ENET_RENA	((ushort)0x0080)
-
-/* BSE uses port B and C bits for PHY control also.
-*/
-#define PB_BSE_POWERUP	((uint)0x00000004)
-#define PB_BSE_FDXDIS	((uint)0x00008000)
-#define PC_BSE_LOOPBACK	((ushort)0x0800)
-
-#define SICR_ENET_MASK	((uint)0x0000ff00)
-#define SICR_ENET_CLKRT	((uint)0x00002c00)
-#endif
-
-#ifdef CONFIG_RPXCLASSIC
-/* Bits in parallel I/O port registers that have to be set/cleared
- * to configure the pins for SCC1 use.
- */
-#define PA_ENET_RXD	((ushort)0x0001)
-#define PA_ENET_TXD	((ushort)0x0002)
-#define PA_ENET_TCLK	((ushort)0x0200)
-#define PA_ENET_RCLK	((ushort)0x0800)
-#define PB_ENET_TENA	((uint)0x00001000)
-#define PC_ENET_CLSN	((ushort)0x0010)
-#define PC_ENET_RENA	((ushort)0x0020)
-
-/* Control bits in the SICR to route TCLK (CLK2) and RCLK (CLK4) to
- * SCC1.  Also, make sure GR1 (bit 24) and SC1 (bit 25) are zero.
- */
-#define SICR_ENET_MASK	((uint)0x000000ff)
-#define SICR_ENET_CLKRT	((uint)0x0000003d)
-#endif
-
 /* SCC Event register as used by Ethernet.
 */
 #define SCCE_ENET_GRA	((ushort)0x0080)	/* Graceful stop complete */
diff --git a/include/asm-powerpc/ide.h b/include/asm-powerpc/ide.h
index 3d90bf7..6fb0254 100644
--- a/include/asm-powerpc/ide.h
+++ b/include/asm-powerpc/ide.h
@@ -34,12 +34,6 @@
 /* FIXME: use ide_platform host driver */
 static __inline__ int ide_default_irq(unsigned long base)
 {
-#ifdef CONFIG_PPLUS
-	switch (base) {
-	case 0x1f0:	return 14;
-	case 0x170:	return 15;
-	}
-#endif
 #ifdef CONFIG_PPC_PREP
 	switch (base) {
 	case 0x1f0:	return 13;
@@ -56,12 +50,6 @@ static __inline__ int ide_default_irq(unsigned long base)
 /* FIXME: use ide_platform host driver */
 static __inline__ unsigned long ide_default_io_base(int index)
 {
-#ifdef CONFIG_PPLUS
-	switch (index) {
-	case 0:		return 0x1f0;
-	case 1:		return 0x170;
-	}
-#endif
 #ifdef CONFIG_PPC_PREP
 	switch (index) {
 	case 0:		return 0x1f0;
-- 
1.5.4.3

-- 
