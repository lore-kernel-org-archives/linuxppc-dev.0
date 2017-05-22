Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWgrH2dFvzDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 00:23:43 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id o12so13484410iod.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 07:23:43 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20170522140208.24652-1-javier@dowhile0.org>
References: <20170522140208.24652-1-javier@dowhile0.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 May 2017 16:23:39 +0200
Message-ID: <CAMuHMdXbhkGGFC80-39Axzv=BdEXyBNuPuHCSWW3eXWDB=SQ+w@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] eeprom: at24: Add OF device ID table
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Lunn <andrew@lunn.ch>, Wolfram Sang <wsa@the-dreams.de>,
 Tony Lindgren <tony@atomide.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Mackerras <paulus@samba.org>, Linux I2C <linux-i2c@vger.kernel.org>,
 Hongtao Jia <hongtao.jia@nxp.com>, David Lechner <david@lechnology.com>,
 Rob Herring <robh@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
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
 Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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

Hi Javier,

On Mon, May 22, 2017 at 4:01 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> This series is a follow-up to patch [0] that added an OF device ID table
> to the at24 EEPROM driver. As you suggested [1], this version instead of
> adding entries for every used <vendor,device> tuple, only adds a single
> entry for each chip type using the "atmel" vendor as a generic fallback.
>
> This is a re-spin that addresses some issues pointed out by Rob Herring.
>
> The first patch documents in the DT binding what's the correct vendor to
> use and what are the ones that are being deprecated. The second one adds
> the OF device ID table for the at24 driver and the next patches use this
> vendor in the compatible string to each DTS that defines a compatible I2C
> EEPROM device node.
>
> Patches can be applied independently since the DTS changes without driver
> changes are no-op and the OF table won't be used without the DTS changes.
>
> [0]: https://lkml.org/lkml/2017/3/14/589
> [1]: https://lkml.org/lkml/2017/3/15/99
>
> Best regards,
> Javier
>
> Changes in v4:
> - Document the manufacturers that have been deprecated (Rob Herring).
> - Only use the atmel manufacturer in the compatible string instead of
>   keeping the deprecated ones (Rob Herring).

I think you're referring to this (https://lkml.org/lkml/2017/4/19/1136)?

| > --- a/arch/arm/boot/dts/am335x-baltos.dtsi
| > +++ b/arch/arm/boot/dts/am335x-baltos.dtsi
| > @@ -255,7 +255,7 @@
| >     };
| >
| >     at24@50 {
| > -           compatible = "at24,24c02";
| > +           compatible = "at24,24c02", "atmel,24c02";
|
| I think you can just drop the at24 compatibles. A new kernel doesn't
| need it. An old kernel ignores the manufacturer. I checked that u-boot
| only matches on "atmel,*", so okay there. Don't know about the *BSDs. I
| couldn't find anything.

I think you misunderstood what Rob means.

In the case above it makes sense to drop the first compatible, as "at24" is
not a manufacturer, but refers to ATMEL's "AT24" line of i2c FLASH ROMs.

However, in cases where a real vendor/part combo is specified, like on
r8a7791-koelsch.dts:

-               compatible = "renesas,24c02";
+               compatible = "atmel,24c02";

you do want to keep the real vendor/part combo, i.e.

     compatible = "renesas,24c02", "atmel,24c02";

like in v3, which is what I gave my Reviewed-by for.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
