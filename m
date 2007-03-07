Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 4DC58DDF7F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 10:29:32 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 4/7] xenon: add southbridge ethernet support
Date: Thu, 8 Mar 2007 00:27:25 +0100
References: <20070307180144.812594000@elitedvb.net>
	<20070307180144.812594000@elitedvb.net>>
	<20070307180526.058443000@elitedvb.net>>
In-Reply-To: <20070307180526.058443000@elitedvb.net>
MIME-Version: 1.0
Message-Id: <200703080027.25914.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 March 2007 19:01:48 Felix Domke wrote:
> This adds support for the Ethernet controller used in the Xenon
> southbridge.
>
> It is based on the skeleton code, and works surprisingly good. It has some
> rough edges, especially regarding SMP locks, and probably needs some code
> cleanup.

Right, though it appears that some of the code that needs to be cleaned
up even comes from the skeleton driver...

It's also the wrong mailing list to post this to, it should go to netdev.

Furthermore, this driver should have MODULE_LICENSE, MODULE_AUTHOR
and MODULE_DESCRIPTION field, like any loadable module.

> +0100 @@ -0,0 +1,725 @@
> +/*
> + * based on skeleton code.
> + */

Your other files have a long copyright notice, why the inconsistency?

> +#define assert(expr) \
> +        if(!(expr)) {					\
> +        printk( "Assertion failed! %s,%s,%s,line=%d\n",	\
> +        #expr,__FILE__,__FUNCTION__,__LINE__);		\
> +        }

use BUG_ON() instead of assert()

> +/* Symbolic offsets to registers. */
> +enum XENONNET_registers {
> +	TxConfig = 0x00,
> +	TxDescriptorBase = 0x04,
> +	TxDescriptorStatus = 0x0C,
> +	RxConfig = 0x10,
> +	RxDescriptorBase = 0x14,
> +	InterruptStatus = 0x20,
> +	InterruptMask = 0x24,
> +	Config0 = 0x28,
> +	Power = 0x30,
> +	PhyConfig = 0x40,
> +	PhyControl = 0x44,
> +	Config1 = 0x50,
> +	RetryCount = 0x54,
> +	MulticastFilterControl = 0x60,
> +	Address0 = 0x62,
> +	MulticastHash = 0x68,
> +	MaxPacketSize = 0x78,
> +	Address1 = 0x7A
> +};

Don't use mixed case identifiers.

> +static int xenon_net_open (struct net_device *dev);
> +static void xenon_net_tx_timeout (struct net_device *dev);
> +static void xenon_net_init_ring (struct net_device *dev);
> +static int xenon_net_start_xmit (struct sk_buff *skb, struct net_device
> *dev); +static irqreturn_t xenon_net_interrupt(int irq, void *dev_id);
> +static int xenon_net_close (struct net_device *dev);
> +static void xenon_net_hw_start (struct net_device *dev);
> +static int xenon_net_poll(struct net_device *dev, int *budget);

avoid forward declarations for static functions

> +#define XENONNET_W8(reg, val8)	writeb ((val8), ioaddr + (reg))
> +#define XENONNET_W16(reg, val16)	writew ((val16), ioaddr + (reg))
> +#define XENONNET_W32(reg, val32)	do { writel ((val32), ioaddr + (reg));  }
> while (0) +#define XENONNET_R8(reg)		readb (ioaddr + (reg))
> +#define XENONNET_R16(reg)		readw (ioaddr + (reg))
> +#define XENONNET_R32(reg)		((u32) readl (ioaddr + (reg)))

get rid of these, just use the {read,write}{b,w,l} directly

> +		printk ("EXIT, returning -ENOMEM\n");

use proper printk levels or kill this output. also watch
your whitespace.

> +	SET_MODULE_OWNER(dev);

SET_MODULE_OWNER is deprecated, just remove this.

> +	memcpy(dev->dev_addr, "\0\0\1\2\3\4", 6);

use random_ether_address

> +	while (1)
> +	{
> +		int index = atomic_read(&tp->rx_next);
> +		volatile u32 *descr = tp->rx_descriptor_base + index * 0x10;

'volatile' is most likely wrong here, I guess you need to convert this
to use the right barriers.

> +static irqreturn_t xenon_net_interrupt(int irq, void *dev_id)
> +{
> +	struct net_device *dev = dev_id;
> +	struct xenon_net_private *tp = dev->priv;
> +	void *ioaddr = tp->mmio_addr;
> +	u32 status;
> +
> +	spin_lock (&tp->lock);
> +
> +	status = XENONNET_R32(InterruptStatus);
> +
> +	if (status & 0x40)
> +	{
> +		if (netif_rx_schedule_prep(dev)) {
> +			status &= ~0x40;
> +			__netif_rx_schedule (dev);
> +		}
> +	}
> +
> +	if (status & 4)
> +	{
> +		xenon_net_tx_interrupt(dev, tp, ioaddr);
> +		status &= ~0x4;
> +	}
> +
> +//	if (status)
> +//		printk("other interrupt: %08x\n", status);
> +
> +	spin_unlock (&tp->lock);
> +
> +	return IRQ_HANDLED;
> +}

Usually, you'd want to use a single poll function for both receive
and transmit, and call __netif_rx_schedule in both cases.

> +	spin_lock_irqsave (&tp->lock, flags);
> +	spin_unlock_irqrestore (&tp->lock, flags);

huh?

> +	synchronize_irq (dev->irq);
> +	free_irq (dev->irq, dev);

free_irq does syncronize_irq itself, iirc

	Arnd <><
