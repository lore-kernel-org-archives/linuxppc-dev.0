Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) by ozlabs.org (Postfix) with ESMTP id 5D83167B5E
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 07:32:18 +1000 (EST)
Date: Wed, 16 Aug 2006 14:32:03 -0700 (PDT)
Message-Id: <20060816.143203.11626235.davem@davemloft.net>
To: arnd@arndb.de
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608162324.47235.arnd@arndb.de>
References: <44E38157.4070805@garzik.org>
	<20060816.134640.115912460.davem@davemloft.net>
	<200608162324.47235.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org, jklewis@us.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens.Osterkamp@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Aug 2006 23:24:46 +0200

> We first had an interrupt per descriptor, then got rid of all TX
> interrupts and replaced them by timers to reduce the interrupt load,
> but reducing throughput in the case where user space sleeps on a full
> socket buffer.

The best schemes seem to be to interrupt mitigate using a combination
of time and number of TX entries pending to be purged.  This is what
most gigabit chips seem to offer.

On Tigon3, for example, we tell the chip to interrupt if either 53
frames or 150usecs have passed since the first TX packet has become
available for reclaim.

That bounds the latency as well as force the interrupt if a lot of TX
work becomes available.

Can spidernet be told these kinds of parameters?  "N packets or
X usecs"?

This is all controllable via ethtool btw (via ETHTOOL_{S,G}COALESCE),
so you can experiment if you want.
