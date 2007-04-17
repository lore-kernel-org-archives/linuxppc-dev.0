Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 56F20DDED5
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 20:40:37 +1000 (EST)
In-Reply-To: <236CD796-DFDF-41B5-A92B-6C15876327E0@freescale.com>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<95a9680c565aa196a4ef78964ef9dee1@kernel.crashing.org>
	<20070416102533.0f87396f.kim.phillips@freescale.com>
	<C793D7D1-CA26-4DCB-B513-56E927BF6BA9@kernel.crashing.org>
	<ba8618e3bd28389b66262e549387ac8d@kernel.crashing.org>
	<98DB6E05-1869-47E9-882E-17B4F574581F@freescale.com>
	<9f68fb3023e258ad0fbe314099a9ffbf@kernel.crashing.org>
	<236CD796-DFDF-41B5-A92B-6C15876327E0@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0e43365ca6941310d2d0cb6e117c493a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Date: Tue, 17 Apr 2007 12:40:17 +0200
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

>>> It's not saying what type the PHY is, though.  It's describing the 
>>> connection.  The PHY is just as flexible wrt connection type as the 
>>> ethernet controller.
>>
>> Huh, I've never seen that.  I'll take your word for it.
>
> Well, mostly this just means that the PHY has pins, and can be told 
> which pins have what meaning in the same way that the ethernet 
> controller can.

Oh I see.  But the PHY is connected in only one way, so
its node should say which way that is.

>>> Ethernet controllers need to know what the connection is so they can 
>>> establish a data connection with the PHYs
>>
>> Can't you probe for PHYs?
>
> I'm beginning to suspect you are confusing the PHY management bus with 
> the PHY data bus.

No I'm not -- not this time, anyway ;-)

>>> 1) The driver tells the PHY what interface to use
>>
>> The device tree is not structured after how Linux device
>> drivers want to use the information; instead, it describes
>> the hardware.
>
> My point was merely that the location of the information is arbitrary, 
> and so here are three reasons for arbitrarily putting it in the 
> ethernet node, rather than the PHY node.

The max speed of the controller, and the types of MII buses
it supports, belongs in the controller node (perhaps as
implicit information).

The max speed of the PHY, and the types of MII buses it
supports, belongs in the PHY node.

I don't see anything arbitrary here.

>>> 3) The UCC needs to be told the connection type, because it does not 
>>> have logic to detect it on its own.
>>
>> Just try all possible kinds, see if you can see a PHY
>> connected?
>
> To extend on the point above, this is nearly impossible.  As I said, 
> the management bus and the data bus are different.  This interface 
> property describes the pin configuration for the data bus.  It also 
> describes the "rate" at which the data is sent or received (some 
> interfaces double-pump, some use echo cancellation).  The result of a 
> misconfiguration is that you receive gibberish and you send gibberish. 
>  The PHY will happily misunderstand the ethernet controller, and 
> visa-versa.
>
> They *both* need to know how they are wired to the other one.

I was thinking you could put the PHY in loopback mode and see
what works.  This might not be too reliable of course.

> Again, no.  You would have to convince me that the interface is more 
> closely tied to the PHY than to the controller.  I believe it's an 
> equal weighting, and have provided three arguments above for why the 
> ethernet node is more appropriate.  Feel free to do so for the PHY.  
> But you need four or more, or I win.  ;)

It seems you misunderstand me.  I say the controller information
belongs in the controller node, and the PHY information belongs
in the PHY node.  If there are multiple modes possible for a
given controller+PHY combination, that information should be put
in the PHY node, since a controller can have multiple PHYs but
not the other way around (for a given PHY->controller assignment,
which is a configuration option for the firmware to decide on,
so any given device tree will describe only one such assignment).


Segher
