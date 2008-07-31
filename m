Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 10C0FDDEFA
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 16:54:16 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20080731152125.2bfec5b7.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1c42eb99377e74cc128fa29aee8dc8b8@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 5/8] Silence warning in arch/powerpc/mm/ppc_mmu_32.c
Date: Thu, 31 Jul 2008 01:54:13 -0500
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu Jul 31 at 15:21:25 EST in 2008, Stephen Rothwell wrote:
> On Thu, 31 Jul 2008 13:51:43 +1000 (EST) Tony Breeds <tony at 
> bakeyournoodle.com> wrote:
>>
>> total_memory is a 'phys_addr_t', cast to unsigned long to silence
>> warning.
>>
>> diff --git a/arch/powerpc/mm/ppc_mmu_32.c 
>> b/arch/powerpc/mm/ppc_mmu_32.c
>> index c53145f..9c19655 100644
>> --- a/arch/powerpc/mm/ppc_mmu_32.c
>> +++ b/arch/powerpc/mm/ppc_mmu_32.c
>> @@ -237,7 +237,7 @@ void __init MMU_init_hw(void)
>>       Hash_end = (struct hash_pte *) ((unsigned long)Hash + 
>> Hash_size);
>>
>>       printk("Total memory = %ldMB; using %ldkB for hash table (at 
>> %p)\n",
>> -            total_memory >> 20, Hash_size >> 10, Hash);
>> +            (unsigned long)total_memory >> 20, Hash_size >> 10, 
>> Hash);
>
> Will this ever be built with CONFIG_PHYS_64BIT?

I think that is how warning originates.

But please, cast the result of the shift.  Otherwise it will print 0MB 
instead of 4096MB.

The patches for 4G ram are in on one platform and in progress on a 
second.

milton
