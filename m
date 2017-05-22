Return-Path: <javier@dowhile0.org>
Received: from mail-it0-x22b.google.com (mail-it0-x22b.google.com
 [IPv6:2607:f8b0:4001:c0b::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWlg16y1qzDqLv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 03:15:57 +1000 (AEST)
Received: by mail-it0-x22b.google.com with SMTP id r63so1484990itc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 10:15:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKj_f-jY3wi78QyAAov=a9-ReaT9qU=ytwSp+5RL0eutg@mail.gmail.com>
References: <20170522140208.24652-1-javier@dowhile0.org>
 <CAMuHMdXbhkGGFC80-39Axzv=BdEXyBNuPuHCSWW3eXWDB=SQ+w@mail.gmail.com>
 <CAL_JsqL2P=C+xRyL-BCC=RtFah4BRf8BHSvWNPZ+6r2ioSk_Yw@mail.gmail.com>
 <CABxcv==xw7UxF1Ey+hDhGb_wzgAcFR9JLm6iuirvYSTTvSxb0A@mail.gmail.com>
 <CAL_JsqKj_f-jY3wi78QyAAov=a9-ReaT9qU=ytwSp+5RL0eutg@mail.gmail.com>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Mon, 22 May 2017 19:15:54 +0200
Message-ID: <CABxcv==8R5_tG8-rsp-9UdS_5N7X8QXkd0OFnN63Ct7L2jFvhA@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] eeprom: at24: Add OF device ID table
To: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Lunn <andrew@lunn.ch>, Wolfram Sang <wsa@the-dreams.de>,
 Tony Lindgren <tony@atomide.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Mackerras <paulus@samba.org>, Linux I2C <linux-i2c@vger.kernel.org>,
 Hongtao Jia <hongtao.jia@nxp.com>, David Lechner <david@lechnology.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Magnus Damm <magnus.damm@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jason Cooper <jason@lakedaemon.net>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Jackson <mpfj@newflow.co.uk>,
 Sekhar Nori <nsekhar@ti.com>, Joachim Eastwood <manabian@gmail.com>,
 Stuart Yoder <stuart.yoder@nxp.com>,
 Scott Wood <oss@buserror.net>, Simon Horman <horms@verge.net.au>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>,
 =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Florian Larysch <fl@n621.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang <leoyang.li@nxp.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>,
 =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Rob,

Thanks a lot for your feedback.

On Mon, May 22, 2017 at 6:52 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, May 22, 2017 at 9:46 AM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:

[snip]

>>>> | >
>>>> | >     at24@50 {
>>>> | > -           compatible = "at24,24c02";
>>>> | > +           compatible = "at24,24c02", "atmel,24c02";
>>>> |
>>>> | I think you can just drop the at24 compatibles. A new kernel doesn't
>>>> | need it. An old kernel ignores the manufacturer. I checked that u-boot
>>>> | only matches on "atmel,*", so okay there. Don't know about the *BSDs. I
>>>> | couldn't find anything.
>>>>
>>>> I think you misunderstood what Rob means.
>>>>
>>>> In the case above it makes sense to drop the first compatible, as "at24" is
>>>> not a manufacturer, but refers to ATMEL's "AT24" line of i2c FLASH ROMs.
>>>>
>>>> However, in cases where a real vendor/part combo is specified, like on
>>>> r8a7791-koelsch.dts:
>>>>
>>>> -               compatible = "renesas,24c02";
>>>> +               compatible = "atmel,24c02";
>>>>
>>>> you do want to keep the real vendor/part combo, i.e.
>>>>
>>>>      compatible = "renesas,24c02", "atmel,24c02";
>>>
>>> Yes, Geert is correct.
>>>
>>
>> Sorry for misunderstanding your previous comment...
>>
>> How this should be documented in the DT binding? Should I include
>> "renesas" as a valid manufacturer or only list the used
>> <vendor,device> pairs (i.e: "renesas,24c02")?
>
> However you are handling any of the vendors. I'll have to go look.
>

The current DT binding is quite lax when describing this. From
Documentation/devicetree/bindings/eeprom/eeprom.txt:

----------------------------------
EEPROMs (I2C)

Required properties:

  - compatible : should be "<manufacturer>,<type>", like these:

"atmel,24c00", "atmel,24c01", "atmel,24c02", "atmel,24c04",
"atmel,24c08", "atmel,24c16", "atmel,24c32", "atmel,24c64",
"atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024"

"catalyst,24c32"

"microchip,24c128"

"ramtron,24c64"

"renesas,r1ex24002"

If there is no specific driver for <manufacturer>, a generic
driver based on <type> is selected. Possible types are:
"24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
"24c128", "24c256", "24c512", "24c1024", "spd"

  - reg : the I2C address of the EEPROM
----------------------------------

I think though that this is one of the cases where the Linux I2C
subsystem matching logic is leaking into the DT binding doc, since the
manufacturer prefix is ignored by the I2C core (the I2C device ID
table is used to match and to report a MODALIAS).

But I'll keep the description generic as it is now and only mention
the atmel variants (at and at24) as deprecated then.

>> I also wonder why this is really needed if AFAIU "renesas,24c02" is
>> compatible with "atmel,24c02". IOW, the driver doesn't need to
>> differentiate between the two since the devices are the same and will
>> always match using "atmel,24c02".
>
> It is needed, so that when a difference is found, it can be handled
> without updating the DT.
>

Yes, I understand this. What I tried to ask is if there could really
be a difference for the same chip type between different vendors, or
is just that people were using other manufacturers in the compatible
string as a consequence of the DT binding doc and the I2C core
ignoring the vendor prefix.

I don't mind though, I will leave the manufacturers that are different
than the atmel variants in the mainline DTS as you and Geert asked.

> Rob

Best regards,
Javier
