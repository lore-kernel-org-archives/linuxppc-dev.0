Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id D3C19DDF34
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 09:11:11 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so28532anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Aug 2008 16:11:09 -0700 (PDT)
Message-ID: <fa686aa40808061611p616208bp2baf9a0d5e095870@mail.gmail.com>
Date: Wed, 6 Aug 2008 17:11:08 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for setting
	up BAT translated IO regions.
In-Reply-To: <1218061585.24157.246.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
	<1218061585.24157.246.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 6, 2008 at 4:26 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2008-08-06 at 00:02 -0600, Grant Likely wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> ioremap_bat() is useful for things like mapping SoC internally memory mapped
>> register and early text because it allows mappings to devices to be setup
>> early in the boot process where they are needed, and the mappings persist
>> after the MMU is configured.
>>
>> Without ioremap_bat(), setting up the MMU would cause the early text
>> mappings to get lost and mostly likely result in a kernel panic on the next
>> attempt at output.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>
> First comment, make the name more generic. This facility could be
> implemented on processors without BATs using different techniques.
>
> Maybe ioremap_block() or ioremap_early() or something like that.

okay

>> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
>> index 066e65c..7b25b57 100644
>> --- a/arch/powerpc/kernel/setup_32.c
>> +++ b/arch/powerpc/kernel/setup_32.c
>> @@ -113,6 +113,15 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
>>   */
>>  notrace void __init machine_init(unsigned long dt_ptr, unsigned long phys)
>>  {
>> +     /* Do the bare minimum to start allocting from the IO region so
>> +      * that ioremap_bat() works */
>> +#ifdef CONFIG_HIGHMEM
>> +     ioremap_base = PKMAP_BASE;
>> +#else
>> +     ioremap_base = 0xfe000000UL;    /* for now, could be 0xfffff000 */
>> +#endif /* CONFIG_HIGHMEM */
>> +     ioremap_bot = ioremap_base;
>> +
>
> Can't these be statically initialized ? If not, then do a function call
> to mm/ please. Something like mm_init_early().

heh, I had just moved this code block without thinking about it.  I'll
investigate and see what I can do.

>> +     /* BAT mappings must be 128k aligned */
>> +     if (addr != _ALIGN_DOWN(addr, 128 << 10))
>> +             return NULL;
>
> Mustn't they be naturally aligned on their size ?

I'm not sure what you're asking.  Are you asking about this particular
test, or are you asking why I don't also test the size?

I do this particular test to make absolute sure that the caller
absolutely understands the limitations of the block mapping.  If they
call this with something that isn't 128k aligned, then I make it fail
immediately so the coder is forced to go and understand what they are
allowed to do.  Basically, I'm reinforcing the fact that this is not
the same as ioremap().

I haven't decided yet if I should test size in the same way.  Thoughts?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
