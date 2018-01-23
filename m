Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQqxC4bDJzDr38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 01:11:59 +1100 (AEDT)
Received: from mail-qt0-f176.google.com (mail-qt0-f176.google.com
 [209.85.216.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE4B82178B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 14:11:56 +0000 (UTC)
Received: by mail-qt0-f176.google.com with SMTP id i1so1520478qtj.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:11:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <878tcpoyku.fsf@concordia.ellerman.id.au>
References: <20180104224542.15333-4-robh@kernel.org>
 <878tcpoyku.fsf@concordia.ellerman.id.au>
From: Rob Herring <robh@kernel.org>
Date: Tue, 23 Jan 2018 08:11:35 -0600
Message-ID: <CAL_JsqLS_7TiQDwAxrDnP=v+63ge0+2SaomDgXQDSfOvwh7XiQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: pseries: use irq_of_parse_and_map helper
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 23, 2018 at 12:53 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> Instead of calling both of_irq_parse_one and irq_create_of_mapping, call
>> of_irq_parse_and_map instead which does the same thing. This gets us closer
>> to making the former 2 functions static.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  arch/powerpc/platforms/pseries/event_sources.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> Sorry NAK, this doesn't boot.
>
>> diff --git a/arch/powerpc/platforms/pseries/event_sources.c b/arch/powerpc/platforms/pseries/event_sources.c
>> index 6eeb0d4bab61..b0d8c146fe7b 100644
>> --- a/arch/powerpc/platforms/pseries/event_sources.c
>> +++ b/arch/powerpc/platforms/pseries/event_sources.c
>> @@ -16,7 +16,8 @@
>>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
>>   */
>>
>> -#include <asm/prom.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/of_irq.h>
>>
>>  #include "pseries.h"
>>
>> @@ -25,15 +26,11 @@ void request_event_sources_irqs(struct device_node *np,
>>                               const char *name)
>>  {
>>       int i, index, count = 0;
>> -     struct of_phandle_args oirq;
>>       unsigned int virqs[16];
>>
>>       /* First try to do a proper OF tree parsing */
>> -     for (index = 0; of_irq_parse_one(np, index, &oirq) == 0;
>> -          index++) {
>> -             if (count > 15)
>> -                     break;
>> -             virqs[count] = irq_create_of_mapping(&oirq);
>> +     for (index = 0; count < 16; index++) {
>> +             virqs[count] = irq_of_parse_and_map(np, index);
>>               if (!virqs[count]) {
>>                       pr_err("event-sources: Unable to allocate "
>>                              "interrupt number for %pOF\n",
>
>                                np);
>                         WARN_ON(1);
>                 } else {
>                         count++;
>                 }
>         }
>
>
> Which is an infinite loop if we have less than 16 irqs, and spews the
> warning continuously.
>
> Are you trying to remove the low-level routines or is this just a
> cleanup?

The former, but I'm not sure that will happen. There's a handful of
others left, but they aren't simply a call to of_irq_parse_one and
then irq_create_of_mapping.

> The patch below works, it loses the error handling if the interrupts
> property is corrupt/empty, but that's probably overly paranoid anyway.

Not quite. Previously, it was silent if parsing failed. Only the
mapping would give an error which would mean the interrupt parent had
some error.

Actually, we could use of_irq_get here to preserve the error handling.
It will return error codes from parsing, 0 on mapping failure, or the
Linux irq number. It adds an irq_find_host call for deferred probe,
but that should be harmless. I'll respin it.

Rob
