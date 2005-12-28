Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id C947268958
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Dec 2005 09:56:19 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 28 Dec 2005 15:49:37 -0700
To: linuxppc-dev@ozlabs.org
Message-ID: <20051228224937.GA6320@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: olh@suse.de
Subject: Re: mv643xx_eth,
	sleeping function called from invalid context at mm/slab.c:2472
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(For unknown reasons, I didn't receive this message directly from the
mailing list, and the archive doesn't seem to have message-ids, so
I can't supply a References: header.)

Olaf Hering reported:

> I get this with 2.6.15-rc6 on a pegasos2 board:
> 
> MV-643xx 10/100/1000 Ethernet Driver
> eth1: port 1 with MAC address 00:2b:2f:de:ad:01
> eth1: Scatter Gather Enabled
> eth1: TX TCP/IP Checksumming Supported
> eth1: RX TCP/UDP Checksum Offload ON 
> eth1: RX NAPI Enabled 
> eth1: Using SRAM
> Debug: sleeping function called from invalid context at mm/slab.c:2472
> in_atomic():0, irqs_disabled():1
> Call Trace:
> [CB32DCF0] [C000AFCC] show_stack+0x54/0x180 (unreliable)
> [CB32DD10] [C0027CD4] __might_sleep+0xbc/0xd0
> [CB32DD20] [C005E50C] kmem_cache_alloc+0x34/0x108
> [CB32DD40] [C01C5F40] rand_initialize_irq+0x40/0x6c
> [CB32DD60] [C0054104] setup_irq+0x5c/0x154
> [CB32DD90] [C0054284] request_irq+0x88/0xb8
> [CB32DDC0] [D22820A0] mv643xx_eth_open+0x44/0xb4 [mv643xx_eth]
> [CB32DDE0] [C0257394] dev_open+0x70/0xd8
> [CB32DE00] [C02554F0] dev_change_flags+0x6c/0x13c
> [CB32DE20] [C02A2818] devinet_ioctl+0x280/0x708
> [CB32DE80] [C02A319C] inet_ioctl+0xb4/0x100
> [CB32DE90] [C02C0078] packet_ioctl+0x15c/0x188
> [CB32DEB0] [C024B998] sock_ioctl+0x30c/0x334
> [CB32DED0] [C00922F4] do_ioctl+0x3c/0x88
> [CB32DEE0] [C0092728] vfs_ioctl+0x3e8/0x424
> [CB32DF10] [C00927CC] sys_ioctl+0x68/0x98
> [CB32DF40] [C000FAEC] ret_from_syscall+0x0/0x4c
> --- Exception: c01 at 0x7f6be80
>     LR = 0x7fec9d0
>     eth1: no IPv6 routers present

I just posted the following patch to the netdev list which should address
this problem.

-Dale

Date: Wed, 28 Dec 2005 15:40:01 -0700
To: netdev@vger.kernel.org
Subject: [PATCH 4/4] mv643xx: Don't call request_irq with a held lock
Message-ID: <20051228224001.GD5742@xyzzy.farnsworth.org>
References: <20051228223449.GA5742@xyzzy.farnsworth.org>

From: Dale Farnsworth <dale@farnsworth.org>

We can't call request_irq() while holding a spin lock.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.6-mv643xx_enet/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.6-mv643xx_enet.orig/drivers/net/mv643xx_eth.c
+++ linux-2.6-mv643xx_enet/drivers/net/mv643xx_eth.c
@@ -655,34 +655,24 @@ static int mv643xx_eth_open(struct net_d
 	unsigned int port_num = mp->port_num;
 	int err;
 
-	spin_lock_irq(&mp->lock);
-
 	err = request_irq(dev->irq, mv643xx_eth_int_handler,
 			SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
-
 	if (err) {
 		printk(KERN_ERR "Can not assign IRQ number to MV643XX_eth%d\n",
 								port_num);
-		err = -EAGAIN;
-		goto out;
+		return -EAGAIN;
 	}
 
+	spin_lock_irq(&mp->lock);
+
 	if (mv643xx_eth_real_open(dev)) {
 		printk("%s: Error opening interface\n", dev->name);
+		free_irq(dev->irq, dev);
 		err = -EBUSY;
-		goto out_free;
 	}
 
 	spin_unlock_irq(&mp->lock);
 
-	return 0;
-
-out_free:
-	free_irq(dev->irq, dev);
-
-out:
-	spin_unlock_irq(&mp->lock);
-
 	return err;
 }
 
