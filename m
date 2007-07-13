Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E7308DDDF7
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 04:04:34 +1000 (EST)
Message-ID: <4697BEAC.9090902@freescale.com>
Date: Fri, 13 Jul 2007 13:04:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/4] pm: Handle HID0_SLEEP in the TLF_NAPPING hack.
References: <20070712191205.GA31358@ld0162-tx32.am.freescale.net>	<20070712191301.GB31381@ld0162-tx32.am.freescale.net>
	<18071.7389.640461.229828@cargo.ozlabs.ibm.com>
In-Reply-To: <18071.7389.640461.229828@cargo.ozlabs.ibm.com>
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

Paul Mackerras wrote:
> Scott Wood writes:
> 
> 
>>The e300 core (and probably most other 6xx chips) can only come out of
>>sleep mode with an interrupt.  However, interrupts are logically disabled
>>by the power management layer.
> 
> 
> On powerbooks it's typically a hard reset rather than an interrupt.
> Is it possible to use a hard reset on e300-based systems?

The 8313 can do this (see the deep sleep portion of the 83xx PM patch 
that I posted), but others can't.  Even on the 8313, it's not always 
desireable to use deep sleep, due to limited wakeup sourcers, higher 
latency, etc.

> Also, if you use an interrupt, presumably the cpu has to do something
> to clear the interrupt condition.  What would that be?

The caller's MSR[EE] is cleared in power_save_6xx_restore, so the 
interrupt won't happen again until the PM code re-enables MSR[EE].

-Scott
