Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 98196DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 04:53:59 +1000 (EST)
In-Reply-To: <1179960728.32247.953.camel@localhost.localdomain>
References: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
	<1179960728.32247.953.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <396FEEDC-99AB-4E25-9C80-A901923429B0@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: TSI ethernet PHY question
Date: Thu, 24 May 2007 13:53:56 -0500
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


On May 23, 2007, at 17:52, Benjamin Herrenschmidt wrote:

>
>> On power up, because this pin is pulled high by the LED, the
>> TXC_RXC_DELAY mode is enabled, causing a 1.9ns delay between the  
>> clock
>> and data on the GMII interface. Tsi109 could not operate properly  
>> with
>> this delay. The TXC_RXC_DELAY mode has to be disabled by software.
>>
>> If the Quality/TXC_RXC_DELAY pin is left not connected PHY will  
>> work in
>> normal mode without delay and therefore the workaround is not  
>> required.
>
> Ok, so this is a workaround that is specific to the Holly board...
> interesting. I have to figure out what is the best way of having it  
> in a
> "generic" PHY driver for the BCM5461A chip.

Yeah, this is a whole category of thing that the PHY Lib doesn't  
handle very well.  My problem is that I can envision several  
categories of board-specific workarounds:

1) board-specific initialization
2) board-specific fixups after a reset
3) board-specific fixups when changing/reading the PHY link state
4) board-specific interrupt fixups
5) Others I haven't thought of

I'm loathe to turn the PHY code into the PCI code by having almost  
every operation call out to board-specific hooks, so it would be good  
if we could get it down to one or two.

For instance, I think #1 might usually be workable by passing in PHY- 
specific flags, and letting the PHY driver deal with it in  
config_init.  This might even be workable for the BCM5461A chip as  
mentioned above.  You could define a BCM5461A_TXC_RXC_DELAY_DISABLE  
flag, and have the config_init code check for that flag and perform  
the necessary disable.

I had hoped most board-specific situations could be handled that way,  
but there's also the case where resetting the PHY requires board code  
to respond (by setting a board register, or somesuch).

It's really quite a mess.  Any suggestions are quite welcome.

Andy
