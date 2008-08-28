Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2EF69DE2C3
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 08:41:31 +1000 (EST)
Message-Id: <4DA58F0E-BBE8-4547-80AF-A890BACC79E7@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48B6CD32.2040308@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support 36-bit
	physical
Date: Thu, 28 Aug 2008 14:37:47 -0500
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
	<48B5E6B7.3000903@freescale.com>
	<C16F93B0-766C-43E8-B4B5-40BC0FEE298F@freescale.com>
	<48B6CD32.2040308@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 28, 2008, at 11:07 AM, Scott Wood wrote:

> Becky Bruce wrote:
>> I'm pretty sure I went through this in great detail at one point  
>> and concluded that I did in fact need the lwarx/stwcx.  IIRC, it  
>> has to do with other non-set_pte_at writers not necessarily holding  
>> the page table lock. FYI, the existing 32-bit PTE code is doing  
>> atomic updates as well.
>
> But will those updates happen if there isn't already a valid PTE?

I understand what you're saying, I've been here before :)  However, I  
was never able to convince myself that it's safe without the lwarx/ 
stwcx.  There's hashing code that wanks around with the HASHPTE bit  
doing a RMW without holding any lock (other than lwarx/stwcx-ing the  
PTE itself).  And there's definitely code that's fairly far removed  
from the last time you checked that an entry was valid.  I've CC'd Ben  
on this mail - perhaps he can shed some light.  If we don't need the  
atomics, I'm happy to yank them.

Now, it *does* seem like set_pte_at could be optimized for the non-SMP  
case....  I'll have to chew on that one a bit.

>
>
>> About PTE_ATOMIC_UPDATES, I didn't add that in because hashed page  
>> table implementations require atomic updates.
>
> Right, I misread it and thought it was being used for non-hashed  
> implementations as well.
>
> What happens if you enable 64-bit PTEs on a 603-ish CPU?  The  
> kconfig seems to allow it.

Don't do that :)  That's why the help is there in the Kconfig.   
Otherwise, I have to list out every 74xx part that supports 36-bit  
physical addressing.  In any event, nothing interesting will happen  
other than that you'll waste some space.  The kernel boots fine with a  
non-36b physical u-boot and small amounts of RAM.

>
>
>> Adding it in would create another clause in that code, because I  
>> would still need to order the operations with a 64-bit PTE and I  
>> can't call pte_update as it only changes the low word of the pte.    
>> I wasn't feeling too keen on adding untested pagetable code into  
>> the kernel :)
>
> Wimp. :-)

Pansy :)

>
>
> > I can add it if the peanut
>> gallery wants it, but I'll be marking it with a big fat "BUYER  
>> BEWARE".
>
> No, there's little point if nothing selects it (or is planned to in  
> the near future).

Good :)

>
>
>>>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/ 
>>>> powerpc/platforms/Kconfig.cputype
>>>> index 7f65127..ca5b58b 100644
>>>> --- a/arch/powerpc/platforms/Kconfig.cputype
>>>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>>>> @@ -128,18 +128,22 @@ config FSL_EMB_PERFMON
>>>> config PTE_64BIT
>>>>    bool
>>>> -    depends on 44x || E500
>>>> +    depends on 44x || E500 || 6xx
>>>>    default y if 44x
>>>> -    default y if E500 && PHYS_64BIT
>>>> +    default y if PHYS_64BIT
>>>
>>> How is this different from PHYS_64BIT?
>> One is the width of the PTE and one is the width of a physical  
>> address.  It's entirely plausible to have a 64-bit PTE because you  
>> have a bunch of status bits, and only have 32-bit physical  
>> addressing.  That's why there are 2 options.
>
> Right, I just didn't see anything that actually selects it  
> independently of PHYS_64BIT.  Is this something that's expected to  
> actually happen in the future?

There's been talk of making the PTEs always 64-bit even on 32-bit  
platforms.  So it's entirely plausible.

>
>
> The "default y if 44x" line is redundant with the "default y if  
> PHYS_64BIT".

You're right, I'll clean that up.

>
>
>>>> config PHYS_64BIT
>>>> -    bool 'Large physical address support' if E500
>>>> -    depends on 44x || E500
>>>> +    bool 'Large physical address support' if E500 || 6xx
>>>
>>> Maybe "if !44x", or have 44x "select" this, rather than listing  
>>> all arches where it's optional.
>> Not sure exactly what you're suggesting here........
>
> It just seems simpler to not conditionalize the bool, but instead  
> have CONFIG_44x do "select PHYS_64BIT".  I'd rather avoid another  
> list of platforms accumulating in a kconfig dependency.

I'm still not sure where you're going with this - I can remove 44x  
from the conditional part, but we still have to deal with e500 and  
6xx.  In which case you're now setting this in different places for  
difft plats, making it potentially harder to read.  Unless you're  
suggesting allowing the selection of PHYS_64BIT on any platform (in  
which case your comment about what happens if I select this on 603  
doesn't make much sense).....

>
>
>>>> +    depends on 44x || E500 || 6xx
>>>>    select RESOURCES_64BIT
>>>>    default y if 44x
>>>>    ---help---
>>>>      This option enables kernel support for larger than 32-bit  
>>>> physical
>>>> -      addresses.  This features is not be available on all e500  
>>>> cores.
>>>> +      addresses.  This features is not be available on all cores.
>>>
>>> "This features is not be"?
>> Heh, I didn't type that :)  But I can fix it.
>
> You didn't type it, but you touched it.  Tag, you're it. :-)

It's already fixed in my tree  :)

-B
