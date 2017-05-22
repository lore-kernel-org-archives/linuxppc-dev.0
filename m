Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWpf95YrXzDqLf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 05:30:25 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id 12so14255550iol.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 12:30:25 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CABxcv==8R5_tG8-rsp-9UdS_5N7X8QXkd0OFnN63Ct7L2jFvhA@mail.gmail.com>
References: <20170522140208.24652-1-javier@dowhile0.org>
 <CAMuHMdXbhkGGFC80-39Axzv=BdEXyBNuPuHCSWW3eXWDB=SQ+w@mail.gmail.com>
 <CAL_JsqL2P=C+xRyL-BCC=RtFah4BRf8BHSvWNPZ+6r2ioSk_Yw@mail.gmail.com>
 <CABxcv==xw7UxF1Ey+hDhGb_wzgAcFR9JLm6iuirvYSTTvSxb0A@mail.gmail.com>
 <CAL_JsqKj_f-jY3wi78QyAAov=a9-ReaT9qU=ytwSp+5RL0eutg@mail.gmail.com>
 <CABxcv==8R5_tG8-rsp-9UdS_5N7X8QXkd0OFnN63Ct7L2jFvhA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 May 2017 21:30:22 +0200
Message-ID: <CAMuHMdVaY6J04TL=cEBVkCx=qhQuvbprxXt4VCjh_oEedRYnzg@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] eeprom: at24: Add OF device ID table
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Rob Herring <robh@kernel.org>,
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

Hi Javier,

On Mon, May 22, 2017 at 7:15 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>>> I also wonder why this is really needed if AFAIU "renesas,24c02" is
>>> compatible with "atmel,24c02". IOW, the driver doesn't need to
>>> differentiate between the two since the devices are the same and will
>>> always match using "atmel,24c02".
>>
>> It is needed, so that when a difference is found, it can be handled
>> without updating the DT.
>
> Yes, I understand this. What I tried to ask is if there could really
> be a difference for the same chip type between different vendors, or
> is just that people were using other manufacturers in the compatible
> string as a consequence of the DT binding doc and the I2C core
> ignoring the vendor prefix.

The devices from different vendors are not the same. They contain FLASH
ROM of a specific size, and glue logic to expose an i2c slave
interface providing
an AT24-compatible command set.  They should behave similar within
the limits of the AT24 "spec".  But the actual implementation may be different.

> I don't mind though, I will leave the manufacturers that are different
> than the atmel variants in the mainline DTS as you and Geert asked.

OK, thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
