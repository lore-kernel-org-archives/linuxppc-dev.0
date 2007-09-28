Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3BB97DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Sep 2007 01:40:23 +1000 (EST)
Message-ID: <46FD205A.50900@freescale.com>
Date: Fri, 28 Sep 2007 10:40:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
References: <20070810095153.GC13994@moe.telargo.com>
	<9e4733910709271112y100e55e8q100336ce95acaf3f@mail.gmail.com>
	<46FBF9B7.9010007@freescale.com>
	<200709281112.18480.jbe@pengutronix.de>
In-Reply-To: <200709281112.18480.jbe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Juergen Beisert wrote:
> I tried with in_atomic(). The BUG report is gone, but the problem still 
> exists. 
> 
> While network stress testing: 
> 
> [...]
> NETDEV WATCHDOG: eth0: transmit timed out
> net eth0: transmit timed out
> net eth0: queues didn't drain
> net eth0:   tx: index: 35, outdex: 36
> net eth0:   rx: index: 24, outdex: 25
> PHY: f0003000:00 - Link is Down
> PHY: f0003000:00 - Link is Up - 100/Full
> 
> The link is up again, but any connection is dead (no answers to ping etc.). 
> But the serial console is still working. I'm not sure if the RT-Preempt patch 
> *causes* this behavior or only *discover* it. Any idea?

I'd try looking at the driver's locking to make sure that it's correct.

-Scott
