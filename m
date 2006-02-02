Return-Path: <jrigby@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2893A68A51
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 05:19:55 +1100 (EST)
Message-ID: <43E24DA6.9@freescale.com>
Date: Thu, 02 Feb 2006 11:21:26 -0700
From: John Rigby <jrigby@freescale.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tnt.com>,
	linuxppc-release@sourceforge.freescale.net, linuxppc-embedded@ozlabs.org
Subject: [PATCH] Add fec support for mpc52xx
Content-Type: multipart/mixed; boundary="------------060500050200080603060601"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060500050200080603060601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adds fec support, requires bestcom patch.  Applies to Sylvains git tree.

--------------060500050200080603060601
Content-Type: text/x-csrc;
 name="0002-Add-fec-support-for-mpc52xx.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-Add-fec-support-for-mpc52xx.txt"

Subject: [PATCH] Add fec support for mpc52xx

Signed-off-by: John Rigby <jrigby@freescale.com>

---

 drivers/net/Kconfig              |    2 
 drivers/net/Makefile             |    1 
 drivers/net/fec_mpc52xx/Kconfig  |   27 +
 drivers/net/fec_mpc52xx/Makefile |   12 
 drivers/net/fec_mpc52xx/fec.c    | 1556 ++++++++++++++++++++++++++++++++++++++
 drivers/net/fec_mpc52xx/fec.h    |  402 ++++++++++
 include/asm-ppc/mpc52xx.h        |    3 
 7 files changed, 2003 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/fec_mpc52xx/Kconfig
 create mode 100644 drivers/net/fec_mpc52xx/Makefile
 create mode 100644 drivers/net/fec_mpc52xx/fec.c
 create mode 100644 drivers/net/fec_mpc52xx/fec.h

3b40e9de53a92ad8aa8e31ccb1378e9ade350c4e
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 626508a..763ffcf 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -920,6 +920,8 @@ config NI65
 
 source "drivers/net/tulip/Kconfig"
 
+source "drivers/net/fec_mpc52xx/Kconfig"
+
 config AT1700
 	tristate "AT1700/1720 support (EXPERIMENTAL)"
 	depends on NET_ETHERNET && (ISA || MCA_LEGACY) && EXPERIMENTAL
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 00e72b1..e18287e 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_SHAPER) += shaper.o
 obj-$(CONFIG_HP100) += hp100.o
 obj-$(CONFIG_SMC9194) += smc9194.o
 obj-$(CONFIG_FEC) += fec.o
+obj-$(CONFIG_PPC_5xxx_FEC) += fec_mpc52xx/
 obj-$(CONFIG_68360_ENET) += 68360enet.o
 obj-$(CONFIG_ARM_ETHERH) += 8390.o
 obj-$(CONFIG_WD80x3) += wd.o 8390.o
diff --git a/drivers/net/fec_mpc52xx/Kconfig b/drivers/net/fec_mpc52xx/Kconfig
new file mode 100644
index 0000000..f72dfe0
--- /dev/null
+++ b/drivers/net/fec_mpc52xx/Kconfig
@@ -0,0 +1,27 @@
+#
+# MPC52xx Communication options
+#
+
+#menu "MPC5xxx I/O Options"
+#	depends on PPC_MPC52xx
+
+config PPC_5xxx_FEC
+	bool "FEC Ethernet on MPC52xx"
+	depends on NET_ETHERNET
+	default n
+	help
+	  Enable Ethernet support via the fast ethernet controller.
+
+config FEC_USE_MDIO
+	bool "Use MDIO for PHY configuration"
+	depends on PPC_5xxx_FEC
+
+config FEC_GENERIC_PHY
+	bool "Generic PHY support"
+	depends on FEC_USE_MDIO
+
+config FEC_LXT971
+	bool "Support LXT971 PHY"
+	depends on FEC_USE_MDIO
+	
+#endmenu
diff --git a/drivers/net/fec_mpc52xx/Makefile b/drivers/net/fec_mpc52xx/Makefile
new file mode 100644
index 0000000..5e85101
--- /dev/null
+++ b/drivers/net/fec_mpc52xx/Makefile
@@ -0,0 +1,12 @@
+#
+# Makefile for the linux MPC5xxx ppc-specific BestComm
+# peripheral controller
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+
+EXTRA_CFLAGS += -I$(TOPDIR)/arch/ppc/syslib/bestcomm/include \
+	        -I$(TOPDIR)/arch/ppc/syslib/bestcomm/capi \
+	        -I$(TOPDIR)/arch/ppc/syslib/bestcomm/capi/task_api \
+	        -I$(TOPDIR)/arch/ppc/syslib/bestcomm/code_dma/image_rtos1
+
+obj-$(CONFIG_PPC_5xxx_FEC)	+= fec.o
diff --git a/drivers/net/fec_mpc52xx/fec.c b/drivers/net/fec_mpc52xx/fec.c
new file mode 100644
index 0000000..0bb3e8f
--- /dev/null
+++ b/drivers/net/fec_mpc52xx/fec.c
@@ -0,0 +1,1556 @@
+/*
+ * arch/ppc/5xxx_io/fec.c
+ *
+ * Driver for the MPC5200 Fast Ethernet Controller
+ * Support for MPC5100 FEC has been removed, contact the author if you need it
+ *
+ * Author: Dale Farnsworth <dfarnsworth@mvista.com>
+ * 2.6 port by Bernhard Kuhn <bkuhn@metrowerks.com>
+ *
+ * 2003 (c) MontaVista, Software, Inc.  This file is licensed under the terms
+ * of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#define CONFIG_UBOOT
+
+static const char *version = "fec.c v0.2\n";
+
+#include <linux/module.h>
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/interrupt.h>
+#include <linux/ptrace.h>
+#include <linux/ioport.h>
+#include <linux/in.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <asm/system.h>
+#include <asm/bitops.h>
+#include <linux/spinlock.h>
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/crc32.h>
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/skbuff.h>
+#include <asm/delay.h>
+#include "fec.h"
+#ifdef CONFIG_UBOOT
+#include <asm/ppcboot.h>
+#endif
+
+#ifdef CONFIG_NET_FASTROUTE
+#error "Fast Routing on MPC5200 ethernet not supported"
+#endif
+
+static struct net_device *mpc52xx_fec_dev;
+static irqreturn_t mpc52xx_fec_interrupt(int, void *, struct pt_regs *);
+static irqreturn_t mpc52xx_fec_receive_interrupt(int, void *, struct pt_regs *);
+static irqreturn_t mpc52xx_fec_transmit_interrupt(int, void *, struct pt_regs *);
+static struct net_device_stats *mpc52xx_fec_get_stats(struct net_device *);
+static void mpc52xx_fec_set_multicast_list(struct net_device *dev);
+static void mpc52xx_fec_reinit(struct net_device* dev);
+static int mpc52xx_fec_setup(struct net_device *dev, int reinit);
+static int mpc52xx_fec_cleanup(struct net_device *dev, int reinit);
+
+#ifdef CONFIG_FEC_USE_MDIO
+static void mpc52xx_fec_mii(struct net_device *dev);
+static int mpc52xx_fec_ioctl(struct net_device *, struct ifreq *rq, int cmd);
+static int mpc52xx_netdev_ethtool_ioctl(struct net_device *dev, void *useraddr);
+#ifdef CONFIG_FEC_USE_MDIO_NOT_YET
+static void mpc52xx_mdio_callback(uint regval, struct net_device *dev, uint data);
+static int mpc52xx_mdio_read(struct net_device *dev, int phy_id, int location);
+#endif
+
+/* MII processing.  We keep this as simple as possible.  Requests are
+ * placed on the list (if there is room).  When the request is finished
+ * by the MII, an optional function may be called.
+ */
+typedef struct mii_list {
+	uint    mii_regval;
+	void    (*mii_func)(uint val, struct net_device *dev, uint data);
+	struct  mii_list *mii_next;
+	uint    mii_data;
+} mii_list_t;
+
+#define		NMII	20
+mii_list_t      mii_cmds[NMII];
+mii_list_t      *mii_free;
+mii_list_t      *mii_head;
+mii_list_t      *mii_tail;
+
+typedef struct mdio_read_data {
+	u16 regval;
+	struct task_struct *sleeping_task;
+} mdio_read_data_t;
+
+static int mii_queue(struct net_device *dev, int request,
+		void (*func)(uint, struct net_device *, uint), uint data);
+
+/* Make MII read/write commands for the FEC.
+ * */
+#define mk_mii_read(REG)	(0x60020000 | ((REG & 0x1f) << 18))
+#define mk_mii_write(REG, VAL)	(0x50020000 | ((REG & 0x1f) << 18) | \
+							(VAL & 0xffff))
+#define mk_mii_end	0
+
+/* Register definitions for the PHY.
+*/
+
+#define MII_REG_CR	 0	/* Control Register */
+#define MII_REG_SR	 1	/* Status Register */
+#define MII_REG_PHYIR1	 2	/* PHY Identification Register 1 */
+#define MII_REG_PHYIR2	 3	/* PHY Identification Register 2 */
+#define MII_REG_ANAR	 4	/* A-N Advertisement Register */
+#define MII_REG_ANLPAR	 5	/* A-N Link Partner Ability Register */
+#define MII_REG_ANER	 6	/* A-N Expansion Register */
+#define MII_REG_ANNPTR	 7	/* A-N Next Page Transmit Register */
+#define MII_REG_ANLPRNPR 8	/* A-N Link Partner Received Next Page Reg. */
+
+/* values for phy_status */
+
+#define PHY_CONF_ANE	0x0001	/* 1 auto-negotiation enabled */
+#define PHY_CONF_LOOP	0x0002	/* 1 loopback mode enabled */
+#define PHY_CONF_SPMASK	0x00f0	/* mask for speed */
+#define PHY_CONF_10HDX	0x0010	/* 10 Mbit half duplex supported */
+#define PHY_CONF_10FDX	0x0020	/* 10 Mbit full duplex supported */
+#define PHY_CONF_100HDX	0x0040	/* 100 Mbit half duplex supported */
+#define PHY_CONF_100FDX	0x0080	/* 100 Mbit full duplex supported */
+
+#define PHY_STAT_LINK	0x0100	/* 1 up - 0 down */
+#define PHY_STAT_FAULT	0x0200	/* 1 remote fault */
+#define PHY_STAT_ANC	0x0400	/* 1 auto-negotiation complete	*/
+#define PHY_STAT_SPMASK	0xf000	/* mask for speed */
+#define PHY_STAT_10HDX	0x1000	/* 10 Mbit half duplex selected	*/
+#define PHY_STAT_10FDX	0x2000	/* 10 Mbit full duplex selected	*/
+#define PHY_STAT_100HDX	0x4000	/* 100 Mbit half duplex selected */
+#define PHY_STAT_100FDX	0x8000	/* 100 Mbit full duplex selected */
+
+#endif	/* CONFIG_FEC_USE_MDIO */
+
+u8 mpc52xx_fec_mac_addr[6];
+u8 null_mac[6];
+
+static void mpc52xx_fec_tx_timeout(struct net_device *dev)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+
+	priv->stats.tx_errors++;
+
+	if (!priv->tx_full)
+		netif_wake_queue(dev);
+}
+
+static void
+mpc52xx_fec_set_paddr(struct net_device *dev, u8 *mac)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	struct mpc52xx_fec *fec = priv->fec;
+
+	out_be32(&fec->paddr1, (mac[0]<<24) | (mac[1]<<16)
+			| (mac[2]<<8) | (mac[3]<<0));
+	out_be32(&fec->paddr2, (mac[4]<<24) | (mac[5]<<16) | 0x8808);
+}
+
+static int
+mpc52xx_fec_set_mac_address(struct net_device *dev, void *addr)
+{
+	struct sockaddr *sock = (struct sockaddr *)addr;
+
+	mpc52xx_fec_set_paddr(dev, sock->sa_data);
+	return 0;
+}
+
+/* This function is called to start or restart the FEC during a link
+ * change.  This happens on fifo errors or when switching between half
+ * and full duplex.
+ */
+static void
+mpc52xx_fec_restart(struct net_device *dev, int duplex)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	struct mpc52xx_fec *fec = priv->fec;
+	u32 rcntrl;
+	u32 tcntrl;
+	int i;
+
+	out_be32(&fec->rfifo_status, in_be32(&fec->rfifo_status) & 0x700000);
+	out_be32(&fec->tfifo_status, in_be32(&fec->tfifo_status) & 0x700000);
+	out_be32(&fec->reset_cntrl, 0x1000000);
+
+	/* Whack a reset.  We should wait for this. */
+	out_be32(&fec->ecntrl, MPC52xx_FEC_ECNTRL_RESET);
+	for (i = 0; i < MPC52xx_FEC_RESET_DELAY; ++i) {
+		if ((in_be32(&fec->ecntrl) & MPC52xx_FEC_ECNTRL_RESET) == 0)
+			break;
+		udelay(1);
+	}
+	if (i == MPC52xx_FEC_RESET_DELAY)
+		printk ("FEC Reset timeout!\n");
+
+	/* Set station address. */
+	out_be32(&fec->paddr1, *(u32 *)&dev->dev_addr[0]);
+	out_be32(&fec->paddr2,
+		((*(u16 *)&dev->dev_addr[4]) << 16) | 0x8808);
+
+	mpc52xx_fec_set_multicast_list(dev);
+
+	rcntrl = MPC52xx_FEC_RECV_BUFFER_SIZE << 16;	/* max frame length */
+	rcntrl |= MPC52xx_FEC_RCNTRL_FCE;
+#ifdef	CONFIG_FEC_USE_MDIO
+	rcntrl |= MPC52xx_FEC_RCNTRL_MII_MODE;
+#endif
+	if (duplex)
+		tcntrl = MPC52xx_FEC_TCNTRL_FDEN;		/* FD enable */
+	else {
+		rcntrl |= MPC52xx_FEC_RCNTRL_DRT;
+		tcntrl = 0;
+	}
+	out_be32(&fec->r_cntrl, rcntrl);
+	out_be32(&fec->x_cntrl, tcntrl);
+
+#ifdef CONFIG_FEC_USE_MDIO
+	/* Set MII speed. */
+	out_be32(&fec->mii_speed, priv->phy_speed);
+#endif
+
+	priv->full_duplex = duplex;
+
+	/* Clear any outstanding interrupt. */
+	out_be32(&fec->ievent, 0xffffffff);	/* clear intr events */
+
+	/* Enable interrupts we wish to service.
+	*/
+#ifdef CONFIG_FEC_USE_MDIO
+	out_be32(&fec->imask, 0xf0fe0000);	/* enable all intr but tfint */
+#else
+	out_be32(&fec->imask, 0xf07e0000);	/* enable all intr but tfint */
+#endif
+
+	/* And last, enable the transmit and receive processing.
+	*/
+	out_be32(&fec->ecntrl, MPC52xx_FEC_ECNTRL_ETHER_EN);
+	out_be32(&fec->r_des_active, 0x01000000);
+
+	/* The tx ring is no longer full. */
+	if (priv->tx_full)
+	{
+		priv->tx_full = 0;
+		netif_wake_queue(dev);
+	}
+}
+
+#ifdef	CONFIG_FEC_USE_MDIO
+static void
+mpc52xx_fec_mii(struct net_device *dev)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	struct mpc52xx_fec *fec = priv->fec;
+	mii_list_t	*mip;
+	uint		mii_reg;
+
+	mii_reg = in_be32(&fec->mii_data);
+
+	if ((mip = mii_head) == NULL) {
+		printk("MII and no head!\n");
+		return;
+	}
+
+	if (mip->mii_func != NULL)
+		(*(mip->mii_func))(mii_reg, dev, mip->mii_data);
+
+	mii_head = mip->mii_next;
+	mip->mii_next = mii_free;
+	mii_free = mip;
+
+	if ((mip = mii_head) != NULL)
+		out_be32(&fec->mii_data, mip->mii_regval);
+}
+
+static int
+mii_queue(struct net_device *dev, int regval, void (*func)(uint, struct net_device *, uint), uint data)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	struct mpc52xx_fec *fec = priv->fec;
+	unsigned long	flags;
+	mii_list_t	*mip;
+	int		retval;
+
+	/* Add PHY address to register command.
+	*/
+	regval |= priv->phy_addr << 23;
+
+	retval = 0;
+
+	save_flags(flags);
+	cli();
+
+	if ((mip = mii_free) != NULL) {
+		mii_free = mip->mii_next;
+		mip->mii_regval = regval;
+		mip->mii_func = func;
+		mip->mii_next = NULL;
+		mip->mii_data = data;
+		if (mii_head) {
+			mii_tail->mii_next = mip;
+			mii_tail = mip;
+		} else {
+			mii_head = mii_tail = mip;
+			out_be32(&fec->mii_data, regval);
+		}
+	} else
+		retval = 1;
+
+	restore_flags(flags);
+
+	return retval;
+}
+
+static void mii_do_cmd(struct net_device *dev, const phy_cmd_t *c)
+{
+	int k;
+
+	if (!c)
+		return;
+
+	for (k = 0; (c+k)->mii_data != mk_mii_end; k++)
+		mii_queue(dev, (c+k)->mii_data, (c+k)->funct, 0);
+}
+
+static void mii_parse_sr(uint mii_reg, struct net_device *dev, uint data)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	uint s = priv->phy_status;
+
+	s &= ~(PHY_STAT_LINK | PHY_STAT_FAULT | PHY_STAT_ANC);
+
+	if (mii_reg & 0x0004)
+		s |= PHY_STAT_LINK;
+	if (mii_reg & 0x0010)
+		s |= PHY_STAT_FAULT;
+	if (mii_reg & 0x0020)
+		s |= PHY_STAT_ANC;
+
+	priv->phy_status = s;
+}
+
+static void mii_parse_cr(uint mii_reg, struct net_device *dev, uint data)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	uint s = priv->phy_status;
+
+	s &= ~(PHY_CONF_ANE | PHY_CONF_LOOP);
+
+	if (mii_reg & 0x1000)
+		s |= PHY_CONF_ANE;
+	if (mii_reg & 0x4000)
+		s |= PHY_CONF_LOOP;
+
+	priv->phy_status = s;
+}
+
+static void mii_parse_anar(uint mii_reg, struct net_device *dev, uint data)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	uint s = priv->phy_status;
+
+	s &= ~(PHY_CONF_SPMASK);
+
+	if (mii_reg & 0x0020)
+		s |= PHY_CONF_10HDX;
+	if (mii_reg & 0x0040)
+		s |= PHY_CONF_10FDX;
+	if (mii_reg & 0x0080)
+		s |= PHY_CONF_100HDX;
+	if (mii_reg & 0x0100)
+		s |= PHY_CONF_100FDX;
+
+	priv->phy_status = s;
+}
+
+/* ------------------------------------------------------------------------- */
+/* Generic PHY support.  Should work for all PHYs, but does not support link
+ * change interrupts.
+ */
+#ifdef CONFIG_FEC_GENERIC_PHY
+
+static phy_info_t phy_info_generic = {
+	0x00000000, /* 0-->match any PHY */
+	"GENERIC",
+
+	(const phy_cmd_t []) {  /* config */
+		/* advertise only half-duplex capabilities */
+		{ mk_mii_write(MII_ADVERTISE, MII_ADVERTISE_HALF),
+			mii_parse_anar },
+
+		/* enable auto-negotiation */
+		{ mk_mii_write(MII_BMCR, BMCR_ANENABLE), mii_parse_cr },
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) {  /* startup */
+		/* restart auto-negotiation */
+		{ mk_mii_write(MII_BMCR, (BMCR_ANENABLE | BMCR_ANRESTART)),
+			NULL },
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) { /* ack_int */
+		/* We don't actually use the ack_int table with a generic
+		 * PHY, but putting a reference to mii_parse_sr here keeps
+		 * us from getting a compiler warning about unused static
+		 * functions in the case where we only compile in generic
+		 * PHY support.
+		 */
+		{ mk_mii_read(MII_BMSR), mii_parse_sr },
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) {  /* shutdown */
+		{ mk_mii_end, }
+	},
+};
+#endif	/* CONFIG_FEC_GENERIC_PHY */
+
+/* ------------------------------------------------------------------------- */
+/* The Level one LXT971 is used on some of my custom boards		     */
+
+#ifdef CONFIG_FEC_LXT971
+
+/* register definitions for the 971 */
+
+#define MII_LXT971_PCR	16	/* Port Control Register	*/
+#define MII_LXT971_SR2	17	/* Status Register 2		*/
+#define MII_LXT971_IER	18	/* Interrupt Enable Register	*/
+#define MII_LXT971_ISR	19	/* Interrupt Status Register	*/
+#define MII_LXT971_LCR	20	/* LED Control Register		*/
+#define MII_LXT971_TCR	30	/* Transmit Control Register	*/
+
+static void mii_parse_lxt971_sr2(uint mii_reg, struct net_device *dev, uint data)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	uint s = priv->phy_status;
+
+	s &= ~(PHY_STAT_SPMASK);
+
+	if (mii_reg & 0x4000) {
+		if (mii_reg & 0x0200)
+			s |= PHY_STAT_100FDX;
+		else
+			s |= PHY_STAT_100HDX;
+	}
+	else {
+		if (mii_reg & 0x0200)
+			s |= PHY_STAT_10FDX;
+		else
+			s |= PHY_STAT_10HDX;
+	}
+	if (mii_reg & 0x0008)
+		s |= PHY_STAT_FAULT;
+
+	priv->full_duplex = ((mii_reg & 0x0200) != 0);
+
+	priv->phy_status = s;
+}
+
+static phy_info_t phy_info_lxt971 = {
+	0x0001378e,
+	"LXT971",
+
+	(const phy_cmd_t []) {	/* config */
+#ifdef MPC5100_FIX10HDX
+		{ mk_mii_write(MII_REG_ANAR, 0x021), NULL }, /* 10 Mbps, HD */
+#else
+/*		{ mk_mii_write(MII_REG_ANAR, 0x0A1), NULL }, *//*  10/100, HD */
+		{ mk_mii_write(MII_REG_ANAR, 0x01E1), NULL }, /* 10/100, FD */
+#endif
+		{ mk_mii_read(MII_REG_CR), mii_parse_cr },
+		{ mk_mii_read(MII_REG_ANAR), mii_parse_anar },
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) {	/* startup - enable interrupts */
+		{ mk_mii_write(MII_LXT971_IER, 0x00f2), NULL },
+		{ mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */
+
+		/* Somehow does the 971 tell me that the link is down
+		 * the first read after power-up.
+		 * read here to get a valid value in ack_int */
+
+		{ mk_mii_read(MII_REG_SR), mii_parse_sr },
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) { /* ack_int */
+		/* find out the current status */
+
+		{ mk_mii_read(MII_REG_SR), mii_parse_sr },
+		{ mk_mii_read(MII_LXT971_SR2), mii_parse_lxt971_sr2 },
+
+		/* we only need to read ISR to acknowledge */
+
+		{ mk_mii_read(MII_LXT971_ISR), NULL },
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) {	/* shutdown - disable interrupts */
+		{ mk_mii_write(MII_LXT971_IER, 0x0000), NULL },
+		{ mk_mii_end, }
+	},
+};
+
+#endif /* CONFIG_FEC_LXT971 */
+
+static phy_info_t *phy_info[] = {
+
+#ifdef CONFIG_FEC_LXT971
+	&phy_info_lxt971,
+#endif /* CONFIG_FEC_LXT971 */
+
+#ifdef CONFIG_FEC_GENERIC_PHY
+	/* Generic PHY support.  This must be the last PHY in the table.
+	 * It will be used to support any PHY that doesn't match a previous
+	 * entry in the table.
+	 */
+	&phy_info_generic,
+#endif /* CONFIG_FEC_GENERIC_PHY */
+
+	NULL
+};
+
+static void mii_display_config(struct net_device *dev)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	uint s = priv->phy_status;
+
+	printk("%s: config: auto-negotiation ", dev->name);
+
+	if (s & PHY_CONF_ANE)
+		printk("on");
+	else
+		printk("off");
+
+	if (s & PHY_CONF_100FDX)
+		printk(", 100FDX");
+	if (s & PHY_CONF_100HDX)
+		printk(", 100HDX");
+	if (s & PHY_CONF_10FDX)
+		printk(", 10FDX");
+	if (s & PHY_CONF_10HDX)
+		printk(", 10HDX");
+	if (!(s & PHY_CONF_SPMASK))
+		printk(", No speed/duplex selected?");
+
+	if (s & PHY_CONF_LOOP)
+		printk(", loopback enabled");
+
+	printk(".\n");
+
+	priv->sequence_done = 1;
+}
+
+static void mii_queue_config(uint mii_reg, struct net_device *dev, uint data)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+
+	priv->phy_task.func = (void *)mii_display_config;
+	priv->phy_task.data = dev;
+	schedule_work(&priv->phy_task);
+}
+
+
+phy_cmd_t phy_cmd_config[] = { { mk_mii_read(MII_REG_CR), mii_queue_config },
+			       { mk_mii_end, } };
+
+
+/* Read remainder of PHY ID.
+*/
+static void
+mii_discover_phy3(uint mii_reg, struct net_device *dev, uint data)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	int	i;
+
+	priv->phy_id |= (mii_reg & 0xffff);
+
+	for (i = 0; phy_info[i]; i++) {
+		if (phy_info[i]->id == (priv->phy_id >> 4) || !phy_info[i]->id)
+			break;
+		if (phy_info[i]->id == 0)	/* check generic entry */
+			break;
+	}
+
+	if (!phy_info[i])
+		panic("%s: PHY id 0x%08x is not supported!\n",
+			dev->name, priv->phy_id);
+
+	priv->phy = phy_info[i];
+	priv->phy_id_done = 1;
+
+	printk("%s: Phy @ 0x%x, type %s (0x%08x)\n",
+		dev->name, priv->phy_addr, priv->phy->name, priv->phy_id);
+}
+
+/* Scan all of the MII PHY addresses looking for someone to respond
+ * with a valid ID.  This usually happens quickly.
+ */
+static void
+mii_discover_phy(uint mii_reg, struct net_device *dev, uint data)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	uint	phytype;
+
+	if ((phytype = (mii_reg & 0xffff)) != 0xffff) {
+		/* Got first part of ID, now get remainder.
+		*/
+		priv->phy_id = phytype << 16;
+		mii_queue(dev, mk_mii_read(MII_REG_PHYIR2), mii_discover_phy3, 0);
+	} else {
+		priv->phy_addr++;
+		if (priv->phy_addr < 32)
+			mii_queue(dev, mk_mii_read(MII_REG_PHYIR1),
+							mii_discover_phy, 0);
+		else
+			printk("fec: No PHY device found.\n");
+	}
+}
+#endif	/* CONFIG_FEC_USE_MDIO */
+
+
+#define RFIFO_DATA	0xf0003184
+#define TFIFO_DATA	0xf00031a4
+
+/*
+ * Initialize FEC receive task.
+ * Returns task number of FEC receive task.
+ * Returns -1 on failure
+ */
+int
+mpc52xx_fec_rx_task_setup(int num_bufs, int maxbufsize)
+{
+	static TaskSetupParamSet_t params;
+	int tasknum;
+
+	params.NumBD = num_bufs;
+	params.Size.MaxBuf = maxbufsize;
+	params.StartAddrSrc = RFIFO_DATA;
+	params.IncrSrc = 0;
+	params.SzSrc = 4;
+	params.IncrDst = 4;
+	params.SzDst = 4;
+
+	tasknum = TaskSetup(TASK_FEC_RX, &params);
+
+	/* clear pending interrupt bits */
+	TaskIntClear(tasknum);
+
+	return tasknum;
+}
+
+/*
+ * Initialize FEC transmit task.
+ * Returns task number of FEC transmit task.
+ * Returns -1 on failure
+ */
+int
+mpc52xx_fec_tx_task_setup(int num_bufs)
+{
+	static TaskSetupParamSet_t params;
+	int tasknum;
+
+	params.NumBD = num_bufs;
+	params.IncrSrc = 4;
+	params.SzSrc = 4;
+	params.StartAddrDst = TFIFO_DATA;
+	params.IncrDst = 0;
+	params.SzDst = 4;
+
+	tasknum = TaskSetup(TASK_FEC_TX, &params);
+
+	/* clear pending interrupt bits */
+	TaskIntClear(tasknum);
+
+	return tasknum;
+}
+
+
+static volatile int tx_fifo_cnt, tx_fifo_ipos, tx_fifo_opos;
+static struct sk_buff *tx_fifo_skb[MPC52xx_FEC_TBD_NUM];
+
+static volatile int rx_fifo_cnt, rx_fifo_ipos, rx_fifo_opos;
+static struct sk_buff *rx_fifo_skb[MPC52xx_FEC_RBD_NUM];
+
+static int
+mpc52xx_fec_setup(struct net_device *dev, int reinit)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	struct sk_buff *skb;
+	int i;
+	struct mpc52xx_rbuf *rbuf;
+	struct mpc52xx_fec *fec = priv->fec;
+#if 0
+	u32 u32_value;
+#endif
+	u16 u16_value;
+
+	mpc52xx_fec_set_paddr(dev, dev->dev_addr);
+
+	/*
+	 * Initialize receive queue
+	 */
+	priv->r_tasknum = mpc52xx_fec_rx_task_setup(MPC52xx_FEC_RBD_NUM,
+						    MPC52xx_FEC_RECV_BUFFER_SIZE);
+	TaskBDReset(priv->r_tasknum);
+	for(i=0;i<MPC52xx_FEC_RBD_NUM;i++) {
+	  skb = dev_alloc_skb(sizeof *rbuf);
+	  if (skb == 0)
+	    goto eagain;
+	  skb->dev = dev;
+	  rbuf = (struct mpc52xx_rbuf *)skb_put(skb, sizeof *rbuf);
+	  invalidate_dcache_range((u32)rbuf, (u32)rbuf + sizeof *rbuf);
+	  rx_fifo_skb[i]=skb;
+	  TaskBDAssign(priv->r_tasknum, (void*)virt_to_phys((void *)&rbuf->data),
+		       0, sizeof *rbuf, MPC52xx_FEC_RBD_INIT);
+	};
+	rx_fifo_cnt = rx_fifo_ipos = rx_fifo_opos = 0;
+#if 0
+	printk("fec_open:\n");
+	checkrxbd(dev);
+#endif
+
+	/*
+	 * Initialize transmit queue
+	 */
+	if(!reinit) {
+	  priv->t_tasknum = mpc52xx_fec_tx_task_setup(MPC52xx_FEC_TBD_NUM);
+	  TaskBDReset(priv->t_tasknum);
+	  for(i=0;i<MPC52xx_FEC_TBD_NUM;i++) tx_fifo_skb[i]=0;
+	  tx_fifo_cnt = tx_fifo_ipos = tx_fifo_opos = 0;
+
+#ifdef CONFIG_FEC_USE_MDIO
+	  if (reinit) {
+	    if (!priv->sequence_done) {
+	      if (!priv->phy) {
+		printk("mpc52xx_fec_open: PHY not configured\n");
+		return -ENODEV;		/* No PHY we understand */
+	      }
+	      
+	      mii_do_cmd(dev, priv->phy->config);
+	      mii_do_cmd(dev, phy_cmd_config);  /* display configuration */
+	      while(!priv->sequence_done)
+		schedule();
+	      
+	      mii_do_cmd(dev, priv->phy->startup);
+	    }
+	  }
+#endif /* CONFIG_FEC_USE_MDIO */
+	  
+	  dev->irq = MPC52xx_FEC_IRQ;
+	  priv->r_irq = MPC52xx_SDMA_IRQ_BASE + priv->r_tasknum;
+	  priv->t_irq = MPC52xx_SDMA_IRQ_BASE + priv->t_tasknum;
+	  
+	  if (request_irq(dev->irq, &mpc52xx_fec_interrupt,
+			  SA_INTERRUPT | SA_SAMPLE_RANDOM, "eth_err", dev)) {
+	    panic("FEC interrupt allocation failed\n");
+	  }
+	  
+	  if (request_irq(priv->r_irq, &mpc52xx_fec_receive_interrupt,
+			  SA_INTERRUPT | SA_SAMPLE_RANDOM, "eth_recv", dev)) {
+	    panic("FEC receive task interrupt allocation failed\n");
+	  }
+	  
+	  if (request_irq(priv->t_irq, &mpc52xx_fec_transmit_interrupt,
+			  SA_INTERRUPT | SA_SAMPLE_RANDOM, "eth_xmit", dev)) {
+	    panic("FEC transmit task interrupt allocation failed\n");
+	  }
+	
+	};
+
+	out_be32(&fec->op_pause, 0x00010020);	/* change to 0xffff0020 ??? */
+	out_be32(&fec->rfifo_cntrl, 0x0f000000);
+	out_be32(&fec->rfifo_alarm, 0x0000030c);
+	out_be32(&fec->tfifo_cntrl, 0x0f000000);
+	out_be32(&fec->tfifo_alarm, 0x00000100);
+	out_be32(&fec->x_wmrk, 0x3);		/* xmit fifo watermark = 256 */
+	out_be32(&fec->xmit_fsm, 0x03000000);	/* enable crc generation */
+	out_be32(&fec->iaddr1, 0x00000000);	/* No individual filter */
+	out_be32(&fec->iaddr2, 0x00000000);	/* No individual filter */
+	
+#ifdef CONFIG_PPC_MPC52xx
+	/* Disable COMM Bus Prefetch */
+	u16_value = in_be16(&priv->sdma->PtdCntrl);
+	u16_value |= 1;
+	out_be16(&priv->sdma->PtdCntrl, u16_value);
+#endif
+
+	if(!reinit) {
+#if !defined(CONFIG_FEC_USE_MDIO)
+	  mpc52xx_fec_restart (dev, 0);	/* always use half duplex mode only */
+#else
+#ifdef CONFIG_UBOOT
+	  bd_t *bd = (bd_t *)&__res;
+#define MPC52xx_IPBFREQ bd->bi_ipbfreq
+#else
+#define MPC52xx_IPBFREQ CONFIG_PPC_52xx_IPBFREQ
+#endif
+	  for (i=0; i<NMII-1; i++)
+	    mii_cmds[i].mii_next = &mii_cmds[i+1];
+	  mii_free = mii_cmds;
+
+	  priv->phy_speed = (((MPC52xx_IPBFREQ >> 20) / 5) << 1);
+
+	  //mpc52xx_fec_restart (dev, 0);	/* half duplex, negotiate speed */
+	  mpc52xx_fec_restart (dev, 1);	/* full duplex, negotiate speed */
+	  
+	  /* Queue up command to detect the PHY and initialize the
+	   * remainder of the interface.
+	   */
+	  priv->phy_id_done = 0;
+	  priv->phy_addr = 0;
+	  mii_queue(dev, mk_mii_read(MII_REG_PHYIR1), mii_discover_phy, 0);
+	  
+	  priv->old_status = 0;
+
+#ifdef CONFIG_FEC_USE_MDIO
+	  if (reinit) {
+	    if (!priv->sequence_done) {
+	      if (!priv->phy) {
+		printk("mpc52xx_fec_open: PHY not configured\n");
+		return -ENODEV;		/* No PHY we understand */
+	      }
+	      
+	      mii_do_cmd(dev, priv->phy->config);
+	      mii_do_cmd(dev, phy_cmd_config);  /* display configuration */
+	      while(!priv->sequence_done)
+		schedule();
+	      
+	      mii_do_cmd(dev, priv->phy->startup);
+	    }
+	  }
+#endif /* CONFIG_FEC_USE_MDIO */
+#endif
+	}
+	else {
+	  mpc52xx_fec_restart (dev, 0);
+	};
+
+	netif_start_queue(dev);
+
+	TaskStart(priv->r_tasknum, TASK_AUTOSTART_ENABLE,
+		  priv->r_tasknum, TASK_INTERRUPT_ENABLE);
+
+	if(reinit) {
+	  TaskStart(priv->t_tasknum, TASK_AUTOSTART_ENABLE,
+		    priv->t_tasknum, TASK_INTERRUPT_ENABLE);
+	};
+
+	return 0;
+
+eagain:
+	printk("mpc52xx_fec_open: failed\n");
+	for (i=0; i<MPC52xx_FEC_RBD_NUM; i++) {
+		skb = rx_fifo_skb[i];
+		if (skb == 0)
+			break;
+		dev_kfree_skb(skb);
+	}
+	TaskBDReset(priv->r_tasknum);
+
+	return -EAGAIN;
+}
+
+
+static int
+mpc52xx_fec_open(struct net_device *dev)
+{
+  int ret = mpc52xx_fec_setup(dev,0);
+  return ret;
+}
+
+/* This will only be invoked if your driver is _not_ in XOFF state.
+ * What this means is that you need not check it, and that this
+ * invariant will hold if you make sure that the netif_*_queue()
+ * calls are done at the proper times.
+ */
+
+static int
+mpc52xx_fec_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	int pad;
+	short length;
+	int bdi;
+
+	length = skb->len;
+#define MUST_ALIGN_TRANSMIT_DATA
+#ifdef	MUST_ALIGN_TRANSMIT_DATA
+	pad = (int)skb->data & 0x3;
+	if (pad) {
+		void *old_data = skb->data;
+		skb_push(skb, pad);
+		memcpy(skb->data, old_data, length);
+		skb_trim(skb, length);
+	}
+#endif
+	/* Zero out up to the minimum length ethernet packet size,
+	 * so we don't inadvertently expose sensitive data
+	 */ 
+	pad = ETH_ZLEN - skb->len;
+	if (pad > 0) {
+		skb = skb_pad(skb, pad);
+		if (skb == 0)
+			return 0;
+		length += pad;
+	}
+
+	flush_dcache_range((u32)skb->data, (u32)skb->data + length);
+
+	spin_lock_irq(&priv->lock);
+	bdi = TaskBDAssign(priv->t_tasknum,(void*)virt_to_phys((void *)skb->data),
+			   NULL,length,MPC52xx_FEC_TBD_INIT);
+
+	// sanity check: bdi must always equal tx_fifo_ipos
+	if(bdi!=tx_fifo_ipos) {
+	  printk("bdi!=tx_fifo_ipos: %i, %i\n",bdi,tx_fifo_ipos);
+	};
+
+	tx_fifo_skb[tx_fifo_ipos]=skb;
+	dev->trans_start = jiffies;
+        TaskStart(priv->t_tasknum, TASK_AUTOSTART_ENABLE,
+		  priv->t_tasknum, TASK_INTERRUPT_ENABLE);
+
+	tx_fifo_cnt++;
+	tx_fifo_ipos++;
+	if(tx_fifo_ipos==MPC52xx_FEC_TBD_NUM) tx_fifo_ipos=0;
+
+	if(tx_fifo_cnt==MPC52xx_FEC_TBD_NUM) {
+		priv->tx_full = 1;
+		netif_stop_queue(dev);
+		printk("fifo full\n");
+	};
+
+	spin_unlock_irq(&priv->lock);
+
+	return 0;
+}
+
+/* This handles SDMA transmit task interrupts
+ */
+static irqreturn_t 
+mpc52xx_fec_transmit_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+{
+	struct net_device *dev = dev_id;
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	int bdi;
+
+	spin_lock(&priv->lock);
+
+	// Already ACK'ed in linux toplevel ISR 
+	// TaskIntClear(priv->t_tasknum);
+
+	while(tx_fifo_cnt) {
+	  if(TaskGetBD(priv->t_tasknum, tx_fifo_opos)->Status & MPC52xx_FEC_TBD_TFD)
+	    break;
+	  dev_kfree_skb_irq(tx_fifo_skb[tx_fifo_opos]);
+	  tx_fifo_skb[tx_fifo_opos]=0;
+	  bdi = TaskBDRelease(priv->t_tasknum);
+	  tx_fifo_cnt--;
+	  tx_fifo_opos++;
+	  if(tx_fifo_opos==MPC52xx_FEC_TBD_NUM) tx_fifo_opos=0;
+	  priv->tx_full = 0;
+
+	  // sanity check: bdi must always equal tx_fifo_opos
+	  if(bdi!=tx_fifo_opos) {
+	    printk("bdi!=tx_fifo_opos: %i, %i\n",bdi,tx_fifo_opos);
+	  };
+	};
+
+	if (netif_queue_stopped(dev) && !priv->tx_full)
+		netif_wake_queue(dev);
+
+	spin_unlock(&priv->lock);
+
+	return IRQ_HANDLED;
+}
+
+
+static irqreturn_t 
+mpc52xx_fec_receive_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+{
+	struct net_device *dev = dev_id;
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	struct sk_buff *skb;
+	struct sk_buff *nskb;
+	struct mpc52xx_rbuf *rbuf;
+	struct mpc52xx_rbuf *nrbuf;
+	u32 status;
+	int length;
+
+	// Already ACK'ed in linux toplevel ISR 
+	// TaskIntClear(priv->r_tasknum);
+
+	for (;;) {
+		status = TaskGetBD(priv->r_tasknum,rx_fifo_opos)->Status;
+		if (!(status & MPC52xx_FEC_RBD_RFD))
+			break;
+		length = status & 0xffff;
+		skb = rx_fifo_skb[rx_fifo_opos];
+		rbuf = (struct mpc52xx_rbuf *)skb->data;
+
+		/* allocate replacement skb */
+		nskb = dev_alloc_skb(sizeof *nrbuf);
+		if (nskb == NULL) {
+			printk(KERN_NOTICE
+			"%s: Memory squeeze, dropping packet.\n",
+				dev->name);
+			priv->stats.rx_dropped++;
+			nrbuf = (struct mpc52xx_rbuf *)skb->data;
+		}
+		else {
+			nskb->dev = dev;
+			nrbuf = (struct mpc52xx_rbuf *)skb_put(nskb,
+					sizeof *nrbuf);
+
+			invalidate_dcache_range((u32)nrbuf,
+					(u32)nrbuf + sizeof *nrbuf);
+
+			skb_trim(skb, length);
+			skb->protocol = eth_type_trans(skb, dev);
+			netif_rx(skb);
+			dev->last_rx = jiffies;
+			rx_fifo_skb[rx_fifo_opos] = nskb;
+
+		}
+
+		TaskBDRelease(priv->r_tasknum);
+		TaskBDAssign(priv->r_tasknum, (void*)virt_to_phys((void *)&nrbuf->data),
+			     0, sizeof *rbuf, MPC52xx_FEC_RBD_INIT);
+
+		rx_fifo_opos++;
+		if(rx_fifo_opos==MPC52xx_FEC_RBD_NUM) rx_fifo_opos=0;
+
+		if (!nskb)
+			break;
+
+	}
+
+	return IRQ_HANDLED;
+}
+
+
+static void mpc52xx_fec_reinit(struct net_device *dev)
+{
+  int retval;
+  printk("mpc52xx_fec_reinit\n");
+  mpc52xx_fec_cleanup(dev,1);
+  retval=mpc52xx_fec_setup(dev,1);
+  if(retval) panic("reinit failed\n");
+};
+
+
+#define LONG_REF(x) (*((volatile unsigned long*)x))
+#define SHORT_REF(x) (*((volatile unsigned short*)x))
+static void checkrxbd(struct net_device *dev) {
+  struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+#if 0
+  int stat[64];
+  int i;
+  for(i=0;i<64;i++) {
+    stat[i] = TaskGetBD(priv->r_tasknum,i)->Status;
+  };
+  for(i=0;i<64;i++) {
+    printk("status[%i]=0x%08x\n",i,stat[i]);
+  };
+#endif
+  printk("SDMA IRQ pending = 0x%08lx\n",LONG_REF(0xf0001214));
+  printk("SDMA IRQ mask    = 0x%08lx\n",LONG_REF(0xf0001218));
+  printk("SDMA Task CTRL0  = 0x%04x\n",SHORT_REF(0xf000121c));
+  printk("SDMA Task CTRL1  = 0x%04x\n",SHORT_REF(0xf000121e));
+  printk("SDMA Task CTRL2  = 0x%04x\n",SHORT_REF(0xf0001220));
+  printk("SDMA Task CTRL3  = 0x%04x\n",SHORT_REF(0xf0001222));
+  printk("SDMA Task CTRL4  = 0x%04x\n",SHORT_REF(0xf0001224));
+  printk("SDMA Task CTRL5  = 0x%04x\n",SHORT_REF(0xf0001226));
+  printk("SDMA Task CTRL6  = 0x%04x\n",SHORT_REF(0xf0001228));
+  printk("SDMA Task CTRL7  = 0x%04x\n",SHORT_REF(0xf000122a));
+  printk("SDMA Task CTRL8  = 0x%04x\n",SHORT_REF(0xf000122c));
+  printk("SDMA Task CTRL9  = 0x%04x\n",SHORT_REF(0xf000122e));
+  printk("SDMA Task CTRL10 = 0x%04x\n",SHORT_REF(0xf0001230));
+  printk("SDMA Task CTRL11 = 0x%04x\n",SHORT_REF(0xf0001232));
+  printk("SDMA Task CTRL12 = 0x%04x\n",SHORT_REF(0xf0001234));
+  printk("SDMA Task CTRL13 = 0x%04x\n",SHORT_REF(0xf0001236));
+  printk("SDMA Task CTRL14 = 0x%04x\n",SHORT_REF(0xf0001238));
+  printk("SDMA Task CTRL15 = 0x%04x\n",SHORT_REF(0xf000123a));
+  printk("r_tasknum=%i\n",priv->r_tasknum);
+  printk("t_tasknum=%i\n",priv->t_tasknum);
+};
+
+static irqreturn_t 
+mpc52xx_fec_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct net_device *dev = (struct net_device *)dev_id;
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	struct mpc52xx_fec *fec = priv->fec;
+	int ievent;
+
+	ievent = in_be32(&fec->ievent);
+	out_be32(&fec->ievent, ievent);		/* clear pending events */
+
+	if (ievent & (MPC52xx_FEC_IEVENT_RFIFO_ERROR |
+		      MPC52xx_FEC_IEVENT_XFIFO_ERROR)) {
+		if (ievent & MPC52xx_FEC_IEVENT_RFIFO_ERROR)
+			printk(KERN_WARNING "MPC52xx_FEC_IEVENT_RFIFO_ERROR\n");
+		if (ievent & MPC52xx_FEC_IEVENT_XFIFO_ERROR)
+			printk(KERN_WARNING "MPC52xx_FEC_IEVENT_XFIFO_ERROR\n");
+		printk("fec_irq:\n");
+		checkrxbd(dev);
+		mpc52xx_fec_reinit(dev);
+	}
+	else if (ievent & MPC52xx_FEC_IEVENT_MII) {
+#ifdef CONFIG_FEC_USE_MDIO
+		mpc52xx_fec_mii(dev);
+#else
+		printk("%s[%d] %s: unexpected MPC52xx_FEC_IEVENT_MII\n"
+			__FILE__, __LINE__, __FUNCTION__);
+#endif /* CONFIG_FEC_USE_MDIO */
+	}
+	else {
+	  printk("fec: ievent=0x%08x\n",ievent);
+	};
+	return IRQ_HANDLED;
+}
+
+static int
+mpc52xx_fec_cleanup(struct net_device *dev, int reinit)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	struct mpc52xx_fec *fec = priv->fec;
+	unsigned long timeout;
+	int i;
+
+	priv->open_time = 0;
+#ifdef CONFIG_FEC_USE_MDIO
+	priv->sequence_done = 0;
+#endif
+
+	netif_stop_queue(dev);
+
+	/* Wait for rx queue to drain */
+	if(!reinit) {
+	  timeout = jiffies + 2*HZ;
+	  while (tx_fifo_cnt && (jiffies < timeout)) {
+	    set_current_state(TASK_INTERRUPTIBLE);
+	    schedule_timeout(HZ/10);
+	  }
+	};
+
+	/* Disable FEC interrupts */
+	out_be32(&fec->imask, 0x0); 
+
+	/* Stop FEC */
+	out_be32(&fec->ecntrl, in_be32(&fec->ecntrl) & ~0x2);
+
+	/* Disable the rx and tx queues. */
+	TaskStop(priv->r_tasknum);
+	TaskStop(priv->t_tasknum);
+
+	/* Release irqs */
+	if(!reinit) {
+	  free_irq(dev->irq, dev);
+	  free_irq(priv->r_irq, dev);
+	  free_irq(priv->t_irq, dev);
+	};
+
+	/* Free rx Buffers */
+	if(!reinit) {
+	  for (i=0; i<MPC52xx_FEC_RBD_NUM; i++) {
+	    dev_kfree_skb(rx_fifo_skb[i]);
+	  };
+	}
+	else {
+	  for (i=0; i<MPC52xx_FEC_RBD_NUM; i++) {
+	    dev_kfree_skb_irq(rx_fifo_skb[i]);
+	  };
+	};
+	
+	mpc52xx_fec_get_stats(dev);
+
+	return 0;
+}
+
+static int
+mpc52xx_fec_close(struct net_device *dev)
+{
+  return mpc52xx_fec_cleanup(dev,0);
+}
+
+/*
+ * Get the current statistics.
+ * This may be called with the card open or closed.
+ */
+static struct net_device_stats *
+mpc52xx_fec_get_stats(struct net_device *dev)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	struct net_device_stats *stats = &priv->stats;
+	struct mpc52xx_fec *fec = priv->fec;
+
+	stats->rx_bytes = in_be32(&fec->rmon_r_octets);
+	stats->rx_packets = in_be32(&fec->rmon_r_packets);
+	stats->rx_errors = stats->rx_packets - in_be32(&fec->ieee_r_frame_ok);
+	stats->tx_bytes = in_be32(&fec->rmon_t_octets);
+	stats->tx_packets = in_be32(&fec->rmon_t_packets);
+	stats->tx_errors = stats->tx_packets - (
+					in_be32(&fec->ieee_t_frame_ok) +
+					in_be32(&fec->rmon_t_col) +
+					in_be32(&fec->ieee_t_1col) +
+					in_be32(&fec->ieee_t_mcol) +
+					in_be32(&fec->ieee_t_def));
+	stats->multicast = in_be32(&fec->rmon_r_mc_pkt);
+	stats->collisions = in_be32(&fec->rmon_t_col);
+
+	/* detailed rx_errors: */
+	stats->rx_length_errors = in_be32(&fec->rmon_r_undersize)
+			+ in_be32(&fec->rmon_r_oversize)
+			+ in_be32(&fec->rmon_r_frag)
+			+ in_be32(&fec->rmon_r_jab);
+	stats->rx_over_errors = in_be32(&fec->r_macerr);
+	stats->rx_crc_errors = in_be32(&fec->ieee_r_crc);
+	stats->rx_frame_errors = in_be32(&fec->ieee_r_align);
+	stats->rx_fifo_errors = in_be32(&fec->rmon_r_drop);
+	stats->rx_missed_errors = in_be32(&fec->rmon_r_drop);
+
+	/* detailed tx_errors: */
+	stats->tx_aborted_errors = 0;
+	stats->tx_carrier_errors = in_be32(&fec->ieee_t_cserr);
+	stats->tx_fifo_errors = in_be32(&fec->rmon_t_drop);
+	stats->tx_heartbeat_errors = in_be32(&fec->ieee_t_sqe);
+	stats->tx_window_errors = in_be32(&fec->ieee_t_lcol);
+
+	return stats;
+}
+
+static void
+mpc52xx_fec_update_stat(struct net_device *dev)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	struct net_device_stats *stats = &priv->stats;
+	struct mpc52xx_fec *fec = priv->fec;
+
+	out_be32(&fec->mib_control, MPC52xx_FEC_MIB_DISABLE);
+	memset_io(&fec->rmon_t_drop, 0,
+			(u32)&fec->reserved10 - (u32)&fec->rmon_t_drop);
+	out_be32(&fec->mib_control, 0);
+	memset(stats, 0, sizeof *stats);
+	mpc52xx_fec_get_stats(dev);
+}
+
+/*
+ * Set or clear the multicast filter for this adaptor.
+ */
+static void
+mpc52xx_fec_set_multicast_list(struct net_device *dev)
+{
+	struct mpc52xx_fec_priv *priv = (struct mpc52xx_fec_priv *)dev->priv;
+	struct mpc52xx_fec *fec = priv->fec;
+	u32 u32_value;
+
+	if (dev->flags & IFF_PROMISC) {
+		printk("%s: Promiscuous mode enabled.\n", dev->name);
+		u32_value = in_be32(&fec->r_cntrl);
+		u32_value |= MPC52xx_FEC_RCNTRL_PROM;
+		out_be32(&fec->r_cntrl, u32_value);
+	}
+	else if (dev->flags & IFF_ALLMULTI) {
+		u32_value = in_be32(&fec->r_cntrl);
+		u32_value &= ~MPC52xx_FEC_RCNTRL_PROM;
+		out_be32(&fec->r_cntrl, u32_value);
+		out_be32(&fec->gaddr1, 0xffffffff);
+		out_be32(&fec->gaddr2, 0xffffffff);
+	}
+	else {
+		u32 crc;
+		int i;
+		struct dev_mc_list *dmi;
+		u32 gaddr1 = 0x00000000;
+		u32 gaddr2 = 0x00000000;
+
+		dmi = dev->mc_list;
+		for (i=0; i<dev->mc_count; i++) {
+			crc = ether_crc_le(6, dmi->dmi_addr) >> 26;
+			if (crc >= 32)
+				gaddr1 |= 1 << (crc-32);
+			else
+				gaddr2 |= 1 << crc;
+			dmi = dmi->next;
+		}
+		out_be32(&fec->gaddr1, gaddr1);
+		out_be32(&fec->gaddr2, gaddr2);
+	}
+}
+
+#ifdef CONFIG_FEC_USE_MDIO
+
+#ifdef CONFIG_FEC_USE_MDIO_NOT_YET
+static void mpc52xx_mdio_callback(uint regval, struct net_device *dev, uint data)
+{
+	mdio_read_data_t* mrd = (mdio_read_data_t *)data;
+	mrd->regval = 0xFFFF & regval;
+	wake_up_process(mrd->sleeping_task);
+}
+
+static int mpc52xx_mdio_read(struct net_device *dev, int phy_id, int location)
+{
+	uint retval;
+	mdio_read_data_t* mrd = (mdio_read_data_t *)kmalloc(sizeof(*mrd),
+			GFP_KERNEL);
+
+	mrd->sleeping_task = current;
+	set_current_state(TASK_INTERRUPTIBLE);
+	mii_queue(dev, mk_mii_read(location),
+		mpc52xx_mdio_callback, (unsigned int) mrd);
+	schedule();
+
+	retval = mrd->regval;
+
+	kfree(mrd);
+
+	return retval;
+}
+#endif
+
+void mdio_write(struct net_device *dev, int phy_id, int location, int value)
+{
+	mii_queue(dev, mk_mii_write(location, value), NULL, 0);
+}
+#endif	/* CONFIG_FEC_USE_MDIO */
+
+static int
+mpc52xx_netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
+{
+#ifdef CONFIG_FEC_USE_MDIO_NOT_YET_XXX
+	struct mpc52xx_fec_priv *private = (struct mpc52xx_fec_priv *)dev->priv;
+#endif
+	u32 ethcmd;
+
+	if (copy_from_user(&ethcmd, useraddr, sizeof ethcmd))
+		return -EFAULT;
+
+	switch (ethcmd) {
+
+		/* Get driver info */
+	case ETHTOOL_GDRVINFO:{
+			struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };
+			strncpy(info.driver, "gt64260",
+				sizeof info.driver - 1);
+			strncpy(info.version, version,
+				sizeof info.version - 1);
+			if (copy_to_user(useraddr, &info, sizeof info))
+				return -EFAULT;
+			return 0;
+		}
+		/* get settings */
+#ifdef CONFIG_FEC_USE_MDIO_NOT_YET_XXX
+	case ETHTOOL_GSET:{
+			struct ethtool_cmd ecmd = { ETHTOOL_GSET };
+			spin_lock_irq(&private->lock);
+			mii_ethtool_gset(&private->mii_if, &ecmd);
+			spin_unlock_irq(&private->lock);
+			if (copy_to_user(useraddr, &ecmd, sizeof ecmd))
+				return -EFAULT;
+			return 0;
+		}
+		/* set settings */
+	case ETHTOOL_SSET:{
+			int r;
+			struct ethtool_cmd ecmd;
+			if (copy_from_user(&ecmd, useraddr, sizeof ecmd))
+				return -EFAULT;
+			spin_lock_irq(&private->lock);
+			r = mii_ethtool_sset(&private->mii_if, &ecmd);
+			spin_unlock_irq(&private->lock);
+			return r;
+		}
+		/* restart autonegotiation */
+	case ETHTOOL_NWAY_RST:{
+			return mii_nway_restart(&private->mii_if);
+		}
+		/* get link status */
+	case ETHTOOL_GLINK:{
+			struct ethtool_value edata = { ETHTOOL_GLINK };
+			edata.data = mii_link_ok(&private->mii_if);
+			if (copy_to_user(useraddr, &edata, sizeof edata))
+				return -EFAULT;
+			return 0;
+		}
+#endif
+		/* get message-level */
+	case ETHTOOL_GMSGLVL:{
+			struct ethtool_value edata = { ETHTOOL_GMSGLVL };
+			edata.data = 0;	/* XXX */
+			if (copy_to_user(useraddr, &edata, sizeof edata))
+				return -EFAULT;
+			return 0;
+		}
+		/* set message-level */
+	case ETHTOOL_SMSGLVL:{
+			struct ethtool_value edata;
+			if (copy_from_user(&edata, useraddr, sizeof edata))
+				return -EFAULT;
+/* debug = edata.data; *//* XXX */
+			return 0;
+		}
+	}
+	return -EOPNOTSUPP;
+}
+
+static int
+mpc52xx_fec_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+#ifdef CONFIG_FEC_USE_MDIO_NOT_YET_XXX
+	struct mii_ioctl_data *data = (struct mii_ioctl_data *) &rq->ifr_data;
+	int phy = dev->base_addr & 0x1f;
+#endif
+	int retval;
+
+	switch (cmd) {
+	case SIOCETHTOOL:
+		retval = mpc52xx_netdev_ethtool_ioctl(
+					dev, (void *) rq->ifr_data);
+		break;
+
+#ifdef CONFIG_FEC_USE_MDIO_NOT_YET_XXX
+	case SIOCGMIIPHY:	/* Get address of MII PHY in use. */
+	case SIOCDEVPRIVATE:	/* for binary compat, remove in 2.5 */
+		data->phy_id = phy;
+		/* Fall through */
+
+	case SIOCGMIIREG:	/* Read MII PHY register. */
+	case SIOCDEVPRIVATE + 1:	/* for binary compat, remove in 2.5 */
+		data->val_out =
+			mpc52xx_mdio_read(dev, data->phy_id&0x1f,
+				data->reg_num&0x1f);
+		retval = 0;
+		break;
+
+	case SIOCSMIIREG:	/* Write MII PHY register. */
+	case SIOCDEVPRIVATE + 2:	/* for binary compat, remove in 2.5 */
+		if (!capable(CAP_NET_ADMIN)) {
+			retval = -EPERM;
+		} else {
+			mdio_write(dev, data->phy_id & 0x1f,
+				data->reg_num & 0x1f, data->val_in);
+			retval = 0;
+		}
+		break;
+#endif
+
+	default:
+		retval = -EOPNOTSUPP;
+		break;
+	}
+	return retval;
+}
+
+static void __init
+mpc52xx_fec_str2mac(char *str, unsigned char *mac)
+{
+	int i;
+	u64 val64;
+
+	val64 = simple_strtoull(str, NULL, 16);
+
+	for (i = 0; i < 6; i++)
+		mac[5-i] = val64 >> (i*8);
+}
+
+static int __init
+mpc52xx_fec_mac_setup(char *mac_address)
+{
+	mpc52xx_fec_str2mac(mac_address, mpc52xx_fec_mac_addr);
+	return 0;
+}
+
+__setup("mpc52xx_mac=", mpc52xx_fec_mac_setup);
+
+static int __init
+mpc52xx_fec_init(void)
+{
+	struct mpc52xx_fec *fec;
+	struct net_device *dev;
+	struct mpc52xx_fec_priv *priv;
+
+	dev = alloc_etherdev(sizeof(struct mpc52xx_fec_priv));
+	if (!dev)
+		return -EIO;
+
+	mpc52xx_fec_dev = dev;
+	priv = (struct mpc52xx_fec_priv *)dev->priv;
+
+	priv->fec = fec = (struct mpc52xx_fec *)ioremap(MPC52xx_PA(MPC52xx_FEC_OFFSET), MPC52xx_FEC_SIZE);
+	priv->gpio = (struct mpc52xx_gpio *)MPC52xx_PA(MPC52xx_GPIO_OFFSET);
+	priv->sdma = (struct mpc52xx_sdma *)MPC52xx_PA(MPC52xx_SDMA_OFFSET);
+
+	spin_lock_init(&priv->lock);
+	dev->open		= mpc52xx_fec_open;
+	dev->stop		= mpc52xx_fec_close;
+	dev->hard_start_xmit	= mpc52xx_fec_hard_start_xmit;
+	dev->do_ioctl		= mpc52xx_fec_ioctl;
+	dev->get_stats		= mpc52xx_fec_get_stats;
+	dev->set_mac_address	= mpc52xx_fec_set_mac_address;
+	dev->set_multicast_list = mpc52xx_fec_set_multicast_list;
+
+	dev->tx_timeout		= mpc52xx_fec_tx_timeout;
+	dev->watchdog_timeo	= MPC52xx_FEC_WATCHDOG_TIMEOUT; 
+	dev->flags &= ~IFF_RUNNING;
+
+#ifdef CONFIG_NET_FASTROUTE
+	dev->accept_fastpath = mpc52xx_fec_accept_fastpath;
+#endif
+	if (memcmp(mpc52xx_fec_mac_addr, null_mac, 6) != 0)
+		memcpy(dev->dev_addr, mpc52xx_fec_mac_addr, 6);
+	else {
+		*(u32 *)&dev->dev_addr[0] = in_be32(&fec->paddr1);
+		*(u16 *)&dev->dev_addr[4] = in_be16((u16*)&fec->paddr2);
+	}
+
+
+	/*
+	 * Read MIB counters in order to reset them,
+	 * then zero all the stats fields in memory
+	 */
+	mpc52xx_fec_update_stat(dev);
+
+	register_netdev(dev);
+	return 0;
+}
+
+static void __exit
+mpc52xx_fec_uninit(void)
+{
+	struct net_device *dev = mpc52xx_fec_dev;
+	unregister_netdev(dev);
+	kfree(dev->priv);
+	dev->priv = NULL;
+}
+
+static int __init
+mpc52xx_fec_module_init(void)
+{
+	return mpc52xx_fec_init();
+}
+
+static void __exit
+mpc52xx_fec_module_exit(void)
+{
+	mpc52xx_fec_uninit();
+}
+
+module_init(mpc52xx_fec_module_init);
+module_exit(mpc52xx_fec_module_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dale Farnsworth");
+MODULE_DESCRIPTION("Ethernet driver for Motorola MPC52xx FEC");
diff --git a/drivers/net/fec_mpc52xx/fec.h b/drivers/net/fec_mpc52xx/fec.h
new file mode 100644
index 0000000..364b871
--- /dev/null
+++ b/drivers/net/fec_mpc52xx/fec.h
@@ -0,0 +1,402 @@
+
+/*
+ * arch/ppc/5xxx_io/fec.h
+ *
+ * Header file for the MPC5xxx Fast Ethernet Controller driver
+ *
+ * Author: Dale Farnsworth <dfarnsworth@mvista.com>
+ *
+ * Copyright 2003 MontaVista Software
+ *
+ * 2003 (c) MontaVista, Software, Inc.  This file is licensed under the terms
+ * of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#ifndef PPC_52XX_IO_FEC_H
+#define PPC_52XX_IO_FEC_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/mii.h>
+#include <linux/skbuff.h>
+#include <asm/mpc52xx.h>
+#include <bestcomm_api.h>
+
+/* Tunable constants */
+#define MPC52xx_FEC_RECV_BUFFER_SIZE	1518	/* max receive packet size */
+#define MPC52xx_FEC_TBD_NUM   		64	/* max transmit packets */
+#define MPC52xx_FEC_RBD_NUM  		64	/* max receive packets */
+
+struct mpc52xx_fec {
+	volatile u32 fec_id;			/* FEC + 0x000 */
+	volatile u32 ievent;			/* FEC + 0x004 */
+	volatile u32 imask;			/* FEC + 0x008 */
+
+	volatile u32 reserved0[1];		/* FEC + 0x00C */
+	volatile u32 r_des_active;		/* FEC + 0x010 */
+	volatile u32 x_des_active;		/* FEC + 0x014 */
+	volatile u32 r_des_active_cl;		/* FEC + 0x018 */
+	volatile u32 x_des_active_cl;		/* FEC + 0x01C */
+	volatile u32 ivent_set;			/* FEC + 0x020 */
+	volatile u32 ecntrl;			/* FEC + 0x024 */
+
+	volatile u32 reserved1[6];		/* FEC + 0x028-03C */
+	volatile u32 mii_data;			/* FEC + 0x040 */
+	volatile u32 mii_speed;			/* FEC + 0x044 */
+	volatile u32 mii_status;		/* FEC + 0x048 */
+
+	volatile u32 reserved2[5];		/* FEC + 0x04C-05C */
+	volatile u32 mib_data;			/* FEC + 0x060 */
+	volatile u32 mib_control;		/* FEC + 0x064 */
+
+	volatile u32 reserved3[6];		/* FEC + 0x068-7C */
+	volatile u32 r_activate;		/* FEC + 0x080 */
+	volatile u32 r_cntrl;			/* FEC + 0x084 */
+	volatile u32 r_hash;			/* FEC + 0x088 */
+	volatile u32 r_data;			/* FEC + 0x08C */
+	volatile u32 ar_done;			/* FEC + 0x090 */
+	volatile u32 r_test;			/* FEC + 0x094 */
+	volatile u32 r_mib;			/* FEC + 0x098 */
+	volatile u32 r_da_low;			/* FEC + 0x09C */
+	volatile u32 r_da_high;			/* FEC + 0x0A0 */
+
+	volatile u32 reserved4[7];		/* FEC + 0x0A4-0BC */
+	volatile u32 x_activate;		/* FEC + 0x0C0 */
+	volatile u32 x_cntrl;			/* FEC + 0x0C4 */
+	volatile u32 backoff;			/* FEC + 0x0C8 */
+	volatile u32 x_data;			/* FEC + 0x0CC */
+	volatile u32 x_status;			/* FEC + 0x0D0 */
+	volatile u32 x_mib;			/* FEC + 0x0D4 */
+	volatile u32 x_test;			/* FEC + 0x0D8 */
+	volatile u32 fdxfc_da1;			/* FEC + 0x0DC */
+	volatile u32 fdxfc_da2;			/* FEC + 0x0E0 */
+	volatile u32 paddr1;			/* FEC + 0x0E4 */
+	volatile u32 paddr2;			/* FEC + 0x0E8 */
+	volatile u32 op_pause;			/* FEC + 0x0EC */
+
+	volatile u32 reserved5[4];		/* FEC + 0x0F0-0FC */
+	volatile u32 instr_reg;			/* FEC + 0x100 */
+	volatile u32 context_reg;		/* FEC + 0x104 */
+	volatile u32 test_cntrl;		/* FEC + 0x108 */
+	volatile u32 acc_reg;			/* FEC + 0x10C */
+	volatile u32 ones;			/* FEC + 0x110 */
+	volatile u32 zeros;			/* FEC + 0x114 */
+	volatile u32 iaddr1;			/* FEC + 0x118 */
+	volatile u32 iaddr2;			/* FEC + 0x11C */
+	volatile u32 gaddr1;			/* FEC + 0x120 */
+	volatile u32 gaddr2;			/* FEC + 0x124 */
+	volatile u32 random;			/* FEC + 0x128 */
+	volatile u32 rand1;			/* FEC + 0x12C */
+	volatile u32 tmp;			/* FEC + 0x130 */
+
+	volatile u32 reserved6[3];		/* FEC + 0x134-13C */
+	volatile u32 fifo_id;			/* FEC + 0x140 */
+	volatile u32 x_wmrk;			/* FEC + 0x144 */
+	volatile u32 fcntrl;			/* FEC + 0x148 */
+	volatile u32 r_bound;			/* FEC + 0x14C */
+	volatile u32 r_fstart;			/* FEC + 0x150 */
+	volatile u32 r_count;			/* FEC + 0x154 */
+	volatile u32 r_lag;			/* FEC + 0x158 */
+	volatile u32 r_read;			/* FEC + 0x15C */
+	volatile u32 r_write;			/* FEC + 0x160 */
+	volatile u32 x_count;			/* FEC + 0x164 */
+	volatile u32 x_lag;			/* FEC + 0x168 */
+	volatile u32 x_retry;			/* FEC + 0x16C */
+	volatile u32 x_write;			/* FEC + 0x170 */
+	volatile u32 x_read;			/* FEC + 0x174 */
+
+	volatile u32 reserved7[2];		/* FEC + 0x178-17C */
+	volatile u32 fm_cntrl;			/* FEC + 0x180 */
+	volatile u32 rfifo_data;		/* FEC + 0x184 */
+	volatile u32 rfifo_status;		/* FEC + 0x188 */
+	volatile u32 rfifo_cntrl;		/* FEC + 0x18C */
+	volatile u32 rfifo_lrf_ptr;		/* FEC + 0x190 */
+	volatile u32 rfifo_lwf_ptr;		/* FEC + 0x194 */
+	volatile u32 rfifo_alarm;		/* FEC + 0x198 */
+	volatile u32 rfifo_rdptr;		/* FEC + 0x19C */
+	volatile u32 rfifo_wrptr;		/* FEC + 0x1A0 */
+	volatile u32 tfifo_data;		/* FEC + 0x1A4 */
+	volatile u32 tfifo_status;		/* FEC + 0x1A8 */
+	volatile u32 tfifo_cntrl;		/* FEC + 0x1AC */
+	volatile u32 tfifo_lrf_ptr;		/* FEC + 0x1B0 */
+	volatile u32 tfifo_lwf_ptr;		/* FEC + 0x1B4 */
+	volatile u32 tfifo_alarm;		/* FEC + 0x1B8 */
+	volatile u32 tfifo_rdptr;		/* FEC + 0x1BC */
+	volatile u32 tfifo_wrptr;		/* FEC + 0x1C0 */
+
+	volatile u32 reset_cntrl;		/* FEC + 0x1C4 */
+	volatile u32 xmit_fsm;			/* FEC + 0x1C8 */
+
+	volatile u32 reserved8[3];		/* FEC + 0x1CC-1D4 */
+	volatile u32 rdes_data0;		/* FEC + 0x1D8 */
+	volatile u32 rdes_data1;		/* FEC + 0x1DC */
+	volatile u32 r_length;			/* FEC + 0x1E0 */
+	volatile u32 x_length;			/* FEC + 0x1E4 */
+	volatile u32 x_addr;			/* FEC + 0x1E8 */
+	volatile u32 cdes_data;			/* FEC + 0x1EC */
+	volatile u32 status;			/* FEC + 0x1F0 */
+	volatile u32 dma_control;		/* FEC + 0x1F4 */
+	volatile u32 des_cmnd;			/* FEC + 0x1F8 */
+	volatile u32 data;			/* FEC + 0x1FC */
+
+	volatile u32 rmon_t_drop;		/* FEC + 0x200 */
+	volatile u32 rmon_t_packets;		/* FEC + 0x204 */
+	volatile u32 rmon_t_bc_pkt;		/* FEC + 0x208 */
+	volatile u32 rmon_t_mc_pkt;		/* FEC + 0x20C */
+	volatile u32 rmon_t_crc_align;		/* FEC + 0x210 */
+	volatile u32 rmon_t_undersize;		/* FEC + 0x214 */
+	volatile u32 rmon_t_oversize;		/* FEC + 0x218 */
+	volatile u32 rmon_t_frag;		/* FEC + 0x21C */
+	volatile u32 rmon_t_jab;		/* FEC + 0x220 */
+	volatile u32 rmon_t_col;		/* FEC + 0x224 */
+	volatile u32 rmon_t_p64;		/* FEC + 0x228 */
+	volatile u32 rmon_t_p65to127;		/* FEC + 0x22C */
+	volatile u32 rmon_t_p128to255;		/* FEC + 0x230 */
+	volatile u32 rmon_t_p256to511;		/* FEC + 0x234 */
+	volatile u32 rmon_t_p512to1023;		/* FEC + 0x238 */
+	volatile u32 rmon_t_p1024to2047;	/* FEC + 0x23C */
+	volatile u32 rmon_t_p_gte2048;		/* FEC + 0x240 */
+	volatile u32 rmon_t_octets;		/* FEC + 0x244 */
+	volatile u32 ieee_t_drop;		/* FEC + 0x248 */
+	volatile u32 ieee_t_frame_ok;		/* FEC + 0x24C */
+	volatile u32 ieee_t_1col;		/* FEC + 0x250 */
+	volatile u32 ieee_t_mcol;		/* FEC + 0x254 */
+	volatile u32 ieee_t_def;		/* FEC + 0x258 */
+	volatile u32 ieee_t_lcol;		/* FEC + 0x25C */
+	volatile u32 ieee_t_excol;		/* FEC + 0x260 */
+	volatile u32 ieee_t_macerr;		/* FEC + 0x264 */
+	volatile u32 ieee_t_cserr;		/* FEC + 0x268 */
+	volatile u32 ieee_t_sqe;		/* FEC + 0x26C */
+	volatile u32 t_fdxfc;			/* FEC + 0x270 */
+	volatile u32 ieee_t_octets_ok;		/* FEC + 0x274 */
+
+	volatile u32 reserved9[2];		/* FEC + 0x278-27C */
+	volatile u32 rmon_r_drop;		/* FEC + 0x280 */
+	volatile u32 rmon_r_packets;		/* FEC + 0x284 */
+	volatile u32 rmon_r_bc_pkt;		/* FEC + 0x288 */
+	volatile u32 rmon_r_mc_pkt;		/* FEC + 0x28C */
+	volatile u32 rmon_r_crc_align;		/* FEC + 0x290 */
+	volatile u32 rmon_r_undersize;		/* FEC + 0x294 */
+	volatile u32 rmon_r_oversize;		/* FEC + 0x298 */
+	volatile u32 rmon_r_frag;		/* FEC + 0x29C */
+	volatile u32 rmon_r_jab;		/* FEC + 0x2A0 */
+
+	volatile u32 rmon_r_resvd_0;		/* FEC + 0x2A4 */
+
+	volatile u32 rmon_r_p64;		/* FEC + 0x2A8 */
+	volatile u32 rmon_r_p65to127;		/* FEC + 0x2AC */
+	volatile u32 rmon_r_p128to255;		/* FEC + 0x2B0 */
+	volatile u32 rmon_r_p256to511;		/* FEC + 0x2B4 */
+	volatile u32 rmon_r_p512to1023;		/* FEC + 0x2B8 */
+	volatile u32 rmon_r_p1024to2047;	/* FEC + 0x2BC */
+	volatile u32 rmon_r_p_gte2048;		/* FEC + 0x2C0 */
+	volatile u32 rmon_r_octets;		/* FEC + 0x2C4 */
+	volatile u32 ieee_r_drop;		/* FEC + 0x2C8 */
+	volatile u32 ieee_r_frame_ok;		/* FEC + 0x2CC */
+	volatile u32 ieee_r_crc;		/* FEC + 0x2D0 */
+	volatile u32 ieee_r_align;		/* FEC + 0x2D4 */
+	volatile u32 r_macerr;			/* FEC + 0x2D8 */
+	volatile u32 r_fdxfc;			/* FEC + 0x2DC */
+	volatile u32 ieee_r_octets_ok;		/* FEC + 0x2E0 */
+
+	volatile u32 reserved10[6];		/* FEC + 0x2E4-2FC */
+
+	volatile u32 reserved11[64];		/* FEC + 0x300-3FF */
+};
+
+#define MPC52xx_FEC_MIB_DISABLE			0x80000000
+
+#define MPC52xx_FEC_IEVENT_HBERR		0x80000000
+#define MPC52xx_FEC_IEVENT_BABR			0x40000000
+#define MPC52xx_FEC_IEVENT_BABT			0x20000000
+#define MPC52xx_FEC_IEVENT_GRA			0x10000000
+#define MPC52xx_FEC_IEVENT_TFINT		0x08000000
+#define MPC52xx_FEC_IEVENT_MII			0x00800000
+#define MPC52xx_FEC_IEVENT_LATE_COL		0x00200000
+#define MPC52xx_FEC_IEVENT_COL_RETRY_LIM	0x00100000
+#define MPC52xx_FEC_IEVENT_XFIFO_UN		0x00080000
+#define MPC52xx_FEC_IEVENT_XFIFO_ERROR		0x00040000
+#define MPC52xx_FEC_IEVENT_RFIFO_ERROR		0x00020000
+
+#define MPC52xx_FEC_IMASK_HBERR			0x80000000
+#define MPC52xx_FEC_IMASK_BABR			0x40000000
+#define MPC52xx_FEC_IMASK_BABT			0x20000000
+#define MPC52xx_FEC_IMASK_GRA			0x10000000
+#define MPC52xx_FEC_IMASK_MII			0x00800000
+#define MPC52xx_FEC_IMASK_LATE_COL		0x00200000
+#define MPC52xx_FEC_IMASK_COL_RETRY_LIM		0x00100000
+#define MPC52xx_FEC_IMASK_XFIFO_UN		0x00080000
+#define MPC52xx_FEC_IMASK_XFIFO_ERROR		0x00040000
+#define MPC52xx_FEC_IMASK_RFIFO_ERROR		0x00020000
+
+#define MPC52xx_FEC_RCNTRL_MAX_FL_SHIFT		16
+#define MPC52xx_FEC_RCNTRL_LOOP			0x01
+#define MPC52xx_FEC_RCNTRL_DRT			0x02
+#define MPC52xx_FEC_RCNTRL_MII_MODE		0x04
+#define MPC52xx_FEC_RCNTRL_PROM			0x08
+#define MPC52xx_FEC_RCNTRL_BC_REJ		0x10
+#define MPC52xx_FEC_RCNTRL_FCE			0x20
+
+#define MPC52xx_FEC_TCNTRL_GTS			0x00000001
+#define MPC52xx_FEC_TCNTRL_HBC			0x00000002
+#define MPC52xx_FEC_TCNTRL_FDEN			0x00000004
+#define MPC52xx_FEC_TCNTRL_TFC_PAUSE		0x00000008
+#define MPC52xx_FEC_TCNTRL_RFC_PAUSE		0x00000010
+
+#define MPC52xx_FEC_ECNTRL_RESET		0x00000001
+#define MPC52xx_FEC_ECNTRL_ETHER_EN		0x00000002
+
+#define MPC52xx_FEC_RESET_DELAY			50 /* uS */
+
+
+/* Receive & Transmit Buffer Descriptor definitions */
+struct mpc52xx_fec_bd {
+	volatile u32 status;
+	volatile u32 data;
+};
+
+/* Receive data buffer format */
+struct mpc52xx_rbuf {
+	u8 data[MPC52xx_FEC_RECV_BUFFER_SIZE];
+};
+
+struct fec_queue {
+	volatile struct mpc52xx_fec_bd *bd_base;
+	struct sk_buff **skb_base;
+	u16 last_index;
+	u16 start_index;
+	u16 finish_index;
+};
+
+#ifdef CONFIG_FEC_USE_MDIO 
+#define MII_ADVERTISE_HALF	(ADVERTISE_100HALF | ADVERTISE_10HALF | \
+				 ADVERTISE_CSMA)
+
+#define MII_ADVERTISE_ALL	(ADVERTISE_100FULL | ADVERTISE_10FULL | \
+				 MII_ADVERTISE_HALF)
+#ifdef PHY_INTERRUPT
+#define MII_ADVERTISE_DEFAULT   MII_ADVERTISE_ALL
+#else
+#define MII_ADVERTISE_DEFAULT   MII_ADVERTISE_HALF
+#endif
+
+typedef struct {
+	uint mii_data;
+	void (*funct)(uint mii_reg, struct net_device *dev, uint data);
+} phy_cmd_t;
+
+typedef struct {
+	uint id;
+	char *name;
+
+	const phy_cmd_t *config;
+	const phy_cmd_t *startup;
+	const phy_cmd_t *ack_int;
+	const phy_cmd_t *shutdown;
+} phy_info_t;
+#endif	/* CONFIG_FEC_USE_MDIO */
+
+struct mpc52xx_fec_priv {
+	int full_duplex;
+	int tx_full;
+	int r_tasknum;
+	int t_tasknum;
+	int r_irq;
+	int t_irq;
+	u32 last_transmit_time;
+	u32 last_receive_time;
+	struct mpc52xx_fec *fec;
+	struct mpc52xx_sram_fec *sram;
+	struct mpc52xx_gpio *gpio;
+	struct mpc52xx_sdma *sdma;
+	struct fec_queue r_queue;
+	struct sk_buff *rskb[MPC52xx_FEC_RBD_NUM];
+	struct fec_queue t_queue;
+	struct sk_buff *tskb[MPC52xx_FEC_TBD_NUM];
+	spinlock_t lock;
+	unsigned long open_time;
+	struct net_device_stats stats;
+#ifdef CONFIG_FEC_USE_MDIO
+	uint phy_id;
+	uint phy_id_done;
+	uint phy_status;
+	uint phy_speed;
+	phy_info_t *phy;
+	struct work_struct phy_task;
+	volatile uint sequence_done;
+	uint link;
+	uint phy_addr;
+
+	struct timer_list phy_timer_list;
+	u16 old_status;
+#endif	/* CONFIG_FEC_USE_MDIO */
+};
+
+struct mpc52xx_sram_fec {
+	volatile struct mpc52xx_fec_bd tbd[MPC52xx_FEC_TBD_NUM];
+	volatile struct mpc52xx_fec_bd rbd[MPC52xx_FEC_RBD_NUM];
+};
+
+#define MPC52xx_FEC_RBD_READY	0x40000000
+#define MPC52xx_FEC_RBD_RFD	0x08000000	/* receive frame done */
+
+#define MPC52xx_FEC_RBD_INIT	MPC52xx_FEC_RBD_READY
+
+#define MPC52xx_FEC_TBD_READY	0x40000000
+#define MPC52xx_FEC_TBD_TFD	0x08000000	/* transmit frame done */
+#define MPC52xx_FEC_TBD_INT	0x04000000	/* Interrupt */
+
+#define MPC52xx_FEC_TBD_INIT	(MPC52xx_FEC_TBD_INT | MPC52xx_FEC_TBD_TFD | \
+				 MPC52xx_FEC_TBD_READY)
+
+
+
+/* MII-related definitions */
+#define MPC52xx_FEC_MII_DATA_ST		0x40000000	/* Start frame */
+#define MPC52xx_FEC_MII_DATA_OP_RD	0x20000000	/* Perform read */
+#define MPC52xx_FEC_MII_DATA_OP_WR	0x10000000	/* Perform write */
+#define MPC52xx_FEC_MII_DATA_PA_MSK	0x0f800000	/* PHY Address mask */
+#define MPC52xx_FEC_MII_DATA_RA_MSK	0x007c0000	/* PHY Register mask */
+#define MPC52xx_FEC_MII_DATA_TA		0x00020000	/* Turnaround */
+#define MPC52xx_FEC_MII_DATA_DATAMSK	0x00000fff	/* PHY data mask */
+
+#define MPC52xx_FEC_MII_DATA_RA_SHIFT	0x12		/* MII reg addr bits */
+#define MPC52xx_FEC_MII_DATA_PA_SHIFT	0x17		/* MII PHY addr bits */
+
+#define MPC52xx_FEC_MII_SPEED		(5 * 2)
+
+const char mpc52xx_fec_name[] = "eth0";
+
+struct mibCounters {
+	unsigned int byteReceived;
+	unsigned int byteSent;
+	unsigned int framesReceived;
+	unsigned int framesSent;
+	unsigned int totalByteReceived;
+	unsigned int totalFramesReceived;
+	unsigned int broadcastFramesReceived;
+	unsigned int multicastFramesReceived;
+	unsigned int cRCError;
+	unsigned int oversizeFrames;
+	unsigned int fragments;
+	unsigned int jabber;
+	unsigned int collision;
+	unsigned int lateCollision;
+	unsigned int frames64;
+	unsigned int frames65_127;
+	unsigned int frames128_255;
+	unsigned int frames256_511;
+	unsigned int frames512_1023;
+	unsigned int frames1024_MaxSize;
+	unsigned int macRxError;
+	unsigned int droppedFrames;
+	unsigned int outMulticastFrames;
+	unsigned int outBroadcastFrames;
+	unsigned int undersizeFrames;
+};
+
+#define MPC52xx_FEC_WATCHDOG_TIMEOUT  ((400*HZ)/1000)
+
+#endif	/* PPC_52XX_IO_FEC_H */
diff --git a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
index a055e07..ce6ceb5 100644
--- a/include/asm-ppc/mpc52xx.h
+++ b/include/asm-ppc/mpc52xx.h
@@ -100,6 +100,9 @@ enum ppc_sys_devices {
 #define MPC52xx_XLB_SIZE		0x100
 #define MPC52xx_PSCx_OFFSET(x)		(((x)!=6)?(0x1e00+((x)<<9)):0x2c00)
 #define MPC52xx_PSC_SIZE		0x0a0
+#define MPC52xx_FEC_OFFSET		0x3000
+#define MPC52xx_FEC_SIZE		0x800
+
 
 /* SRAM used for SDMA */
 #define MPC52xx_SRAM_OFFSET		0x8000
-- 
1.1.3

--------------060500050200080603060601--
