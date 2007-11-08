Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77549DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Nov 2007 11:28:25 +1100 (EST)
Message-ID: <473258B8.4060905@genesi-usa.com>
Date: Thu, 08 Nov 2007 00:30:48 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>	
	<4732396D.4040904@genesi-usa.com>
	<9e4733910711071421i347a6a0bu99cbf062cc152aca@mail.gmail.com>
In-Reply-To: <9e4733910711071421i347a6a0bu99cbf062cc152aca@mail.gmail.com>
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

Jon Smirl wrote:
> I'm not in favor of all these fsl prefixes. These chip families do get
> sold. What would we have done with intel,pxa320 all over the place
> when they sold it to marvell? mass changes to marvell,pxa320?

That's the idea, and there'd be a compatible entry for intel,pxa320.

Actually the spec says you should use the stock ticker (IBM, FSL, INTC,
JAVA, MRVL) if they have one and if not, the company name in lower case.

Freescale are a funny one because they used to have a stock ticker as
MOT and then FSL but now they're privately owned, so it's gonna have to
be lower case :]

It's just to seperate out the fact that sometimes you get chips with
very similar or identical names, or to mark out vendor-specific
functionality. fsl,has-wdt differs from has-wdt ideally because
Freescale watchdog timers aren't the same as other watchdog timers -
the term is pretty pliable, Freescale's GPT on the MPC52xx isn't
always a watchdog (it can be a normal, non-watchdog timer too..)

> The mpc/pxa parts numbers don't get changes when chip families get sold.

There is a case that between selling chips, some of them get updated
or bugfixed, and you can tell which one you have by the name.

There has to be some standardisation on the first implementation of
the device tree for the chip, otherwise the chopping and changing
gets rather tedious.

I'm sure you can see why we don't release firmware updates every time
some Linux guy changes some lousy, hacky tree definition for yet another
6 times a year, until it finally stabilises and the product is usually
discontinued anyway :D

However in the current situation it just means you need to flash new
FDT blobs to your U-Boots which are more clean, and keep your kernel
in sync, because Linux only handles what it currently thinks is the
standard.

The real loser is the real Open Firmware implementation, but nobody
seems to think about that, the device trees on OF devices get more
cluttered..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
