Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD634B6F74
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 20:02:21 +1000 (EST)
Date: Tue, 12 Jul 2011 03:01:04 -0700 (PDT)
Message-Id: <20110712.030104.585873452291819607.davem@davemloft.net>
To: patrickdepinguin+linuxppc@gmail.com
Subject: Re: softirqs are invoked while bottom halves are masked
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAAXf6LXHeiCT+n=Wpdf=QfUXUHUSd7fmx9y3kB7te8N3ON1fTg@mail.gmail.com>
References: <CAAXf6LXHeiCT+n=Wpdf=QfUXUHUSd7fmx9y3kB7te8N3ON1fTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, ronny.meeus@gmail.com, eric.dumazet@gmail.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
Date: Tue, 12 Jul 2011 11:23:28 +0200

> Note that the reason we are seeing this problem, may be because the
> kernel we are using contains some patches from Freescale.
> Specifically, in dev_queue_xmit(), support is added for hardware queue
> handling, just before entering the rcu_read_lock_bh():
> 
>         if (dev->features & NETIF_F_HW_QDISC) {
>                 txq = dev_pick_tx(dev, skb);
>                 return dev_hard_start_xmit(skb, dev, txq);
>         }
> 
>         /* Disable soft irqs for various locks below. Also
>          * stops preemption for RCU.
>          */
>         rcu_read_lock_bh();
> 
> We just tried moving the escaping to dev_hard_start_xmit() after
> taking the lock, but this gives a large number of other problems, e.g.

This is definitely why you are seeing this behavior.

You cannot invoke dev_hard_start_xmit() without softirqs
being disabled.  It breaks everything.

This is what happens when you integrate networking patches
which were not reviewed and vetted on netdev.
