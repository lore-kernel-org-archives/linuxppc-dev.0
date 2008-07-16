Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC777DDF19
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 07:22:37 +1000 (EST)
Message-Id: <DBBB7889-795A-40CC-ABF6-874CF6148772@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B2B96B0D-960F-4FB1-A5C1-6146EFB7E563@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: SW TLB MMU rework and SMP issues (pte read/write)
Date: Wed, 16 Jul 2008 16:15:32 -0500
References: <BF59BFC7-736B-4D3F-9227-97DC90CE4739@kernel.crashing.org>
	<1216174045.7740.152.camel@pasglop>
	<B2B96B0D-960F-4FB1-A5C1-6146EFB7E563@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 16, 2008, at 3:57 PM, Kumar Gala wrote:

>>> * 64-bit PTEs and reader vs writer hazards.  How do we ensure that  
>>> the
>>> TLB miss handler samples a consistent view of the pte.  pte_updates
>>> seem ok since we only update the flag word.  However set_pte_at  
>>> seems
>>> like it could be problematic.
>>
>> eieio on the writer and a data dependency on the reader. segher
>> suggested a nice way to do it on the reader side, by doing a subf  
>> of the
>> value from the pointer and then a lwxz using that value as an offset.
>>
>> ie. something like that, with r3 containing the PTE pointer:
>>
>> 	lwz	r10,4(r3)
>> 	subf	r4,r10,r3  <-- you can use r3,r10,r3 if clobber is safe
>> 	lwzx	r11,r10,r4 <-- in which case you use r3 here too
>>
>> That ensures that the top half is loaded after the bottom half, which
>> is what you want if you do the set_pte_at() that way:
>>
>> 	stw	r11,0(r3)  <-- write top half first
>> 	eieio	           <-- maitain order to coherency domain
>>       stw	r10,4(r3)  <-- write bottom half last
>>
>> In fact, in the reader case, while at it, you can interleave that  
>> with
>> the testing of the present bit. Assuming _PAGE_PRESENT is in the low
>> bits and you can clobber r3, you get something like:
>>
>> 	lwz	r10,4(r3)
>> 	<-- can't do much here unless you can do unrelated things -->
>> 	andi.	r0,r10,_PAGE_PRESENT
>> 	subf	r3,r10,r3
>> 	beq	page_fault
>> 	lwzx	r11,r10,r3
>
> This makes sense.  I think we need to order the stores in set_pte_at  
> regardless of CONFIG_SMP.

Ok, so I realized that we don't actually need to order the stores  
since the sequential programming model will ensure the right things  
happens.

- k
