Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) by ozlabs.org (Postfix) with ESMTP id 80DFF679E9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 10:32:10 +1000 (EST)
Date: Mon, 21 Aug 2006 17:32:25 -0700 (PDT)
Message-Id: <20060821.173225.68047257.davem@davemloft.net>
To: rdreier@cisco.com
Subject: Re: [RFC] HOWTO use NAPI to reduce TX interrupts
From: David Miller <davem@davemloft.net>
In-Reply-To: <adaac5x3966.fsf@cisco.com>
References: <20060821235244.GJ5427@austin.ibm.com>
	<20060821.165616.107936004.davem@davemloft.net>
	<adaac5x3966.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: akpm@osdl.org, arnd@arndb.de, netdev@vger.kernel.org, jklewis@us.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens.Osterkamp@de.ibm.com, jgarzik@pobox.com, shemminger@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 21 Aug 2006 17:29:05 -0700

> This is a digression from spidernet, but what if a device is able to
> generate separate MSIs for TX and RX?  Some people from IBM have
> suggested that it is beneficial for throughput to handle TX work and
> RX work for IP-over-InfiniBand in parallel on separate CPUs, and
> handling everything through the ->poll() method would defeat this.

The TX work is so incredibly cheap, relatively speaking, compared
to the full input packet processing path that the RX side runs
that I see no real benefit.

In fact, you might even get better locality due to the way the
locking can be performed if TX reclaim runs inside of ->poll()
