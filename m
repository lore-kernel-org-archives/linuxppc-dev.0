Return-Path: <oohall@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpT3y00p8zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 12:09:49 +1100 (AEDT)
Received: by mail-qt0-x242.google.com with SMTP id n37so27521446qtb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 18:09:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877f3qlrep.fsf@concordia.ellerman.id.au>
References: <20170302004920.21948-1-oohall@gmail.com>
 <877f3qlrep.fsf@concordia.ellerman.id.au>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 23 Mar 2017 12:09:47 +1100
Message-ID: <CAOSf1CHwODMGc=G=OT21TrSit_G4ypd5sgCrCZOxWAGy3GtEww@mail.gmail.com>
Subject: Re: [PATCH 1/5] powerpc/smp: use cpu_to_chip_id() to find siblings
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
>
>> To determine which logical CPUs are on the same core the kernel uses the
>> ibm,chipid property from the device tree node associated with that cpu.
>> The lookup for this this information is currently open coded in both
>> traverse_siblings() and traverse_siblings_chip_id(). This patch replaces
>> these manual lookups with the existing cpu_to_chip_id() function.
>
> Some minor nits.
>
> cpu_to_chip_id() actually searches recursively up the parents until it
> finds a ibm,chip-id, so it's not a 1:1 replacement for the existing
> logic, but it's probably still an OK conversion. It's still worth
> mentioning in the change log thought.

fair enough

>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index 893bd7f79be6..dfe0e1d9cd06 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -664,23 +655,19 @@ static void traverse_core_siblings(int cpu, bool add)
>>  {
>>       struct device_node *l2_cache, *np;
>>       const struct cpumask *mask;
>> -     int i, chip, plen;
>> -     const __be32 *prop;
>> +     int chip_id;
>> +     int i;
>>
>> -     /* First see if we have ibm,chip-id properties in cpu nodes */
>> -     np = of_get_cpu_node(cpu, NULL);
>> -     if (np) {
>> -             chip = -1;
>> -             prop = of_get_property(np, "ibm,chip-id", &plen);
>> -             if (prop && plen == sizeof(int))
>> -                     chip = of_read_number(prop, 1);
>> -             of_node_put(np);
>> -             if (chip >= 0) {
>> -                     traverse_siblings_chip_id(cpu, add, chip);
>> -                     return;
>> -             }
>> +     /* threads that share a chip-id are considered siblings (same die) */
>
> You might know it means the "same die", but AFAIK there's no actual
> definition for what the chip-id means, so let's not write comments that
> might be wrong in future. Just saying they're considered siblings is
> sufficient.
>
> Also "Threads" :)

The cpus masks are all built in terms of threads, so this is
technically correct even if it sounds stupid. Maybe "logical cpus"
would be better?

>
> cheers
