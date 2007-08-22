Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 415B0DDE18
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 00:07:03 +1000 (EST)
In-Reply-To: <20070822090315.7e0010c4@weaponx.rchland.ibm.com>
References: <Pine.LNX.4.64.0708220856530.31744@blarg.am.freescale.net>
	<20070822090315.7e0010c4@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <490B1783-FA20-4DD8-A580-E71398B9928F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: [PATCH v2] Fixup modpost warnings in head*.S for ppc32
Date: Wed, 22 Aug 2007 09:08:31 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 9:03 AM, Josh Boyer wrote:

> On Wed, 22 Aug 2007 08:58:31 -0500 (CDT)
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>> Addess the following modpost warnings we get out of the ppc32 head
>> files:
>>
>> WARNING: vmlinux.o(.text+0x358): Section mismatch: reference  
>> to .init.text:early_init (between 'skpinv' and 'interrupt_base')
>> WARNING: vmlinux.o(.text+0x380): Section mismatch: reference  
>> to .init.text:machine_init (between 'skpinv' and 'interrupt_base')
>> WARNING: vmlinux.o(.text+0x384): Section mismatch: reference  
>> to .init.text:MMU_init (between 'skpinv' and 'interrupt_base')
>> WARNING: vmlinux.o(.text+0x3aa): Section mismatch: reference  
>> to .init.text:start_kernel (between 'skpinv' and 'interrupt_base')
>> WARNING: vmlinux.o(.text+0x3ae): Section mismatch: reference  
>> to .init.text:start_kernel (between 'skpinv' and 'interrupt_base')
>>
>> Does anyone have any issues with this?  This version cleans up 40x  
>> based
>> on the latest for-2.6.24 tree and removes the stabs defn from _ENTRY.
>
> No signed-off-by on purpose?

Yes, since its an RFC, I explicitly didn't put a signed-off-by :)

>> diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/ 
>> head_40x.S
>> index a8e0457..00bdb6d 100644
>> --- a/arch/powerpc/kernel/head_40x.S
>> +++ b/arch/powerpc/kernel/head_40x.S
>> @@ -52,9 +52,9 @@
>>   *
>>   * This is all going to change RSN when we add bi_recs.......  --  
>> Dan
>>   */
>> -	.text
>> -_GLOBAL(_stext)
>> -_GLOBAL(_start)
>> +	.section	.text.head, "ax"
>> +_ENTRY(_stext);
>> +_ENTRY(_start);
>>
>>  	/* Save parameters we are passed.
>>  	*/
>> @@ -89,9 +89,9 @@ turn_on_mmu:
>>   */
>>  	. = 0xc0
>>  crit_save:
>> -_GLOBAL(crit_r10)
>> +_ENTRY(crit_r10)
>>  	.space	4
>> -_GLOBAL(crit_r11)
>> +_ENTRY(crit_r11)
>>  	.space	4
>>
>>  /*
>> @@ -814,7 +814,7 @@ finish_tlb_load:
>>   * The PowerPC 4xx family of processors do not have an FPU, so  
>> this just
>>   * returns.
>>   */
>> -_GLOBAL(giveup_fpu)
>> +_ENTRY(giveup_fpu)
>>  	blr
>
> I had moved this bit below initial_mmu instead in my version.  I
> realize there isn't much difference from a technical point of view,  
> but
> it seems misleading to label this one as _ENTRY.

Do you want to move both crit_r10/r11 & giveup_fpu or just giveup_fpu?

- k
