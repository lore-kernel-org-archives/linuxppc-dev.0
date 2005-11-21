Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 308AC681BE
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Nov 2005 21:25:19 +1100 (EST)
Received: from mail01.m-online.net (unknown [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 1ED93704F8
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Nov 2005 11:23:28 +0100 (CET)
Received: from embluxa7e0291e (213-163-18-7.vnet.hu [213.163.18.7])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 13BE990F29
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Nov 2005 11:23:25 +0100 (CET)
From: "Heiko Schocher" <hs@denx.de>
To: <linuxppc-dev@ozlabs.org>
Date: Mon, 21 Nov 2005 11:24:58 +0100
Message-ID: <AHEILKONAKAEJPHNMOPNKELACDAA.hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [PATCH]	ppc32:	Add support for PM82x Boards
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello

the following Patch (against 2.6 kernel.org tree, COMMIT_ID:
f093182d313edde9b1f86dbdaf40ba4da2dbd0e7) adds support for
the Microsys PM82x Boards. Verified on the PM827 Board.

not included yet: support for MTD, I2C, RTC.

Note: 2 previously submitted Patches are required:

Thu, 4 Nov 2005 [PATCH] ppc32: Fix SCC Uart write problem after 2. open()
Tue, 3 Nov 2005 [PATCH] ppc32: fix: swallowed chars when booting.

Signed-off-by: Heiko Schocher <hs@denx.de>

---

 arch/ppc/8260_io/Kconfig                |    7
 arch/ppc/8260_io/fcc_enet.c             |  117 ++++
 arch/ppc/Kconfig                        |    7
 arch/ppc/configs/pm82x_defconfig        |  897
+++++++++++++++++++++++++++++++
 arch/ppc/platforms/Makefile             |    1
 arch/ppc/platforms/pm82x.h              |   48 ++
 arch/ppc/platforms/pm82x_setup.c        |   40 +
 arch/ppc/syslib/m8260_setup.c           |   24 +
 arch/ppc/syslib/m82xx_pci.c             |   15 -
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |   56 ++
 include/asm-ppc/cpm2.h                  |    2
 include/asm-ppc/mpc8260.h               |    4
 12 files changed, 1212 insertions(+), 6 deletions(-)

diff --git a/arch/ppc/8260_io/Kconfig b/arch/ppc/8260_io/Kconfig
index ea9651e..0cb917d 100644
--- a/arch/ppc/8260_io/Kconfig
+++ b/arch/ppc/8260_io/Kconfig
@@ -23,6 +23,10 @@ config FCC1_ENET
 	help
 	  Use CPM2 fast Ethernet controller 1 to drive Ethernet (default).

+config DB_CR826_J30x_ON
+	bool "  DB CR826 Legacy Jumper ON"
+	depends on PM82X
+
 config FCC2_ENET
 	bool "Ethernet on FCC2"
 	depends on FEC_ENET
@@ -59,6 +63,9 @@ config FCC_DM9131
 config FCC_DM9161
 	bool "DM9161"

+config FCC_AMD79C873
+	bool "AMD79C873"
+
 config FCC_GENERIC_PHY
 	bool "Generic"
 endchoice
diff --git a/arch/ppc/8260_io/fcc_enet.c b/arch/ppc/8260_io/fcc_enet.c
index 4edeede..2f67f5b 100644
--- a/arch/ppc/8260_io/fcc_enet.c
+++ b/arch/ppc/8260_io/fcc_enet.c
@@ -202,8 +202,18 @@ static int fcc_enet_set_mac_address(stru

 #define PC_F1RXCLK	PC_CLK(F1_RXCLK)
 #define PC_F1TXCLK	PC_CLK(F1_TXCLK)
+#if defined(CONFIG_PM82X)
+#ifndef CONFIG_DB_CR826_J30x_ON
+#define CMX1_CLK_ROUTE  ((uint)0x35000000)
+#define CMX1_CLK_MASK   ((uint)0x7f000000)
+#else
+#define CMX1_CLK_ROUTE  ((uint)0x37000000)
+#define CMX1_CLK_MASK   ((uint)0x7f000000)
+#endif
+#else
 #define CMX1_CLK_ROUTE	(CMXFCR_RF1CS(F1_RXCLK) | CMXFCR_TF1CS(F1_TXCLK))
 #define CMX1_CLK_MASK	((uint)0xff000000)
+#endif

 #define PC_F2RXCLK	PC_CLK(F2_RXCLK)
 #define PC_F2TXCLK	PC_CLK(F2_TXCLK)
@@ -297,6 +307,14 @@ static int fcc_enet_set_mac_address(stru
 #elif defined(CONFIG_EST8260) || defined(CONFIG_ADS8260) ||
defined(CONFIG_PQ2FADS)
 #define PC_MDIO		((uint)0x00400000)
 #define PC_MDCK		((uint)0x00200000)
+#elif defined (CONFIG_PM82X)
+#ifndef CONFIG_DB_CR826_J30x_ON
+#define PC_MDIO		((uint)0x00000080) /* MDIO on PC24 */
+#define PC_MDCK		((uint)0x00000100) /* MDCK on PC23 */
+#else
+#define PC_MDIO		((uint)0x00000100) /* MDIO on PA23 */
+#define PC_MDCK		((uint)0x00000200) /* MDCK on PA22 */
+#endif  /* CONFIG_DB_CR826_J30x_ON */
 #else
 #define PC_MDIO		((uint)0x00000004)
 #define PC_MDCK		((uint)0x00000020)
@@ -875,6 +893,28 @@ static void mii_parse_anar(uint mii_reg,
 	fep->phy_status = s;
 }

+#ifdef CONFIG_FCC_AMD79C873
+/* Some boards don't have the MDIRQ line connected (PM82x is such a board)
*/
+
+static void mii_waitfor_anc(uint mii_reg, struct net_device *dev)
+{
+	struct fcc_enet_private *fep;
+	int regval;
+	int i;
+
+	fep = dev->priv;
+	regval = mk_mii_read(MII_BMSR) | (fep->phy_addr << 23);
+
+	for (i = 0; i < 1000; i++) {
+		if (mii_send_receive(fep->fip, regval) & 0x20)
+			return;
+		udelay(10000);
+	}
+
+	printk("%s: autonegotiation timeout\n", dev->name);
+}
+#endif
+
 /* ------------------------------------------------------------------------
- */
 /* Generic PHY support.  Should work for all PHYs, but does not support
link
  * change interrupts.
@@ -1150,6 +1190,72 @@ static phy_info_t phy_info_qs6612 = {

 #endif /* CONFIG_FEC_QS6612 */

+/* ------------------------------------------------------------------------
- */
+/* The AMD Am79C873 PHY is on PM82x                             */
+
+#ifdef CONFIG_FCC_AMD79C873
+
+#define MII_79C873_IER		17  /* Interrupt Enable Register */
+#define MII_79C873_DR		18  /* Diagnostic Register       */
+
+static void mii_parse_79c873_cr(uint mii_reg, struct net_device *dev)
+{
+	volatile struct fcc_enet_private *fep = dev->priv;
+	uint s = fep->phy_status;
+
+	s &= ~(PHY_STAT_SPMASK);
+
+	if (mii_reg & 0x2000) {
+		if (mii_reg & 0x0100)
+			s |= PHY_STAT_100FDX;
+		else
+			s |= PHY_STAT_100HDX;
+	} else {
+		if (mii_reg & 0x0100)
+			s |= PHY_STAT_10FDX;
+		else
+			s |= PHY_STAT_10HDX;
+	}
+
+	fep->phy_status = s;
+}
+
+static phy_info_t phy_info_79c873 = {
+	0x00181b80,
+	"AMD79C873",
+
+	(const phy_cmd_t []) {  /* config */
+		{ mk_mii_read(MII_BMCR), mii_parse_cr },
+		{ mk_mii_read(MII_ADVERTISE), mii_parse_anar },
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) {  /* startup */
+#if 0
+		{ mk_mii_write(MII_79C873_IER, 0xff00), NULL },
+#endif
+		{ mk_mii_write(MII_BMCR, 0x1200), NULL }, /* autonegotiate */
+#ifdef  CONFIG_PM82X
+		{ mk_mii_read(MII_BMSR), mii_waitfor_anc },
+#endif
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) { /* ack_int */
+		/* read SR twice: to acknowledge and to get link status */
+		{ mk_mii_read(MII_BMSR), mii_parse_sr },
+		{ mk_mii_read(MII_BMSR), mii_parse_sr },
+
+		/* find out the current link parameters */
+
+		{ mk_mii_read(MII_BMCR), mii_parse_79c873_cr },
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) {  /* shutdown - disable interrupts */
+		{ mk_mii_write(MII_79C873_IER, 0x0000), NULL },
+		{ mk_mii_end, }
+	},
+};
+
+#endif /* CONFIG_FCC_AMD79C873 */

 /* ------------------------------------------------------------------------
- */
 /* The Davicom DM9131 is used on the HYMOD board			     */
@@ -1381,6 +1487,10 @@ static phy_info_t *phy_info[] = {
 	&phy_info_dm9161,
 #endif /* CONFIG_FCC_DM9161 */

+#ifdef CONFIG_FCC_AMD79C873
+	&phy_info_79c873,
+#endif /* CONFIG_FCC_AMD79C873 */
+
 #ifdef CONFIG_FCC_GENERIC_PHY
 	/* Generic PHY support.  This must be the last PHY in the table.
 	 * It will be used to support any PHY that doesn't match a previous
@@ -1847,8 +1957,10 @@ init_fcc_ioports(fcc_info_t *fip, volati
 #ifdef	CONFIG_USE_MDIO
 	/* ....and the MII serial clock/data.
 	*/
+#ifndef CONFIG_PM82X
 	io->iop_pdatc |= (fip->fc_mdio | fip->fc_mdck);
 	io->iop_podrc &= ~(fip->fc_mdio | fip->fc_mdck);
+#endif
 	io->iop_pdirc |= (fip->fc_mdio | fip->fc_mdck);
 	io->iop_pparc &= ~(fip->fc_mdio | fip->fc_mdck);
 #endif	/* CONFIG_USE_MDIO */
@@ -2380,6 +2492,11 @@ fcc_enet_open(struct net_device *dev)
 			schedule();

 		mii_do_cmd(dev, fep->phy->startup);
+#ifdef  CONFIG_PM82X
+		/* Read the autonegotiation results */
+		mii_do_cmd(dev, fep->phy->ack_int);
+		mii_do_cmd(dev, phy_cmd_relink);
+#endif  /* CONFIG_PM82X */
 		netif_start_queue(dev);
 		return 0;		/* Success */
 	}
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 8fa51b0..1add0a9 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -667,6 +667,11 @@ config TQM8260
 	  End of Life: not yet :-)
 	  URL: <http://www.denx.de/PDF/TQM82xx_SPEC_Rev005.pdf>

+config PM82X
+	bool "PM82X"
+	help
+	  This option enables support for the MicroSys PM82x evaluation boards.
+
 config ADS8272
 	bool "ADS8272"

@@ -723,7 +728,7 @@ config PPC_MPC52xx
 config 8260
 	bool "CPM2 Support" if WILLOW
 	depends on 6xx
-	default y if TQM8260 || RPX8260 || EST8260 || SBS8260 || SBC82xx ||
PQ2FADS
+	default y if TQM8260 || RPX8260 || EST8260 || SBS8260 || SBC82xx ||
PQ2FADS || PM82X
 	help
 	  The MPC8260 is a typical embedded CPU made by Motorola.  Selecting
 	  this option means that you wish to build a kernel for a machine with
diff --git a/arch/ppc/configs/pm82x_defconfig
b/arch/ppc/configs/pm82x_defconfig
new file mode 100644
index 0000000..13f0e8a
--- /dev/null
+++ b/arch/ppc/configs/pm82x_defconfig
@@ -0,0 +1,897 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.14-rc3
+# Mon Oct 17 12:21:11 2005
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+# CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+# CONFIG_EPOLL is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Processor
+#
+CONFIG_6xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+# CONFIG_E200 is not set
+# CONFIG_E500 is not set
+CONFIG_PPC_FPU=y
+# CONFIG_KEXEC is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_WANT_EARLY_SERIAL is not set
+CONFIG_EMBEDDEDBOOT=y
+CONFIG_PPC_STD_MMU=y
+
+#
+# Platform options
+#
+# CONFIG_PPC_MULTIPLATFORM is not set
+# CONFIG_APUS is not set
+# CONFIG_KATANA is not set
+# CONFIG_WILLOW is not set
+# CONFIG_CPCI690 is not set
+# CONFIG_POWERPMC250 is not set
+# CONFIG_CHESTNUT is not set
+# CONFIG_SPRUCE is not set
+# CONFIG_HDPU is not set
+# CONFIG_EV64260 is not set
+# CONFIG_LOPEC is not set
+# CONFIG_MVME5100 is not set
+# CONFIG_PPLUS is not set
+# CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
+# CONFIG_SANDPOINT is not set
+# CONFIG_RADSTONE_PPC7D is not set
+# CONFIG_PAL4 is not set
+# CONFIG_GEMINI is not set
+# CONFIG_EST8260 is not set
+# CONFIG_SBC82xx is not set
+# CONFIG_SBS8260 is not set
+# CONFIG_RPX8260 is not set
+# CONFIG_TQM8260 is not set
+CONFIG_PM82X=y
+# CONFIG_ADS8272 is not set
+# CONFIG_PQ2FADS is not set
+# CONFIG_LITE5200 is not set
+# CONFIG_MPC834x_SYS is not set
+# CONFIG_EV64360 is not set
+CONFIG_8260=y
+CONFIG_CPM2=y
+# CONFIG_PC_KEYBOARD is not set
+# CONFIG_SMP is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_8260=y
+# CONFIG_8260_PCI9 is not set
+CONFIG_PCI_LEGACY_PROC=y
+# CONFIG_PCI_DEBUG is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_BOOT_LOAD=0x00400000
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+CONFIG_NFTL=y
+# CONFIG_NFTL_RW is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
+CONFIG_MTD_CFI_GEOMETRY=y
+# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
+CONFIG_MTD_MAP_BANK_WIDTH_8=y
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+# CONFIG_MTD_CFI_I1 is not set
+# CONFIG_MTD_CFI_I2 is not set
+CONFIG_MTD_CFI_I4=y
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_OTP is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+CONFIG_MTD_COMPLEX_MAPPINGS=y
+# CONFIG_MTD_PHYSMAP is not set
+# CONFIG_MTD_SBC8240 is not set
+CONFIG_MTD_PM82X=y
+# CONFIG_MTD_PCI is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_DISKONCHIP=y
+# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
+CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
+# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Macintosh device drivers
+#
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# PHY device support
+#
+# CONFIG_PHYLIB is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+CONFIG_EEPRO100=y
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+# CONFIG_INPUT is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_CPM=y
+CONFIG_SERIAL_CPM_CONSOLE=y
+CONFIG_SERIAL_CPM_SCC1=y
+CONFIG_SERIAL_CPM_SCC2=y
+CONFIG_SERIAL_CPM_SCC3=y
+CONFIG_SERIAL_CPM_SCC4=y
+CONFIG_SERIAL_CPM_SMC1=y
+CONFIG_SERIAL_CPM_SMC2=y
+# CONFIG_SERIAL_JSM is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
+# I2C support
+#
+CONFIG_I2C=y
+# CONFIG_I2C_CHARDEV is not set
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_MPC is not set
+CONFIG_I2C_MPC8260=y
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_SCx200_ACB is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_ISA is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+CONFIG_SENSORS_PCF8563=y
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+# CONFIG_SENSORS_M41T00 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+CONFIG_I2C_DEBUG_CORE=y
+CONFIG_I2C_DEBUG_ALGO=y
+CONFIG_I2C_DEBUG_BUS=y
+CONFIG_I2C_DEBUG_CHIP=y
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+# CONFIG_HWMON is not set
+# CONFIG_HWMON_VID is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia Capabilities Port drivers
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# SN Devices
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_PROC_KCORE is not set
+CONFIG_SYSFS=y
+# CONFIG_TMPFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+# CONFIG_JFFS2_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+# CONFIG_MSDOS_PARTITION is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+# CONFIG_SCC_ENET is not set
+CONFIG_FEC_ENET=y
+CONFIG_USE_MDIO=y
+
+#
+# CPM2 Options
+#
+CONFIG_FCC1_ENET=y
+# CONFIG_DB_CR826_J30x_ON is not set
+# CONFIG_FCC2_ENET is not set
+# CONFIG_FCC3_ENET is not set
+# CONFIG_FCC_LXT970 is not set
+CONFIG_FCC_LXT971=y
+# CONFIG_FCC_QS6612 is not set
+# CONFIG_FCC_DM9131 is not set
+# CONFIG_FCC_DM9161 is not set
+# CONFIG_FCC_AMD79C873 is not set
+# CONFIG_FCC_GENERIC_PHY is not set
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_REED_SOLOMON=y
+CONFIG_REED_SOLOMON_DEC16=y
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_FS is not set
+# CONFIG_KGDB_CONSOLE is not set
+# CONFIG_XMON is not set
+# CONFIG_BDI_SWITCH is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
index 7c5cdab..becaed3 100644
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_PMAC_BACKLIGHT)	+= pmac_bac
 obj-$(CONFIG_PREP_RESIDUAL)	+= residual.o
 obj-$(CONFIG_PQ2ADS)		+= pq2ads.o
 obj-$(CONFIG_TQM8260)		+= tqm8260_setup.o
+obj-$(CONFIG_PM82X)		+= pm82x_setup.o
 obj-$(CONFIG_CPCI690)		+= cpci690.o
 obj-$(CONFIG_EV64260)		+= ev64260.o
 obj-$(CONFIG_CHESTNUT)		+= chestnut.o
diff --git a/arch/ppc/platforms/pm82x.h b/arch/ppc/platforms/pm82x.h
new file mode 100644
index 0000000..ee12e1d
--- /dev/null
+++ b/arch/ppc/platforms/pm82x.h
@@ -0,0 +1,48 @@
+/*
+ * PM82X board specific definitions
+ *
+ * Copyright (c) 2005 Heiko Schocher (hs@denx.de)
+ */
+
+#ifndef __MACH_PM82X_H
+#define __MACH_PM82X_H
+
+#include <linux/config.h>
+
+#include <asm/ppcboot.h>
+
+#if defined(CONFIG_PCI)
+/* #include <platforms/m8260_pci.h> */
+#endif
+
+#define CPM_MAP_ADDR		((uint)0xF0000000)
+#define	I2C_ADDR_RTC		0x51
+
+/* For our show_cpuinfo hooks. */
+#define CPUINFO_VENDOR		"Microsys"
+#define CPUINFO_MACHINE	"PM82x PowerPC"
+
+#if defined (CONFIG_MTD_NAND_DISKONCHIP)
+#define BOOTROM_RESTART_ADDR	((uint)0x40000100)
+#else
+#define BOOTROM_RESTART_ADDR	((uint)0xFF800100)
+#endif
+
+/* PPC Sys identification */
+#define BOARD_CHIP_NAME "8250"
+
+#ifdef CONFIG_PCI
+/* PCI interrupt controller */
+#define PCI_INT_STAT_REG	0xF8200000
+#define PCI_INT_MASK_REG	0xF8200004
+#define PIRQA			(NR_CPM_INTS + 0)
+#define PIRQB			(NR_CPM_INTS + 1)
+#define PIRQC			(NR_CPM_INTS + 2)
+#define PIRQD			(NR_CPM_INTS + 3)
+
+#define PCI_INT_TO_SIU  SIU_INT_IRQ2
+
+#endif /* CONFIG_PCI */
+
+
+#endif	/* __MACH_PM82X_H */
diff --git a/arch/ppc/platforms/pm82x_setup.c
b/arch/ppc/platforms/pm82x_setup.c
new file mode 100644
index 0000000..dd8ea88
--- /dev/null
+++ b/arch/ppc/platforms/pm82x_setup.c
@@ -0,0 +1,40 @@
+/*
+ * arch/ppc/platforms/pm82x_setup.c
+ *
+ * PM82X platform support
+ *
+ * Author: Heiko Schocher <hs@denx.de>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+
+#include <asm/mpc8260.h>
+#include <asm/cpm2.h>
+#include <asm/machdep.h>
+
+static int
+pm82x_set_rtc_time(unsigned long time)
+{
+	((cpm2_map_t *)CPM_MAP_ADDR)->im_sit.sit_tmcnt = time;
+	((cpm2_map_t *)CPM_MAP_ADDR)->im_sit.sit_tmcntsc = 0x3;
+	return(0);
+}
+
+static unsigned long
+pm82x_get_rtc_time(void)
+{
+	return ((cpm2_map_t *)CPM_MAP_ADDR)->im_sit.sit_tmcnt;
+}
+
+void __init
+m82xx_board_init(void)
+{
+	/* Anything special for this platform */
+	ppc_md.set_rtc_time	= pm82x_set_rtc_time;
+	ppc_md.get_rtc_time	= pm82x_get_rtc_time;
+}
diff --git a/arch/ppc/syslib/m8260_setup.c b/arch/ppc/syslib/m8260_setup.c
index 76a2aa4..f4b0f3a 100644
--- a/arch/ppc/syslib/m8260_setup.c
+++ b/arch/ppc/syslib/m8260_setup.c
@@ -51,6 +51,16 @@ m8260_setup_arch(void)

 	/* Reset the Communication Processor Module. */
 	cpm2_reset();
+
+#ifdef  CONFIG_PM82X
+	/* On PM82x BRG1 is not initialized by the firmware (as the console
+	 * is on SMC2). We initialize it here to avoid "realtime clock stuck"
+	 * messages. Later on, when the RTC driver loads up, it re-installs
+	 * its own handlers.
+	 */
+	cpm_setbrg(0, 9600);
+#endif  /* CONFIG_PM82X */
+
 #ifdef CONFIG_8260_PCI9
 	/* Initialise IDMA for PCI erratum workaround */
 	idma_pci9_init();
@@ -156,9 +166,9 @@ m8260_show_cpuinfo(struct seq_file *m)
 		   "core clock\t: %u MHz\n"
 		   "CPM  clock\t: %u MHz\n"
 		   "bus  clock\t: %u MHz\n",
-		   CPUINFO_VENDOR, CPUINFO_MACHINE, bp->bi_memsize,
-		   bp->bi_baudrate, bp->bi_intfreq / 1000000,
-		   bp->bi_cpmfreq / 1000000, bp->bi_busfreq / 1000000);
+		   CPUINFO_VENDOR, CPUINFO_MACHINE, (unsigned int) bp->bi_memsize,
+		   (int) bp->bi_baudrate, (unsigned int) bp->bi_intfreq / 1000000,
+		   (unsigned int) bp->bi_cpmfreq / 1000000, (unsigned int) bp->bi_busfreq
/ 1000000);
 	return 0;
 }

@@ -176,7 +186,15 @@ m8260_init_IRQ(void)
 	/* Initialize the default interrupt mapping priorities,
 	 * in case the boot rom changed something on us.
 	 */
+#ifndef CONFIG_PM82X
 	cpm2_immr->im_intctl.ic_siprr = 0x05309770;
+	cpm2_immr->im_intctl.ic_scprrh = 0x05309770;
+	cpm2_immr->im_intctl.ic_scprrl = 0x05309770;
+#else
+	cpm2_immr->im_intctl.ic_siprr = 0x0530b370;
+	cpm2_immr->im_intctl.ic_scprrh = 0x0530b370;
+	cpm2_immr->im_intctl.ic_scprrl = 0x0530b370;
+#endif

 #if defined(CONFIG_PCI) && (defined(CONFIG_ADS8272) ||
defined(CONFIG_PQ2FADS))
  	/* Initialize stuff for the 82xx CPLD IC and install demux  */
diff --git a/arch/ppc/syslib/m82xx_pci.c b/arch/ppc/syslib/m82xx_pci.c
index 1d1c395..5af560e 100644
--- a/arch/ppc/syslib/m82xx_pci.c
+++ b/arch/ppc/syslib/m82xx_pci.c
@@ -300,6 +300,19 @@ pq2ads_setup_pci(struct pci_controller *

 }

+void m8260_pcibios_fixup(void)
+{
+	struct pci_dev *dev = NULL;
+
+	for_each_pci_dev(dev) {
+#ifdef CONFIG_PM82X
+		if (dev->bus->number == 0 && (dev->devfn & ~0x7) == (0xD << 3)) {
+			dev->irq = SIU_INT_IRQ5;
+		}
+#endif
+	}
+}
+
 void __init pq2_find_bridges(void)
 {
 	extern int pci_assign_all_buses;
@@ -377,7 +390,7 @@ void __init pq2_find_bridges(void)
 	hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);

 	ppc_md.pci_map_irq = pq2pci_map_irq;
-	ppc_md.pcibios_fixup = NULL;
+	ppc_md.pcibios_fixup = m8260_pcibios_fixup;
 	ppc_md.pcibios_fixup_bus = NULL;

 }
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index fd9e53e..39776bc 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -95,8 +95,13 @@ void smc1_lineif(struct uart_cpm_port *p
 	io->iop_pdird &= ~0x00800000;
 	io->iop_psord &= ~0x00c00000;

+#if defined(CONFIG_PM82X)
+	/* Wire BRG7 to SMC1 */
+	cpm2_immr->im_cpmux.cmx_smr &= 0x1f;
+#else
 	/* Wire BRG1 to SMC1 */
 	cpm2_immr->im_cpmux.cmx_smr &= 0x0f;
+#endif
 	pinfo->brg = 1;
 }

@@ -104,14 +109,29 @@ void smc2_lineif(struct uart_cpm_port *p
 {
 	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;

+#if defined(CONFIG_PM82X)
+	/* SMC2 is only on port A */
+	io->iop_ppard |= 0x08000000;
+	io->iop_pdird &= ~0x08000000;
+	io->iop_psord |= 0x08000000;
+	io->iop_pparc |= 0x00010000;
+	io->iop_pdirc |= 0x00010000;
+	io->iop_psorc &= ~0x00010000;
+#else
 	/* SMC2 is only on port A */
 	io->iop_ppara |= 0x00c00000;
 	io->iop_pdira |= 0x00400000;
 	io->iop_pdira &= ~0x00800000;
 	io->iop_psora &= ~0x00c00000;
+#endif

+#if defined(CONFIG_PM82X)
+	/* Wire BRG8 to SMC2 */
+	cpm2_immr->im_cpmux.cmx_smr &= 0xf1;
+#else
 	/* Wire BRG2 to SMC2 */
 	cpm2_immr->im_cpmux.cmx_smr &= 0xf0;
+#endif
 	pinfo->brg = 2;
 }

@@ -119,12 +139,22 @@ void scc1_lineif(struct uart_cpm_port *p
 {
 	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;

+#if defined(CONFIG_PM82X)
+	io->iop_ppard |= 0x00000001;	/* Rx */
+	io->iop_pparb |= 0x00000008;	/* Tx */
+
+	io->iop_psord &= ~0x00000001;   /* Rx */
+	io->iop_psorb |= 0x00000008;    /* Tx */
+	io->iop_pdird &= ~0x00000001;   /* Rx */
+	io->iop_pdirb |= 0x00000008;    /* Tx */
+#else
 	/* Use Port D for SCC1 instead of other functions.  */
 	io->iop_ppard |= 0x00000003;
 	io->iop_psord &= ~0x00000001;	/* Rx */
 	io->iop_psord |= 0x00000002;	/* Tx */
 	io->iop_pdird &= ~0x00000001;	/* Rx */
 	io->iop_pdird |= 0x00000002;	/* Tx */
+#endif

 	/* Wire BRG1 to SCC1 */
 	cpm2_immr->im_cpmux.cmx_scr &= 0x00ffffff;
@@ -149,6 +179,14 @@ void scc2_lineif(struct uart_cpm_port *p
 	io->iop_psord &= ~0x00000010;	/* Tx */
 	io->iop_pdird &= ~0x00000008;	/* Rx */
 	io->iop_pdird |= 0x00000010;	/* Tx */
+#elif defined(CONFIG_PM82X)
+	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
+	io->iop_pparb |= 0x00010000;	/* Rx */
+	io->iop_pdirb &= ~0x00010000;
+	io->iop_psorb &= ~0x00010000;
+	io->iop_ppard |= 0x00000010;	/* Tx */
+	io->iop_pdird |= 0x00000010;
+	io->iop_psord &= ~0x00000010;
 #else
 	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
 	io->iop_pparb |= 0x008b0000;
@@ -165,12 +203,21 @@ void scc2_lineif(struct uart_cpm_port *p

 void scc3_lineif(struct uart_cpm_port *pinfo)
 {
+#if defined(CONFIG_PM82X)
+	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
+	io->iop_pparb |= 0x00820000;	/* Rx */
+	io->iop_pdirb &= ~0x00020000;
+	io->iop_psorb &= ~0x00020000;
+	io->iop_pdirb |= 0x00800000;	/* Tx */
+	io->iop_psorb |= 0x00800000;
+#else
 	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
 	io->iop_pparb |= 0x008b0000;
 	io->iop_pdirb |= 0x00880000;
 	io->iop_psorb |= 0x00880000;
 	io->iop_pdirb &= ~0x00030000;
 	io->iop_psorb &= ~0x00030000;
+#endif
 	cpm2_immr->im_cpmux.cmx_scr &= 0xffff00ff;
 	cpm2_immr->im_cpmux.cmx_scr |= 0x00001200;
 	pinfo->brg = 3;
@@ -180,10 +227,19 @@ void scc4_lineif(struct uart_cpm_port *p
 {
 	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;

+#if defined(CONFIG_PM82X)
+	io->iop_ppard |= 0x00000200;	/* Rx */
+	io->iop_pdird &= ~0x00000200;
+	io->iop_psord &= ~0x00000200;
+	io->iop_ppard |= 0x00000400;	/* Tx */
+	io->iop_pdird |= 0x00000400;
+	io->iop_psord &= ~0x00000400;
+#else
 	io->iop_ppard |= 0x00000600;
 	io->iop_psord &= ~0x00000600;	/* Tx/Rx */
 	io->iop_pdird &= ~0x00000200;	/* Rx */
 	io->iop_pdird |= 0x00000400;	/* Tx */
+#endif

 	cpm2_immr->im_cpmux.cmx_scr &= 0xffffff00;
 	cpm2_immr->im_cpmux.cmx_scr |= 0x0000001b;
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
index 43d2ebb..0e7a03c 100644
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -181,7 +181,7 @@ typedef struct cpm_buf_desc {
  */
 #define PROFF_SMC1	(0)
 #define PROFF_SMC2	(64)
-
+#define PROFF_I2C	((16 * 1024) - 64)

 /* Define enough so I can at least use the serial port as a UART.
  */
diff --git a/include/asm-ppc/mpc8260.h b/include/asm-ppc/mpc8260.h
index 3214526..501ea8e 100644
--- a/include/asm-ppc/mpc8260.h
+++ b/include/asm-ppc/mpc8260.h
@@ -36,6 +36,10 @@
 #include <platforms/tqm8260.h>
 #endif

+#ifdef CONFIG_PM82X
+#include <platforms/pm82x.h>
+#endif
+
 #if defined(CONFIG_PQ2ADS) || defined (CONFIG_PQ2FADS)
 #include <platforms/pq2ads.h>
 #endif



!-------------------------------------------------------------flip-
