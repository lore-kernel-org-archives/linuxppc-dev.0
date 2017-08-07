Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQgj76pW2zDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 12:00:27 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id d136so6474291qkg.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Aug 2017 19:00:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ff133efb-7cd5-1c50-ee71-e8bb941ea492@linux.vnet.ibm.com>
References: <20170804011218.10489-1-matthew.brown.dev@gmail.com>
 <ff133efb-7cd5-1c50-ee71-e8bb941ea492@linux.vnet.ibm.com>
From: Matt Brown <matthew.brown.dev@gmail.com>
Date: Mon, 7 Aug 2017 12:00:24 +1000
Message-ID: <CAPoR37Ykavb9_V2a9abJ9vTPMqXTMLMp4LxvRmCHiCKm51g5xw@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/powernv: Use darn instr for random_seed on p9
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 5, 2017 at 3:06 AM, Tyrel Datwyler
<tyreld@linux.vnet.ibm.com> wrote:
> On 08/03/2017 06:12 PM, Matt Brown wrote:
>> This adds the powernv_get_random_darn function which utilises the darn
>> instruction, introduced in POWER9. The powernv_get_random_darn function
>> is used as the ppc_md.get_random_seed on P9.
>>
>> The DARN instruction can potentially throw an error, so we attempt to
>> register the powernv_get_random_darn function up to 10 times before
>> failing.
>>
>> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
>> ---
>> v3:
>>       - add repeat attempts to register the ppc_md.get_random_seed
>>       - fixed the PPC_DARN macro
>>       - move DARN_ERR definition
>>       - fixed commit message
>> v2:
>>       - remove repeat darn attempts
>>       - move hook to rng_init
>> ---
>>  arch/powerpc/include/asm/ppc-opcode.h |  4 ++++
>>  arch/powerpc/platforms/powernv/rng.c  | 35 ++++++++++++++++++++++++++++++++++-
>>  2 files changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
>> index c4ced1d..aabd150 100644
>> --- a/arch/powerpc/include/asm/ppc-opcode.h
>> +++ b/arch/powerpc/include/asm/ppc-opcode.h
>> @@ -134,6 +134,7 @@
>>  #define PPC_INST_COPY                        0x7c00060c
>>  #define PPC_INST_COPY_FIRST          0x7c20060c
>>  #define PPC_INST_CP_ABORT            0x7c00068c
>> +#define PPC_INST_DARN                        0x7c0005e6
>>  #define PPC_INST_DCBA                        0x7c0005ec
>>  #define PPC_INST_DCBA_MASK           0xfc0007fe
>>  #define PPC_INST_DCBAL                       0x7c2005ec
>> @@ -325,6 +326,9 @@
>>
>>  /* Deal with instructions that older assemblers aren't aware of */
>>  #define      PPC_CP_ABORT            stringify_in_c(.long PPC_INST_CP_ABORT)
>> +#define PPC_DARN(t, l)               stringify_in_c(.long PPC_INST_DARN |  \
>> +                                             ___PPC_RT(t)       |  \
>> +                                             (((l) & 0x3) << 16))
>>  #define      PPC_DCBAL(a, b)         stringify_in_c(.long PPC_INST_DCBAL | \
>>                                       __PPC_RA(a) | __PPC_RB(b))
>>  #define      PPC_DCBZL(a, b)         stringify_in_c(.long PPC_INST_DCBZL | \
>> diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
>> index 5dcbdea..83b925c 100644
>> --- a/arch/powerpc/platforms/powernv/rng.c
>> +++ b/arch/powerpc/platforms/powernv/rng.c
>> @@ -16,11 +16,13 @@
>>  #include <linux/slab.h>
>>  #include <linux/smp.h>
>>  #include <asm/archrandom.h>
>> +#include <asm/cputable.h>
>>  #include <asm/io.h>
>>  #include <asm/prom.h>
>>  #include <asm/machdep.h>
>>  #include <asm/smp.h>
>>
>> +#define DARN_ERR 0xFFFFFFFFFFFFFFFFul
>>
>>  struct powernv_rng {
>>       void __iomem *regs;
>> @@ -67,6 +69,21 @@ int powernv_get_random_real_mode(unsigned long *v)
>>       return 1;
>>  }
>>
>> +int powernv_get_random_darn(unsigned long *v)
>> +{
>> +     unsigned long val;
>> +
>> +     /* Using DARN with L=1 - 64-bit conditioned random number */
>> +     asm volatile(PPC_DARN(%0, 1) : "=r"(val));
>> +
>> +     if (val == DARN_ERR)
>> +             return 0;
>> +
>> +     *v = val;
>> +
>> +     return 1;
>> +}
>> +
>>  int powernv_get_random_long(unsigned long *v)
>>  {
>>       struct powernv_rng *rng;
>> @@ -135,8 +152,9 @@ static __init int rng_create(struct device_node *dn)
>>
>>  static __init int rng_init(void)
>>  {
>> +     unsigned long darn_test;
>>       struct device_node *dn;
>> -     int rc;
>> +     int rc, i;
>>
>>       for_each_compatible_node(dn, NULL, "ibm,power-rng") {
>>               rc = rng_create(dn);
>> @@ -150,6 +168,21 @@ static __init int rng_init(void)
>>               of_platform_device_create(dn, NULL, NULL);
>>       }
>>
>> +     if (cpu_has_feature(CPU_FTR_ARCH_300)) {
>> +             for (i = 0; i < 10; i++) {
>> +                     if (powernv_get_random_darn(&darn_test)) {
>> +                             ppc_md.get_random_seed =
>> +                                     powernv_get_random_darn;
>> +                             break;
>
> If you return directly here you can avoid the (i == 9) conditional every iteration of the
> loop by moving the pr_warn to just outside the loop.

That's true, although it is very unlikely for the
powernv_get_random_darn to fail. So in practice we should never reach
the (i == 9) conditional.
The loop is more of a backup in the rare case that it does fail.

Thanks,
Matt


>
> -Tyrel
>
>> +                     }
>> +
>> +                     if (i == 9) {
>> +                             pr_warn("Failed to use powernv_get_random_darn"\
>> +                                     "as get_random_seed");
>> +                     }
>> +             }
>> +     }
>> +
>>       return 0;
>>  }
>>  machine_subsys_initcall(powernv, rng_init);
>>
>
