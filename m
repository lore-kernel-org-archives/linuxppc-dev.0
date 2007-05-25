Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0F66FDDEB8
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 10:57:31 +1000 (EST)
In-Reply-To: <1180051272.32247.1087.camel@localhost.localdomain>
References: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
	<1179960728.32247.953.camel@localhost.localdomain>
	<396FEEDC-99AB-4E25-9C80-A901923429B0@freescale.com>
	<1180047084.32247.1070.camel@localhost.localdomain>
	<2994f78d2591e45517247003d613bb98@kernel.crashing.org>
	<1180051272.32247.1087.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <adf40b0a9d45728359da78fa45efab8a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: TSI ethernet PHY question
Date: Fri, 25 May 2007 02:57:24 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> You still have the same problems as Andy described where the
>> necessary workaround is not something local to phylib, but
>> needs cooperation of the ethernet code or the soc code or
>> some other platform code.
>
> If it's in the PHY device node, the ethernet driver doesn't need to be
> involved more than calling some generic helper that finds the right
> node, parses it and generates known flags.

I am not talking about the workaround for _this_ bug, but
about other PHY workarounds that _do_ need cooperation of
other devices.  How should those be described in the
device tree?

>> Since the specific bug we're talking about here is not a
>> problem with the PHY, but a miswiring on the board, I wouldn't
>> put a flag for the workaround in the phy node in the device
>> tree.  It certainly is an option though.
>
> Why ? That's the perfect place to put it in !

Only if you think the device tree is a configuration
mechanism for the OS.  Your workaround is in the PHY,
sure; but the _bug_ is in the board.

However in this case you could put a property in the
PHY node, similar things have been done before.  It's
ugly and doesn't solve any problem (it is just as much
work to parse the board model as to find this magic
property), and you *still* should pass in the flag
from the platform layer, and not have the phylib try
to handle it by itself.

>>> The problem is that of course the PHY driver will need some powerpc
>>> specific code to go fetch that.
>>
>> The ethernet driver can handle it, instead.
>
> I don't understand why you want to involve the ethernet driver in
> something that doesn't have much to do with it.

The ethernet driver is a powerpc-specific driver, that's
one thing.  Also, the workaround should be initiated by
the platform code, so has to go through the ethernet driver
(since it instantiates the phylib driver).

> A pin of the PHY is
> miswired causing something to be enabled that shouldn't be. Ok, there 
> is
> indeed the fact that the problem is partially related to the TSI
> ethernet not supporting when that PHY feature is "enabled" but still...
> it's a PHY setting, totally specific to a given PHY revision, I'm not
> sure there's much point in having it in the eth driver.

For many similar workarounds, the ethernet driver _does_ have
to cooperate in the workaround.  For some other such workarounds,
the soc code has to be involved.  Etc. etc.

You can do a quick "fix" now by doing this magic property
thing, and it sure is a *quick* fix; but later on you'll
have to do some other workarounds the proper way.  And
you'll be stuck with the property forever.  Not such a
big deal, sure; hey, I already _did_ say I'm okay with it,
right?  It's just the "wrong" thing to do ;-)


Segher
