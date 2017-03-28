Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsXyK4v7bzDqZJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 12:15:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/5] powerpc/smp: add set_cpus_related()
In-Reply-To: <CAOSf1CFSg4hDNo_=wWmy4TjXv3kASmy9iKiU8kzzsjOKS1GX7A@mail.gmail.com>
References: <20170302004920.21948-1-oohall@gmail.com>
 <20170302004920.21948-2-oohall@gmail.com>
 <8760jalreg.fsf@concordia.ellerman.id.au>
 <CAOSf1CFSg4hDNo_=wWmy4TjXv3kASmy9iKiU8kzzsjOKS1GX7A@mail.gmail.com>
Date: Tue, 28 Mar 2017 12:15:37 +1100
Message-ID: <87h92eb3ra.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oliver O'Halloran <oohall@gmail.com> writes:

> On Wed, Mar 15, 2017 at 10:18 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Oliver O'Halloran <oohall@gmail.com> writes:
>>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>>> index dfe0e1d9cd06..1c531887ca51 100644
>>> --- a/arch/powerpc/kernel/smp.c
>>> +++ b/arch/powerpc/kernel/smp.c
>>> @@ -377,6 +377,25 @@ static void smp_store_cpu_info(int id)
>>>  #endif
>>>  }
>>>
>>> +/*
>>> + * Relationships between CPUs are maintained in a set of per-cpu cpumasks. We
>>> + * need to ensure that they are kept consistant between CPUs when they are
>>> + * changed.
>>> + *
>>> + * This is slightly tricky since the core mask must be a strict superset of
>>> + * the sibling mask.
>>> + */
>>> +static void set_cpus_related(int i, int j, bool related, struct cpumask *(*relation_fn)(int))
>>> +{
>>> +     if (related) {
>>> +             cpumask_set_cpu(i, relation_fn(j));
>>> +             cpumask_set_cpu(j, relation_fn(i));
>>> +     } else {
>>> +             cpumask_clear_cpu(i, relation_fn(j));
>>> +             cpumask_clear_cpu(j, relation_fn(i));
>>> +     }
>>> +}
>>
>> I think you pushed the abstraction one notch too far on this one, or
>> perhaps not far enough.
>>
>> We end up with a function called "set" that might clear, depending on a
>> bool you pass. Which is hard to parse, eg:
>>
>>         set_cpus_related(cpu, base + i, false, cpu_sibling_mask);
>>
>> And I know there's two places where we pass an existing bool "add", but
>> there's four where we pass true or false.
>
> I think you're looking at this patch.

Yeah I guess I was.

> With the full series applied we never pass a literal to
> set_cpus_related() directly:
>
> [12:14 oliver ~/.../powerpc/kernel (p9-sched $%)]$ gg set_cpus_related
> smp.c:391:static void set_cpus_related(int i, int j, bool related,
> struct cpumask *(*relation_fn)(int))
> smp.c:647:      set_cpus_related(cpu, cpu, add, cpu_core_mask);
> smp.c:651:                      set_cpus_related(cpu, i, add, cpu_core_mask);
> smp.c:685:      set_cpus_related(cpu, cpu, onlining, mask_fn);
> smp.c:697:                      set_cpus_related(cpu, i, onlining, mask_fn);
> smp.c:721:              set_cpus_related(cpu, base + i, onlining, cpu_sibling_mask);
> smp.c:736:      set_cpus_related(cpu, cpu, onlining, cpu_core_mask);
> smp.c:746:              set_cpus_related(cpu, i, onlining, cpu_core_mask);

Yeah I guess it's a bit better.

But it's still very non-obvious what each of those lines is doing.

> I agree that set_cpus_related() is probably a bad name,
> make_cpus_related() maybe?

Except in the clearing case it's unrelating them.

I think the fact that we can't think of a meaningful name is a sign it's
not a good API.

>> If we want to push it in that direction I think we should just pass the
>> set/clear routine instead of the flag, so:
>>
>>         do_cpus_related(cpu, base + i, cpumask_clear_cpu, cpu_sibling_mask);
>>
>> But that might be overdoing it.
>
> I think this would be ok.
>
>>
>> So I think we should just do:
>>
>> static void set_cpus_related(int i, int j, struct cpumask *(*mask_func)(int))
>> {
>>         cpumask_set_cpu(i, mask_func(j));
>>         cpumask_set_cpu(j, mask_func(i));
>> }
>>
>> static void clear_cpus_related(int i, int j, struct cpumask *(*mask_func)(int))
>> {
>>         cpumask_clear_cpu(i, mask_func(j));
>>         cpumask_clear_cpu(j, mask_func(i));
>> }
>>
>> So the cases with add become:
>>
>>         if (add)
>>                 set_cpus_related(cpu, i, cpu_core_mask(i));
>>         else
>>                 clear_cpus_related(cpu, i, cpu_core_mask(i));
>
> Dunno, I was trying to get rid of this sort of thing since the logic
> is duplicated in a lot of places. Seemed to me that it was just
> pointlessly verbose rather than being helpfully explicit.

It's annoyingly verbose perhaps, but I don't think pointlessly.

Your version passes two CPU numbers, a bool and a function to another
function, and based on the bool calls a third or fourth function and
passes the CPU numbers and result of the first function.

My version(s) above takes two cpu numbers and a mask, and calls one
function passing it the CPU numbers and the mask.

So it's clearly simpler and more explicit, and because the function
names are actually meaningful you can have some hope of determining what
they do without looking at the definition every time you see it.

cheers
