Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 3A273DDE2D
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:21:54 +1000 (EST)
Date: Tue, 28 Aug 2007 13:21:52 -0700 (PDT)
Message-Id: <20070828.132152.38706038.davem@davemloft.net>
To: ossthema@de.ibm.com
Subject: Re: RFC: issues concerning the next NAPI interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <200708281319.03903.ossthema@de.ibm.com>
References: <200708271147.01890.ossthema@de.ibm.com>
	<20070827.133721.59473971.davem@davemloft.net>
	<200708281319.03903.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, stefan.roscher@de.ibm.com,
	netdev@vger.kernel.org, jchapman@katalix.com, raisch@de.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akepner@sgi.com, meder@de.ibm.com, shemminger@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jan-Bernd Themann <ossthema@de.ibm.com>
Date: Tue, 28 Aug 2007 13:19:03 +0200

> I will try the following scheme (once we get hrtimers): Each device
> (queue) has a hrtimer.  Schedule the timer in the poll function
> instead of reactivating IRQs when a high load situation has been
> detected and all packets have been emptied from the receive queue.
> The timer function could then just call netif_rx_schedule to
> register the rx_queue for NAPI again.

Interrupt mitigation only works if it helps you avoid interrupts.
This scheme potentially makes more of them happen.

The hrtimer is just another interrupt, a cpu locally triggered one,
but it has much of the same costs nonetheless.

So if you set this timer, it triggers, and no packets arrive, you are
taking more interrupts and doing more work than if you had disabled
NAPI.

In fact, for certain packet rates, your scheme would result in
twice as many interrupts than the current scheme.

This is one of several reasons why hardware is the only truly proper
place for this kind of logic.  Only the hardware can see the packet
arrive, and do the interrupt deferral without any cpu intervention
whatsoever.
