Return-Path: <fweisbec@gmail.com>
Received: from mail-ie0-x233.google.com (mail-ie0-x233.google.com
 [IPv6:2607:f8b0:4001:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A37521A0B95
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 09:14:00 +1100 (AEDT)
Received: by iecar1 with SMTP id ar1so19447372iec.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Feb 2015 14:13:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1424059606.21410.41.camel@kernel.crashing.org>
References: <54DE52BC.3020303@us.ibm.com>
 <1424045319.3018.2.camel@ellerman.id.au>
 <1424059606.21410.41.camel@kernel.crashing.org>
Date: Sun, 22 Feb 2015 23:13:58 +0100
Message-ID: <CAFTL4hw_caOPUPwkgDst=gwtT1wh_DUmL-djF43DJC5at=7+Jg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: re-enable dynticks
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Clarke <pc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

2015-02-16 5:06 GMT+01:00 Benjamin Herrenschmidt <benh@kernel.crashing.org>:
> On Mon, 2015-02-16 at 11:08 +1100, Michael Ellerman wrote:
>> On Fri, 2015-02-13 at 13:38 -0600, Paul Clarke wrote:
>> > implement arch_irq_work_has_interrupt() for powerpc
>> >
>> > Commit 9b01f5bf3 introduced a dependency on "IRQ work self-IPIs" for
>> > full dynamic ticks to be enabled, by expecting architectures to
>> > implement a suitable arch_irq_work_has_interrupt() routine.
>> >
>> > Several arches have implemented this routine, including x86 (3010279f)
>> > and arm (09f6edd4), but powerpc was omitted.
>> >
>> > This patch implements this routine for powerpc.
>> >
>  .../...
>>
>> It makes the message change, but is that correct? ie. do we actually implement
>> "IRQ work self-IPIs"?
>
> I think so... Fred, do you think what we do will work ? We hijack our
> decrementer (local timer) by making it shoot almost immediately (1 tick
> away) and run the irq work at the beginning of __timer_interrupt().
>
> At that point we are on our irq stack and have done irq_enter but that's
> about it.

Yes that should work. After all "self-IPI" is an oxymoron. One would
expect an IPI to be triggered by an irq controller but if such
operation isn't supported with the current CPU being both source and
destination, anything triggering the desired callback in an interrupt
context in a reasonable amount of time ahead does the job here.

I thought well that's what powerpc was doing for irq work but I wasn't
sure I understood the code correctly. I should have pinged people
about that, sorry.

Thanks.

>
> Cheers,
> Ben.
>
>> > diff --git a/arch/powerpc/include/asm/irq_work.h
>> > b/arch/powerpc/include/asm/irq_work.h
>> > new file mode 100644
>> > index 0000000..18365ec
>> > --- /dev/null
>> > +++ b/arch/powerpc/include/asm/irq_work.h
>> > @@ -0,0 +1,11 @@
>> > +#ifndef _ASM_IRQ_WORK_H
>> > +#define _ASM_IRQ_WORK_H
>> > +
>> > +#include <asm/processor.h>
>> > +
>> > +static inline bool arch_irq_work_has_interrupt(void)
>> > +{
>> > +   return 1;
>>
>> Should be "true";
>>
>> > +}
>>
>> cheers
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
