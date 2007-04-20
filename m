Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 23F36DDEC8
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Apr 2007 05:13:29 +1000 (EST)
In-Reply-To: <d16d2a0d1742a32e45597baabfc3735a@kernel.crashing.org>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<95a9680c565aa196a4ef78964ef9dee1@kernel.crashing.org>
	<20070416102533.0f87396f.kim.phillips@freescale.com>
	<C793D7D1-CA26-4DCB-B513-56E927BF6BA9@kernel.crashing.org>
	<ba8618e3bd28389b66262e549387ac8d@kernel.crashing.org>
	<20070416115729.292c10b1.kim.phillips@freescale.com>
	<53810df560c7af272cd1c71c9d5fa1ab@kernel.crashing.org>
	<20070416193110.77b63e4b.kim.phillips@freescale.com>
	<788e650fbb3f95eaf1bfb6955f9cef17@kernel.crashing.org>
	<20070417152712.51c7348f.kim.phillips@freescale.com>
	<f170b2c44ae8a76dd4d35ceb94a624b0@kernel.crashing.org>
	<20070417201350.12727df7.kim.phillips@freescale.com>
	<524e7cf7aec7be8289ab2f99df8a0776@kernel.crashing.org>
	<20070418164849.6f0fd817.kim.phillips@freescale.com>
	<d16d2a0d1742a32e45597baabfc3735a@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6358CE18-B118-4BC1-B46A-D485449273D5@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Date: Fri, 20 Apr 2007 14:13:26 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 20, 2007, at 03:34, Segher Boessenkool wrote:

>>>> ..but I'm not interested in specifying what interfaces the PHY
>>>> supports.
>>>
>>> But you *have* to.  The device tree describes the hardware,
>>> it is not a configuration file for Linux to use as it sees fit.
>>
>> not for the purposes of this patch; ucc_geth passes interface_type,
>
> It doesn't matter what the Linux code does.  The device tree
> describes the hardware, it is not a configuration file for
> Linux to use as it sees fit.

Agreed.

>
>> a
>> property of the board describing the connection between the MAC  
>> and PHY
>> (not a list of what connection types the PHY is capable of) to the
>> phylib, and the phylib is left to probe, identify, and configure the
>> PHY
>> appropriately.
>
> Sure there's an argument for describing what type of
> interface the PHY is connected on, if it supports more
> than one -- but that should be a property in the PHY
> node, not the controller node, since you can have multiple
> PHYs connected to the same controller, possibly on
> different interfaces each.


I just want to reiterate that I disagree strongly with this  
statement.  If you have multiple PHYs hooked up to one ethernet  
controller, you're going to need to change the device tree to use a  
different PHY, anyway.  That, or have Linux ignore the phandle that  
points to the connected PHY.

Also, you'd need to do something to the hardware, since the different  
interfaces are not, typically, on different pins.  Just in different  
combinations.

And if you put it in the PHY node, you haven't really helped out the  
people who can change the interface type by flipping a dip switch.  I  
can think of two or three boards off the top of my head that do that  
(though I know of very few people who actually use this functionality).

My point, again, is that the interface type is not strongly tied to  
the PHY.  It is strongly tied to the board configuration.  We *could*  
put the interface type in the PHY node, but I want to disabuse you of  
the notion that it would be any better there.

Andy
