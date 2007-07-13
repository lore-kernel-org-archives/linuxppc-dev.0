Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4B24ADDECA
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 06:29:06 +1000 (EST)
Message-ID: <4697E08B.6080700@freescale.com>
Date: Fri, 13 Jul 2007 15:28:59 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexandre Bounine <Alexandre.Bounine@tundra.com>
Subject: Re: [PATCH] Fix Tsi108 ethernet driver performance
References: <1B5F013528140F45B5C671039279CA5701F8314C@NANUK.pc.tundra.com>
In-Reply-To: <1B5F013528140F45B5C671039279CA5701F8314C@NANUK.pc.tundra.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexandre Bounine wrote:
> -/* If the RX ring has run out of memory, try periodically
> - * to allocate some more, as otherwise poll would never
> - * get called (apart from the initial end-of-queue condition).
> - *
> - * This is called once per second (by default) from the thread.
> +/* tsi108_check_rxring() is used to periodically check if the RX ring
> has
> + * pending frames that have not been reported by RX interrupt (due to
> interrupt
> + * moderation). It is called with CHECK_RX_INTERVAL timer interval.

Wouldn't this cause latencies of up to a second in responding to 
received packets?  I'd think that would be considered excessive.

And shouldn't NAPI be reducing the RX interrupt load anyway?

-Scott
