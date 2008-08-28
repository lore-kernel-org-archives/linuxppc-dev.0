Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3341DE1F2
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 02:08:06 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m7SG7xft003101
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 09:07:59 -0700 (MST)
Message-ID: <48B6CD32.2040308@freescale.com>
Date: Thu, 28 Aug 2008 11:07:14 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support 36-bit
	physical
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
	<48B5E6B7.3000903@freescale.com>
	<C16F93B0-766C-43E8-B4B5-40BC0FEE298F@freescale.com>
In-Reply-To: <C16F93B0-766C-43E8-B4B5-40BC0FEE298F@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Becky Bruce wrote:
> I'm pretty sure I went through this in great detail at one point and 
> concluded that I did in fact need the lwarx/stwcx.  IIRC, it has to do 
> with other non-set_pte_at writers not necessarily holding the page table 
> lock. FYI, the existing 32-bit PTE code is doing atomic updates as well.

But will those updates happen if there isn't already a valid PTE?

> About PTE_ATOMIC_UPDATES, I didn't add that in because hashed page table 
> implementations require atomic updates.

Right, I misread it and thought it was being used for non-hashed 
implementations as well.

What happens if you enable 64-bit PTEs on a 603-ish CPU?  The kconfig 
seems to allow it.

>  Adding it in would create 
> another clause in that code, because I would still need to order the 
> operations with a 64-bit PTE and I can't call pte_update as it only 
> changes the low word of the pte.   I wasn't feeling too keen on adding 
> untested pagetable code into the kernel :)

Wimp. :-)

 > I can add it if the peanut
> gallery wants it, but I'll be marking it with a big fat "BUYER BEWARE".

No, there's little point if nothing selects it (or is planned to in the 
near future).

>>> diff --git a/arch/powerpc/platforms/Kconfig.cputype 
>>> b/arch/powerpc/platforms/Kconfig.cputype
>>> index 7f65127..ca5b58b 100644
>>> --- a/arch/powerpc/platforms/Kconfig.cputype
>>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>>> @@ -128,18 +128,22 @@ config FSL_EMB_PERFMON
>>>  config PTE_64BIT
>>>     bool
>>> -    depends on 44x || E500
>>> +    depends on 44x || E500 || 6xx
>>>     default y if 44x
>>> -    default y if E500 && PHYS_64BIT
>>> +    default y if PHYS_64BIT
>>
>> How is this different from PHYS_64BIT?
> 
> One is the width of the PTE and one is the width of a physical address.  
> It's entirely plausible to have a 64-bit PTE because you have a bunch of 
> status bits, and only have 32-bit physical addressing.  That's why there 
> are 2 options.

Right, I just didn't see anything that actually selects it independently 
of PHYS_64BIT.  Is this something that's expected to actually happen in 
the future?

The "default y if 44x" line is redundant with the "default y if PHYS_64BIT".

>>> config PHYS_64BIT
>>> -    bool 'Large physical address support' if E500
>>> -    depends on 44x || E500
>>> +    bool 'Large physical address support' if E500 || 6xx
>>
>> Maybe "if !44x", or have 44x "select" this, rather than listing all 
>> arches where it's optional.
> 
> Not sure exactly what you're suggesting here........

It just seems simpler to not conditionalize the bool, but instead have 
CONFIG_44x do "select PHYS_64BIT".  I'd rather avoid another list of 
platforms accumulating in a kconfig dependency.

>>> +    depends on 44x || E500 || 6xx
>>>     select RESOURCES_64BIT
>>>     default y if 44x
>>>     ---help---
>>>       This option enables kernel support for larger than 32-bit physical
>>> -      addresses.  This features is not be available on all e500 cores.
>>> +      addresses.  This features is not be available on all cores.
>>
>> "This features is not be"?
> 
> Heh, I didn't type that :)  But I can fix it.

You didn't type it, but you touched it.  Tag, you're it. :-)

-Scott
