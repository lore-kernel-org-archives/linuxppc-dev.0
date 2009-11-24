Return-Path: <albert_herranz@yahoo.es>
Received: from smtp129.mail.ukl.yahoo.com (smtp129.mail.ukl.yahoo.com
	[77.238.184.60]) by ozlabs.org (Postfix) with SMTP id 4227DB6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 04:56:51 +1100 (EST)
Message-ID: <4B0C1E61.6010101@yahoo.es>
Date: Tue, 24 Nov 2009 18:56:49 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 05/19] powerpc: wii: bootwrapper bits
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<90646C9F-F27D-47AD-9985-83DB7381D6BF@kernel.crashing.org>
In-Reply-To: <90646C9F-F27D-47AD-9985-83DB7381D6BF@kernel.crashing.org>
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

Segher Boessenkool wrote:
>> + * We enter with an unknown cache, high BATs and MMU status.
> 
> What does this mean?  You know the low four BATs on entry and
> nothing else?
> 

That means that we do not make assumptions regarding:
- the state of the cache (enabled vs disabled)
- if the high BATs are enabled or not
- if the MMU is enabled or not

Is this clearer? I'm not a native english speaker as you may have noticed already :-P

>> +asm ("\n\
> 
> Global asm() is evil.
> 

Yes, you said. Still, I'd like a proper argument :)

>> +    mfmsr    9\n\
>> +    andi.    0, 9, (1<<4)|(1<<5) /* MSR_DR|MSR_IR */\n\
> 
>> +    andc    9, 9, 0\n\
> 
> mfmsr 9 ; rlwinm 9,9,0,~0x30 ?
> 

Yes. Maybe

mfmsr 9 ; rlwinm 9,9,0,~((1<<4)|(1<<5)) /* MSR_DR|MSR_IR */

>> +    mtspr    0x01a, 8    /* SRR0 */\n\
>> +    mtspr    0x01b, 9    /* SRR1 */\n\
> 
> mtsrr0 and mtsrr1
> 

Easier :)

>> +    sync\n\
>> +    rfi\n\
> 
> No need for sync before rfi
> 

Ok.

>> +    mtspr    0x210, 8    /* IBAT0U */\n\
>> +    mtspr    0x211, 8    /* IBAT0L */\n\
> 
> You only need to set the upper BAT to zero, saves some code.
> 

Great. Is this documented somewhere?

>> +    isync\n\
> 
> isync here is cargo cult
> 

I'll offer a dead chicken to compensate for this.

>> +    li    8, 0x01ff    /* first 16MiB */\n\
>> +    li    9, 0x0002    /* rw */\n\
>> +    mtspr    0x210, 8    /* IBAT0U */\n\
>> +    mtspr    0x211, 9    /* IBAT0L */\n\
>> +    mtspr    0x218, 8    /* DBAT0U */\n\
>> +    mtspr    0x219, 9    /* DBAT0L */\n\
> 
> M=0 for RAM?
> 

See analog question for gamecube bootwrapper bits.

>>
> 
> Also, you should normally write the lower BAT first.  Doesn't matter
> here because IR=DR=0 of course.
> 

I can change that too if it's the general way to go.

>> +    lis    8, 0xcc00    /* I/O mem */\n\
>> +    ori    8, 8, 0x3ff    /* 32MiB */\n\
>> +    lis    9, 0x0c00\n\
>> +    ori    9, 9, 0x002a    /* uncached, guarded, rw */\n\
>> +    mtspr    0x21a, 8    /* DBAT1U */\n\
>> +    mtspr    0x21b, 9    /* DBAT1L */\n\
> 
> Is there any real reason you don't identity map this?
> 

No. There's a bit of nostalgia there.
(On the other hand there's no real reason to identity map it).

>> +    sync\n\
>> +    isync\n\
>> +\n\
> 
> Don't need these
> 

I'll get rid of them, then.

>> +    /* enable high BATs */\n\
>> +    lis    8, 0x8200\n\
>> +    mtspr    0x3f3, 8    /* HID4 */\n\
> 
> You need to use read-modify-write here.  Also, shouldn't you
> enable the extra BATs before setting them?
> 

No. You should first set them up and then enable them.
The content of the HIGH BATs is undefined on boot, AFAIK.

> And you _do_ need isync here as far as I can see.
> 
>> +    /* enable caches */\n\
>> +    mfspr    8, 0x3f0\n\
>> +    ori    8, 8, 0xc000\n\
>> +    mtspr    0x3f0, 8    /* HID0 */\n\
>> +    isync\n\
> 
> You need to invalidate the L1 caches at the same time as you enable
> them.
> 

Ok. I'll check if the caches are enabled. If they aren't I'll invalidate and enable them.

>> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
>> +{
>> +    u32 heapsize = 24*1024*1024 - (u32)_end;
>> +
>> +    simple_alloc_init(_end, heapsize, 32, 64);
>> +    fdt_init(_dtb_start);
>> +
>> +    if (!ug_grab_io_base() && ug_is_adapter_present())
> 
> The "!" reads weird.  Can you not make ug_is_adapter_present()
> call ug_grab_io_base(), anyway?
> 

Calling ug_grab_io_base() from ug_is_adapter_present() can be misleading too (you are supposed to just check if the adapter is present in that function, according to the name).
If the "!" is ugly I can use the following idiom, introducing an error variable.

  error = ug_grab_io_base();
  if (!error && ug_is_adapter_present())
     /* blah */

Thanks,
Albert
