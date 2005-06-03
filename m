Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 390DF67B1C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 06:42:52 +1000 (EST)
In-Reply-To: <42A085AD.3070005@am.sony.com>
References: <42A085AD.3070005@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b69ad095ef9d42a1e25079a3dcf28be8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 3 Jun 2005 15:42:46 -0500
To: "Geoff Levand" <geoffrey.levand@am.sony.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Fix PPC440 pagetable attributes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 3, 2005, at 11:30 AM, Geoff Levand wrote:

> Kumar Gala wrote:
>> On Jun 2, 2005, at 6:00 PM, Geoff Levand wrote:
>>
>>
>>> This patch fixes a bug in the PPC440 pagetable attributes that breaks
>>> swap support.  It also adds some notes on the PPC440 attribute 
>>> fields.
>>>
>>>  *
>>>  * Note that these bits preclude future use of a page size
>>>  * less than 4KB.
>>> + *
>>> + *
>>> + * PPC 440 core has following TLB attribute fields;
>>> + *
>>> + *   TLB1:
>>> + *   0  1  2  3  4  ... 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
>>> 31
>>> + *   RPN.................................  -  -  -  -  -  -
>>> ERPN.......
>>> + *
>>> + *   TLB2:
>>> + *   0  1  2  3  4  ... 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
>>> 31
>>> + *   -  -  -  -  -    - U0 U1 U2 U3 W  I  M  G  E   - UX UW UR SX SW
>>> SR
>>> + *
>>> + * There are some constrains and options, to decide mapping software
>>> bits
>>> + * into TLB entry.
>>> + *
>>> + *   - PRESENT *must* be in the bottom three bits because swap cache
>>> + *     entries use the top 29 bits for TLB2.
>>> + *
>>> + *   - FILE *must* be in the bottom three bits because swap cache
>>> + *     entries use the top 29 bits for TLB2.
>>> + *
>>> + *   - CACHE COHERENT bit (M) has no effect on PPC440 core, because 
>>> it
>>> + *     doesn't support SMP. So we can use this as software bit, like
>>> + *     DIRTY.
>>> + *
>>> + * PPC Book-E Linux implementation uses PPC HW PTE bit field
>>> definition,
>>> + * even it doesn't have HW PTE. 0-11th LSB of PTE stand for memory
>>> + * protection-related function. (See PTE structure in
>>> include/asm-ppc/mmu.h)
>>> + * Definition of _PAGE_XXX in "include/asm-ppc/pagetable.h" stands 
>>> for
>>> + * above bits. Note that those bits values are CPU dependent, not
>>> + * architecture.
>>> + *
>>
>> I disagree with this comment.  PPC Book-E PTE format has nothing to do
>> with PPC HW PTE format.
>>
>
> OK, is this more agreeable?
>
> * With the PPC Book-E Linux implementation, 0-11th LSB of PTE stand 
> for memory
> * protection-related function. (See PTE structure in 
> include/asm-ppc/mmu.h)
> * Definition of _PAGE_XXX here stands for above bits. Note that those 
> bits
> * values are CPU dependent, not architecture.

That's more reasonable, however I would make it say PPC 44x ... instead 
of Book-E, the e500 is also a Book-E processor and if you notice if we 
use a 64-bit PTE we end up using more than the 12 LSBs for PTE flags.

- kumar
