Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (unknown [192.88.165.103])
	by ozlabs.org (Postfix) with ESMTP id 1B75C67A42
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 13:58:34 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k4I48gAZ016109
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 21:08:42 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k4I3wPLZ006986
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 22:58:27 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730626DE48@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: jgarzik@pobox.com
Subject: RE: [PATCH/2.6.17-rc4 5/10]  Add tsi108 Ethernet support
Date: Thu, 18 May 2006 11:58:23 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Cc: Alexandre.Bounine@tundra.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch adds Tundra tsi108 Ethernet driver support.

-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]
Sent: 2006=E5=B9=B45=E6=9C=8817=E6=97=A5 21:24
To: Zang Roy-r61911
Cc: Paul Mackerras; linuxppc-dev list; Alexandre.Bounine@tundra.com; =
Yang Xin-Xin-r48390
Subject: Re: [PATCH/2.6.17-rc4 5/10] Add tsi108 Ethernet support



On May 17, 2006, at 5:14 AM, Zang Roy-r61911 wrote:

> This patch adds a device driver and configuration options for
> Tundra Semiconductor Tsi108 integrated dual port Gigabit Ethernet =20
> controller
>
> Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
> Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>

This patch needs to go to the netdev list and Jeff Garzik as =20
maintainer for review.

- kumar

>  drivers/net/Kconfig      |    8
>  drivers/net/Makefile     |    1
>  drivers/net/tsi108_eth.c | 1740 +++++++++++++++++++++++++++++++++++=20
> +++++++++++
>  drivers/net/tsi108_eth.h |  404 +++++++++++
>  4 files changed, 2153 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/tsi108_eth.c
>  create mode 100644 drivers/net/tsi108_eth.h
>
> 23ed1c55ab6bc7a4c1c76f646579a1bc195bc7d2
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index bdaaad8..8a4ef29 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -2177,6 +2177,14 @@ config SPIDER_NET
>  	  This driver supports the Gigabit Ethernet chips present on the
>  	  Cell Processor-Based Blades from IBM.
>
> +config TSI108_ETH
> +	   tristate "Tundra TSI108 gigabit Ethernet support"
> +	   depends on TSI108_BRIDGE
> +	   help
> +	     This driver supports Tundra TSI108 gigabit Ethernet ports.
> +	     To compile this driver as a module, choose M here: the module
> +	     will be called tsi108_eth.
> +
>  config GIANFAR
>  	tristate "Gianfar Ethernet"
>  	depends on 85xx || 83xx
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index b90468a..5f90b30 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -109,6 +109,7 @@ obj-$(CONFIG_B44) +=3D b44.o
>  obj-$(CONFIG_FORCEDETH) +=3D forcedeth.o
>  obj-$(CONFIG_NE_H8300) +=3D ne-h8300.o 8390.o
>
> +obj-$(CONFIG_TSI108_ETH) +=3D tsi108_eth.o
>  obj-$(CONFIG_MV643XX_ETH) +=3D mv643xx_eth.o
>
>  obj-$(CONFIG_PPP) +=3D ppp_generic.o slhc.o
> diff --git a/drivers/net/tsi108_eth.c b/drivers/net/tsi108_eth.c
> new file mode 100644
> index 0000000..cb67dbe
> --- /dev/null
> +++ b/drivers/net/tsi108_eth.c
> @@ -0,0 +1,1740 @@
> +/=20
> =
**********************************************************************=20
> *********
> +
> +  Copyright(c) 2005 Tundra Semiconductor Corporation.
> +
> +  This program is free software; you can redistribute it and/or =20
> modify it
> +  under the terms of the GNU General Public License as published =20
> by the Free
> +  Software Foundation; either version 2 of the License, or (at =20
> your option)
> +  any later version.
> +
> +  This program is distributed in the hope that it will be useful, =20
> but WITHOUT
> +  ANY WARRANTY; without even the implied warranty of =20
> MERCHANTABILITY or
> +  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public =20
> License for
> +  more details.
> +
> +  You should have received a copy of the GNU General Public =20
> License along with
> +  this program; if not, write to the Free Software Foundation, =20
> Inc., 59
> +  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> +
> =
+*********************************************************************=20
> **********/
> +
> +/* This driver is based on the driver code originally developed=09
> + * for the Intel IOC80314 (ForestLake) Gigabit Ethernet by
> + * scott.wood@timesys.com  * Copyright (C) 2003 TimeSys Corporation
> + *
> + * Currently changes from original version are:
> + * - portig to Tsi108-based platform and kernel 2.6  
> (kong.lai@tundra.com)
> + * - modifications to handle two ports independently and support for
> + *   additional PHY devices (alexandre.bounine@tundra.com)
> + *
> + */
> +
> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/net.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/skbuff.h>
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/delay.h>
> +#include <linux/crc32.h>
> +#include <linux/mii.h>
> +#include <linux/device.h>
> +#include <asm/system.h>
> +#include <asm/io.h>
> +#include <linux/pci.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/timer.h>
> +
> +#include <asm/tsi108_irq.h>
> +#include <asm/tsi108.h>
> +#include "tsi108_eth.h"
> +
> +typedef struct net_device net_device;
> +typedef struct sk_buff sk_buff;
> +
> +#define MII_READ_DELAY 10000	/* max link wait time in msec */
> +
> +#define TSI108_RXRING_LEN     256
> +
> +/* NOTE: The driver currently does not support receiving packets
> + * larger than the buffer size, so don't decrease this (unless you
> + * want to add such support).
> + */
> +#define TSI108_RXBUF_SIZE     1536
> +
> +#define TSI108_TXRING_LEN     256
> +
> +#define TSI108_TX_INT_FREQ    64
> +
> +/* Check the phy status every half a second. */
> +#define CHECK_PHY_INTERVAL (HZ/2)
> +
> +extern hw_info hw_info_table[];
> +
> +typedef struct {
> +	volatile u32 regs;	/* Base of normal regs */
> +	volatile u32 phyregs;	/* Base of register bank used for PHY =20
> access */
> +	int phy;		/* Index of PHY for this interface */
> +	int irq_num;
> +
> +	struct timer_list timer;/* Timer that triggers the check phy =20
> function */
> +	int rxtail;		/* Next entry in rxring to read */
> +	int rxhead;		/* Next entry in rxring to give a new buffer */
> +	int rxfree;		/* Number of free, allocated RX buffers */
> +
> +	int rxpending;		/* Non-zero if there are still descriptors
> +				 * to be processed from a previous descriptor
> +				 * interrupt condition that has been cleared */
> +
> +	int txtail;		/* Next TX descriptor to check status on */
> +	int txhead;		/* Next TX descriptor to use */
> +
> +	/* Number of free TX descriptors.  This could be calculated from
> +	 * rxhead and rxtail if one descriptor were left unused to =20
> disambiguate
> +	 * full and empty conditions, but it's simpler to just keep track
> +	 * explicitly. */
> +
> +	int txfree;
> +
> +	int phy_ok;		/* The PHY is currently powered on. */
> +
> +	/* PHY status (duplex is 1 for half, 2 for full,
> +	 * so that the default 0 indicates that neither has
> +	 * yet been configured). */
> +
> +	int link_up;
> +	int speed;
> +	int duplex;
> +
> +	tx_desc *txring;
> +	rx_desc *rxring;
> +	sk_buff *txskbs[TSI108_TXRING_LEN];
> +	sk_buff *rxskbs[TSI108_RXRING_LEN];
> +
> +	dma_addr_t txdma, rxdma;
> +
> +	/* txlock nests in misclock and phy_lock */
> +
> +	spinlock_t txlock, misclock;
> +
> +	/* stats is used to hold the upper bits of each hardware counter,
> +	 * and tmpstats is used to hold the full values for returning
> +	 * to the caller of get_stats().  They must be separate in case
> +	 * an overflow interrupt occurs before the stats are consumed.
> +	 */
> +
> +	struct net_device_stats stats;
> +	struct net_device_stats tmpstats;
> +
> +	/* These stats are kept separate in hardware, thus require =20
> individual
> +	 * fields for handling carry.  They are combined in get_stats.
> +	 */
> +
> +	unsigned long rx_fcs;	/* Add to rx_frame_errors */
> +	unsigned long rx_short_fcs;	/* Add to rx_frame_errors */
> +	unsigned long rx_long_fcs;	/* Add to rx_frame_errors */
> +	unsigned long rx_underruns;	/* Add to rx_length_errors */
> +	unsigned long rx_overruns;	/* Add to rx_length_errors */
> +
> +	unsigned long tx_coll_abort;	/* Add to tx_aborted_errors/=20
> collisions */
> +	unsigned long tx_pause_drop;	/* Add to tx_aborted_errors */
> +
> +	unsigned long mc_hash[16];
> +} tsi108_prv_data;
> +static void tsi108_timed_checker(unsigned long dev_ptr);
> +
> +static net_device *tsi108_devs[TSI108_ETH_PORT_NUM];
> +
> +static void dump_eth_one(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +
> +	printk("Dumping %s...\n", dev->name);
> +	printk("intstat %x intmask %x phy_ok %d"
> +	       " link %d speed %d duplex %d\n",
> +	       TSI108_ETH_READ_REG(TSI108_EC_INTSTAT),
> +	       TSI108_ETH_READ_REG(TSI108_EC_INTMASK), data->phy_ok,
> +	       data->link_up, data->speed, data->duplex);
> +
> +	printk("TX: head %d, tail %d, free %d, stat %x, estat %x, err =
%x\n",
> +	       data->txhead, data->txtail, data->txfree,
> +	       TSI108_ETH_READ_REG(TSI108_EC_TXSTAT),
> +	       TSI108_ETH_READ_REG(TSI108_EC_TXESTAT),
> +	       TSI108_ETH_READ_REG(TSI108_EC_TXERR));
> +
> +	printk("RX: head %d, tail %d, free %d, stat %x,"
> +	       " estat %x, err %x, pending %d\n\n",
> +	       data->rxhead, data->rxtail, data->rxfree,
> +	       TSI108_ETH_READ_REG(TSI108_EC_RXSTAT),
> +	       TSI108_ETH_READ_REG(TSI108_EC_RXESTAT),
> +	       TSI108_ETH_READ_REG(TSI108_EC_RXERR), data->rxpending);
> +}
> +
> +void tsi108_dump_eth(void)
> +{
> +	dump_eth_one(tsi108_devs[0]);
> +	dump_eth_one(tsi108_devs[1]);
> +}
> +
> +/* Synchronization is needed between the thread and up/down events.
> + * Note that the PHY is accessed through the same registers for both
> + * interfaces, so this can't be made interface-specific.
> + */
> +
> +static spinlock_t phy_lock =3D SPIN_LOCK_UNLOCKED;
> +
> +static inline u16 tsi108_read_mii(tsi108_prv_data * data, int reg, =20
> int *status)
> +{
> +	int i;
> +	u16 ret;
> +
> +	TSI108_ETH_WRITE_PHYREG(TSI108_MAC_MII_ADDR,
> +				(data->phy << TSI108_MAC_MII_ADDR_PHY) |
> +				(reg << TSI108_MAC_MII_ADDR_REG));
> +	mb();
> +	TSI108_ETH_WRITE_PHYREG(TSI108_MAC_MII_CMD, 0);
> +	mb();
> +	TSI108_ETH_WRITE_PHYREG(TSI108_MAC_MII_CMD, =20
> TSI108_MAC_MII_CMD_READ);
> +	mb();
> +	for (i =3D 0; i < 100; i++) {
> +		if (!(TSI108_ETH_READ_PHYREG(TSI108_MAC_MII_IND) &
> +		      (TSI108_MAC_MII_IND_NOTVALID | TSI108_MAC_MII_IND_BUSY)))
> +			break;
> +		udelay(10);
> +	}
> +
> +	if (i =3D=3D 100) {
> +		if (status)
> +			*status =3D -EBUSY;
> +
> +		ret =3D 0xffff;
> +	} else {
> +		if (status)
> +			*status =3D 0;
> +
> +		ret =3D TSI108_ETH_READ_PHYREG(TSI108_MAC_MII_DATAIN);
> +	}
> +
> +	return ret;
> +}
> +
> +static inline void tsi108_write_mii(tsi108_prv_data * data, int =20
> reg, u16 val)
> +{
> +	TSI108_ETH_WRITE_PHYREG(TSI108_MAC_MII_ADDR,
> +				(data->phy << TSI108_MAC_MII_ADDR_PHY) |
> +				(reg << TSI108_MAC_MII_ADDR_REG));
> +	mb();
> +	TSI108_ETH_WRITE_PHYREG(TSI108_MAC_MII_DATAOUT, val);
> +	mb();
> +	while (TSI108_ETH_READ_PHYREG(TSI108_MAC_MII_IND) &
> +	       TSI108_MAC_MII_IND_BUSY) ;
> +}
> +
> +static inline void tsi108_write_tbi(tsi108_prv_data * data, int =20
> reg, u16 val)
> +{
> +
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_MII_ADDR,
> +			     (0x1e << TSI108_MAC_MII_ADDR_PHY)
> +			     | (reg << TSI108_MAC_MII_ADDR_REG));
> +	mb();
> +
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_MII_DATAOUT, val);
> +	mb();
> +	while (TSI108_ETH_READ_REG(TSI108_MAC_MII_IND) &
> +	       TSI108_MAC_MII_IND_BUSY) ;
> +}
> +
> +static void tsi108_check_phy(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	u16 sumstat;
> +	u32 mac_cfg2_reg, portctrl_reg;
> +	u32 fdx_flag =3D 0, reg_update =3D 0;
> +
> +	/* Do a dummy read, as for some reason the first read
> +	 * after a link becomes up returns link down, even if
> +	 * it's been a while since the link came up.
> +	 */
> +
> +	spin_lock(&phy_lock);
> +
> +	if (!data->phy_ok)
> +		goto out;
> +
> +	tsi108_read_mii(data, PHY_STAT, NULL);
> +
> +	if (!(tsi108_read_mii(data, PHY_STAT, NULL) & PHY_STAT_LINKUP)) {
> +		if (data->link_up =3D=3D 1) {
> +			netif_stop_queue(dev);
> +			data->link_up =3D 0;
> +			printk(KERN_NOTICE "%s : link is down\n", dev->name);
> +			netif_carrier_off(dev);
> +		}
> +
> +		goto out;
> +	}
> +
> +	{
> +		mac_cfg2_reg =3D TSI108_ETH_READ_REG(TSI108_MAC_CFG2);
> +		portctrl_reg =3D TSI108_ETH_READ_REG(TSI108_EC_PORTCTRL);
> +
> +		sumstat =3D tsi108_read_mii(data, PHY_SUM_STAT, NULL);
> +
> +		switch (sumstat & PHY_SUM_STAT_SPEED_MASK) {
> +		case PHY_SUM_STAT_1000T_FD:
> +			fdx_flag++;
> +		case PHY_SUM_STAT_1000T_HD:
> +			if (data->speed !=3D 1000) {
> +				mac_cfg2_reg &=3D ~TSI108_MAC_CFG2_IFACE_MASK;
> +				mac_cfg2_reg |=3D TSI108_MAC_CFG2_GIG;
> +				portctrl_reg &=3D ~TSI108_EC_PORTCTRL_NOGIG;
> +				data->speed =3D 1000;
> +				reg_update++;
> +			}
> +			break;
> +		case PHY_SUM_STAT_100TX_FD:
> +			fdx_flag++;
> +		case PHY_SUM_STAT_100TX_HD:
> +			if (data->speed !=3D 100) {
> +				mac_cfg2_reg &=3D ~TSI108_MAC_CFG2_IFACE_MASK;
> +				mac_cfg2_reg |=3D TSI108_MAC_CFG2_NOGIG;
> +				portctrl_reg |=3D TSI108_EC_PORTCTRL_NOGIG;
> +				data->speed =3D 100;
> +				reg_update++;
> +			}
> +			break;
> +
> +		case PHY_SUM_STAT_10T_FD:
> +			fdx_flag++;
> +		case PHY_SUM_STAT_10T_HD:
> +			if (data->speed !=3D 10) {
> +				mac_cfg2_reg &=3D ~TSI108_MAC_CFG2_IFACE_MASK;
> +				mac_cfg2_reg |=3D TSI108_MAC_CFG2_NOGIG;
> +				portctrl_reg |=3D TSI108_EC_PORTCTRL_NOGIG;
> +				data->speed =3D 10;
> +				reg_update++;
> +			}
> +			break;
> +
> +		default:
> +			if (net_ratelimit())
> +				printk(KERN_ERR "PHY reported invalid speed,"
> +				       KERN_ERR " summary status %x\n",
> +				       sumstat);
> +			goto out;
> +		}
> +
> +		if (fdx_flag || (sumstat & PHY_SUM_STAT_FULLDUPLEX)) {
> +			if (data->duplex !=3D 2) {
> +				mac_cfg2_reg |=3D TSI108_MAC_CFG2_FULLDUPLEX;
> +				portctrl_reg &=3D ~TSI108_EC_PORTCTRL_HALFDUPLEX;
> +				data->duplex =3D 2;
> +				reg_update++;
> +			}
> +		} else {
> +			if (data->duplex !=3D 1) {
> +				mac_cfg2_reg &=3D ~TSI108_MAC_CFG2_FULLDUPLEX;
> +				portctrl_reg |=3D TSI108_EC_PORTCTRL_HALFDUPLEX;
> +				data->duplex =3D 1;
> +				reg_update++;
> +			}
> +		}
> +
> +		if (reg_update) {
> +			TSI108_ETH_WRITE_REG(TSI108_MAC_CFG2, mac_cfg2_reg);
> +			mb();
> +			TSI108_ETH_WRITE_REG(TSI108_EC_PORTCTRL, portctrl_reg);
> +			mb();
> +		}
> +
> +	}
> +
> +	if (data->link_up =3D=3D 0) {
> +		/* The manual says it can take 3-4 usecs for the speed change
> +		 * to take effect.
> +		 */
> +		udelay(5);
> +
> +		spin_lock(&data->txlock);
> +		if (netif_queue_stopped(dev)
> +		    && is_valid_ether_addr(dev->dev_addr) && data->txfree)
> +			netif_wake_queue(dev);
> +
> +		data->link_up =3D 1;
> +		spin_unlock(&data->txlock);
> +		printk("%s : link is up: %dMb %s-duplex\n",
> +		       dev->name, data->speed,
> +		       (data->duplex =3D=3D 2) ? "full" : "half");
> +		netif_carrier_on(dev);
> +	}
> +
> +      out:
> +	spin_unlock(&phy_lock);
> +}
> +
> +static inline void
> +tsi108_stat_carry_one(int carry, int carry_bit, int carry_shift,
> +		      unsigned long *upper)
> +{
> +	if (carry & carry_bit)
> +		*upper +=3D carry_shift;
> +}
> +
> +static void tsi108_stat_carry(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	u32 carry1, carry2;
> +
> +	spin_lock_irq(&data->misclock);
> +
> +	carry1 =3D TSI108_ETH_READ_REG(TSI108_STAT_CARRY1);
> +	carry2 =3D TSI108_ETH_READ_REG(TSI108_STAT_CARRY2);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_STAT_CARRY1, carry1);
> +	TSI108_ETH_WRITE_REG(TSI108_STAT_CARRY2, carry2);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXBYTES,
> +			      TSI108_STAT_RXBYTES_CARRY, &data->stats.rx_bytes);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXPKTS,
> +			      TSI108_STAT_RXPKTS_CARRY,
> +			      &data->stats.rx_packets);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXFCS,
> +			      TSI108_STAT_RXFCS_CARRY, &data->rx_fcs);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXMCAST,
> +			      TSI108_STAT_RXMCAST_CARRY,
> +			      &data->stats.multicast);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXALIGN,
> +			      TSI108_STAT_RXALIGN_CARRY,
> +			      &data->stats.rx_frame_errors);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXLENGTH,
> +			      TSI108_STAT_RXLENGTH_CARRY,
> +			      &data->stats.rx_length_errors);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXRUNT,
> +			      TSI108_STAT_RXRUNT_CARRY, &data->rx_underruns);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXJUMBO,
> +			      TSI108_STAT_RXJUMBO_CARRY, &data->rx_overruns);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXFRAG,
> +			      TSI108_STAT_RXFRAG_CARRY, &data->rx_short_fcs);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXJABBER,
> +			      TSI108_STAT_RXJABBER_CARRY, &data->rx_long_fcs);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXDROP,
> +			      TSI108_STAT_RXDROP_CARRY,
> +			      &data->stats.rx_missed_errors);
> +
> +	tsi108_stat_carry_one(carry2, TSI108_STAT_CARRY2_TXBYTES,
> +			      TSI108_STAT_TXBYTES_CARRY, &data->stats.tx_bytes);
> +
> +	tsi108_stat_carry_one(carry2, TSI108_STAT_CARRY2_TXPKTS,
> +			      TSI108_STAT_TXPKTS_CARRY,
> +			      &data->stats.tx_packets);
> +
> +	tsi108_stat_carry_one(carry2, TSI108_STAT_CARRY2_TXEXDEF,
> +			      TSI108_STAT_TXEXDEF_CARRY,
> +			      &data->stats.tx_aborted_errors);
> +
> +	tsi108_stat_carry_one(carry2, TSI108_STAT_CARRY2_TXEXCOL,
> +			      TSI108_STAT_TXEXCOL_CARRY, &data->tx_coll_abort);
> +
> +	tsi108_stat_carry_one(carry2, TSI108_STAT_CARRY2_TXTCOL,
> +			      TSI108_STAT_TXTCOL_CARRY,
> +			      &data->stats.collisions);
> +
> +	tsi108_stat_carry_one(carry2, TSI108_STAT_CARRY2_TXPAUSE,
> +			      TSI108_STAT_TXPAUSEDROP_CARRY,
> +			      &data->tx_pause_drop);
> +
> +	spin_unlock_irq(&data->misclock);
> +}
> +
> +/* Read a stat counter atomically with respect to carries.
> + * data->misclock must be held.
> + */
> +static inline unsigned long
> +tsi108_read_stat(tsi108_prv_data * data, int reg, int carry_bit,
> +		 int carry_shift, unsigned long *upper)
> +{
> +	int carryreg;
> +	unsigned long val;
> +
> +	if (reg < 0xb0)
> +		carryreg =3D TSI108_STAT_CARRY1;
> +	else
> +		carryreg =3D TSI108_STAT_CARRY2;
> +
> +      again:
> +	val =3D TSI108_ETH_READ_REG(reg) | *upper;
> +
> +	rmb();
> +
> +	/* Check to see if it overflowed, but the interrupt hasn't
> +	 * been serviced yet.  If so, handle the carry here, and
> +	 * try again.
> +	 */
> +
> +	if (unlikely(TSI108_ETH_READ_REG(carryreg) & carry_bit)) {
> +		*upper +=3D carry_shift;
> +		TSI108_ETH_WRITE_REG(carryreg, carry_bit);
> +		mb();
> +
> +		goto again;
> +	}
> +
> +	return val;
> +}
> +
> +static struct net_device_stats *tsi108_get_stats(net_device * dev)
> +{
> +	unsigned long excol;
> +
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	spin_lock_irq(&data->misclock);
> +
> +	data->tmpstats.rx_packets =3D
> +	    tsi108_read_stat(data, TSI108_STAT_RXPKTS,
> +			     TSI108_STAT_CARRY1_RXPKTS,
> +			     TSI108_STAT_RXPKTS_CARRY, &data->stats.rx_packets);
> +
> +	data->tmpstats.tx_packets =3D
> +	    tsi108_read_stat(data, TSI108_STAT_TXPKTS,
> +			     TSI108_STAT_CARRY2_TXPKTS,
> +			     TSI108_STAT_TXPKTS_CARRY, &data->stats.tx_packets);
> +
> +	data->tmpstats.rx_bytes =3D
> +	    tsi108_read_stat(data, TSI108_STAT_RXBYTES,
> +			     TSI108_STAT_CARRY1_RXBYTES,
> +			     TSI108_STAT_RXBYTES_CARRY, &data->stats.rx_bytes);
> +
> +	data->tmpstats.tx_bytes =3D
> +	    tsi108_read_stat(data, TSI108_STAT_TXBYTES,
> +			     TSI108_STAT_CARRY2_TXBYTES,
> +			     TSI108_STAT_TXBYTES_CARRY, &data->stats.tx_bytes);
> +
> +	data->tmpstats.multicast =3D
> +	    tsi108_read_stat(data, TSI108_STAT_RXMCAST,
> +			     TSI108_STAT_CARRY1_RXMCAST,
> +			     TSI108_STAT_RXMCAST_CARRY, &data->stats.multicast);
> +
> +	excol =3D tsi108_read_stat(data, TSI108_STAT_TXEXCOL,
> +				 TSI108_STAT_CARRY2_TXEXCOL,
> +				 TSI108_STAT_TXEXCOL_CARRY,
> +				 &data->tx_coll_abort);
> +
> +	data->tmpstats.collisions =3D
> +	    tsi108_read_stat(data, TSI108_STAT_TXTCOL,
> +			     TSI108_STAT_CARRY2_TXTCOL,
> +			     TSI108_STAT_TXTCOL_CARRY, &data->stats.collisions);
> +
> +	data->tmpstats.collisions +=3D excol;
> +
> +	data->tmpstats.rx_length_errors =3D
> +	    tsi108_read_stat(data, TSI108_STAT_RXLENGTH,
> +			     TSI108_STAT_CARRY1_RXLENGTH,
> +			     TSI108_STAT_RXLENGTH_CARRY,
> +			     &data->stats.rx_length_errors);
> +
> +	data->tmpstats.rx_length_errors +=3D
> +	    tsi108_read_stat(data, TSI108_STAT_RXRUNT,
> +			     TSI108_STAT_CARRY1_RXRUNT,
> +			     TSI108_STAT_RXRUNT_CARRY, &data->rx_underruns);
> +
> +	data->tmpstats.rx_length_errors +=3D
> +	    tsi108_read_stat(data, TSI108_STAT_RXJUMBO,
> +			     TSI108_STAT_CARRY1_RXJUMBO,
> +			     TSI108_STAT_RXJUMBO_CARRY, &data->rx_overruns);
> +
> +	data->tmpstats.rx_frame_errors =3D
> +	    tsi108_read_stat(data, TSI108_STAT_RXALIGN,
> +			     TSI108_STAT_CARRY1_RXALIGN,
> +			     TSI108_STAT_RXALIGN_CARRY,
> +			     &data->stats.rx_frame_errors);
> +
> +	data->tmpstats.rx_frame_errors +=3D
> +	    tsi108_read_stat(data, TSI108_STAT_RXFCS,
> +			     TSI108_STAT_CARRY1_RXFCS, TSI108_STAT_RXFCS_CARRY,
> +			     &data->rx_fcs);
> +
> +	data->tmpstats.rx_frame_errors +=3D
> +	    tsi108_read_stat(data, TSI108_STAT_RXFRAG,
> +			     TSI108_STAT_CARRY1_RXFRAG,
> +			     TSI108_STAT_RXFRAG_CARRY, &data->rx_short_fcs);
> +
> +	data->tmpstats.rx_missed_errors =3D
> +	    tsi108_read_stat(data, TSI108_STAT_RXDROP,
> +			     TSI108_STAT_CARRY1_RXDROP,
> +			     TSI108_STAT_RXDROP_CARRY,
> +			     &data->stats.rx_missed_errors);
> +
> +	/* These three are maintained by software. */
> +	data->tmpstats.rx_fifo_errors =3D data->stats.rx_fifo_errors;
> +	data->tmpstats.rx_crc_errors =3D data->stats.rx_crc_errors;
> +
> +	data->tmpstats.tx_aborted_errors =3D
> +	    tsi108_read_stat(data, TSI108_STAT_TXEXDEF,
> +			     TSI108_STAT_CARRY2_TXEXDEF,
> +			     TSI108_STAT_TXEXDEF_CARRY,
> +			     &data->stats.tx_aborted_errors);
> +
> +	data->tmpstats.tx_aborted_errors +=3D
> +	    tsi108_read_stat(data, TSI108_STAT_TXPAUSEDROP,
> +			     TSI108_STAT_CARRY2_TXPAUSE,
> +			     TSI108_STAT_TXPAUSEDROP_CARRY,
> +			     &data->tx_pause_drop);
> +
> +	data->tmpstats.tx_aborted_errors +=3D excol;
> +
> +	data->tmpstats.tx_errors =3D data->tmpstats.tx_aborted_errors;
> +	data->tmpstats.rx_errors =3D data->tmpstats.rx_length_errors +
> +	    data->tmpstats.rx_crc_errors +
> +	    data->tmpstats.rx_frame_errors +
> +	    data->tmpstats.rx_fifo_errors + =
data->tmpstats.rx_missed_errors;
> +
> +	spin_unlock_irq(&data->misclock);
> +	return &data->tmpstats;
> +}
> +
> +static void tsi108_restart_rx(tsi108_prv_data * data, net_device * =20
> dev)
> +{
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXQ_PTRHIGH,
> +			     TSI108_EC_RXQ_PTRHIGH_VALID);
> +
> +	wmb();
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXCTRL, TSI108_EC_RXCTRL_GO
> +			     | TSI108_EC_RXCTRL_QUEUE0);
> +}
> +
> +static void tsi108_restart_tx(tsi108_prv_data * data)
> +{
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXQ_PTRHIGH,
> +			     TSI108_EC_TXQ_PTRHIGH_VALID);
> +
> +	wmb();
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXCTRL, TSI108_EC_TXCTRL_IDLEINT |
> +			     TSI108_EC_TXCTRL_GO | TSI108_EC_TXCTRL_QUEUE0);
> +}
> +
> +/* txlock must be held by caller, with IRQs disabled, and
> + * with permission to re-enable them when the lock is dropped.
> + */
> +static void tsi108_check_for_completed_tx(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	int tx;
> +	struct sk_buff *skb;
> +	int release =3D 0;
> +
> +	while (!data->txfree || data->txhead !=3D data->txtail) {
> +		tx =3D data->txtail;
> +
> +		if (data->txring[tx].misc & TSI108_TX_OWN)
> +			break;
> +
> +		skb =3D data->txskbs[tx];
> +
> +		if (!(data->txring[tx].misc & TSI108_TX_OK))
> +			printk("%s: bad tx packet, misc %x\n",
> +			       dev->name, data->txring[tx].misc);
> +
> +		data->txtail =3D (data->txtail + 1) % TSI108_TXRING_LEN;
> +		data->txfree++;
> +
> +		if (data->txring[tx].misc & TSI108_TX_EOF) {
> +			dev_kfree_skb_any(skb);
> +			release++;
> +		}
> +	}
> +
> +	if (release) {
> +
> +		if (netif_queue_stopped(dev)
> +		    && is_valid_ether_addr(dev->dev_addr) && data->link_up)
> +			netif_wake_queue(dev);
> +	}
> +}
> +
> +static int tsi108_send_packet(sk_buff * skb, net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	int frags =3D skb_shinfo(skb)->nr_frags + 1;
> +	int i;
> +#ifdef FIXME_SG_CSUM_NOT_TESTED	/* FIXME: Not supported now. */
> +	long csstart;
> +	long csum;
> +
> +	csstart =3D skb->len - skb->data_len;
> +	if (csstart > skb->len - skb->data_len)
> +		BUG();
> +	csum =3D 0;
> +	if (csstart !=3D skb->len)
> +		csum =3D skb_checksum(skb, csstart, skb->len - csstart, 0);
> +#endif
> +
> +	if (!data->phy_ok && net_ratelimit())
> +		printk(KERN_ERR "%s: Transmit while PHY is down!\n", dev->name);
> +
> +	if (!data->link_up) {
> +		printk(KERN_ERR "%s: Transmit while link is down!\n",
> +		       dev->name);
> +		netif_stop_queue(dev);
> +		return 1;
> +	}
> +
> +	if (data->txfree < MAX_SKB_FRAGS + 1) {
> +		netif_stop_queue(dev);
> +
> +		if (net_ratelimit())
> +			printk(KERN_ERR "%s: Transmit with full tx ring!\n",
> +			       dev->name);
> +		return 1;
> +	}
> +
> +	if (data->txfree - frags < MAX_SKB_FRAGS + 1) {
> +		netif_stop_queue(dev);
> +	}
> +
> +	spin_lock_irq(&data->txlock);
> +
> +	for (i =3D 0; i < frags; i++) {
> +		int misc =3D 0;
> +		int tx =3D data->txhead;
> +
> +		/* This is done to mark every TSI108_TX_INT_FREQ tx buffers with
> +		 * the interrupt bit.  TX descriptor-complete interrupts are
> +		 * enabled when the queue fills up, and masked when there is
> +		 * still free space.  This way, when saturating the outbound
> +		 * link, the tx interrupts are kept to a reasonable level.
> +		 * When the queue is not full, reclamation of skbs still occurs
> +		 * as new packets are transmitted, or on a queue-empty
> +		 * interrupt.
> +		 */
> +
> +		if ((tx % TSI108_TX_INT_FREQ =3D=3D 0) &&
> +		    ((TSI108_TXRING_LEN - data->txfree) >=3D TSI108_TX_INT_FREQ)
> +		    )
> +			misc =3D TSI108_TX_INT;
> +
> +		data->txskbs[tx] =3D skb;
> +
> +		if (i =3D=3D 0) {
> +			data->txring[tx].buf0 =3D virt_to_phys(skb->data);
> +			data->txring[tx].len =3D skb->len - skb->data_len;
> +			misc |=3D TSI108_TX_SOF;
> +		} else {
> +			skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i - 1];
> +
> +			data->txring[tx].buf0 =3D
> +			    page_to_phys(frag->page) + frag->page_offset;
> +			data->txring[tx].len =3D frag->size;
> +		}
> +
> +		if (i =3D=3D frags - 1)
> +			misc |=3D TSI108_TX_EOF;
> +
> +#ifdef TSI108_PRINT_TX_FRAME
> +		{
> +			int i;
> +			printk("%s: Tx Frame contents (%d)\n", dev->name,
> +			       skb->len);
> +			for (i =3D 0; i < skb->len; i++)
> +				printk(" %2.2x", skb->data[i]);
> +			printk(".\n");
> +		}
> +#endif				/* TSI108_PRINT_TX_FRAME */
> +
> +		mb();
> +		data->txring[tx].misc =3D misc | TSI108_TX_OWN;
> +
> +		data->txhead =3D (data->txhead + 1) % TSI108_TXRING_LEN;
> +		data->txfree--;
> +	}
> +
> +	tsi108_check_for_completed_tx(dev);
> +
> +	/* This must be done after the check for completed tx descriptors,
> +	 * so that the tail pointer is correct.
> +	 */
> +
> +	if (!(TSI108_ETH_READ_REG(TSI108_EC_TXSTAT) & =20
> TSI108_EC_TXSTAT_QUEUE0))
> +		tsi108_restart_tx(data);
> +
> +	spin_unlock_irq(&data->txlock);
> +	return 0;
> +}
> +
> +static int tsi108_check_for_completed_rx(net_device * dev, int =20
> budget)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	int done =3D 0;
> +
> +	while (data->rxfree && done !=3D budget) {
> +		int rx =3D data->rxtail;
> +		struct sk_buff *skb;
> +
> +		if (data->rxring[rx].misc & TSI108_RX_OWN)
> +			break;
> +
> +		skb =3D data->rxskbs[rx];
> +		data->rxtail =3D (data->rxtail + 1) % TSI108_RXRING_LEN;
> +		data->rxfree--;
> +		done++;
> +
> +		if (data->rxring[rx].misc & TSI108_RX_BAD) {
> +			spin_lock_irq(&data->misclock);
> +
> +			if (data->rxring[rx].misc & TSI108_RX_CRC)
> +				data->stats.rx_crc_errors++;
> +			if (data->rxring[rx].misc & TSI108_RX_OVER)
> +				data->stats.rx_fifo_errors++;
> +
> +			spin_unlock_irq(&data->misclock);
> +
> +			dev_kfree_skb_any(skb);
> +			continue;
> +		}
> +#ifdef TSI108_PRINT_RX_FRAME
> +		{
> +			int i;
> +			printk("%s: Rx Frame contents (%d)\n",
> +			       dev->name, data->rxring[rx].len);
> +			for (i =3D 0; i < data->rxring[rx].len; i++)
> +				printk(" %2.2x", skb->data[i]);
> +			printk(".\n");
> +		}
> +#endif				/* TSI108_PRINT_RX_FRAME */
> +
> +		skb->dev =3D dev;
> +		skb_put(skb, data->rxring[rx].len);
> +		skb->protocol =3D eth_type_trans(skb, dev);
> +		netif_receive_skb(skb);
> +		dev->last_rx =3D jiffies;
> +	}
> +
> +	return done;
> +}
> +
> +static int tsi108_refill_rx(net_device * dev, int budget)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	int done =3D 0;
> +
> +	while (data->rxfree !=3D TSI108_RXRING_LEN && done !=3D budget) {
> +		int rx =3D data->rxhead;
> +		sk_buff *skb;
> +
> +		data->rxskbs[rx] =3D skb =3D dev_alloc_skb(TSI108_RXBUF_SIZE + 2);
> +		if (!skb)
> +			break;
> +
> +		skb_reserve(skb, 2);	/* Align the data on a 4-byte boundary. */
> +
> +		data->rxring[rx].buf0 =3D virt_to_phys(skb->data);
> +
> +		/* Sometimes the hardware sets blen to zero after packet
> +		 * reception, even though the manual says that it's only ever
> +		 * modified by the driver.
> +		 */
> +
> +		data->rxring[rx].blen =3D 1536;
> +		mb();
> +		data->rxring[rx].misc =3D TSI108_RX_OWN | TSI108_RX_INT;
> +
> +		data->rxhead =3D (data->rxhead + 1) % TSI108_RXRING_LEN;
> +		data->rxfree++;
> +		done++;
> +	}
> +
> +	mb();
> +
> +	if (done !=3D 0 && !(TSI108_ETH_READ_REG(TSI108_EC_RXSTAT) &
> +			   TSI108_EC_RXSTAT_QUEUE0))
> +		tsi108_restart_rx(data, dev);
> +
> +	return done;
> +}
> +
> +static int tsi108_poll(net_device * dev, int *budget)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	u32 estat =3D TSI108_ETH_READ_REG(TSI108_EC_RXESTAT);
> +	u32 intstat =3D TSI108_ETH_READ_REG(TSI108_EC_INTSTAT);
> +	int total_budget =3D min(*budget, dev->quota);
> +	int num_received =3D 0, num_filled =3D 0, budget_used;
> +
> +	intstat &=3D TSI108_INT_RXQUEUE0 | TSI108_INT_RXTHRESH |
> +	    TSI108_INT_RXOVERRUN | TSI108_INT_RXERROR | TSI108_INT_RXWAIT;
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXESTAT, estat);
> +	TSI108_ETH_WRITE_REG(TSI108_EC_INTSTAT, intstat);
> +
> +	if (data->rxpending || (estat & TSI108_EC_RXESTAT_Q0_DESCINT))
> +		num_received =3D tsi108_check_for_completed_rx(dev, total_budget);
> +
> +	/* This should normally fill no more slots than the number of
> +	 * packets received in tsi108_check_for_completed_rx().  The =20
> exception
> +	 * is when we previously ran out of memory for RX SKBs.  In that
> +	 * case, it's helpful to obey the budget, not only so that the
> +	 * CPU isn't hogged, but so that memory (which may still be low)
> +	 * is not hogged by one device.
> +	 *
> +	 * A work unit is considered to be two SKBs to allow us to catch
> +	 * up when the ring has shrunk due to out-of-memory but we're
> +	 * still removing the full budget's worth of packets each time.
> +	 */
> +
> +	if (data->rxfree < TSI108_RXRING_LEN)
> +		num_filled =3D tsi108_refill_rx(dev, total_budget * 2);
> +
> +	if (intstat & TSI108_INT_RXERROR) {
> +		u32 err =3D TSI108_ETH_READ_REG(TSI108_EC_RXERR);
> +		TSI108_ETH_WRITE_REG(TSI108_EC_RXERR, err);
> +
> +		if (err) {
> +			if (net_ratelimit())
> +				printk(KERN_DEBUG "%s: RX error %x\n",
> +				       dev->name, err);
> +
> +			if (!(TSI108_ETH_READ_REG(TSI108_EC_RXSTAT) &
> +			      TSI108_EC_RXSTAT_QUEUE0))
> +				tsi108_restart_rx(data, dev);
> +		}
> +	}
> +
> +	if (intstat & TSI108_INT_RXOVERRUN) {
> +		spin_lock_irq(&data->misclock);
> +		data->stats.rx_fifo_errors++;
> +		spin_unlock_irq(&data->misclock);
> +	}
> +
> +	budget_used =3D max(num_received, num_filled / 2);
> +
> +	*budget -=3D budget_used;
> +	dev->quota -=3D budget_used;
> +
> +	if (budget_used !=3D total_budget) {
> +		data->rxpending =3D 0;
> +		netif_rx_complete(dev);
> +
> +		TSI108_ETH_WRITE_REG(TSI108_EC_INTMASK,
> +				     TSI108_ETH_READ_REG(TSI108_EC_INTMASK)
> +				     & ~(TSI108_INT_RXQUEUE0
> +					 | TSI108_INT_RXTHRESH |
> +					 TSI108_INT_RXOVERRUN |
> +					 TSI108_INT_RXERROR |
> +					 TSI108_INT_RXWAIT));
> +
> +		mb();
> +
> +		/* IRQs are level-triggered, so no need to re-check */
> +		return 0;
> +	} else {
> +		data->rxpending =3D 1;
> +	}
> +
> +	return 1;
> +}
> +
> +static void tsi108_rx_int(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +
> +	/* A race could cause dev to already be scheduled, so it's not an
> +	 * error if that happens (and interrupts shouldn't be re-masked,
> +	 * because that can cause harmful races, if poll has already
> +	 * unmasked them but not cleared LINK_STATE_SCHED).
> +	 *
> +	 * This can happen if this code races with tsi108_poll(), which =20
> masks
> +	 * the interrupts after tsi108_irq_one() read the mask, but before
> +	 * netif_rx_schedule is called.  It could also happen due to calls
> +	 * from tsi108_check_rxring().
> +	 */
> +
> +	if (netif_rx_schedule_prep(dev)) {
> +		/* Mask, rather than ack, the receive interrupts.  The ack
> +		 * will happen in tsi108_poll().
> +		 */
> +
> +		TSI108_ETH_WRITE_REG(TSI108_EC_INTMASK,
> +				     TSI108_ETH_READ_REG(TSI108_EC_INTMASK) |
> +				     TSI108_INT_RXQUEUE0
> +				     | TSI108_INT_RXTHRESH |
> +				     TSI108_INT_RXOVERRUN | TSI108_INT_RXERROR |
> +				     TSI108_INT_RXWAIT);
> +		mb();
> +		__netif_rx_schedule(dev);
> +	} else {
> +		if (!netif_running(dev)) {
> +			/* This can happen if an interrupt occurs while the
> +			 * interface is being brought down, as the START
> +			 * bit is cleared before the stop function is called.
> +			 *
> +			 * In this case, the interrupts must be masked, or
> +			 * they will continue indefinitely.
> +			 *
> +			 * There's a race here if the interface is brought down
> +			 * and then up in rapid succession, as the device could
> +			 * be made running after the above check and before
> +			 * the masking below.  This will only happen if the IRQ
> +			 * thread has a lower priority than the task brining
> +			 * up the interface.  Fixing this race would likely
> +			 * require changes in generic code.
> +			 */
> +
> +			TSI108_ETH_WRITE_REG(TSI108_EC_INTMASK,
> +					     TSI108_ETH_READ_REG
> +					     (TSI108_EC_INTMASK) |
> +					     TSI108_INT_RXQUEUE0 |
> +					     TSI108_INT_RXTHRESH |
> +					     TSI108_INT_RXOVERRUN |
> +					     TSI108_INT_RXERROR |
> +					     TSI108_INT_RXWAIT);
> +			mb();
> +		}
> +	}
> +}
> +
> +/* If the RX ring has run out of memory, try periodically
> + * to allocate some more, as otherwise poll would never
> + * get called (apart from the initial end-of-queue condition).
> + *
> + * This is called once per second (by default) from the thread.
> + */
> +
> +static void tsi108_check_rxring(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +
> +	/* A poll is scheduled, as opposed to caling tsi108_refill_rx
> +	 * directly, so as to keep the receive path single-threaded
> +	 * (and thus not needing a lock).
> +	 */
> +
> +	if (netif_running(dev) && data->rxfree < TSI108_RXRING_LEN / 4)
> +		tsi108_rx_int(dev);
> +}
> +
> +static void tsi108_tx_int(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	u32 estat =3D TSI108_ETH_READ_REG(TSI108_EC_TXESTAT);
> +
> +	mb();
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXESTAT, estat);
> +	mb();
> +	TSI108_ETH_WRITE_REG(TSI108_EC_INTSTAT, TSI108_INT_TXQUEUE0 |
> +			     TSI108_INT_TXIDLE | TSI108_INT_TXERROR);
> +	mb();
> +	if (estat & TSI108_EC_TXESTAT_Q0_ERR) {
> +		u32 err =3D TSI108_ETH_READ_REG(TSI108_EC_TXERR);
> +		TSI108_ETH_WRITE_REG(TSI108_EC_TXERR, err);
> +
> +		if (err && net_ratelimit())
> +			printk(KERN_ERR "%s: TX error %x\n", dev->name, err);
> +	}
> +
> +	if (estat & (TSI108_EC_TXESTAT_Q0_DESCINT | =20
> TSI108_EC_TXESTAT_Q0_EOQ)) {
> +		spin_lock(&data->txlock);
> +		tsi108_check_for_completed_tx(dev);
> +		spin_unlock(&data->txlock);
> +	}
> +}
> +
> +static irqreturn_t tsi108_irq_one(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	u32 stat =3D TSI108_ETH_READ_REG(TSI108_EC_INTSTAT);
> +
> +	if (!(stat & TSI108_INT_ANY))
> +		return IRQ_NONE;	/* Not our interrupt */
> +
> +	stat &=3D ~TSI108_ETH_READ_REG(TSI108_EC_INTMASK);
> +
> +	if (stat & (TSI108_INT_TXQUEUE0 | TSI108_INT_TXIDLE |
> +		    TSI108_INT_TXERROR))
> +		tsi108_tx_int(dev);
> +	if (stat & (TSI108_INT_RXQUEUE0 | TSI108_INT_RXTHRESH |
> +		    TSI108_INT_RXWAIT | TSI108_INT_RXOVERRUN |
> +		    TSI108_INT_RXERROR))
> +		tsi108_rx_int(dev);
> +
> +	if (stat & TSI108_INT_SFN) {
> +		if (net_ratelimit())
> +			printk(KERN_DEBUG "%s: SFN error\n", dev->name);
> +		TSI108_ETH_WRITE_REG(TSI108_EC_INTSTAT, TSI108_INT_SFN);
> +	}
> +
> +	if (stat & TSI108_INT_STATCARRY) {
> +		tsi108_stat_carry(dev);
> +		TSI108_ETH_WRITE_REG(TSI108_EC_INTSTAT, TSI108_INT_STATCARRY);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t tsi108_irq(int irq, void *dev_id, struct =20
> pt_regs *regs)
> +{
> +	if ((IRQ_TSI108_GIGE0 !=3D irq) && (IRQ_TSI108_GIGE1 !=3D irq))
> +		return IRQ_NONE;	/* Not our interrupt */
> +
> +	return tsi108_irq_one((struct net_device *)dev_id);
> +}
> +
> +static void tsi108_stop_ethernet(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +
> +	/* Disable all TX and RX queues ... */
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXCTRL, 0);
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXCTRL, 0);
> +
> +	/* ...and wait for them to become idle */
> +	mb();
> +	while (TSI108_ETH_READ_REG(TSI108_EC_TXSTAT) &
> +	       TSI108_EC_TXSTAT_ACTIVE) ;
> +	while (TSI108_ETH_READ_REG(TSI108_EC_RXSTAT) &
> +	       TSI108_EC_RXSTAT_ACTIVE) ;
> +}
> +
> +static void tsi108_reset_ether(tsi108_prv_data * data)
> +{
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG1, TSI108_MAC_CFG1_SOFTRST);
> +	udelay(100);
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG1, 0);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_PORTCTRL, =20
> TSI108_EC_PORTCTRL_STATRST);
> +	udelay(100);
> +	TSI108_ETH_WRITE_REG(TSI108_EC_PORTCTRL,
> +			     TSI108_ETH_READ_REG(TSI108_EC_PORTCTRL) &
> +			     ~TSI108_EC_PORTCTRL_STATRST);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXCFG, TSI108_EC_TXCFG_RST);
> +	udelay(100);
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXCFG,
> +			     TSI108_ETH_READ_REG(TSI108_EC_TXCFG) &
> +			     ~TSI108_EC_TXCFG_RST);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXCFG, TSI108_EC_RXCFG_RST);
> +	udelay(100);
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXCFG,
> +			     TSI108_ETH_READ_REG(TSI108_EC_RXCFG) &
> +			     ~TSI108_EC_RXCFG_RST);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_MII_MGMT_CFG,
> +			     TSI108_ETH_READ_REG(TSI108_MAC_MII_MGMT_CFG) |
> +			     TSI108_MAC_MII_MGMT_RST);
> +	udelay(100);
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_MII_MGMT_CFG,
> +			     TSI108_ETH_READ_REG(TSI108_MAC_MII_MGMT_CFG) &
> +			     ~(TSI108_MAC_MII_MGMT_RST |
> +			       TSI108_MAC_MII_MGMT_CLK));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_MII_MGMT_CFG,
> +			     TSI108_ETH_READ_REG(TSI108_MAC_MII_MGMT_CFG) |
> +			     TSI108_MAC_MII_MGMT_CLK);
> +}
> +
> +static int tsi108_get_mac(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +
> +	u32 word1 =3D TSI108_ETH_READ_REG(TSI108_MAC_ADDR1);
> +	u32 word2 =3D TSI108_ETH_READ_REG(TSI108_MAC_ADDR2);
> +
> +	/* Note that the octets are reversed from what the manual says,
> +	 * producing an even weirder ordering...
> +	 */
> +	if (word2 =3D=3D 0 && word1 =3D=3D 0) {
> +		dev->dev_addr[0] =3D 0x00;
> +		dev->dev_addr[1] =3D 0x06;
> +		dev->dev_addr[2] =3D 0xd2;
> +		dev->dev_addr[3] =3D 0x00;
> +		dev->dev_addr[4] =3D 0x00;
> +		if (0x8 =3D=3D data->phy)
> +			dev->dev_addr[5] =3D 0x01;
> +		else
> +			dev->dev_addr[5] =3D 0x02;
> +
> +		word2 =3D (dev->dev_addr[0] << 16) | (dev->dev_addr[1] << 24);
> +
> +		word1 =3D (dev->dev_addr[2] << 0) | (dev->dev_addr[3] << 8) |
> +		    (dev->dev_addr[4] << 16) | (dev->dev_addr[5] << 24);
> +
> +		TSI108_ETH_WRITE_REG(TSI108_MAC_ADDR1, word1);
> +		TSI108_ETH_WRITE_REG(TSI108_MAC_ADDR2, word2);
> +	} else {
> +		dev->dev_addr[0] =3D (word2 >> 16) & 0xff;
> +		dev->dev_addr[1] =3D (word2 >> 24) & 0xff;
> +		dev->dev_addr[2] =3D (word1 >> 0) & 0xff;
> +		dev->dev_addr[3] =3D (word1 >> 8) & 0xff;
> +		dev->dev_addr[4] =3D (word1 >> 16) & 0xff;
> +		dev->dev_addr[5] =3D (word1 >> 24) & 0xff;
> +	}
> +
> +	if (!is_valid_ether_addr(dev->dev_addr)) {
> +		printk("KERN_ERR: word1: %08x, word2: %08x\n", word1, word2);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tsi108_set_mac(net_device * dev, void *addr)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	u32 word1, word2;
> +	int i;
> +
> +	if (!is_valid_ether_addr(addr))
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < 6; i++)
> +		/* +2 is for the offset of the HW addr type */
> +		dev->dev_addr[i] =3D ((unsigned char *)addr)[i + 2];
> +
> +	word2 =3D (dev->dev_addr[0] << 16) | (dev->dev_addr[1] << 24);
> +
> +	word1 =3D (dev->dev_addr[2] << 0) | (dev->dev_addr[3] << 8) |
> +	    (dev->dev_addr[4] << 16) | (dev->dev_addr[5] << 24);
> +
> +	spin_lock_irq(&data->misclock);
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_ADDR1, word1);
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_ADDR2, word2);
> +	spin_lock(&data->txlock);
> +
> +	if (netif_queue_stopped(dev) && data->txfree && data->link_up)
> +		netif_wake_queue(dev);
> +
> +	spin_unlock(&data->txlock);
> +	spin_unlock_irq(&data->misclock);
> +	return 0;
> +}
> +
> +/* Protected by dev->xmit_lock. */
> +static void tsi108_set_rx_mode(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	u32 rxcfg =3D TSI108_ETH_READ_REG(TSI108_EC_RXCFG);
> +
> +	if (dev->flags & IFF_PROMISC) {
> +		rxcfg &=3D ~(TSI108_EC_RXCFG_UC_HASH | TSI108_EC_RXCFG_MC_HASH);
> +		rxcfg |=3D TSI108_EC_RXCFG_UFE | TSI108_EC_RXCFG_MFE;
> +		goto out;
> +	}
> +
> +	rxcfg &=3D ~(TSI108_EC_RXCFG_UFE | TSI108_EC_RXCFG_MFE);
> +
> +	if (dev->mc_count) {
> +		int i;
> +		struct dev_mc_list *mc =3D dev->mc_list;
> +		rxcfg |=3D TSI108_EC_RXCFG_MFE | TSI108_EC_RXCFG_MC_HASH;
> +
> +		memset(data->mc_hash, 0, sizeof(data->mc_hash));
> +
> +		while (mc) {
> +			u32 hash, crc;
> +
> +			if (mc->dmi_addrlen =3D=3D 6) {
> +				crc =3D ether_crc(6, mc->dmi_addr);
> +				hash =3D crc >> 23;
> +
> +				__set_bit(hash, &data->mc_hash[0]);
> +			} else {
> +				printk(KERN_ERR
> +				       "%s: got multicast address of length %d "
> +				       "instead of 6.\n", dev->name,
> +				       mc->dmi_addrlen);
> +			}
> +
> +			mc =3D mc->next;
> +		}
> +
> +		TSI108_ETH_WRITE_REG(TSI108_EC_HASHADDR,
> +				     TSI108_EC_HASHADDR_AUTOINC |
> +				     TSI108_EC_HASHADDR_MCAST);
> +
> +		for (i =3D 0; i < 16; i++) {
> +			/* The manual says that the hardware may drop
> +			 * back-to-back writes to the data register.
> +			 */
> +			udelay(1);
> +			mb();
> +			TSI108_ETH_WRITE_REG(TSI108_EC_HASHDATA,
> +					     data->mc_hash[i]);
> +			mb();
> +		}
> +	}
> +
> +      out:
> +	mb();
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXCFG, rxcfg);
> +}
> +
> +static void tsi108_init_phy(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	u32 i =3D 0;
> +	u16 phyVal =3D 0;
> +
> +	spin_lock_irq(&phy_lock);
> +
> +	tsi108_write_mii(data, PHY_CTRL, PHY_CTRL_RESET);
> +	mb();
> +	while (tsi108_read_mii(data, PHY_CTRL, NULL) & PHY_CTRL_RESET) ;
> +
> +#if (TSI108_PHY_TYPE =3D=3D PHY_BCM54XX)	/* Broadcom BCM54xx PHY */
> +	tsi108_write_mii(data, 0x09, 0x0300);
> +	tsi108_write_mii(data, 0x10, 0x1020);
> +	tsi108_write_mii(data, 0x1c, 0x8c00);
> +	mb();
> +#endif
> +
> +	tsi108_write_mii(data,
> +			 PHY_CTRL,
> +			 PHY_CTRL_AUTONEG_EN | PHY_CTRL_AUTONEG_START);
> +	mb();
> +	while (tsi108_read_mii(data, PHY_CTRL, NULL) & =20
> PHY_CTRL_AUTONEG_START) ;
> +
> +	/* Set G/MII mode and receive clock select in TBI control #2.  The
> +	 * second port won't work if this isn't done, even though we don't
> +	 * use TBI mode.
> +	 */
> +
> +	tsi108_write_tbi(data, 0x11, 0x30);
> +
> +	/* FIXME: It seems to take more than 2 back-to-back reads to the
> +	 * PHY_STAT register before the link up status bit is set.
> +	 */
> +
> +	data->link_up =3D 1;
> +
> +	while (!((phyVal =3D tsi108_read_mii(data, PHY_STAT, NULL)) &
> +		 PHY_STAT_LINKUP)) {
> +		if (i++ > (MII_READ_DELAY / 10)) {
> +			data->link_up =3D 0;
> +			break;
> +		}
> +		mdelay(10);
> +	}
> +
> +	printk(KERN_DEBUG "PHY_STAT reg contains %08x\n", phyVal);
> +	data->phy_ok =3D 1;
> +	spin_unlock_irq(&phy_lock);
> +}
> +
> +static void tsi108_kill_phy(struct net_device *dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +
> +	spin_lock_irq(&phy_lock);
> +	tsi108_write_mii(data, PHY_CTRL, PHY_CTRL_POWERDOWN);
> +	data->phy_ok =3D 0;
> +	spin_unlock_irq(&phy_lock);
> +}
> +
> +static int tsi108_open(struct net_device *dev)
> +{
> +	int i;
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	unsigned int rxring_size =3D TSI108_RXRING_LEN * sizeof(rx_desc);
> +	unsigned int txring_size =3D TSI108_TXRING_LEN * sizeof(tx_desc);
> +
> +	printk(KERN_DEBUG "Inside tsi108_open()!\n");
> +
> +	i =3D request_irq(data->irq_num, tsi108_irq, 0, dev->name, dev);
> +	if (i !=3D 0) {
> +		printk(KERN_ERR "tsi108_eth%d: Could not allocate IRQ%d.\n",
> +		       data->irq_num % IRQ_TSI108_GIGE0, data->irq_num);
> +		return i;
> +	} else {
> +		dev->irq =3D data->irq_num;
> +		printk(KERN_NOTICE
> +		       "tsi108_open : Port %d Assigned IRQ %d to %s\n",
> +		       data->irq_num % IRQ_TSI108_GIGE0, dev->irq, dev->name);
> +	}
> +
> +	data->rxring =3D pci_alloc_consistent(NULL, rxring_size, &data-=20
> >rxdma);
> +
> +	if (!data->rxring) {
> +		printk(KERN_DEBUG
> +		       "TSI108_ETH: failed to allocate memory for rxring!\n");
> +		return -ENOMEM;
> +	} else {
> +		memset(data->rxring, 0, rxring_size);
> +	}
> +
> +	data->txring =3D pci_alloc_consistent(NULL, txring_size, &data-=20
> >txdma);
> +
> +	if (!data->txring) {
> +		printk(KERN_DEBUG
> +		       "TSI108_ETH: failed to allocate memory for txring!\n");
> +		pci_free_consistent(0, rxring_size, data->rxring, data->rxdma);
> +		return -ENOMEM;
> +	} else {
> +		memset(data->txring, 0, txring_size);
> +	}
> +
> +	for (i =3D 0; i < TSI108_RXRING_LEN; i++) {
> +		data->rxring[i].next0 =3D data->rxdma + (i + 1) * sizeof(rx_desc);
> +		data->rxring[i].blen =3D TSI108_RXBUF_SIZE;
> +		data->rxring[i].vlan =3D 0;
> +	}
> +
> +	data->rxring[TSI108_RXRING_LEN - 1].next0 =3D data->rxdma;
> +
> +	data->rxtail =3D 0;
> +	data->rxhead =3D 0;
> +
> +	for (i =3D 0; i < TSI108_RXRING_LEN; i++) {
> +		sk_buff *skb =3D dev_alloc_skb(TSI108_RXBUF_SIZE + NET_IP_ALIGN);
> +
> +		if (!skb) {
> +			/* Bah.  No memory for now, but maybe we'll get
> +			 * some more later.
> +			 * For now, we'll live with the smaller ring.
> +			 */
> +			printk(KERN_WARNING
> +			       "%s: Could only allocate %d receive skb(s).\n",
> +			       dev->name, i);
> +			data->rxhead =3D i;
> +			break;
> +		}
> +
> +		data->rxskbs[i] =3D skb;
> +		/* Align the payload on a 4-byte boundary */
> +		skb_reserve(skb, 2);
> +		data->rxskbs[i] =3D skb;
> +		data->rxring[i].buf0 =3D virt_to_phys(data->rxskbs[i]->data);
> +		data->rxring[i].misc =3D TSI108_RX_OWN | TSI108_RX_INT;
> +	}
> +
> +	data->rxfree =3D i;
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXQ_PTRLOW, data->rxdma);
> +
> +	for (i =3D 0; i < TSI108_TXRING_LEN; i++) {
> +		data->txring[i].next0 =3D data->txdma + (i + 1) * sizeof(tx_desc);
> +		data->txring[i].misc =3D 0;
> +	}
> +
> +	data->txring[TSI108_TXRING_LEN - 1].next0 =3D data->txdma;
> +	data->txtail =3D 0;
> +	data->txhead =3D 0;
> +	data->txfree =3D TSI108_TXRING_LEN;
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXQ_PTRLOW, data->txdma);
> +	tsi108_init_phy(dev);
> +
> +	init_timer(&data->timer);
> +	data->timer.expires =3D jiffies + 1;
> +	data->timer.data =3D (unsigned long)dev;
> +	data->timer.function =3D &tsi108_timed_checker;	/* timer handler */
> +	add_timer(&data->timer);
> +
> +	tsi108_restart_rx(data, dev);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_INTSTAT, ~0);
> +	mb();
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_INTMASK,
> +			     ~(TSI108_INT_TXQUEUE0 | TSI108_INT_RXERROR |
> +			       TSI108_INT_RXTHRESH | TSI108_INT_RXQUEUE0 |
> +			       TSI108_INT_RXOVERRUN | TSI108_INT_RXWAIT |
> +			       TSI108_INT_SFN | TSI108_INT_STATCARRY));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG1,
> +			     TSI108_MAC_CFG1_RXEN | TSI108_MAC_CFG1_TXEN);
> +	netif_start_queue(dev);
> +	return 0;
> +}
> +
> +static int tsi108_close(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +
> +	netif_stop_queue(dev);
> +
> +	del_timer_sync(&data->timer);
> +
> +	printk(KERN_DEBUG "Inside tsi108_ifdown!\n");
> +
> +	tsi108_stop_ethernet(dev);
> +	tsi108_kill_phy(dev);
> +	TSI108_ETH_WRITE_REG(TSI108_EC_INTMASK, ~0);
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG1, 0);
> +
> +	/* Check for any pending TX packets, and drop them. */
> +
> +	while (!data->txfree || data->txhead !=3D data->txtail) {
> +		int tx =3D data->txtail;
> +		struct sk_buff *skb;
> +		skb =3D data->txskbs[tx];
> +		data->txtail =3D (data->txtail + 1) % TSI108_TXRING_LEN;
> +		data->txfree++;
> +		dev_kfree_skb(skb);
> +	}
> +
> +	synchronize_irq(data->irq_num);
> +	free_irq(data->irq_num, dev);
> +
> +	/* Discard the RX ring. */
> +
> +	while (data->rxfree) {
> +		int rx =3D data->rxtail;
> +		struct sk_buff *skb;
> +
> +		skb =3D data->rxskbs[rx];
> +		data->rxtail =3D (data->rxtail + 1) % TSI108_RXRING_LEN;
> +		data->rxfree--;
> +		dev_kfree_skb(skb);
> +	}
> +
> +	pci_free_consistent(0,
> +			    TSI108_RXRING_LEN * sizeof(rx_desc),
> +			    data->rxring, data->rxdma);
> +	pci_free_consistent(0,
> +			    TSI108_TXRING_LEN * sizeof(tx_desc),
> +			    data->txring, data->txdma);
> +
> +	return 0;
> +}
> +
> +static void tsi108_init_mac(net_device * dev)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG2, =20
> TSI108_MAC_CFG2_DFLT_PREAMBLE |
> +			     TSI108_MAC_CFG2_PADCRC);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXTHRESH,
> +			     (192 << TSI108_EC_TXTHRESH_STARTFILL) |
> +			     (192 << TSI108_EC_TXTHRESH_STOPFILL));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_STAT_CARRYMASK1,
> +			     ~(TSI108_STAT_CARRY1_RXBYTES |
> +			       TSI108_STAT_CARRY1_RXPKTS |
> +			       TSI108_STAT_CARRY1_RXFCS |
> +			       TSI108_STAT_CARRY1_RXMCAST |
> +			       TSI108_STAT_CARRY1_RXALIGN |
> +			       TSI108_STAT_CARRY1_RXLENGTH |
> +			       TSI108_STAT_CARRY1_RXRUNT |
> +			       TSI108_STAT_CARRY1_RXJUMBO |
> +			       TSI108_STAT_CARRY1_RXFRAG |
> +			       TSI108_STAT_CARRY1_RXJABBER |
> +			       TSI108_STAT_CARRY1_RXDROP));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_STAT_CARRYMASK2,
> +			     ~(TSI108_STAT_CARRY2_TXBYTES |
> +			       TSI108_STAT_CARRY2_TXPKTS |
> +			       TSI108_STAT_CARRY2_TXEXDEF |
> +			       TSI108_STAT_CARRY2_TXEXCOL |
> +			       TSI108_STAT_CARRY2_TXTCOL |
> +			       TSI108_STAT_CARRY2_TXPAUSE));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_PORTCTRL, =
TSI108_EC_PORTCTRL_STATEN);
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG1, 0);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXCFG,
> +			     TSI108_EC_RXCFG_SE | TSI108_EC_RXCFG_BFE);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXQ_CFG, TSI108_EC_TXQ_CFG_DESC_INT =
|
> +			     TSI108_EC_TXQ_CFG_EOQ_OWN_INT |
> +			     TSI108_EC_TXQ_CFG_WSWP | (TSI108_PBM_PORT <<
> +						       TSI108_EC_TXQ_CFG_SFNPORT));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXQ_CFG, TSI108_EC_RXQ_CFG_DESC_INT =
|
> +			     TSI108_EC_RXQ_CFG_EOQ_OWN_INT |
> +			     TSI108_EC_RXQ_CFG_WSWP | (TSI108_PBM_PORT <<
> +						       TSI108_EC_RXQ_CFG_SFNPORT));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXQ_BUFCFG,
> +			     TSI108_EC_TXQ_BUFCFG_BURST256 |
> +			     TSI108_EC_TXQ_BUFCFG_BSWP | (TSI108_PBM_PORT <<
> +							  TSI108_EC_TXQ_BUFCFG_SFNPORT));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXQ_BUFCFG,
> +			     TSI108_EC_RXQ_BUFCFG_BURST256 |
> +			     TSI108_EC_RXQ_BUFCFG_BSWP | (TSI108_PBM_PORT <<
> +							  TSI108_EC_RXQ_BUFCFG_SFNPORT));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_INTMASK, ~0);
> +}
> +
> +static int tsi108_ioctl(net_device * dev, struct ifreq *rq, int cmd)
> +{
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +	struct mii_ioctl_data *mii_data =3D
> +	    (struct mii_ioctl_data *)&rq->ifr_data;
> +	int ret;
> +
> +	switch (cmd) {
> +	case SIOCGMIIPHY:
> +		mii_data->phy_id =3D data->phy;
> +		ret =3D 0;
> +		break;
> +
> +	case SIOCGMIIREG:
> +		spin_lock_irq(&phy_lock);
> +		mii_data->val_out =3D
> +		    tsi108_read_mii(data, mii_data->reg_num, &ret);
> +		spin_unlock_irq(&phy_lock);
> +		break;
> +
> +	default:
> +		ret =3D -EOPNOTSUPP;
> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +tsi108_init_one(unsigned long regs, unsigned long phyregs, u16 =20
> phy, u16 irq_num)
> +{
> +	net_device *dev =3D alloc_etherdev(sizeof(tsi108_prv_data));
> +	tsi108_prv_data *data;
> +	int ret;
> +
> +	if (!dev) {
> +		printk("tsi108_eth: Could not allocate a device structure\n");
> +		return -ENOMEM;
> +	}
> +
> +	data =3D netdev_priv(dev);
> +	memset(data, 0, sizeof(tsi108_prv_data));
> +
> +	data->regs =3D (volatile u32)regs;
> +	data->phyregs =3D (volatile u32)phyregs;
> +	data->phy =3D phy;
> +	data->irq_num =3D irq_num;
> +
> +	dev->open =3D tsi108_open;
> +	dev->stop =3D tsi108_close;
> +	dev->hard_start_xmit =3D tsi108_send_packet;
> +	dev->set_mac_address =3D tsi108_set_mac;
> +	dev->set_multicast_list =3D tsi108_set_rx_mode;
> +	dev->get_stats =3D tsi108_get_stats;
> +	dev->poll =3D tsi108_poll;
> +	dev->do_ioctl =3D tsi108_ioctl;
> +	dev->weight =3D 64;	/* 64 is more suitable for GigE interface - =20
> klai */
> +
> +	/* Apparently, the Linux networking code won't use scatter-gather
> +	 * if the hardware doesn't do checksums.  However, it's faster
> +	 * to checksum in place and use SG, as (among other reasons)
> +	 * the cache won't be dirtied (which then has to be flushed
> +	 * before DMA).  The checksumming is done by the driver (via
> +	 * a new function skb_csum_dev() in net/core/skbuff.c).
> +	 */
> +
> +#ifdef FIXME_SG_CSUM_NOT_TESTED	/* FIXME: Not supported now. */
> +	dev->features =3D NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_HW_CSUM;
> +#else
> +	dev->features =3D NETIF_F_HIGHDMA;
> +#endif
> +	SET_MODULE_OWNER(dev);
> +
> +	spin_lock_init(&data->txlock);
> +	spin_lock_init(&data->misclock);
> +
> +	tsi108_reset_ether(data);
> +	tsi108_kill_phy(dev);
> +
> +	if (tsi108_get_mac(dev) !=3D 0)
> +		printk(KERN_ERR "%s: Invalid MAC address.  Please correct.\n",
> +		       dev->name);
> +
> +	tsi108_init_mac(dev);
> +
> +	tsi108_devs[irq_num % IRQ_TSI108_GIGE0] =3D dev;
> +
> +	ret =3D register_netdev(dev);
> +	if (ret < 0) {
> +		kfree(dev);
> +		return ret;
> +	}
> +
> +	printk(KERN_INFO "%s: Tsi108 Gigabit Ethernet, MAC: "
> +	       "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name,
> +	       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
> +	       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
> +
> +	return 0;
> +}
> +
> +/* There's no way to either get interrupts from the PHY when
> + * something changes, or to have the Tsi108 automatically =
communicate
> + * with the PHY to reconfigure itself.
> + *
> + * Thus, we have to do it using a timer.
> + */
> +
> +static void tsi108_timed_checker(unsigned long dev_ptr)
> +{
> +	struct net_device *dev =3D (struct net_device *)dev_ptr;
> +	tsi108_prv_data *data =3D netdev_priv(dev);
> +
> +	tsi108_check_phy(dev);
> +	tsi108_check_rxring(dev);
> +	data->timer.expires =3D jiffies + CHECK_PHY_INTERVAL;
> +	add_timer(&data->timer);
> +}
> +
> +static int tsi108_ether_init(void)
> +{
> +	int ret;
> +	int dev_count =3D 0;
> +	int i;
> +
> +	hw_info_table[0].regs =3D (u32) ioremap(hw_info_table[0].regs, =
0x400);
> +	hw_info_table[0].phyregs =3D hw_info_table[0].regs;
> +
> +	hw_info_table[1].regs =3D (u32) ioremap(hw_info_table[1].regs, =
0x400);
> +	hw_info_table[1].phyregs =3D hw_info_table[0].regs;
> +
> +	for (i =3D 0; hw_info_table[i].regs !=3D TBL_END; i++) {
> +		ret =3D tsi108_init_one(hw_info_table[i].regs,
> +				      hw_info_table[i].phyregs,
> +				      hw_info_table[i].phy,
> +				      hw_info_table[i].irq_num);
> +		if (ret < 0)
> +			printk("tsi108_ether_init: error initializing ethernet "
> +			       "device%d\n", i);
> +		else
> +			dev_count++;
> +	}
> +
> +	printk("tsi108_ether_init: found %d device(s)\n", dev_count);
> +
> +	return 0;
> +}
> +
> +static void tsi108_ether_exit(void)
> +{
> +	int i;
> +	net_device *dev;
> +
> +	for (i =3D 0; hw_info_table[i].regs !=3D TBL_END; i++) {
> +		if ((dev =3D tsi108_devs[i]) !=3D NULL) {
> +			unregister_netdev(dev);
> +			tsi108_stop_ethernet(dev);
> +			kfree(dev);
> +			tsi108_devs[i] =3D NULL;
> +		}
> +	}
> +}
> +
> +module_init(tsi108_ether_init);
> +module_exit(tsi108_ether_exit);
> +
> +MODULE_AUTHOR("Tundra Semiconductor Corporation");
> +MODULE_DESCRIPTION("Tsi108 Gigabit Ethernet driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/net/tsi108_eth.h b/drivers/net/tsi108_eth.h
> new file mode 100644
> index 0000000..cb54f92
> --- /dev/null
> +++ b/drivers/net/tsi108_eth.h
> @@ -0,0 +1,404 @@
> +/*
> + * (C) Copyright 2005 Tundra Semiconductor Corp.
> + * Kong Lai, <kong.lai@tundra.com).
> + *
> + * See file CREDITS for list of people who contributed to this
> + * project.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> + * MA 02111-1307 USA
> + */
> +
> +/*
> + * net/tsi108_eth.h - definitions for Tsi108 GIGE network =
controller.
> + */
> +
> +#ifndef __TSI108_ETH_H
> +#define __TSI108_ETH_H
> +
> +#include <linux/config.h>
> +#include <linux/types.h>
> +
> +#define TSI108_ETH_WRITE_REG(offset, val) \
> +	out_be32((volatile u32 *)(data->regs + offset), val)
> +
> +#define TSI108_ETH_READ_REG(offset) \
> +	in_be32((volatile u32 *)(data->regs + offset))
> +
> +#define TSI108_ETH_WRITE_PHYREG(offset, val) \
> +	out_be32((volatile u32 *)(data->phyregs + offset), val)
> +
> +#define TSI108_ETH_READ_PHYREG(offset) \
> +	in_be32((volatile u32 *)(data->phyregs + offset))
> +
> +/*
> + * PHY Configuration Options
> + *
> + * NOTE: Enable set of definitions corresponding to your board type
> + */
> +#define PHY_MV88E	1	/* Marvel 88Exxxx PHY */
> +#define PHY_BCM54XX	2	/* Broardcom BCM54xx PHY */
> +#define TSI108_PHY_TYPE	PHY_MV88E
> +
> +/*
> + * TSI108 GIGE port registers
> + */
> +
> +#define TSI108_ETH_PORT_NUM		2
> +#define TSI108_PBM_PORT			2
> +#define TSI108_SDRAM_PORT		4
> +
> +#define TSI108_MAC_CFG1			(0x000)
> +#define TSI108_MAC_CFG1_SOFTRST		(1 << 31)
> +#define TSI108_MAC_CFG1_LOOPBACK	(1 << 8)
> +#define TSI108_MAC_CFG1_RXEN		(1 << 2)
> +#define TSI108_MAC_CFG1_TXEN		(1 << 0)
> +
> +#define TSI108_MAC_CFG2			(0x004)
> +#define TSI108_MAC_CFG2_DFLT_PREAMBLE	(7 << 12)
> +#define TSI108_MAC_CFG2_IFACE_MASK	(3 << 8)
> +#define TSI108_MAC_CFG2_NOGIG		(1 << 8)
> +#define TSI108_MAC_CFG2_GIG		(2 << 8)
> +#define TSI108_MAC_CFG2_PADCRC		(1 << 2)
> +#define TSI108_MAC_CFG2_FULLDUPLEX	(1 << 0)
> +
> +#define TSI108_MAC_MII_MGMT_CFG		(0x020)
> +#define TSI108_MAC_MII_MGMT_CLK		(7 << 0)
> +#define TSI108_MAC_MII_MGMT_RST		(1 << 31)
> +
> +#define TSI108_MAC_MII_CMD		(0x024)
> +#define TSI108_MAC_MII_CMD_READ		(1 << 0)
> +
> +#define TSI108_MAC_MII_ADDR		(0x028)
> +#define TSI108_MAC_MII_ADDR_REG		0
> +#define TSI108_MAC_MII_ADDR_PHY		8
> +
> +#define TSI108_MAC_MII_DATAOUT		(0x02c)
> +#define TSI108_MAC_MII_DATAIN		(0x030)
> +
> +#define TSI108_MAC_MII_IND		(0x034)
> +#define TSI108_MAC_MII_IND_NOTVALID	(1 << 2)
> +#define TSI108_MAC_MII_IND_SCANNING	(1 << 1)
> +#define TSI108_MAC_MII_IND_BUSY		(1 << 0)
> +
> +#define TSI108_MAC_IFCTRL		(0x038)
> +#define TSI108_MAC_IFCTRL_PHYMODE	(1 << 24)
> +
> +#define TSI108_MAC_ADDR1		(0x040)
> +#define TSI108_MAC_ADDR2		(0x044)
> +
> +#define TSI108_STAT_RXBYTES		(0x06c)
> +#define TSI108_STAT_RXBYTES_CARRY	(1 << 24)
> +
> +#define TSI108_STAT_RXPKTS		(0x070)
> +#define TSI108_STAT_RXPKTS_CARRY	(1 << 18)
> +
> +#define TSI108_STAT_RXFCS		(0x074)
> +#define TSI108_STAT_RXFCS_CARRY		(1 << 12)
> +
> +#define TSI108_STAT_RXMCAST		(0x078)
> +#define TSI108_STAT_RXMCAST_CARRY	(1 << 18)
> +
> +#define TSI108_STAT_RXALIGN		(0x08c)
> +#define TSI108_STAT_RXALIGN_CARRY	(1 << 12)
> +
> +#define TSI108_STAT_RXLENGTH		(0x090)
> +#define TSI108_STAT_RXLENGTH_CARRY	(1 << 12)
> +
> +#define TSI108_STAT_RXRUNT		(0x09c)
> +#define TSI108_STAT_RXRUNT_CARRY	(1 << 12)
> +
> +#define TSI108_STAT_RXJUMBO		(0x0a0)
> +#define TSI108_STAT_RXJUMBO_CARRY	(1 << 12)
> +
> +#define TSI108_STAT_RXFRAG		(0x0a4)
> +#define TSI108_STAT_RXFRAG_CARRY	(1 << 12)
> +
> +#define TSI108_STAT_RXJABBER		(0x0a8)
> +#define TSI108_STAT_RXJABBER_CARRY	(1 << 12)
> +
> +#define TSI108_STAT_RXDROP		(0x0ac)
> +#define TSI108_STAT_RXDROP_CARRY	(1 << 12)
> +
> +#define TSI108_STAT_TXBYTES		(0x0b0)
> +#define TSI108_STAT_TXBYTES_CARRY	(1 << 24)
> +
> +#define TSI108_STAT_TXPKTS		(0x0b4)
> +#define TSI108_STAT_TXPKTS_CARRY	(1 << 18)
> +
> +#define TSI108_STAT_TXEXDEF		(0x0c8)
> +#define TSI108_STAT_TXEXDEF_CARRY	(1 << 12)
> +
> +#define TSI108_STAT_TXEXCOL		(0x0d8)
> +#define TSI108_STAT_TXEXCOL_CARRY	(1 << 12)
> +
> +#define TSI108_STAT_TXTCOL		(0x0dc)
> +#define TSI108_STAT_TXTCOL_CARRY	(1 << 13)
> +
> +#define TSI108_STAT_TXPAUSEDROP		(0x0e4)
> +#define TSI108_STAT_TXPAUSEDROP_CARRY	(1 << 12)
> +
> +#define TSI108_STAT_CARRY1		(0x100)
> +#define TSI108_STAT_CARRY1_RXBYTES	(1 << 16)
> +#define TSI108_STAT_CARRY1_RXPKTS	(1 << 15)
> +#define TSI108_STAT_CARRY1_RXFCS	(1 << 14)
> +#define TSI108_STAT_CARRY1_RXMCAST	(1 << 13)
> +#define TSI108_STAT_CARRY1_RXALIGN	(1 << 8)
> +#define TSI108_STAT_CARRY1_RXLENGTH	(1 << 7)
> +#define TSI108_STAT_CARRY1_RXRUNT	(1 << 4)
> +#define TSI108_STAT_CARRY1_RXJUMBO	(1 << 3)
> +#define TSI108_STAT_CARRY1_RXFRAG	(1 << 2)
> +#define TSI108_STAT_CARRY1_RXJABBER	(1 << 1)
> +#define TSI108_STAT_CARRY1_RXDROP	(1 << 0)
> +
> +#define TSI108_STAT_CARRY2		(0x104)
> +#define TSI108_STAT_CARRY2_TXBYTES	(1 << 13)
> +#define TSI108_STAT_CARRY2_TXPKTS	(1 << 12)
> +#define TSI108_STAT_CARRY2_TXEXDEF	(1 << 7)
> +#define TSI108_STAT_CARRY2_TXEXCOL	(1 << 3)
> +#define TSI108_STAT_CARRY2_TXTCOL	(1 << 2)
> +#define TSI108_STAT_CARRY2_TXPAUSE	(1 << 0)
> +
> +#define TSI108_STAT_CARRYMASK1		(0x108)
> +#define TSI108_STAT_CARRYMASK2		(0x10c)
> +
> +#define TSI108_EC_PORTCTRL		(0x200)
> +#define TSI108_EC_PORTCTRL_STATRST	(1 << 31)
> +#define TSI108_EC_PORTCTRL_STATEN	(1 << 28)
> +#define TSI108_EC_PORTCTRL_NOGIG	(1 << 18)
> +#define TSI108_EC_PORTCTRL_HALFDUPLEX	(1 << 16)
> +
> +#define TSI108_EC_INTSTAT		(0x204)
> +#define TSI108_EC_INTMASK		(0x208)
> +
> +#define TSI108_INT_ANY			(1 << 31)
> +#define TSI108_INT_SFN			(1 << 30)
> +#define TSI108_INT_RXIDLE		(1 << 29)
> +#define TSI108_INT_RXABORT		(1 << 28)
> +#define TSI108_INT_RXERROR		(1 << 27)
> +#define TSI108_INT_RXOVERRUN		(1 << 26)
> +#define TSI108_INT_RXTHRESH		(1 << 25)
> +#define TSI108_INT_RXWAIT		(1 << 24)
> +#define TSI108_INT_RXQUEUE0		(1 << 16)
> +#define TSI108_INT_STATCARRY		(1 << 15)
> +#define TSI108_INT_TXIDLE		(1 << 13)
> +#define TSI108_INT_TXABORT		(1 << 12)
> +#define TSI108_INT_TXERROR		(1 << 11)
> +#define TSI108_INT_TXUNDERRUN		(1 << 10)
> +#define TSI108_INT_TXTHRESH		(1 <<  9)
> +#define TSI108_INT_TXWAIT		(1 <<  8)
> +#define TSI108_INT_TXQUEUE0		(1 <<  0)
> +
> +#define TSI108_EC_TXCFG			(0x220)
> +#define TSI108_EC_TXCFG_RST		(1 << 31)
> +
> +#define TSI108_EC_TXCTRL		(0x224)
> +#define TSI108_EC_TXCTRL_IDLEINT	(1 << 31)
> +#define TSI108_EC_TXCTRL_ABORT		(1 << 30)
> +#define TSI108_EC_TXCTRL_GO		(1 << 15)
> +#define TSI108_EC_TXCTRL_QUEUE0		(1 <<  0)
> +
> +#define TSI108_EC_TXSTAT		(0x228)
> +#define TSI108_EC_TXSTAT_ACTIVE		(1 << 15)
> +#define TSI108_EC_TXSTAT_QUEUE0		(1 << 0)
> +
> +#define TSI108_EC_TXESTAT		(0x22c)
> +#define TSI108_EC_TXESTAT_Q0_ERR	(1 << 24)
> +#define TSI108_EC_TXESTAT_Q0_DESCINT	(1 << 16)
> +#define TSI108_EC_TXESTAT_Q0_EOF	(1 <<  8)
> +#define TSI108_EC_TXESTAT_Q0_EOQ	(1 <<  0)
> +
> +#define TSI108_EC_TXERR			(0x278)
> +
> +#define TSI108_EC_TXQ_CFG		(0x280)
> +#define TSI108_EC_TXQ_CFG_DESC_INT	(1 << 20)
> +#define TSI108_EC_TXQ_CFG_EOQ_OWN_INT	(1 << 19)
> +#define TSI108_EC_TXQ_CFG_WSWP		(1 << 11)
> +#define TSI108_EC_TXQ_CFG_BSWP		(1 << 10)
> +#define TSI108_EC_TXQ_CFG_SFNPORT	0
> +
> +#define TSI108_EC_TXQ_BUFCFG		(0x284)
> +#define TSI108_EC_TXQ_BUFCFG_BURST8	(0 << 8)
> +#define TSI108_EC_TXQ_BUFCFG_BURST32	(1 << 8)
> +#define TSI108_EC_TXQ_BUFCFG_BURST128	(2 << 8)
> +#define TSI108_EC_TXQ_BUFCFG_BURST256	(3 << 8)
> +#define TSI108_EC_TXQ_BUFCFG_WSWP	(1 << 11)
> +#define TSI108_EC_TXQ_BUFCFG_BSWP	(1 << 10)
> +#define TSI108_EC_TXQ_BUFCFG_SFNPORT	0
> +
> +#define TSI108_EC_TXQ_PTRLOW		(0x288)
> +
> +#define TSI108_EC_TXQ_PTRHIGH		(0x28c)
> +#define TSI108_EC_TXQ_PTRHIGH_VALID	(1 << 31)
> +
> +#define TSI108_EC_TXTHRESH		(0x230)
> +#define TSI108_EC_TXTHRESH_STARTFILL	0
> +#define TSI108_EC_TXTHRESH_STOPFILL	16
> +
> +#define TSI108_EC_RXCFG			(0x320)
> +#define TSI108_EC_RXCFG_RST		(1 << 31)
> +
> +#define TSI108_EC_RXSTAT		(0x328)
> +#define TSI108_EC_RXSTAT_ACTIVE		(1 << 15)
> +#define TSI108_EC_RXSTAT_QUEUE0		(1 << 0)
> +
> +#define TSI108_EC_RXESTAT		(0x32c)
> +#define TSI108_EC_RXESTAT_Q0_ERR	(1 << 24)
> +#define TSI108_EC_RXESTAT_Q0_DESCINT	(1 << 16)
> +#define TSI108_EC_RXESTAT_Q0_EOF	(1 <<  8)
> +#define TSI108_EC_RXESTAT_Q0_EOQ	(1 <<  0)
> +
> +#define TSI108_EC_HASHADDR		(0x360)
> +#define TSI108_EC_HASHADDR_AUTOINC	(1 << 31)
> +#define TSI108_EC_HASHADDR_DO1STREAD	(1 << 30)
> +#define TSI108_EC_HASHADDR_UNICAST	(0 <<  4)
> +#define TSI108_EC_HASHADDR_MCAST	(1 <<  4)
> +
> +#define TSI108_EC_HASHDATA		(0x364)
> +
> +#define TSI108_EC_RXQ_PTRLOW		(0x388)
> +
> +#define TSI108_EC_RXQ_PTRHIGH		(0x38c)
> +#define TSI108_EC_RXQ_PTRHIGH_VALID	(1 << 31)
> +
> +/* Station Enable -- accept packets destined for us */
> +#define TSI108_EC_RXCFG_SE		(1 << 13)
> +/* Unicast Frame Enable -- for packets not destined for us */
> +#define TSI108_EC_RXCFG_UFE		(1 << 12)
> +/* Multicast Frame Enable */
> +#define TSI108_EC_RXCFG_MFE		(1 << 11)
> +/* Broadcast Frame Enable */
> +#define TSI108_EC_RXCFG_BFE		(1 << 10)
> +#define TSI108_EC_RXCFG_UC_HASH		(1 <<  9)
> +#define TSI108_EC_RXCFG_MC_HASH		(1 <<  8)
> +
> +#define TSI108_EC_RXQ_CFG		(0x380)
> +#define TSI108_EC_RXQ_CFG_DESC_INT	(1 << 20)
> +#define TSI108_EC_RXQ_CFG_EOQ_OWN_INT	(1 << 19)
> +#define TSI108_EC_RXQ_CFG_WSWP		(1 << 11)
> +#define TSI108_EC_RXQ_CFG_BSWP		(1 << 10)
> +#define TSI108_EC_RXQ_CFG_SFNPORT	0
> +
> +#define TSI108_EC_RXQ_BUFCFG		(0x384)
> +#define TSI108_EC_RXQ_BUFCFG_BURST8	(0 << 8)
> +#define TSI108_EC_RXQ_BUFCFG_BURST32	(1 << 8)
> +#define TSI108_EC_RXQ_BUFCFG_BURST128	(2 << 8)
> +#define TSI108_EC_RXQ_BUFCFG_BURST256	(3 << 8)
> +#define TSI108_EC_RXQ_BUFCFG_WSWP	(1 << 11)
> +#define TSI108_EC_RXQ_BUFCFG_BSWP	(1 << 10)
> +#define TSI108_EC_RXQ_BUFCFG_SFNPORT	0
> +
> +#define TSI108_EC_RXCTRL		(0x324)
> +#define TSI108_EC_RXCTRL_ABORT		(1 << 30)
> +#define TSI108_EC_RXCTRL_GO		(1 << 15)
> +#define TSI108_EC_RXCTRL_QUEUE0		(1 << 0)
> +
> +#define TSI108_EC_RXERR			(0x378)
> +
> +#define PHY_CTRL			0
> +#define PHY_CTRL_RESET			(1 << 15)
> +#define PHY_CTRL_AUTONEG_EN		(1 << 12)
> +#define PHY_CTRL_POWERDOWN		(1 << 11)
> +#define PHY_CTRL_AUTONEG_START		(1 << 9)
> +
> +#define PHY_STAT			1
> +#define PHY_STAT_LINKUP			(1 << 2)
> +
> +#if (TSI108_PHY_TYPE =3D=3D PHY_MV88E)
> +/* Marvel 88E1xxx-specific */
> +#define PHY_SUM_STAT			0x11
> +#define PHY_SUM_STAT_SPEED_MASK		(3 << 14)
> +#define PHY_SUM_STAT_SPEED_10		(0 << 14)
> +#define PHY_SUM_STAT_SPEED_100		(1 << 14)
> +#define PHY_SUM_STAT_SPEED_1000		(2 << 14)
> +#define PHY_SUM_STAT_FULLDUPLEX		(1 << 13)
> +
> +#define PHY_SUM_STAT_1000T_FD    (PHY_SUM_STAT_SPEED_1000 | =20
> PHY_SUM_STAT_FULLDUPLEX)
> +#define PHY_SUM_STAT_1000T_HD    (PHY_SUM_STAT_SPEED_1000)
> +#define PHY_SUM_STAT_100TX_FD    (PHY_SUM_STAT_SPEED_100 | =20
> PHY_SUM_STAT_FULLDUPLEX)
> +#define PHY_SUM_STAT_100TX_HD    (PHY_SUM_STAT_SPEED_100)
> +#define PHY_SUM_STAT_10T_FD	    (PHY_SUM_STAT_SPEED_10 | =20
> PHY_SUM_STAT_FULLDUPLEX)
> +#define PHY_SUM_STAT_10T_HD	    (PHY_SUM_STAT_SPEED_10)
> +#elif (TSI108_PHY_TYPE =3D=3D PHY_BCM54XX)
> +/*Broadcom BCM54xx */
> +#define PHY_SUM_STAT			0x19
> +#define PHY_SUM_STAT_SPEED_MASK		(7 << 8)	/* Auto Negotiation HCD */
> +#define PHY_SUM_STAT_1000T_FD		(7 << 8)	/* 1000BASE-T Full-Duplex */
> +#define PHY_SUM_STAT_1000T_HD		(6 << 8)	/* 1000BASE-T Half-Duplex */
> +#define PHY_SUM_STAT_100TX_FD		(5 << 8)	/* 100BASE-TX Full-Duplex */
> +#define PHY_SUM_STAT_100T4		(4 << 8)	/* 100BASE-T4 */
> +#define PHY_SUM_STAT_100TX_HD		(3 << 8)	/* 100BASE-TX Half-Duplex */
> +#define PHY_SUM_STAT_10T_FD		(2 << 8)	/* 10BASE-T Full-Duplex */
> +#define PHY_SUM_STAT_10T_HD		(1 << 8)	/* 10BASE-T Half-Duplex */
> +#define PHY_SUM_STAT_AN_FAIL		(0 << 8)	/* 1000BASE-T Half-Duplex */
> +#else
> +#error "PHY Device not specified"
> +#endif				/* MV88_PHY */
> +
> +#define TSI108_TX_EOF	(1 << 0)	/* End of frame; last fragment of =20
> packet */
> +#define TSI108_TX_SOF	(1 << 1)	/* Start of frame; first frag. of =20
> packet */
> +#define TSI108_TX_VLAN	(1 << 2)	/* Per-frame VLAN: enables VLAN =20
> override */
> +#define TSI108_TX_HUGE	(1 << 3)	/* Huge frame enable */
> +#define TSI108_TX_PAD	(1 << 4)	/* Pad the packet if too short */
> +#define TSI108_TX_CRC	(1 << 5)	/* Generate CRC for this packet */
> +#define TSI108_TX_INT	(1 << 14)	/* Generate an IRQ after frag. =20
> processed */
> +#define TSI108_TX_RETRY	16	/* 4 bit field indicating num. of =20
> retries */
> +#define TSI108_TX_COL	(1 << 20)	/* Set if a collision occured */
> +#define TSI108_TX_LCOL	(1 << 24)	/* Set if a late collision =20
> occured */
> +#define TSI108_TX_UNDER	(1 << 25)	/* Set if a FIFO underrun =20
> occured */
> +#define TSI108_TX_RLIM	(1 << 26)	/* Set if the retry limit was =20
> reached */
> +#define TSI108_TX_OK	(1 << 30)	/* Set if the frame TX was =20
> successful */
> +#define TSI108_TX_OWN	(1 << 31)	/* Set if the device owns the =20
> descriptor */
> +
> +/* Note: the descriptor layouts assume big-endian byte order. */
> +typedef struct {
> +	u32 buf0;
> +	u32 buf1;		/* Base address of buffer */
> +	u32 next0;		/* Address of next descriptor, if any */
> +	u32 next1;
> +	u16 vlan;		/* VLAN, if override enabled for this packet */
> +	u16 len;		/* Length of buffer in bytes */
> +	u32 misc;		/* See TSI108_TX_* above */
> +	u32 reserved0;		/*reserved0 and reserved1 are added to make the =20
> desc */
> +	u32 reserved1;		/* 32-byte aligned */
> +} __attribute__ ((aligned(32))) tx_desc;
> +
> +#define TSI108_RX_EOF	(1 << 0)	/* End of frame; last fragment of  
> packet */
> +#define TSI108_RX_SOF	(1 << 1)	/* Start of frame; first frag. of =20
> packet */
> +#define TSI108_RX_VLAN	(1 << 2)	/* Set on SOF if packet has a VLAN =
*/
> +#define TSI108_RX_FTYPE	(1 << 3)	/* Length/Type field is type, not =20
> length */
> +#define TSI108_RX_RUNT	(1 << 4)/* Packet is less than minimum size =
*/
> +#define TSI108_RX_HASH	(1 << 7)/* Hash table match */
> +#define TSI108_RX_BAD	(1 << 8)	/* Bad frame */
> +#define TSI108_RX_OVER	(1 << 9)	/* FIFO overrun occured */
> +#define TSI108_RX_TRUNC	(1 << 11)	/* Packet truncated due to =20
> excess length */
> +#define TSI108_RX_CRC	(1 << 12)	/* Packet had a CRC error */
> +#define TSI108_RX_INT	(1 << 13)	/* Generate an IRQ after frag. =20
> processed */
> +#define TSI108_RX_OWN	(1 << 15)	/* Set if the device owns the =20
> descriptor */
> +
> +typedef struct {
> +	u32 buf0;		/* Base address of buffer */
> +	u32 buf1;		/* Base address of buffer */
> +	u32 next0;		/* Address of next descriptor, if any */
> +	u32 next1;		/* Address of next descriptor, if any */
> +	u16 vlan;		/* VLAN of received packet, first frag only */
> +	u16 len;		/* Length of received fragment in bytes */
> +	u16 blen;		/* Length of buffer in bytes */
> +	u16 misc;		/* See TSI108_RX_* above */
> +	u32 reserved0;		/* reserved0 and reserved1 are added to make the =20
> desc */
> +	u32 reserved1;		/* 32-byte aligned */
> +} __attribute__ ((aligned(32))) rx_desc;
> +
> +#endif				/* __TSI108_ETH_H */
> --=20
> 1.3.0
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
