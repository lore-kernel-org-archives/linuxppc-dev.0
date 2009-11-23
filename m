Return-Path: <albert_herranz@yahoo.es>
Received: from smtp133.mail.ukl.yahoo.com (smtp133.mail.ukl.yahoo.com
	[77.238.184.64]) by ozlabs.org (Postfix) with SMTP id D8576B7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 07:16:18 +1100 (EST)
Message-ID: <4B0AED90.6050600@yahoo.es>
Date: Mon, 23 Nov 2009 21:16:16 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 14/19] powerpc: allow ioremap within reserved fake
	ram 	regions
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221536pf558b1fte36dc88bdf58e883@mail.gmail.com>
In-Reply-To: <fa686aa40911221536pf558b1fte36dc88bdf58e883@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> wrote:
>> The Nintendo Wii has two discontiguous RAM memory areas called
>> MEM1 and MEM2.
>> MEM1 starts at 0x00000000 and contains 24MB of 1T-SRAM.
>> MEM2 starts at 0x10000000 and contains 64MB of DDR2 RAM.
>> Between both memory address ranges there is an address space
>> where memory-mapped I/O registers are found.
>>
>> Currently, Linux 32-bit PowerPC does not support RAM in
>> discontiguous memory address spaces. Thus, in order to use
>> both RAM areas, we declare as RAM the range from the start of
>> MEM1 to the end of useable MEM2 and exclude the needed parts
>> with /memreserve/ statements, at the expense of wasting a bit
>> of memory.
>>
>> As a side effect, we need to allow ioremapping RAM areas
>> because the I/O address space sits within the memreserve'd part
>> of the declared RAM region.
>> Note that this is not safe if the region ioremapped is covered
>> by an existing BAT mapping used to map RAM, so this is
>> specifically banned here.
>>
>> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
>> ---
>>  arch/powerpc/mm/pgtable_32.c |   19 ++++++++++++++++---
>>  1 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>> index cb96cb2..ba00cb1 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -191,9 +191,22 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
>>         * Don't allow anybody to remap normal RAM that we're using.
>>         * mem_init() sets high_memory so only do the check after that.
>>         */
>> -       if (mem_init_done && (p < virt_to_phys(high_memory))) {
>> -               printk("__ioremap(): phys addr 0x%llx is RAM lr %p\n",
>> -                      (unsigned long long)p, __builtin_return_address(0));
>> +       if (mem_init_done && (p < virt_to_phys(high_memory))
>> +#ifdef CONFIG_WII
>> +               /*
>> +                * On some systems, though, we may want to remap an area
>> +                * declared as normal RAM that we have memreserve'd at the
>> +                * device tree. See wii.dts.
>> +                * But we can't do that safely if we are using BATs to map
>> +                * part of that area.
>> +                */
>> +           && !__map_without_bats
>> +#endif
>> +           ) {
>> +               printk(KERN_WARNING
>> +                      "__ioremap(): phys addr 0x%llx is RAM lr %p\n",
>> +                      (unsigned long long)p,
>> +                        __builtin_return_address(0));
> 
> This could adversely affect multiplatform kernels.  I'd rather get the
> RAM problem fixed and not hack up common code to work around the hack.
> 
> g.
> 

Would it be acceptable to create a global var __allow_ioremap_normal_ram that by default would have a value of 0 and would be set _only_ for those platforms needing it?

The other solutions I see is:
- add support for discontiguous memory to powerpc 32-bits (which is not something that I can look into now)
- don't use the precious second 64MB area (which is a waste)

Do you have any other suggestions?

Thanks,
Albert
