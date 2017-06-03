Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-it0-x235.google.com (mail-it0-x235.google.com
 [IPv6:2607:f8b0:4001:c0b::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wg2rv6fygzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Jun 2017 00:04:47 +1000 (AEST)
Received: by mail-it0-x235.google.com with SMTP id m47so41867017iti.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Jun 2017 07:04:47 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1496412702.2842.11.camel@kernel.crashing.org>
References: <20170222190235.92E5F661CEB@gitolite.kernel.org>
 <CAMuHMdWGZYkM_aQ=vXr5J9-KFGzzWgq3hf+ZRY-n-+8-ghG5nQ@mail.gmail.com>
 <1496412702.2842.11.camel@kernel.crashing.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 3 Jun 2017 16:04:44 +0200
Message-ID: <CAMuHMdUWM+5U=gngX9V5y8yNzfW5JM_DYQm_jC4uEWdX3asPJw@mail.gmail.com>
Subject: Re: powerpc/opal-irqchip: Use interrupt names if present
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On Fri, Jun 2, 2017 at 4:11 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2017-06-02 at 14:39 +0200, Geert Uytterhoeven wrote:
>> > diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
>> > index 998316bf2dad..ecdcba9d1220 100644
>> > --- a/arch/powerpc/platforms/powernv/opal-irqchip.c
>> > +++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
>> > @@ -183,8 +183,9 @@ void opal_event_shutdown(void)
>> > +       /* It's not an error for the names to be missing */
>> > +       of_property_read_string_array(opal_node, "opal-interrupts-names",
>> > +                                     names, opal_irq_count);
>>
>> Just double-checking, as it's different from the standard "interrupt-names":
>> is "opal-interrupts-names" the correct name?
>
> Yes, because the property it refers to isn't a standard "interrupts"
> property... it's ... complicated :-)

I'm aware it's a different property.

> It could have been mind you, but the decision for that was made years
> ago... it's a bunch of interrupts OPAL is interested in, which Linux
> requests and sets up a handler for which just calls back into OPAL.
>
> In any case, firmwares with that property are out now.

Thanks for the confirmation!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
