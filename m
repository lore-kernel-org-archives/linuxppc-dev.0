Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BB5EFDDE31
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 07:57:39 +1100 (EST)
Message-Id: <C0519630-66EF-4860-A27E-15CC749D98DC@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1229373978.26324.120.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 11/16] powerpc/mm: Add SMP support to no-hash TLB handling
	v3
Date: Mon, 15 Dec 2008 14:57:33 -0600
References: <20081215054554.E883EDDF9D@ozlabs.org>
	<B3FDD472-0720-4454-9329-5A1C8A9BF84A@freescale.com>
	<1229373978.26324.120.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 15, 2008, at 2:46 PM, Benjamin Herrenschmidt wrote:

>>>
>>> Index: linux-work/arch/powerpc/include/asm/mmu.h
>>> ===================================================================
>>> --- linux-work.orig/arch/powerpc/include/asm/mmu.h	2008-12-15
>>> 14:36:20.000000000 +1100
>>> +++ linux-work/arch/powerpc/include/asm/mmu.h	2008-12-15
>>> 14:36:20.000000000 +1100
>>> @@ -15,6 +15,9 @@
>>> #define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
>>> #define MMU_FTR_HAS_HIGH_BATS		ASM_CONST(0x00010000)
>>> #define MMU_FTR_BIG_PHYS		ASM_CONST(0x00020000)
>>> +#define MMU_FTR_HAS_TLBIVAX_BCAST	ASM_CONST(0x00040000)
>>> +#define MMU_FTR_HAS_TLBILX_PID		ASM_CONST(0x00080000)
>>
>> Can we make these FTR_USE_ instead of FTR_HAS_.  On e500 we have
>> TLBIVAX_BCAST but dont plan to use it.  I'd prefer not to have to
>> answer questions about that.
>
> Hehehe :-) I can change that easily yes.

Probably good to add something in the commit message about how  
FTR_USE_ implies FTR_HAS_ just so when some comes back through the git  
history the know we thought about it.

>>> +#define MMU_FTR_TLBIVAX_NEED_LOCK	ASM_CONST(0x00100000)
>>
>> Is this really ivax lock or sync lock?
>
> The whole thing. Not totally clear, you have a better name ? Some CPUs
> want a lock on sync and some on ivax, I plan to lock the whole  
> sequence.

MMU_FTR_TLBIVAX_OR_SYNC_NEED_LOCK ?

Its probably a good idea to have a clear definition of what each of  
these flags means in the commit message.

-k
