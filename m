Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 301E5B7235
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 05:44:02 +1100 (EST)
Received: by wwf10 with SMTP id 10so2839403wwf.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 10:43:58 -0800 (PST)
Message-ID: <4EC555D7.1080808@gmail.com>
Date: Thu, 17 Nov 2011 22:43:35 +0400
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
MIME-Version: 1.0
To: lee.nipper@gmail.com
Subject: Re: [PATCH 3/6] powerpc/85xx: separate MPIC handling code
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
 <1321552581-29773-3-git-send-email-dbaryshkov@gmail.com>
 <CALg11mj7DG2KE=pODJ526zQdQZSc4vFuDCtEGGYXNiwxpGAcyA@mail.gmail.com>
In-Reply-To: <CALg11mj7DG2KE=pODJ526zQdQZSc4vFuDCtEGGYXNiwxpGAcyA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2011 10:30 PM, Lee Nipper wrote:
> On Thu, Nov 17, 2011 at 11:56 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com>  wrote:
>> All mpc85xx boards deal with MPIC initialization in more or less the
>> same way. The only difrerences are some flags (WANTS_RESET,
>> BROKEN_FRR_NIRQS, SINGLE_DEST_CPU), and some bugs like leaking device
>> node counter, etc. To minimize problems, switch all boards to use one
>> single instance of code.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov<dbaryshkov@gmail.com>
>
> <snip>
>
>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_common.c b/arch/powerpc/platforms/85xx/mpc85xx_common.c
>> index fe40668..7579e24 100644
>> --- a/arch/powerpc/platforms/85xx/mpc85xx_common.c
>> +++ b/arch/powerpc/platforms/85xx/mpc85xx_common.c
>> @@ -7,6 +7,9 @@
>>   */
>>   #include<linux/of_platform.h>
>>
>> +#include<asm/machdep.h>
>> +#include<asm/mpic.h>
>> +
>>   #include<sysdev/cpm2_pic.h>
>>
>>   #include "mpc85xx.h"
>> @@ -63,3 +66,43 @@ void __init mpc85xx_cpm2_pic_init(void)
>>         irq_set_chained_handler(irq, cpm2_cascade);
>>   }
>>   #endif
>> +
>> +
>> +void __init mpc85xx_init_mpic(bool reset, bool broken_frr, bool singledest)
>> +{
>> +       struct mpic *mpic;
>> +       struct resource r;
>> +       struct device_node *np = NULL;
>> +       unsigned int flags = MPIC_PRIMARY | MPIC_BIG_ENDIAN |
>> +                               MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU;
>
> since parameters broken_frr and singledest are used later,
> flags should probably be just:
>
>              unsigned int flags = MPIC_PRIMARY | MPIC_BIG_ENDIAN;

Yes, forgot about this when cleaning up. Sorry.

>
>> +
>> +       np = of_find_node_by_type(np, "open-pic");
>> +
>> +       if (np == NULL) {
>> +               printk(KERN_ERR "Could not find open-pic node\n");
>> +               return;
>> +       }
>> +
>> +       if (of_address_to_resource(np, 0,&r)) {
>> +               printk(KERN_ERR "Failed to map mpic register space\n");
>> +               of_node_put(np);
>> +               return;
>> +       }
>> +
>> +       if (reset)
>> +               flags |= MPIC_WANTS_RESET;
>> +       if (broken_frr)
>> +               flags |= MPIC_BROKEN_FRR_NIRQS;
>> +       if (singledest)
>> +               flags |= MPIC_SINGLE_DEST_CPU;
>> +       if (ppc_md.get_irq == mpic_get_coreint_irq)
>> +               flags |= MPIC_ENABLE_COREINT;
>> +
>> +       mpic = mpic_alloc(np, r.start, flags, 0, 256, " OpenPIC  ");
>> +       BUG_ON(mpic == NULL);
>> +
>> +       /* Return the mpic node */
>> +       of_node_put(np);
>> +
>> +       mpic_init(mpic);
>> +}
>
> <snip>
>
>> --
>> 1.7.7.1


-- 
With best wishes
Dmitry
