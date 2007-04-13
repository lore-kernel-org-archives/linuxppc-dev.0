Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 29C9ADDE34
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Apr 2007 02:21:40 +1000 (EST)
Message-ID: <461FAF0D.3070803@ru.mvista.com>
Date: Fri, 13 Apr 2007 20:25:49 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Peter Mendham <petermendham@computing.dundee.ac.uk>
Subject: Re: Tri-mode auto-negotiation on ML405
References: <461F65E3.1050004@computing.dundee.ac.uk>
In-Reply-To: <461F65E3.1050004@computing.dundee.ac.uk>
Content-Type: multipart/mixed; boundary="------------020801050905020704060009"
Cc: linuxppc-embedded@ozlabs.org
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
--------------020801050905020704060009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter,

I've had some problems with a self-made "TEMAC in SGDMA mode" design for ML403,
so working with TEMAC in FIFO mode at the moment.

And I've tried the PHY library (drivers/net/phy/*) introduced by Andy Fleming.
Kinda works. The only problem I have no explanation for yet is that after
turning auto-negotiation off (with ethtool), and playing with switching
between 1000/100/10Mbits, I could not make the board to get back to 1000Mbits
(the board simply stops advertising 1000Mbits at some point).

Attached is the incomplete adapter.c (with FIFO mode support only) which
uses the PHY lib to handle the PHY. Just to illustrate the idea (will post the
patch later when it is completed).
It could auto-negotiate faster than the driver you are using, as there are
no explicit 2 second delays. But the things could be even faster if the
auto-negotiation interrupt would be used (this is TBD).

Don't forget to "select PHYLIB" in the drivers/net/Kconfig for TEMAC
if you want to try this approach.

Thanks,
Andrei


Peter Mendham wrote:
> Dear all,
> 
> I have the Xilinx TEMAC (kind of) working on an ML405 using an adapter.c 
> file posted by Rick Moleres on 8th Feb 2007.  However, there are some 
> serious issues with auto-negotiation:
> 1. link negotiation at startup is *very* slow - in the order of ten seconds
> 2. if no network is detected at the boot time the auto-negotiation runs 
> through 1G, 100M, 10M before giving up.  I guess this leaves the PHY in 
> a 10M state.  When I plug a link in the PHY says 10M.  I have 100M and 
> 1G links available (but no 10M link) neither work.
> 3. if a link is present boot time the auto-negotiation correctly chooses 
> the link speed and the link appears to function.  If I unplug the link 
> and replace it with a different speed the link will not function.  If 
> the original link was 100M, the PHY identifies a 1G link as 100M and it 
> does not work.  If the original link was 1G the PHY gives up altogether 
> and no link is detected.
> I guess this all makes sense: it just means that the PHY is not 
> auto-negotiating the link speed.
> 
> Being a newbie at this and really not knowing what I am doing I tried 
> adding a call to set_mac_speed in poll_gmii where a link carrier is 
> detected (after it prints "link carrier restored").  This successfully 
> renegotiated the link speed when a link was inserted, but only in 
> certain cases.  If the link first inserted was 100M, or if there was no 
> link present an inserted link of either 100M or 1G would renegotiate 
> fine.  After having a 100M link, inserting a 1G link would *say* it had 
> renegotiated, the PHY lights up and tells me the link is running at 1G, 
> but nothing works.  Also, whenever this negotiation is going on, 
> everything grinds to a halt.  After having a 1G link, inserting a 100M 
> link would result in the PHY not even picking up the link, as before. 
> 
> I'm clearly barking up the wrong tree here, please can someone tell me 
> The Right Way?
> 
> Many thanks in advance,
> -- Peter
> 
> 


--------------020801050905020704060009
Content-Type: text/x-csrc;
 name="adapter.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adapter.c"

/*
 * adapter.c
 *
 * Xilinx Ethernet Adapter component to interface XTemac component to Linux
 *
 * Author: MontaVista Software, Inc.
 *         source@mvista.com
 *
 * 2002-2007 (c) MontaVista, Software, Inc. This file is licensed under the
 * terms of the GNU General Public License version 2.1. This program is
 * licensed "as is" without any warranty of any kind, whether express
 * or implied.
 */

/*
 * This driver is a bit unusual in that it is composed of two logical
 * parts where one part is the OS independent code and the other part is
 * the OS dependent code.  Xilinx provides their drivers split in this
 * fashion.  This file represents the Linux OS dependent part known as
 * the Linux adapter.  The other files in this directory are the OS
 * independent files as provided by Xilinx with no changes made to them.
 * The names exported by those files begin with XTemac_.  All functions
 * in this file that are called by Linux have names that begin with
 * xtenet_.  The functions in this file that have Handler in their name
 * are registered as callbacks with the underlying Xilinx OS independent
 * layer.  Any other functions are static helper functions.
 *
 * Current Xilinx Trimode EMAC device version this adapter supports does
 * not have MII/GMII interface, and this adapter assumes that the PHY
 * connecting the Trimode EMAC to the ethernet bus runs at 1Gbps, has
 * Full duplex turned on and PHY link is always on.
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/mm.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/delay.h>
#include <linux/dma-mapping.h>
#include <linux/xilinx_devices.h>
#include <asm/io.h>
#include <linux/ethtool.h>

#include <linux/mii.h>
#include <linux/phy.h>

#include "xbasic_types.h"
#include "xtemac.h"
#include "xipif_v1_23_b.h"

/* Must be shorter than length of ethtool_drvinfo.driver field to fit */
#define DRIVER_NAME		"xilinx_temac"
#define DRIVER_VERSION		"2.00b/1.00" /* "level 1 ver."/"adapter ver." */
#define DRIVER_DESCRIPTION	"Xilinx Tri-Mode Eth MAC driver"

MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
MODULE_DESCRIPTION(DRIVER_NAME);
MODULE_LICENSE("GPL");

#define TX_TIMEOUT   (3*HZ)	/* Transmission timeout is 3 seconds. */

/*
 * Our private per device data.  When a net_device is allocated we will
 * ask for enough extra space for this.
 */
struct net_local {
	struct list_head rcv;
	struct list_head xmit;

	struct net_device_stats stats;	/* Statistics for this device */
	struct net_device *ndev;	/* this device */

	u32 index;		/* Which interface is this */
	XInterruptHandler Isr;	/* Pointer to the XTemac ISR routine */

	/* The underlying OS independent code needs space as well.  A
	 * pointer to the following XTemac structure will be passed to
	 * any XTemac_ function that requires it.  However, we treat the
	 * data as an opaque object in this file (meaning that we never
	 * reference any of the fields inside of the structure). */
	XTemac Emac;

	/* Spinlock to control access to the TEMAC hardware */
	spinlock_t xte_spinlock;

	unsigned int max_frame_size;

	/* Buffer Descriptor space for both TX and RX BD ring */
	void *desc_space;	/* virtual address of BD space */
	dma_addr_t desc_space_handle;	/* physical address of BD space */
	int desc_space_size;	/* size of BD space */

	/* buffer for one skb in case no room is available for transmission */
	struct sk_buff *deferred_skb;

	int old_speed;
	/* int old_duplex; - TEMAC v3.00a doesn't support half duplex */

	struct phy_device *phy_dev;
	struct mii_bus mii_bus;
};

/* Helper function to determine if a given XTemac error warrants a reset. */
extern inline int status_requires_reset(XStatus s)
{
	return (s == XST_FIFO_ERROR ||
		s == XST_PFIFO_DEADLOCK ||
		s == XST_DMA_ERROR || s == XST_IPIF_ERROR);
}

/*
 * Helper function to reset the underlying hardware.  This is called
 * when we get into such deep trouble that we don't know how to handle
 * otherwise.
 */
typedef enum DUPLEX { UNKNOWN_DUPLEX, HALF_DUPLEX, FULL_DUPLEX } DUPLEX;

/*
 * This reset function should handle five different reset request types
 * from other functions. The reset request types include
 *      1. FIFO error: FifoWrite()/FifoSend()/FifoRecv()/FifoRead() fails
 *      2. DMA error: SgAlloc()/SgCommit()/SgFree() fails
 *      3. DUPLEX error: MAC DUPLEX is not full duplex or does not match
 *                       PHY setting
 *      4. TX Timeout: Timeout occurs for a TX frame given to this adapter
 *      5. Error Status: Temac Error interrupt occurs and asks for a reset
 */

static void reset(struct net_device *ndev, u32 line_num)
{
	struct net_local *lp = netdev_priv(ndev);
	u32 Options;
	static u32 reset_cnt = 0;

	printk(KERN_INFO "%s: XTemac resets (#%u) from adapter code line %d\n",
	       ndev->name, ++reset_cnt, line_num);

	/* Shouldn't really be necessary, but shouldn't hurt. */
	netif_stop_queue(ndev);

	/* Stop device */
	XTemac_Stop(&lp->Emac);
	phy_stop(lp->phy_dev);

	/*
	 * XTemac_Reset puts the device back to the default state.  We need
	 * to save all the settings we don't already know, reset, restore
	 * the settings, and then restart the temac.
	 */
	Options = XTemac_GetOptions(&lp->Emac);
	/* now we can reset the device */
	XTemac_Reset(&lp->Emac, 0);

	/*
	 * The following four functions will return an error if the
	 * TEMAC is already started.  We just stopped it by calling
	 * XTemac_Reset() so we can safely ignore the return values.
	 */
	XTemac_SetMacAddress(&lp->Emac, ndev->dev_addr);
	XTemac_SetOptions(&lp->Emac, Options);
	XTemac_ClearOptions(&lp->Emac, ~Options);
	Options = XTemac_GetOptions(&lp->Emac);
	printk(KERN_INFO "%s: XTemac Options: 0x%x\n", ndev->name, Options);

	XTemac_IntrFifoEnable(&lp->Emac, XTE_RECV | XTE_SEND);

	if (lp->deferred_skb) {
		dev_kfree_skb_any(lp->deferred_skb);
		lp->deferred_skb = NULL;
		lp->stats.tx_errors++;
	}

	/*
	 * XTemac_Start returns an error when: if configured for
	 * scatter-gather DMA and a descriptor list has not yet been created
	 * for the send or receive channel, or if no receive buffer descriptors
	 * have been initialized. Those are not happening. so ignore the
	 * returned result checking.
	 */
	XTemac_Start(&lp->Emac);

	phy_start(lp->phy_dev);

	/* We're all ready to go.  Start the queue in case it was stopped. */
	netif_wake_queue(ndev);
}

/*
 * This routine is registered with the OS as the function to call when
 * the TEMAC interrupts.  It in turn, calls the Xilinx OS independent
 * interrupt function.  There are different interrupt functions for FIFO
 * and scatter-gather so we just set a pointer (Isr) into our private
 * data so we don't have to figure it out here.  The Xilinx OS
 * independent interrupt function will in turn call any callbacks that
 * we have registered for various conditions.
 */
static irqreturn_t xtenet_interrupt(int irq, void *dev_id)
{
	struct net_device *ndev = dev_id;
	struct net_local *lp = netdev_priv(ndev);

	/* Call it. */
	(*(lp->Isr)) (&lp->Emac);

	return IRQ_HANDLED;
}

static int xtenet_open(struct net_device *ndev)
{
	struct net_local *lp = netdev_priv(ndev);
	u32 Options;
	unsigned long flags;

	/*
	 * Just to be safe, stop TX queue and the device first. If the device is
	 * already stopped, an error will be returned. In this case, we don't
	 * really care,.
	 */
	netif_stop_queue(ndev);

	spin_lock_irqsave(&lp->xte_spinlock, flags);

	phy_stop(lp->phy_dev);
	(void)XTemac_Stop(&lp->Emac);

	/* Set the MAC address each time opened. */
	if (XTemac_SetMacAddress(&lp->Emac, ndev->dev_addr) != XST_SUCCESS) {
		printk(KERN_ERR "%s: XTemac could not set MAC address.\n",
		       ndev->name);
		spin_unlock_irqrestore(&lp->xte_spinlock, flags);
		return -EIO;
	}

	/*
	 * If the device is not configured for polled mode, connect to the
	 * interrupt controller and enable interrupts.  Currently, there
	 * isn't any code to set polled mode, so this check is probably
	 * superfluous.
	 */
	Options = XTemac_GetOptions(&lp->Emac);
	Options &= ~XTE_SGEND_INT_OPTION;
	Options |= XTE_FLOW_CONTROL_OPTION;
	Options &= ~XTE_JUMBO_OPTION;
	(void)XTemac_SetOptions(&lp->Emac, Options);
	(void)XTemac_ClearOptions(&lp->Emac, ~Options);
	Options = XTemac_GetOptions(&lp->Emac);
	printk(KERN_INFO "%s: XTemac Options: 0x%x\n", ndev->name, Options);

	/* Register interrupt handler */
	if ((Options & XTE_POLLED_OPTION) == 0) {
		int retval;
		/* Grab the IRQ */
		retval = request_irq(ndev->irq, &xtenet_interrupt, 0,
				     ndev->name, ndev);
		if (retval) {
			printk(KERN_ERR
			       "%s: XTemac could not allocate interrupt %d.\n",
			       ndev->name, ndev->irq);
			spin_unlock_irqrestore(&lp->xte_spinlock, flags);
			return retval;
		}
	}

	/* Enable interrupts if not in polled mode */
	if ((Options & XTE_POLLED_OPTION) == 0) {
		XTemac_IntrFifoEnable(&lp->Emac, XTE_RECV | XTE_SEND);
	}

	/* Start TEMAC device */
	if (XTemac_Start(&lp->Emac) != XST_SUCCESS) {
		printk(KERN_ERR "%s: XTemac could not start device.\n",
		       ndev->name);
		free_irq(ndev->irq, ndev);
		spin_unlock_irqrestore(&lp->xte_spinlock, flags);
		return -EBUSY;
	}

	phy_start(lp->phy_dev);

	spin_unlock_irqrestore(&lp->xte_spinlock, flags);

	/* We're ready to go. */
	netif_start_queue(ndev);

	return 0;
}

static int xtenet_close(struct net_device *ndev)
{
	struct net_local *lp = netdev_priv(ndev);
	unsigned long flags;

	spin_lock_irqsave(&lp->xte_spinlock, flags);

	/* Stop Send queue */
	netif_stop_queue(ndev);

	/* Now we could stop the device */
	phy_stop(lp->phy_dev);
	XTemac_Stop(&lp->Emac);

	/*
	 * If not in polled mode, free the interrupt.  Currently, there
	 * isn't any code to set polled mode, so this check is probably
	 * superfluous.
	 */
	if ((XTemac_GetOptions(&lp->Emac) & XTE_POLLED_OPTION) == 0)
		free_irq(ndev->irq, ndev);

	spin_unlock_irqrestore(&lp->xte_spinlock, flags);

	return 0;
}

static struct net_device_stats *xtenet_get_stats(struct net_device *ndev)
{
	struct net_local *lp = netdev_priv(ndev);
	return &lp->stats;
}

static int xtenet_change_mtu(struct net_device *ndev, int new_mtu)
{
	int head_size = XTE_HDR_SIZE;
	struct net_local *lp = netdev_priv(ndev);
	int max_frame = new_mtu + head_size + XTE_TRL_SIZE;
	int min_frame = 1 + head_size + XTE_TRL_SIZE;

	if ((max_frame < min_frame) || (max_frame > lp->max_frame_size))
		return -EINVAL;

	ndev->mtu = new_mtu;	/* change mtu in net_device structure */
	return 0;
}

static int xtenet_FifoSend(struct sk_buff *skb, struct net_device *ndev)
{
	struct net_local *lp = netdev_priv(ndev);
	unsigned int len;
	XStatus result;
	unsigned long flags, fifo_free_bytes;

	/* The following lock is used to protect GetFreeBytes, FifoWrite
	 * and FifoSend sequence which could happen from FifoSendHandler
	 * or other processor in SMP case.
	 */
	spin_lock_irqsave(&lp->xte_spinlock, flags);

	len = skb->len;

	fifo_free_bytes = XTemac_FifoGetFreeBytes(&lp->Emac, XTE_SEND);
	if (fifo_free_bytes < len) {
		netif_stop_queue(ndev);	/* stop send queue */
		lp->deferred_skb = skb;	/* buffer the sk_buffer and will send
					   it in interrupt context */
		spin_unlock_irqrestore(&lp->xte_spinlock, flags);
		return 0;
	}

	/* Write frame data to FIFO */
	result = XTemac_FifoWrite(&lp->Emac, (void *)skb->data, len,
				  XTE_END_OF_PACKET);
	if (result != XST_SUCCESS) {
		reset(ndev, __LINE__);
		lp->stats.tx_errors++;
		spin_unlock_irqrestore(&lp->xte_spinlock, flags);
		return -EIO;
	}

	/* Initiate transmit */
	if ((result = XTemac_FifoSend(&lp->Emac, len)) != XST_SUCCESS) {
		reset(ndev, __LINE__);
		lp->stats.tx_errors++;
		spin_unlock_irqrestore(&lp->xte_spinlock, flags);
		return -EIO;
	}
	lp->stats.tx_bytes += len;
	spin_unlock_irqrestore(&lp->xte_spinlock, flags);

	dev_kfree_skb(skb);	/* free skb */
	ndev->trans_start = jiffies;

	return 0;
}

/* Callback function for completed frames sent in FIFO interrupt driven mode */
static void FifoSendHandler(void *CallbackRef)
{
	struct net_device *ndev;
	struct net_local *lp;
	XStatus result;
	struct sk_buff *skb;

	ndev = (struct net_device *)CallbackRef;
	lp = netdev_priv(ndev);

	spin_lock(&lp->xte_spinlock);

	lp->stats.tx_packets++;

	/*Send out the deferred skb and wake up send queue if a deferred skb exists */
	if (lp->deferred_skb) {

		skb = lp->deferred_skb;
		/* If no room for the deferred packet, return */
		if (XTemac_FifoGetFreeBytes(&lp->Emac, XTE_SEND) < skb->len) {
			spin_unlock(&lp->xte_spinlock);
			return;
		}

		/* Write frame data to FIFO */
		result = XTemac_FifoWrite(&lp->Emac, (void *)skb->data,
					  skb->len, XTE_END_OF_PACKET);
		if (result != XST_SUCCESS) {
			reset(ndev, __LINE__);
			lp->stats.tx_errors++;
			spin_unlock(&lp->xte_spinlock);
			return;
		}

		/* Initiate transmit */
		result = XTemac_FifoSend(&lp->Emac, skb->len);
		if (result != XST_SUCCESS) {
			reset(ndev, __LINE__);
			lp->stats.tx_errors++;
			spin_unlock(&lp->xte_spinlock);
			return;
		}

		dev_kfree_skb_irq(skb);
		lp->deferred_skb = NULL;
		lp->stats.tx_bytes += skb->len;
		ndev->trans_start = jiffies;
		netif_wake_queue(ndev);	/* wake up send queue */
	}
	spin_unlock(&lp->xte_spinlock);
}

static void xtenet_tx_timeout(struct net_device *ndev)
{
	struct net_local *lp = netdev_priv(ndev);
	unsigned long flags;

	printk(KERN_ERR
	       "%s: XTemac exceeded transmit timeout of %lu ms.  Resetting emac.\n",
	       ndev->name, TX_TIMEOUT * 1000UL / HZ);

	/*
	 * Make sure that no interrupts come in that could cause reentrancy
	 * problems in reset.
	 */
	spin_lock_irqsave(&lp->xte_spinlock, flags);
	lp->stats.tx_errors++;
	reset(ndev, __LINE__);
	spin_unlock_irqrestore(&lp->xte_spinlock, flags);
}

/* The callback function for frames received when in FIFO mode. */

#define XTE_RX_SINK_BUFFER_SIZE 1024

static void FifoRecvHandler(void *CallbackRef)
{
	struct net_device *ndev;
	struct net_local *lp;
	struct sk_buff *skb;
	u32 len;
	XStatus Result;
	static u32 rx_buffer_sink[XTE_RX_SINK_BUFFER_SIZE / sizeof(u32)];

	ndev = (struct net_device *)CallbackRef;
	lp = netdev_priv(ndev);

	spin_lock(&lp->xte_spinlock);

	Result = XTemac_FifoRecv(&lp->Emac, &len);
	if (Result != XST_SUCCESS) {
		printk(KERN_ERR
		       "%s: XTemac could not read received packet length, error=%d.\n",
		       ndev->name, Result);
		lp->stats.rx_errors++;
		reset(ndev, __LINE__);
		spin_unlock(&lp->xte_spinlock);
		return;
	}

	if (!(skb = dev_alloc_skb(len))) {
		/* Couldn't get memory. */
		lp->stats.rx_dropped++;
		printk(KERN_ERR
		       "%s: XTemac could not allocate receive buffer.\n",
		       ndev->name);

		/* consume data in Xilinx TEMAC RX data fifo so it is sync with RX length fifo */
		for (; len > XTE_RX_SINK_BUFFER_SIZE;
		     len -= XTE_RX_SINK_BUFFER_SIZE) {
			XTemac_FifoRead(&lp->Emac, rx_buffer_sink,
					XTE_RX_SINK_BUFFER_SIZE,
					XTE_PARTIAL_PACKET);
		}
		XTemac_FifoRead(&lp->Emac, rx_buffer_sink, len,
				XTE_END_OF_PACKET);

		spin_unlock(&lp->xte_spinlock);
		return;
	}

	/* Read the packet data */
	Result = XTemac_FifoRead(&lp->Emac, skb->data, len, XTE_END_OF_PACKET);
	if (Result != XST_SUCCESS) {
		lp->stats.rx_errors++;
		dev_kfree_skb_irq(skb);
		printk(KERN_ERR
		       "%s: XTemac could not receive buffer, error=%d.\n",
		       ndev->name, Result);
		reset(ndev, __LINE__);
		spin_unlock(&lp->xte_spinlock);
		return;
	}
	lp->stats.rx_packets++;
	lp->stats.rx_bytes += len;
	spin_unlock(&lp->xte_spinlock);

	skb_put(skb, len);	/* Tell the skb how much data we got. */
	skb->dev = ndev;	/* Fill out required meta-data. */
	skb->protocol = eth_type_trans(skb, ndev);
	skb->ip_summed = CHECKSUM_NONE;
	netif_rx(skb);		/* Send the packet upstream. */
}

/* The callback function for errors. */
static void ErrorHandler(void *CallbackRef, XStatus ErrClass, u32 Word1,
			 u32 Word2)
{
	struct net_device *ndev;
	struct net_local *lp;
	int need_reset;

	ndev = (struct net_device *)CallbackRef;
	lp = netdev_priv(ndev);

	need_reset = status_requires_reset(ErrClass);
	/* The following print code could be used for debugging */
	/*
	   printk(KERN_ERR "%s: XTemac device error %d%s\n",
	   dev->name, ErrClass, need_reset ? ", resetting device." : "");
	 */
	if (need_reset) {
		spin_lock(&lp->xte_spinlock);
		reset(ndev, __LINE__);
		spin_unlock(&lp->xte_spinlock);
	}
}

/*
 * ethtool operations
 */

static int xtenet_get_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
{
	struct net_local *lp = netdev_priv(ndev);

	if (lp->phy_dev)
		return phy_ethtool_gset(lp->phy_dev, cmd);

	return -EINVAL;
}

static int xtenet_set_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
{
	struct net_local *lp = netdev_priv(ndev);

	if (lp->phy_dev)
		return phy_ethtool_sset(lp->phy_dev, cmd);

	return -EINVAL;
}

/*
 * ethtool has a status reporting feature where we can report any sort of
 * status information we'd like. This is the list of strings used for that
 * status reporting. ETH_GSTRING_LEN is defined in ethtool.h
 */
static char xenet_ethtool_gstrings_stats[][ETH_GSTRING_LEN] = {
    "txdmaerr", "txpfifoerr", "txstatuserr", "rxrejerr", "rxdmaerr",
    "rxpfifoerror", "fifoerr", "ipiferr", "intr",
///    "max_frags", "tx_hw_csums", "rx_hw_csums",
};
#define XENET_STATS_LEN sizeof(xenet_ethtool_gstrings_stats) / ETH_GSTRING_LEN

static int xtenet_get_stats_count(struct net_device *ndev)
{
	return XENET_STATS_LEN;
}

static void xtenet_get_ethtool_stats(struct net_device *ndev,
				     struct ethtool_stats *stats, u64 *data)
{
	struct net_local *lp = netdev_priv(ndev);
	XTemac_SoftStats *stat = &lp->Emac.Stats;
	unsigned long flags;

	/* make sure *stat is not updated while being read */
	spin_lock_irqsave(&lp->xte_spinlock, flags);

	data[0] = stat->TxDmaErrors;
	data[1] = stat->TxPktFifoErrors;
	data[2] = stat->TxStatusErrors;
	data[3] = stat->RxRejectErrors;
	data[4] = stat->RxDmaErrors;
	data[5] = stat->RxPktFifoErrors;
	data[6] = stat->FifoErrors;
	data[7] = stat->IpifErrors;
	data[8] = stat->Interrupts;
///	data[9] = lp->max_frags_in_a_packet;
///	data[10] = lp->tx_hw_csums;
///	data[11] = lp->rx_hw_csums;

	spin_unlock_irqrestore(&lp->xte_spinlock, flags);
}

static void xtemac_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
{
	memcpy(data, xenet_ethtool_gstrings_stats,
	       sizeof(xenet_ethtool_gstrings_stats));
}

static void xtenet_get_drvinfo(struct net_device *ndev,
			       struct ethtool_drvinfo *info)
{
	memset(info, 0, sizeof(struct ethtool_drvinfo));
	strncpy(info->driver, DRIVER_NAME, sizeof(info->driver) - 1);
	strncpy(info->version, DRIVER_VERSION, sizeof(info->version) - 1);
}

static const struct ethtool_ops xtenet_ethtool_ops = {
	.get_settings = xtenet_get_settings,
	.set_settings = xtenet_set_settings,
	.get_drvinfo = xtenet_get_drvinfo,
	.get_stats_count = xtenet_get_stats_count,
	.get_ethtool_stats = xtenet_get_ethtool_stats,
	.get_strings = xtemac_get_strings,
	.get_link = ethtool_op_get_link,
};

/*********************
 * The device driver *
 *********************/

static int xtenet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
{
	struct net_local *lp = netdev_priv(ndev);

	if (!netif_running(ndev))
		return -EINVAL;

	if (!lp->phy_dev)
		return -EINVAL;

	return phy_mii_ioctl(lp->phy_dev, if_mii(rq), cmd);
}

static void xtenet_remove_ndev(struct net_device *ndev)
{
	struct net_local *lp = netdev_priv(ndev);

	iounmap((void *)lp->Emac.BaseAddress);

	/* Free up the memory. */
	free_netdev(ndev);
}

static int xtenet_remove(struct device *dev)
{
	struct net_device *ndev = dev_get_drvdata(dev);

	unregister_netdev(ndev);
	xtenet_remove_ndev(ndev);

	return 0;		/* success */
}

static void xtenet_adjust_link(struct net_device *ndev)
{
	struct net_local *lp = netdev_priv(ndev);
	struct phy_device *pdev = lp->phy_dev;
	int netif_carrier;
	int temac_speed;
	unsigned long flags;
	int link_state_changed = 0;

	spin_lock_irqsave(&lp->xte_spinlock, flags);

	temac_speed = pdev->speed;

	if (pdev->link && (lp->old_speed != pdev->speed)) {
		/* speed changed */
		link_state_changed = 1;
		lp->old_speed = pdev->speed;
		if (pdev->speed == SPEED_1000)
			temac_speed = 1000;
		else if (pdev->speed == SPEED_100)
			temac_speed = 100;
		else if (pdev->speed == SPEED_10)
			temac_speed = 10;
		else
			temac_speed = 1000;
		XTemac_SetOperatingSpeed(&lp->Emac, temac_speed);
	}

	netif_carrier = netif_carrier_ok(ndev) != 0;
	if (pdev->link != netif_carrier) {
		link_state_changed = 1;
		if (!pdev->link) {
			lp->old_speed = 0;
		}
	}

	spin_unlock_irqrestore(&lp->xte_spinlock, flags);

	if (link_state_changed) {
		if (pdev->link) {
			printk(KERN_INFO "%s: Link carrier restored (%d).\n",
			       ndev->name, temac_speed);
		} else {
			printk(KERN_INFO "%s: Link carrier lost.\n", ndev->name);
		}
	}
}

static int mdiobus_read(struct mii_bus *bus, int phy_addr, int regnum)
{
	/* WARNING: bus->phy_map[phy_addr].attached_dev == dev does
	 * _NOT_ hold (e.g. when PHY is accessed through other MAC's MII bus) */
	struct net_device *const ndev = bus->priv;
	struct net_local *lp = netdev_priv(ndev);
	XStatus result;
	u16 reg;

	result = XTemac_PhyRead(&lp->Emac, phy_addr, regnum, &reg);
	return (result == XST_SUCCESS) ? (unsigned)reg : -1;
}

static int mdiobus_write(struct mii_bus *bus, int phy_addr, int regnum,
			 u16 value)
{
	struct net_device *const ndev = bus->priv;
	struct net_local *lp = netdev_priv(ndev);
	XStatus result;

	result = XTemac_PhyWrite(&lp->Emac, phy_addr, regnum, value);
	return (result == XST_SUCCESS) ? 0 : -1;
}

static int mdiobus_reset(struct mii_bus *bus)
{
	struct net_device *const ndev = bus->priv;

	printk(KERN_INFO "mdiobus_reset on %s\n", ndev->name);

	return 0;
}

static int mii_probe (struct net_device *ndev)
{
	struct net_local *lp = netdev_priv(ndev);
	struct phy_device *phydev = NULL;
	int phy_addr;

	/* find the first (lowest address) PHY on the current MAC's MII bus */
	for (phy_addr = 0; phy_addr < PHY_MAX_ADDR; phy_addr++)
		if (lp->mii_bus.phy_map[phy_addr]) {
			phydev = lp->mii_bus.phy_map[phy_addr];
			break; /* break out with first one found */
		}

	if (!phydev) {
		printk(KERN_ERR ":%s: no PHY found\n", ndev->name);
		return -1;
	}

	/* now we are supposed to have a proper phydev, to attach to... */
	BUG_ON(phydev->attached_dev);

	phydev = phy_connect(ndev, phydev->dev.bus_id, &xtenet_adjust_link, 0,
			PHY_INTERFACE_MODE_GMII);

	if (IS_ERR(phydev)) {
		printk(KERN_ERR "%s: Could not attach to PHY\n", ndev->name);
		return PTR_ERR(phydev);
	}

	/* mask with MAC supported features */
	phydev->supported &= PHY_GBIT_FEATURES;
	/* ver3.00a TEMAC doesn't support half duplex */
	phydev->supported &= ~(SUPPORTED_10baseT_Half | SUPPORTED_100baseT_Half
			      | SUPPORTED_1000baseT_Half);
	phydev->advertising = phydev->supported;

	lp->phy_dev = phydev;

	printk(KERN_INFO "%s: attached PHY driver [%s] "
	       "(mii_bus:phy_addr=%s, irq=%d)\n",
	       ndev->name, phydev->drv->name, phydev->dev.bus_id, phydev->irq);

	return 0;
}

static int xtenet_probe(struct device *dev)
{
	struct net_device *ndev;
	struct net_local *lp;
	struct platform_device *pdev = to_platform_device(dev);
	struct xtemac_platform_data *pdata;
	struct resource *r_irq, *r_mem;
	u32 baseaddr_v;
	int retval;
	u32 id;
	int i;
	XTemac_Config Config;

	pdata = (struct xtemac_platform_data *)pdev->dev.platform_data;

	if (!pdata) {
		printk(KERN_ERR "xtemac %d: Couldn't find platform data.\n",
		       pdev->id);

		return -ENODEV;
	}
	r_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
	r_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!r_irq || !r_mem) {
		printk(KERN_ERR "xtemac %d: IO resource(s) not found.\n",
		       pdev->id);

		return -ENODEV;
	}

	/* Create an ethernet device instance */
	ndev = alloc_etherdev(sizeof(struct net_local));
	if (!ndev) {
		printk(KERN_ERR "xtemac %d: Could not allocate net device.\n",
		       pdev->id);
		return -ENOMEM;
	}
	dev_set_drvdata(dev, ndev);
	ndev->irq = r_irq->start;

	/* Initialize the private data.
	 * The private data are zeroed out by alloc_etherdev() already.
	 */
	lp = netdev_priv(ndev);
	lp->ndev = ndev;
	spin_lock_init(&lp->xte_spinlock);

	/* Setup the Config structure for the XTemac_CfgInitialize() call. */
	memset(&Config, 0, sizeof(XTemac_Config));
	Config.DeviceId = pdev->id;
	Config.BaseAddress = r_mem->start;
	Config.IpIfDmaConfig = pdata->dma_mode;
	Config.RxPktFifoDepth = pdata->rx_pkt_fifo_depth;
	Config.TxPktFifoDepth = pdata->tx_pkt_fifo_depth;
	Config.MacFifoDepth = pdata->mac_fifo_depth;
	Config.RxDre = pdata->rx_dre;
	Config.TxDre = pdata->tx_dre;
	Config.RxCsum = pdata->rx_csum;
	Config.TxCsum = pdata->tx_csum;

	baseaddr_v = (u32) ioremap(r_mem->start, r_mem->end - r_mem->start + 1);
	if (baseaddr_v == 0) {
		printk(KERN_ERR "%s: Could not ioremap.\n", ndev->name);
		xtenet_remove_ndev(ndev);
		return -EIO;
	}

	if (XTemac_CfgInitialize(&lp->Emac, &Config, baseaddr_v) != XST_SUCCESS) {
		printk(KERN_ERR "%s: Could not initialize device.\n",
		       ndev->name);
		xtenet_remove_ndev(ndev);
		return -ENODEV;
	}

	/* Set the MAC address */
	memcpy(ndev->dev_addr, pdata->mac_addr, 6);
	if (XTemac_SetMacAddress(&lp->Emac, ndev->dev_addr) != XST_SUCCESS) {
		/* should not fail right after an initialize */
		printk(KERN_ERR "%s: XTemac could not set MAC address.\n",
		       ndev->name);
		xtenet_remove_ndev(ndev);
		return -EIO;
	}

	lp->max_frame_size = XTE_MAX_FRAME_SIZE;
	if (ndev->mtu > XTE_MTU)
		ndev->mtu = XTE_MTU;

	printk(KERN_INFO
	       "%s: XTemac using fifo direct interrupt driven mode.\n",
	       ndev->name);
	XTemac_SetHandler(&lp->Emac, XTE_HANDLER_FIFORECV,
			  FifoRecvHandler, ndev);
	XTemac_SetHandler(&lp->Emac, XTE_HANDLER_FIFOSEND,
			  FifoSendHandler, ndev);
	ndev->hard_start_xmit = xtenet_FifoSend;
	lp->Isr = XTemac_IntrFifoHandler;

	XTemac_SetHandler(&lp->Emac, XTE_HANDLER_ERROR, ErrorHandler, ndev);

	lp->mii_bus.priv = ndev;
	lp->mii_bus.read = mdiobus_read;
	lp->mii_bus.write = mdiobus_write;
	lp->mii_bus.reset = mdiobus_reset;
	lp->mii_bus.name = "temac_mii";
	lp->mii_bus.id = pdev->id;	/* assume one bus per TEMAC */
	lp->mii_bus.irq = kmalloc(sizeof(int)*PHY_MAX_ADDR, GFP_KERNEL);
	for(i = 0; i < PHY_MAX_ADDR; ++i)
		lp->mii_bus.irq[i] = PHY_POLL;

	mdiobus_register(&lp->mii_bus);

	if (mii_probe(ndev) != 0) {
		printk(KERN_ERR
		       "%s: PHY not found\n",
		       ndev->name);
		xtenet_remove_ndev(ndev);
		return -ENODEV;
	}

	SET_NETDEV_DEV(ndev, dev);

	ndev->open = xtenet_open;
	ndev->stop = xtenet_close;
	ndev->change_mtu = xtenet_change_mtu;
	ndev->get_stats = xtenet_get_stats;
	ndev->flags &= ~IFF_MULTICAST;
	ndev->do_ioctl = xtenet_ioctl;
	SET_ETHTOOL_OPS(ndev, &xtenet_ethtool_ops);
	ndev->tx_timeout = xtenet_tx_timeout;
	ndev->watchdog_timeo = TX_TIMEOUT;

	retval = register_netdev(ndev);
	if (retval) {
		printk(KERN_ERR
		       "%s: Cannot register net device, aborting.\n",
		       ndev->name);
		xtenet_remove_ndev(ndev);
		return retval;
	}

	printk(KERN_INFO
	       "%s: Xilinx TEMAC #%d at 0x%08X mapped to 0x%08X, irq=%d\n",
	       ndev->name, lp->Emac.Config.DeviceId,
	       lp->Emac.Config.BaseAddress, lp->Emac.BaseAddress, ndev->irq);

	/* print h/w id  */
	id = XIo_In32((lp->Emac).BaseAddress + XIIF_V123B_RESETR_OFFSET);

	printk(KERN_INFO
	       "%s: XTemac id %d.%d%c, block id %d, type %d\n",
	       ndev->name, (id >> 28) & 0xf, (id >> 21) & 0x7f,
	       ((id >> 16) & 0x1f) + 'a', (id >> 16) & 0xff, (id >> 0) & 0xff);

	return 0;
}

static struct device_driver xtenet_driver = {
	.name = DRIVER_NAME,
	.bus = &platform_bus_type,

	.probe = xtenet_probe,
	.remove = xtenet_remove
};

static int __init xtenet_init(void)
{
	/*
	 * No kernel boot options used,
	 * so we just need to register the driver
	 */
	return driver_register(&xtenet_driver);
}

static void __exit xtenet_cleanup(void)
{
	driver_unregister(&xtenet_driver);
}

module_init(xtenet_init);
module_exit(xtenet_cleanup);

MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
MODULE_LICENSE("GPL");

--------------020801050905020704060009--
