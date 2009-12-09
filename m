Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 89FAAB6F0D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 15:28:39 +1100 (EST)
Date: Tue, 08 Dec 2009 20:28:38 -0800 (PST)
Message-Id: <20091208.202838.78052287.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH/REPOST] net/mpc5200: Fix locking on fec_mpc52xx driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091205043015.28041.19288.stgit@angua>
References: <20091205043015.28041.19288.stgit@angua>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: a.llano@ziv.es, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 04 Dec 2009 21:33:13 -0700

> Fix the locking scheme on the fec_mpc52xx driver.  This device can
> receive IRQs from three sources; the FEC itself, the tx DMA, and the
> rx DMA.  Mutual exclusion was handled by taking a spin_lock() in the
> critical regions, but because the handlers are run with IRQs enabled,
> spin_lock() is insufficient and the driver can end up interrupting
> a critical region anyway from another IRQ.
> 
> Asier Llano discovered that this occurs when an error IRQ is raised
> in the middle of handling rx irqs which resulted in an sk_buff memory
> leak.

I'll apply this fix.

But, longer term, it's a thousand times easier and more efficient to
move the processing of these interrupts into softirq context.
