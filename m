Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404YVz64jXzF1Vp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 22:19:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Jonathan =?utf-8?Q?Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>, linux-mm@kvack.org, Paul Mackerras
 <paulus@samba.org>, Joel Stanley <joel@jms.id.au>, Guenter Roeck
 <linux@roeck-us.net>
Subject: Re: [PATCH 3/5] powerpc/mm/32: Use page_is_ram to check for RAM
In-Reply-To: <874llcha6p.fsf@concordia.ellerman.id.au>
References: <20180222121516.23415-1-j.neuschaefer@gmx.net>
 <20180222121516.23415-4-j.neuschaefer@gmx.net>
 <874llcha6p.fsf@concordia.ellerman.id.au>
Date: Mon, 19 Mar 2018 22:19:32 +1100
Message-ID: <87y3iofh2z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> writes:
>
>> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>> ---
>>  arch/powerpc/mm/pgtable_32.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>> index d35d9ad3c1cd..d54e1a9c1c99 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -145,9 +145,8 @@ __ioremap_caller(phys_addr_t addr, unsigned long siz=
e, unsigned long flags,
>>  #ifndef CONFIG_CRASH_DUMP
>>  	/*
>>  	 * Don't allow anybody to remap normal RAM that we're using.
>> -	 * mem_init() sets high_memory so only do the check after that.
>>  	 */
>> -	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
>> +	if (page_is_ram(__phys_to_pfn(p)) &&
>>  	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size)=
)) {
>>  		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
>>  		       (unsigned long long)p, __builtin_return_address(0));
>
>
> This is killing my p5020ds (Freescale e5500) unfortunately:

Duh, I should actually read the patch :)

This is a 32-bit system with 4G of RAM, so not all of RAM is mapped,
some of it is highem which is why removing the test against high_memory
above breaks it.

So I need the high_memory test on this system.

I'm not clear why it was a problem for you on the Wii, do you even build
the Wii kernel with HIGHMEM enabled?

cheers
