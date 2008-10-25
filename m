Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id DC7DCDDDE7
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 18:17:26 +1100 (EST)
Date: Sat, 25 Oct 2008 00:17:03 -0700 (PDT)
Message-Id: <20081025.001703.261277154.davem@davemloft.net>
To: cfriesen@nortel.com
Subject: Re: [BUG] oops in net_rx_action on 64-bit powerpc
From: David Miller <davem@davemloft.net>
In-Reply-To: <4902B1D8.8070800@nortel.com>
References: <49025C94.60406@nortel.com>
	<20081024.164128.113131091.davem@davemloft.net>
	<4902B1D8.8070800@nortel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jesse.brandeburg@intel.com,
	romieu@fr.zoreil.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Chris Friesen" <cfriesen@nortel.com>
Date: Fri, 24 Oct 2008 23:42:48 -0600

> David Miller wrote:
> > From: "Chris Friesen" <cfriesen@nortel.com>
> > Date: Fri, 24 Oct 2008 17:39:00 -0600
> > 
> >> So...it would appear that the NAPI code is somehow buggy, and
> >> 6ba33ac should probably be reverted until the problem is found and
> >> fixed.
> > No I think the problem is simple enough that someone should study the
> > ->poll() routine quickly and audit it's return values.
>
> Assuming that amd8111e_rx_poll() is the proper routine, there is
> only one exit point, and it returns "num_rx_pkt".  This variable is
> initialized to zero and increments for each packet sent up the
> stack.

The problematic case in this routine seem to be when the driver
processes exactly "budget" number of packets.

In this case it should not call __netif_rx_complete(), it should instead
use the rx_not_empty label.

Probably the simplest fix is to get rid of the rx_not_empty label and
protect the entire:

	/* Receive descriptor is empty now */
	spin_lock_irqsave(&lp->lock, flags);
	__netif_rx_complete(dev, napi);
	writel(VAL0|RINTEN0, mmio + INTEN0);
	writel(VAL2 | RDMD0, mmio + CMD0);
	spin_unlock_irqrestore(&lp->lock, flags);

code block with a test such as:

	if (rx_pkt_limit > 0)

(yes, greater than zero, not >= 0)

then replace the rx_not_empty goto with a simple break.
