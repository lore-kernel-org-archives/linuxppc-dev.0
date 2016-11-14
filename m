Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-it0-x236.google.com (mail-it0-x236.google.com
 [IPv6:2607:f8b0:4001:c0b::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHS4R0QHjzDvQd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 21:51:19 +1100 (AEDT)
Received: by mail-it0-x236.google.com with SMTP id c20so75477817itb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 02:51:18 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <25057157.YlGi2v6RrE@wuerfel>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <3693445.TSdZGaiT9S@wuerfel>
 <CAMuHMdX+T=Y--F6KXZwFmZwWFdfP5mL5Tar-wKwRM2p6Hh2-sg@mail.gmail.com>
 <25057157.YlGi2v6RrE@wuerfel>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Nov 2016 11:51:15 +0100
Message-ID: <CAMuHMdWavRFnYFmiL2jy3KWZnHG_F8qaxK29zHx6fsLmqXEwiA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] soc: renesas: Identify SoC and register with the
 SoC bus
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yangbo Lu <yangbo.lu@nxp.com>, Simon Horman <horms@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Dirk Behme <dirk.behme@de.bosch.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,

On Thu, Nov 10, 2016 at 12:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday, November 10, 2016 11:19:20 AM CET Geert Uytterhoeven wrote:
>> On Wed, Nov 9, 2016 at 5:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Monday, October 31, 2016 12:30:55 PM CET Geert Uytterhoeven wrote:
>> >> v2:
>> >>   - Drop SoC families and family names; use fixed "Renesas" instead,
>> >
>> > I think I'd rather have seen the family names left in there, but it's
>> > not important, so up to you.
>>
>> They're not useful for matching, as family names may change anytime, and don't
>> always say much about the hardware capabilities.
>> E.g. SH-Mobile -> R-Mobile -> R-Car | RZ/A | RZ/G
>> Some SH-Mobile (even some R-Car) parts are SuperH only, others have ARM and
>> SuperH.
>>
>> At least the SoC part numbers are stable (hmm, sh73a0 == r8a73a0).
>
> I think the marketing names are much more useful for humans looking
> at the sysfs files than the kernel doing matching on, but both use
> cases are important.

OK, I'll re-add the family names for humans reading sysfs.

>> >>   - Use "renesas,prr" and "renesas,cccr" device nodes in DT if
>> >>     available, else fall back to hardcoded addresses for compatibility
>> >>     with existing DTBs,

>> > It does seem wrong to have a device node for a specific register though.
>> > Shouldn't the node be for the block of registers that these are inside
>> > of?
>>
>> On R-Mobile APE6, R-Car Gen2 and Gen3, PRR is a lone register.
>> On R-Car Gen1, it's not even documented (and doesn't exist on all parts).
>
> It just seems odd to have it at address 0xff000044 when all the other
> devices are at page-aligned addresses. Do you mean that accessing
> 0xff000040 or 0xff000048 will result in a bus-level exception for a
> missing register and just 0xff000044 is actually valid for access,
> or is it just the only thing that is documented?

For PRR, all other registers in the page read as all zeroes on all SoCs that
have it. So it really is a lone register.

>> On SH-Mobile/R-Mobile, CCCR may be part of the HPB/APB register block, which
>> we further don't touch at all.
>> On R-Car Gen2, it's not documented, but does exist.
>
> This is where the family names would come in handy ;-) I now have
> no idea which chip(s) you are referring to.

SH/R-Mobile are r8a7740, r8a73a4, sh73a0.
R-Car Gen2 are r8a779[0-4].

> If you know the name of the register block, just put it into DT with
> that name. The driver can trivially add the right offset.

CCCR is different. The amount of registers that read as non-zero depends a lot
on the actual SoC.

HPB/APB is gonna need real DT bindings, which needs some more investigation.
Hence if you don't mind, I'd like to postpone that part, which only affects
the older SoCs. And I'll drop the "renesas,cccr" binding.

For now, having revision detection for R-Car Gen3 (r8a779[56]) using PRR is
most urgent, as several drivers (e.g. HDMI, Ethernet, clocks, pinctrl) are
waiting for this support. So I'd like to have that dependency in v4.10.

>> >>   - Don't register the SoC bus if the chip ID register is missing,
>> >
>> > Why? My objection was to hardcoding the register, not to registering
>> > the device? I think I'd rather see the device registered with an
>> > empty revision string.
>>
>> If there's no chip ID register, there's no reason to use soc_device_match(),
>> as we can always look at a compatible value. All SoCs listed in this driver
>> have a chip ID register.
>
> But you may still have user space tools looking into sysfs, e.g. to
> figure out how to install a kernel that the boot loader can find,
> or which hardware specific distro packages to install.
>
>> if you want me to register the soc_bus for  those SoCs regardless, I want to
>> re-add r7s72100 (RZ/A) and r8a7778 (R-Car M1A), who don't have chip ID
>> registers ;-)
>
> Right. Just don't encode too much knowledge about the SoCs into the
> driver, so we are prepared for adding new ones: We should still look
> for the registers in DT on all chips.

OK, will re-add.

>> >> +static int __init renesas_soc_init(void)
>> >> +{
>> >> +       struct soc_device_attribute *soc_dev_attr;
>> >> +       const struct of_device_id *match;
>> >> +       void __iomem *chipid = NULL;
>> >> +       struct soc_device *soc_dev;
>> >> +       struct device_node *np;
>> >> +       unsigned int product;
>> >> +
>> >> +       np = of_find_matching_node_and_match(NULL, renesas_socs, &match);
>> >> +       if (!np)
>> >> +               return -ENODEV;
>> >> +
>> >> +       of_node_put(np);
>> >> +
>> >> +       /* Try PRR first, then CCCR, then hardcoded fallback */
>> >> +       np = of_find_compatible_node(NULL, NULL, "renesas,prr");
>> >> +       if (!np)
>> >> +               np = of_find_compatible_node(NULL, NULL, "renesas,cccr");
>> >> +       if (np) {
>> >> +               chipid = of_iomap(np, 0);
>> >> +               of_node_put(np);
>> >> +       } else if (match->data) {
>> >> +               chipid = ioremap((uintptr_t)match->data, 4);
>> >> +       }
>> >> +       if (!chipid)
>> >>
>> >
>> > Here, I'd turn the order around and look for the DT nodes of the
>> > devices first. Only if they are not found, look at the compatible
>> > string of the root node. No need to search for a node though,
>> > you know which one it is when you look for a compatible =
>> > "renesas,r8a73a4".
>>
>> "renesas,r8a73a4" is the root node, not the device, so it does not have the
>> "reg" property for reading the chip ID?
>
> I mean replace of_find_matching_node_and_match() with
> of_match_node(renesas_socs, of_root).
>
> It does the same thing, just more efficiently.

OK (didn't know "of_root" was available for public use ;-)

>> There is no SoC part number in the "renesas,prr" and "renesas,cccr" nodes.
>> Hence I always need to look at the root nodes.
>
> Not sure what that would protect you from. Could you have a renesas,cccr

Looks like you forgot to finish your sentence?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
