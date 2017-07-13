Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7HH30xbSzDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 10:47:59 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id w12so4270208qta.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 17:47:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8737a3mi5l.fsf@linkitivity.dja.id.au>
References: <20170707070249.15773-1-matthew.brown.dev@gmail.com>
 <8737a3mi5l.fsf@linkitivity.dja.id.au>
From: Matt Brown <matthew.brown.dev@gmail.com>
Date: Thu, 13 Jul 2017 10:47:56 +1000
Message-ID: <CAPoR37YUGNKre=YyBixvG7iNjr-ZHy1-zYOtjyMRaVzqS8BLxw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/powernv: Use darn instr for random_seed on p9
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 11, 2017 at 7:34 PM, Daniel Axtens <dja@axtens.net> wrote:
> Hi Matt,
>
>> Currently ppc_md.get_random_seed uses the powernv_get_random_long function.
>> A guest calling this function would have to go through the hypervisor. The
>> 'darn' instruction, introduced in POWER9, allows us to bypass this by
>> directly obtaining a value from the mmio region.
>>
>> This patch adds a function for ppc_md.get_random_seed on p9,
>> utilising the darn instruction.
>
> This patch looks pretty good - I'm not set up to test it but I have one
> code-style nit:
>
>> diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
>> index 5dcbdea..ab6f411 100644
>> --- a/arch/powerpc/platforms/powernv/rng.c
>> +++ b/arch/powerpc/platforms/powernv/rng.c
>> @@ -8,6 +8,7 @@
>>   */
>>
>>  #define pr_fmt(fmt)  "powernv-rng: " fmt
>> +#define DARN_ERR 0xFFFFFFFFFFFFFFFFul
>>
>>  #include <linux/kernel.h>
>>  #include <linux/of.h>
>> @@ -16,6 +17,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/smp.h>
>>  #include <asm/archrandom.h>
>> +#include <asm/cputable.h>
>>  #include <asm/io.h>
>>  #include <asm/prom.h>
>>  #include <asm/machdep.h>
>> @@ -67,6 +69,21 @@ int powernv_get_random_real_mode(unsigned long *v)
>>       return 1;
>>  }
>>
>> +int powernv_get_random_darn(unsigned long *v)
>
> This is only referenced in this file so it should probably be labelled
> as 'static'.
>

That's true, my thinking was to then use the get_random_darn where the
get_random_long was being used.
Looks like there is only one other caller of it at the moment,
kvmppc_h_random (in arch/powerpc/kvm/book3s_hv_builtin.c).
We may want to change that to get_random_darn.

>> +{
>> +     unsigned long val;
>> +
>> +     /* Using DARN with L=1 - conditioned random number */
>> +     asm (PPC_DARN(%0, 1)"\n" : "=r"(val) :);
>> +
>> +     if (val == DARN_ERR)
>> +             return 0;
>> +
>> +     *v = val;
>> +
>> +     return 1;
>
> I was a bit confused to see 1 representing success - I think I have been
> in userspace too long. But I checked against pseries_get_random_long and
> it is in fact correct, so good for you!
>
> An excellent followup patch would be changing the type of this function
> to be bool rather than int, but no pressure :)

That's probably a good idea!

Thanks,
Matt

>
> Regards,
> Daniel
>
>> +}
>> +
>>  int powernv_get_random_long(unsigned long *v)
>>  {
>>       struct powernv_rng *rng;
>> @@ -136,6 +153,7 @@ static __init int rng_create(struct device_node *dn)
>>  static __init int rng_init(void)
>>  {
>>       struct device_node *dn;
>> +     unsigned long drn_test;
>>       int rc;
>>
>>       for_each_compatible_node(dn, NULL, "ibm,power-rng") {
>> @@ -150,6 +168,10 @@ static __init int rng_init(void)
>>               of_platform_device_create(dn, NULL, NULL);
>>       }
>>
>> +     if (cpu_has_feature(CPU_FTR_ARCH_300) &&
>> +         powernv_get_random_darn(&drn_test))
>> +             ppc_md.get_random_seed = powernv_get_random_darn;
>> +
>>       return 0;
>>  }
>>  machine_subsys_initcall(powernv, rng_init);
>> --
>> 2.9.3
