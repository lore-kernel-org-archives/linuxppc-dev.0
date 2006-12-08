Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDC5367B6C
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 09:47:26 +1100 (EST)
Subject: Re: [PATCH 3/16] Spidernet RX Locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061207175046.GB4614@austin.ibm.com>
References: <20061206223223.GH17931@austin.ibm.com>
	<20061206233134.GC4649@austin.ibm.com> <4577E850.6040500@pobox.com>
	<20061207175046.GB4614@austin.ibm.com>
Content-Type: text/plain
Date: Sat, 09 Dec 2006 09:47:05 +1100
Message-Id: <1165618025.1103.85.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A spinlock is expensive in the fast path, which is why Jeff says it's
invasive.

> spider_net_decode_one_descr() is called from
> spider_net_poll() (which is the netdev->poll callback)
> and also from spider_net_handle_rxram_full(). 
> 
> The rxramfull routine is called from a tasklet that
> is fired off after a "RX ram full" interrupt is receved.
> This interrupt is generated when the hardware runs out
> of space to store incoming packets. We are seeing this
> interrupt fire when the CPU is heavily loaded, and a
> lot of traffic is being fired at the device.

How often does that interrupt happen in that case ?

A better approach is to keep the fast path (ie. poll()) lockless, and in
handle_rxram_full(), the slow path, protect against poll using
netif_disable_poll(). Though that means using a work queue, not a
tasklet, since it needs to schedule.

> > and what other 
> > non-sledgehammer approaches were discarded before arriving at this one?
> 
> Well, I'm not that good at kernel programming, so I guess
> I did not perceive this as a "sledgehammer."  And alternative
> approach is to simply ignore the rxramfull interrupt entirely,
> and depend on poll() do all the work.   I'll try this shortly.

or you can schedule rx work from the rxramfull interrupt after setting a
"something bad happened" flag. Then, poll can check this flag and do the
right thing.

Ben.
