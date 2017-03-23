Return-Path: <oohall@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpTSt2G7RzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 12:27:58 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id x35so27562175qtc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 18:27:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8760jalreg.fsf@concordia.ellerman.id.au>
References: <20170302004920.21948-1-oohall@gmail.com>
 <20170302004920.21948-2-oohall@gmail.com>
 <8760jalreg.fsf@concordia.ellerman.id.au>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 23 Mar 2017 12:27:55 +1100
Message-ID: <CAOSf1CFSg4hDNo_=wWmy4TjXv3kASmy9iKiU8kzzsjOKS1GX7A@mail.gmail.com>
Subject: Re: [PATCH 2/5] powerpc/smp: add set_cpus_related()
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 15, 2017 at 10:18 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Oliver O'Halloran <oohall@gmail.com> writes:
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index dfe0e1d9cd06..1c531887ca51 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -377,6 +377,25 @@ static void smp_store_cpu_info(int id)
>>  #endif
>>  }
>>
>> +/*
>> + * Relationships between CPUs are maintained in a set of per-cpu cpumasks. We
>> + * need to ensure that they are kept consistant between CPUs when they are
>> + * changed.
>> + *
>> + * This is slightly tricky since the core mask must be a strict superset of
>> + * the sibling mask.
>> + */
>> +static void set_cpus_related(int i, int j, bool related, struct cpumask *(*relation_fn)(int))
>> +{
>> +     if (related) {
>> +             cpumask_set_cpu(i, relation_fn(j));
>> +             cpumask_set_cpu(j, relation_fn(i));
>> +     } else {
>> +             cpumask_clear_cpu(i, relation_fn(j));
>> +             cpumask_clear_cpu(j, relation_fn(i));
>> +     }
>> +}
>
> I think you pushed the abstraction one notch too far on this one, or
> perhaps not far enough.
>
> We end up with a function called "set" that might clear, depending on a
> bool you pass. Which is hard to parse, eg:
>
>         set_cpus_related(cpu, base + i, false, cpu_sibling_mask);
>
> And I know there's two places where we pass an existing bool "add", but
> there's four where we pass true or false.

I think you're looking at this patch. With the full series applied we
never pass a literal to set_cpus_related() directly:

[12:14 oliver ~/.../powerpc/kernel (p9-sched $%)]$ gg set_cpus_related
smp.c:391:static void set_cpus_related(int i, int j, bool related,
struct cpumask *(*relation_fn)(int))
smp.c:647:      set_cpus_related(cpu, cpu, add, cpu_core_mask);
smp.c:651:                      set_cpus_related(cpu, i, add, cpu_core_mask);
smp.c:685:      set_cpus_related(cpu, cpu, onlining, mask_fn);
smp.c:697:                      set_cpus_related(cpu, i, onlining, mask_fn);
smp.c:721:              set_cpus_related(cpu, base + i, onlining,
cpu_sibling_mask);
smp.c:736:      set_cpus_related(cpu, cpu, onlining, cpu_core_mask);
smp.c:746:              set_cpus_related(cpu, i, onlining, cpu_core_mask);

I agree that set_cpus_related() is probably a bad name,
make_cpus_related() maybe?

>
> If we want to push it in that direction I think we should just pass the
> set/clear routine instead of the flag, so:
>
>         do_cpus_related(cpu, base + i, cpumask_clear_cpu, cpu_sibling_mask);
>
> But that might be overdoing it.

I think this would be ok.

>
> So I think we should just do:
>
> static void set_cpus_related(int i, int j, struct cpumask *(*mask_func)(int))
> {
>         cpumask_set_cpu(i, mask_func(j));
>         cpumask_set_cpu(j, mask_func(i));
> }
>
> static void clear_cpus_related(int i, int j, struct cpumask *(*mask_func)(int))
> {
>         cpumask_clear_cpu(i, mask_func(j));
>         cpumask_clear_cpu(j, mask_func(i));
> }
>
>
> So the cases with add become:
>
>         if (add)
>                 set_cpus_related(cpu, i, cpu_core_mask(i));
>         else
>                 clear_cpus_related(cpu, i, cpu_core_mask(i));

Dunno, I was trying to get rid of this sort of thing since the logic
is duplicated in a lot of places. Seemed to me that it was just
pointlessly verbose rather than being helpfully explicit.

>
> Which is not as pretty but more explicit.
>
> And the other cases look much better, eg:
>
>         clear_cpus_related(cpu, base + i, cpu_sibling_mask);
>
> ??
>
> cheers
