Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (mail.tranzeo.com [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id A7CADDE3C2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Aug 2008 03:03:07 +1000 (EST)
Subject: Possible init bug in ibm_newemac/core.c
From: Darcy Watkins <dwatkins@tranzeo.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Fri, 15 Aug 2008 10:03:05 -0700
Message-Id: <1218819785.3465.190.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

In function...

static int __devinit emac_probe(struct of_device *ofdev,
				const struct of_device_id *match)


... in 

   drivers/net/ibm_newemac/core.c

... there is a chunk of code as follows (The // DLW - BUG ... comment is
mine)  ...

	/* Find PHY if any */
	// DLW - BUG - This uses an uninitialized spinlock (potential badness).
	err = emac_init_phy(dev);
	if (err != 0)
		goto err_detach_tah;

	/* Fill in the driver function table */
	ndev->open = &emac_open;
	if (dev->tah_dev)
		ndev->features |= NETIF_F_IP_CSUM | NETIF_F_SG;
	ndev->tx_timeout = &emac_tx_timeout;
	ndev->watchdog_timeo = 5 * HZ;
	ndev->stop = &emac_close;
	ndev->get_stats = &emac_stats;
	ndev->set_multicast_list = &emac_set_multicast_list;
	ndev->do_ioctl = &emac_ioctl;
	if (emac_phy_supports_gige(dev->phy_mode)) {
		ndev->hard_start_xmit = &emac_start_xmit_sg;
		ndev->change_mtu = &emac_change_mtu;
		dev->commac.ops = &emac_commac_sg_ops;
	} else {
		ndev->hard_start_xmit = &emac_start_xmit;
	}
	SET_ETHTOOL_OPS(ndev, &emac_ethtool_ops);

	netif_carrier_off(ndev);
	netif_stop_queue(ndev);

	err = register_netdev(ndev);
	if (err) {
		printk(KERN_ERR "%s: failed to register net device (%d)!\n",
		       np->full_name, err);
		goto err_detach_tah;
	}

init_emac_phy() uses a spinlock that isn't initialized until
register_netdev() is invoked.  I tried moving the init_emac_phy() to be
after the register_netdev().  The fix appeared to work on one board
variant (with two Ethernet ports) but kernel panics during boot on
another board variant (with one Etherent port and less memory).

So I have reverted my lame hack attempt and am reporting this so that an
expert can check into it.

The bug normally goes unnoticed until you turn on spinlock and/or
rtmutex debuggging in the kernel config - then the debugging magic
checks will catch it during boot.

This is based on kernel 2.6.25.8-rt7 and then upgraded to be
2.6.25.13-rt7 using incremental patches - running on an AMCC PPC405EP
but I think you could reproduce it using 2.6.25.8-rt7 (or possibly other
kernel versions).


-- 


Regards,

Darcy

--------------
Darcy L. Watkins - Senior Software Developer
Tranzeo Wireless Technologies, Inc.
19273 Fraser Way, Pitt Meadows, BC, Canada V3Y 2V4
T:604-460-6002 ext:410
http://www.tranzeo.com
