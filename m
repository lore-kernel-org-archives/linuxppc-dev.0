Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 017C8DDED3
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 00:24:16 +1000 (EST)
In-Reply-To: <1180058031.32247.1091.camel@localhost.localdomain>
References: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
	<1179960728.32247.953.camel@localhost.localdomain>
	<396FEEDC-99AB-4E25-9C80-A901923429B0@freescale.com>
	<1180047084.32247.1070.camel@localhost.localdomain>
	<2994f78d2591e45517247003d613bb98@kernel.crashing.org>
	<1180051272.32247.1087.camel@localhost.localdomain>
	<adf40b0a9d45728359da78fa45efab8a@kernel.crashing.org>
	<1180058031.32247.1091.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7507d41be286f5a08a8a00538aab314d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: TSI ethernet PHY question
Date: Fri, 25 May 2007 16:24:10 +0200
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

>> However in this case you could put a property in the
>> PHY node, similar things have been done before.  It's
>> ugly and doesn't solve any problem (it is just as much
>> work to parse the board model as to find this magic
>> property), and you *still* should pass in the flag
>> from the platform layer, and not have the phylib try
>> to handle it by itself.
>
> I disagree, it's not ugly and nicely solves the problem.

It doesn't solve the conceived problem that making this
a board-dependent workaround would be "too hard".

> For example, imagine you have 2 PHYs on a board and only one needs the
> workaround ? Really, the PHY node is the best place for it.

Then the board code will know that.

>> The ethernet driver is a powerpc-specific driver, that's
>> one thing.  Also, the workaround should be initiated by
>> the platform code, so has to go through the ethernet driver
>> (since it instantiates the phylib driver).
>
> Still... it can be done via generic calls in powerpc ethernet drivers
> that set flags in phylib based on things in the device-tree.

Yes, exactly.

>> For many similar workarounds, the ethernet driver _does_ have
>> to cooperate in the workaround.  For some other such workarounds,
>> the soc code has to be involved.  Etc. etc.
>
>> You can do a quick "fix" now by doing this magic property
>> thing, and it sure is a *quick* fix; but later on you'll
>> have to do some other workarounds the proper way.  And
>> you'll be stuck with the property forever.  Not such a
>> big deal, sure; hey, I already _did_ say I'm okay with it,
>> right?  It's just the "wrong" thing to do ;-)
>
> I have no bloody idea what you consider "the proper way"

Make board-specific workarounds triggered by the board code.

> I think it's the right thing to do.

And I don't :-)  But I already said I'm okay with it, it's
only one property and it won't hurt anything else.


Segher
