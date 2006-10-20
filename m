Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 7FF9867C33
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 03:36:14 +1000 (EST)
In-Reply-To: <94A9DAA6-37CD-48F0-A793-70274E0B38FA@kernel.crashing.org>
References: <Pine.LNX.4.61.0610191947090.632@ld0175-tx32.am.freescale.net>
	<94A9DAA6-37CD-48F0-A793-70274E0B38FA@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FF715000-8935-40EB-8A04-64A699441F6C@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Slight refactor of interrupt mapping for FSL parts (take
	3)
Date: Fri, 20 Oct 2006 12:36:03 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 20, 2006, at 00:44, Kumar Gala wrote:

>
> On Oct 19, 2006, at 7:52 PM, Andy Fleming wrote:
>
>> * Cleaned up interrupt mapping a little by adding a helper
>>   function which parses the irq out of the device-tree, and puts
>>   it into a resource.
>
> Split this patch in two.  One for the mapping cleanup and one for  
> the PHY changes.


I don't want to be a whiner, here, but isn't that more effort than  
the benefit it gives?  I mean, I'll do it if you really want, but I'm  
trying to get to work on the *next* patch.


>
>> * Changed the arch/ppc platform files to specify PHY_POLL, instead  
>> of -1
>
> This seems like a confusing way to indicate lack of interrupt.   
> Can't remember but if in my system all the PHYs are just polled do  
> I even have to setup the data structure?


It is precisely the way to indicate lack of interrupt.  Here are the  
options:

1) PHY is not used.
2) PHY is polled by PHY lib
3) PHY lib handles interrupts, does not poll
4) PHY Lib does not handle reflecting device state changes

#4 Is indicated by setting phydev->irq to PHY_IGNORE_INTERRUPT
#3 Is indicated by phydev->irq containing an actual irq number
#2 is indicated by setting phydev->irq to PHY_POLL
#1 means it doesn't matter what the irq is set to

So yes, you have to set up the data structure.  If you set it to -1,  
you have only been *coincidentally* getting PHY_POLL (because  
PHY_POLL is -1).  That's a bad idea, because PHY_POLL might change in  
the future.

Andy
