Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3133DDDFDE
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 04:56:23 +1000 (EST)
Message-ID: <46F2C217.2000207@ru.mvista.com>
Date: Thu, 20 Sep 2007 22:55:19 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC: add setup_cpu for 44x for processor-specific init
References: <20070920175558.GA3191@ru.mvista.com>
	<3C1A509F-D243-4465-BDB1-25B6437CA04F@kernel.crashing.org>
In-Reply-To: <3C1A509F-D243-4465-BDB1-25B6437CA04F@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
>> diff -ruN linux-2.6.orig/arch/powerpc/kernel/cputable.c 
>> linux-2.6/arch/powerpc/kernel/cputable.c
>> --- linux-2.6.orig/arch/powerpc/kernel/cputable.c    2007-09-20 
>> 19:30:47.000000000 +0400
>> +++ linux-2.6/arch/powerpc/kernel/cputable.c    2007-09-20 
>> 21:27:35.000000000 +0400
> 
> [snip]
> 
>> @@ -1318,18 +1327,14 @@
>>
>>      for (i = 0; i < ARRAY_SIZE(cpu_specs); i++,s++)
>>          if ((pvr & s->pvr_mask) == s->pvr_value) {
>> +            cpu_setup_t setup_func  = PTRRELOC(s->cpu_setup);
>> +
>>              *cur = cpu_specs + i;
>> -#ifdef CONFIG_PPC64
>> -            /* ppc64 expects identify_cpu to also call setup_cpu
>> -             * for that processor. I will consolidate that at a
>> -             * later time, for now, just use our friend #ifdef.
>> -             * we also don't need to PTRRELOC the function pointer
>> -             * on ppc64 as we are running at 0 in real mode.
>> +            /* ppc expects identify_cpu to also call setup_cpu
>> +             * for that processor.
>>               */
>> -            if (s->cpu_setup) {
>> -                s->cpu_setup(offset, s);
>> -            }
>> -#endif /* CONFIG_PPC64 */
>> +            if (setup_func)
>> +                setup_func(offset, s);
>>              return s;
>>          }
> 
> This should just be something like:
> 
> #if defined(CONFIG_PPC64) || defined(CONFIG_BOOKE)
>     if (s->cpu_setup)
> ...
> #endif
> 
> we know reloc_offset is always 0 in book-e, plus fixup the comment.
> 
> - k

OK,
thanks,
Valentine.

> 
> 
> 
