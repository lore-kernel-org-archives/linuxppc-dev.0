Return-Path: <jlinton@tributary.com>
Received: from relay05.mycloudmailbox.com (relay05.mycloudmailbox.com
 [199.244.76.204])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA20A1A0368
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2015 04:00:30 +1000 (AEST)
Message-ID: <558D91C1.6030004@tributary.com>
Date: Fri, 26 Jun 2015 12:54:09 -0500
From: Jeremy Linton <jlinton@tributary.com>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>, Jeremy Linton
 <lintonrjeremy@gmail.com>, Grant Likely <grant.likely@linaro.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>,
 <benh@kernel.crashing.org>
Subject: Re: pSeries boot failure due to wrong interrupt controller
References: <CAEFTgiyHkf8ooYdWW0nTLcdraJ_L9FpLSVZa4KS3CcdpGWJxew@mail.gmail.com>
 <CAL_JsqJqkUL8XyqR6yjg+-thj4YOQ6cUohGHHid71tdRFft7vw@mail.gmail.com>
In-Reply-To: <CAL_JsqJqkUL8XyqR6yjg+-thj4YOQ6cUohGHHid71tdRFft7vw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ping? Anyone?

I'm adding ppc-dev to see if anyone there is interested in picking up the patch..

Thanks,
	Jeremy


Ok so I messed up the formatting a little and was lazy and didn't checkpatch it
cause I mean, it was 1 line! If someone wants it resent I will do so.





On 6/23/2015 8:42 AM, Rob Herring wrote:
> +Grant
> 
> On Mon, Jun 22, 2015 at 2:44 PM, Jeremy Linton <lintonrjeremy@gmail.com> wrote:
>> The OF IRQ logic was refactored a while back, and it appears that it
>> broke the case where a device doesn't have an interrupt-map
>> (legacy/ISA platform peripherals). In particular on the older pSeries
>> platforms the console serial port (keyboard/etc) is attached via a
>> Winbond super I/O controller. With the refactored logic
>> of_irq_parse_raw() returns with the out_irq->np pointing at the bus,
>> rather than the interrupt controller. This results in the platform
>> logic getting confused about the appropriate interrupt host, and in
>> ics_rtas_host_match() it doesn't match "chrp,iic" and the xics takes
>> over and tries to use RTAS to map the interrupt. RTAS then crashes the
>> machine.
>>
>> This tweaks the "-> no map, getting parent" behavior to behave as
>> before, and the machine boots.
> 
> I think the real question is why doesn't of_irq_find_parent return the
> interrupt controller node instead of the bus node.
> 
> While I think this fix is correct, I think of_irq_parse_raw should be
> a nop in the case of no interrupt-map.
> 
> Rob
> 
>>
>> Thanks
>>
>> Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>
>>
>>
>> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>> index 1a79806..78b4161b 100644
>> --- a/drivers/of/irq.c
>> +++ b/drivers/of/irq.c
>> @@ -252,7 +252,6 @@ int of_irq_parse_raw(const __be32 *addr, struct
>> of_phandle_args *out_irq)
>>                  * Successfully parsed an interrrupt-map translation; copy new
>>                  * interrupt specifier into the out_irq structure
>>                  */
>> -               out_irq->np = newpar;
>>
>>                 match_array = imap - newaddrsize - newintsize;
>>                 for (i = 0; i < newintsize; i++)
>> @@ -262,6 +261,7 @@ int of_irq_parse_raw(const __be32 *addr, struct
>> of_phandle_args *out_irq)
>>
>>         skiplevel:
>>                 /* Iterate again with new parent */
>> +               out_irq->np = newpar;
>>                 pr_debug(" -> new parent: %s\n", of_node_full_name(newpar));
>>                 of_node_put(ipar);
>>                 ipar = newpar;
