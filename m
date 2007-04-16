Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4CB83DDE4A
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 09:25:58 +1000 (EST)
In-Reply-To: <98DB6E05-1869-47E9-882E-17B4F574581F@freescale.com>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<95a9680c565aa196a4ef78964ef9dee1@kernel.crashing.org>
	<20070416102533.0f87396f.kim.phillips@freescale.com>
	<C793D7D1-CA26-4DCB-B513-56E927BF6BA9@kernel.crashing.org>
	<ba8618e3bd28389b66262e549387ac8d@kernel.crashing.org>
	<98DB6E05-1869-47E9-882E-17B4F574581F@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9f68fb3023e258ad0fbe314099a9ffbf@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Date: Tue, 17 Apr 2007 01:25:45 +0200
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Yep.  The whole reason why any property is wanted here is
>> to say what type the PHY is, as the enet controller can
>> be attached to several kinds.  And what type the PHY is
>> belongs in the PHY node, obviously.  In its "compatible"
>> property to be exact.
>
> It's not saying what type the PHY is, though.  It's describing the 
> connection.  The PHY is just as flexible wrt connection type as the 
> ethernet controller.

Huh, I've never seen that.  I'll take your word for it.

> This is actually a property of the board.  In some cases its a fixed 
> property of the board.  In some cases it's changeable through dip 
> switches, or even through software.

In such a case you cannot describe this with a fixed
flat device tree *at all*.

> Ethernet controllers need to know what the connection is so they can 
> establish a data connection with the PHYs

Can't you probe for PHYs?

> The reason for choosing the ethernet controller in this case has to do 
> with the flow of information.
>
> 1) The driver tells the PHY what interface to use

The device tree is not structured after how Linux device
drivers want to use the information; instead, it describes
the hardware.

> 2) The ethernet controller is the endpoint of this connection which is 
> accessible by everyone else.  IE data is not sent through PHYs by any 
> means but through the ethernet controller, and data is not received 
> from PHYs by any means but through the ethernet controller.

So?

> 3) The UCC needs to be told the connection type, because it does not 
> have logic to detect it on its own.

Just try all possible kinds, see if you can see a PHY
connected?

> The truth is, this is a somewhat intractable problem because of the 
> myriad possibilities for how board designers can hook up ethernet 
> controllers to PHYs.  One can envision scenarios where controllers can 
> hook up to multiple PHYs, each of one fixed type.

Yeah, seen that.  Quite a common scenario.

> One can envision scenarios where multiple controllers are hooked up to 
> one PHY, and each of the controllers can use different connections.

How would that work at all, except when only one controller
is active and the rest are shut down?

> If we put the information in the PHY node, we allow for the first 
> scenario, but not the second.  If we put it in the ethernet node, we 
> reverse that situation.  In either case, we'd currently have to modify 
> our dts to specify which PHY we want to use.

Which brings me back to, can't you just probe for it?


Segher
