Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1C254B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 02:21:36 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70453DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 02:21:34 +1000 (EST)
Message-Id: <2EA75185-AC33-4BCA-AE53-A60E6D98DC46@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1249265010.5516.31.camel@concordia>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 3/20] powerpc/mm: Add HW threads support to no_hash TLB
	management
Date: Mon, 3 Aug 2009 11:21:17 -0500
References: <20090724091523.8AD8CDDD1B@ozlabs.org>
	<2E027F3C-8FAA-42EC-99B2-9B7EC470094E@kernel.crashing.org>
	<6FD94305-B60D-4DAF-8296-88345D11187F@kernel.crashing.org>
	<1249079342.1509.99.camel@pasglop>
	<1249265010.5516.31.camel@concordia>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 2, 2009, at 9:03 PM, Michael Ellerman wrote:

> On Sat, 2009-08-01 at 08:29 +1000, Benjamin Herrenschmidt wrote:
>> On Thu, 2009-07-30 at 22:35 -0500, Kumar Gala wrote:
>>>>              /* XXX This clear should ultimately be part of
>>> local_flush_tlb_mm */
>>>> -             __clear_bit(id, stale_map[cpu]);
>>>> +             for (cpu = cpu_first_thread_in_core(cpu);
>>>> +                  cpu <= cpu_last_thread_in_core(cpu); cpu++)
>>>> +                     __clear_bit(id, stale_map[cpu]);
>>>>      }
>>>
>>> This looks a bit dodgy.  using 'cpu' as both the loop variable and
>>> what you are computing to determine loop start/end..
>>>
>> Hrm... I would have thought that it was still correct... do you see  
>> any
>> reason why the above code is wrong ? because if not we may be  
>> hitting a
>> gcc issue...
>>
>> IE. At loop init, cpu gets clamped down to the first thread in the  
>> core,
>> which should be fine. Then, we compare CPU to the last thread in core
>> for the current CPU which should always return the same value.
>>
>> So I'm very interested to know what is actually wrong, ie, either I'm
>> just missing something obvious, or you are just pushing a bug under  
>> the
>> carpet which could come back and bit us later :-)
>
> for (cpu = cpu_first_thread_in_core(cpu);
>     cpu <= cpu_last_thread_in_core(cpu); cpu++)
>        __clear_bit(id, stale_map[cpu]);
>
> ==
>
> cpu = cpu_first_thread_in_core(cpu);
> while (cpu <= cpu_last_thread_in_core(cpu)) {
> 	__clear_bit(id, stale_map[cpu]);
> 	cpu++;
> }
>
> cpu = 0
> cpu <= 1
> cpu++ (1)
> cpu <= 1
> cpu++ (2)
> cpu <= 3
> ...

Which is pretty much what I see, in a dual core setup, I get an oops  
because we are trying to clear cpu #2 (which clearly doesn't exist)

cpu = 1
(in loop)
	clearing 1
	clearing 2
OOPS

- k
