Return-Path: <javier@dowhile0.org>
Received: from mail-io0-x22a.google.com (mail-io0-x22a.google.com
 [IPv6:2607:f8b0:4001:c06::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj9gG55QYzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 02:19:05 +1000 (AEST)
Received: by mail-io0-x22a.google.com with SMTP id s101so6640678ioe.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 09:19:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170829084831.hsdok3ksi7anxzuc@ninjato>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170731153009.xkjknygpmckv2pfp@ninjato>
 <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
 <20170828160121.gu4wf7jqu4ditksc@ninjato>
 <CABxcv=kSiqDN1=9fSfLkyW=uuXQZAoW4dhw=fco9RyOdDuPAdA@mail.gmail.com>
 <20170829084831.hsdok3ksi7anxzuc@ninjato>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Wed, 30 Aug 2017 18:19:02 +0200
Message-ID: <CABxcv=nqbNsTs7D57VOt1-Tav_3i9U=XKn=BV=hPr1tG68eE2g@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
 Florian Larysch <fl@n621.de>, David Lechner <david@lechnology.com>,
 Rob Herring <robh+dt@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Simon Horman <horms@verge.net.au>, Michal Simek <michal.simek@xilinx.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will.deacon@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Sekhar Nori <nsekhar@ti.com>, Scott Wood <oss@buserror.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joachim Eastwood <manabian@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Magnus Damm <magnus.damm@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <kernel@pengutronix.de>,
 Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfram,

On Tue, Aug 29, 2017 at 10:48 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> I don't have a DT based system at hand now, but I'll test it again and
>> let you know probably tomorrow.
>
> I will try again today, too. Thanks!
>

Ok, I had some time to do some tests again. I used an ARM Chromebook
(Exynos Peach Pi) that has an I2C touchpad (Atmel maXTouch).

Tested the following cases:

1) Driver without OF device ID table (only a I2C table with a
"maxtouch" entry) and DTS defining a device node with a
"atmel,maxtouch" compatible string. This is the case without any of
the patches in this series.

$ modinfo drivers/input/touchscreen/atmel_mxt_ts.ko | grep maxtouch
alias:          i2c:maxtouch

$ grep maxtouch /sys/devices/platform/soc/12e00000.i2c/i2c-8/8-004b/uevent
OF_COMPATIBLE_0=atmel,maxtouch
MODALIAS=i2c:maxtouch

2) Driver without OF device ID table (only a I2C table with a
"maxtouch" entry) and DTS defining a device node with a
"atmel,maxtouch", "generic,maxtouch" compatible string. This is the
case when platform maintainers merge the DTS patches without the
driver patch.

$ modinfo drivers/input/touchscreen/atmel_mxt_ts.ko | grep maxtouch
alias:          i2c:maxtouch

$ grep maxtouch /sys/devices/platform/soc/12e00000.i2c/i2c-8/8-004b/uevent
OF_COMPATIBLE_0=atmel,maxtouch
OF_COMPATIBLE_1=generic,maxtouch
MODALIAS=i2c:maxtouch

3) Driver with an OF device ID table (with a "generic,maxtouch" entry)
and DTS defining a device node with a "atmel,maxtouch" compatible
string. This is the case when the driver patch is merged without the
DTS patches.

$ modinfo drivers/input/touchscreen/atmel_mxt_ts.ko | grep maxtouch
alias:          of:N*T*Cgeneric,maxtouchC*
alias:          of:N*T*Cgeneric,maxtouch
alias:          i2c:maxtouch

$ grep maxtouch /sys/devices/platform/soc/12e00000.i2c/i2c-8/8-004b/uevent
OF_COMPATIBLE_0=atmel,maxtouch
MODALIAS=i2c:maxtouch

4) Driver with an OF device ID table (with a "generic,maxtouch" entry)
and DTS defining a device node with a "atmel,maxtouch",
"generic,maxtouch" compatible string. This is the case when both the
DTS and driver patches are merged.

$ modinfo drivers/input/touchscreen/atmel_mxt_ts.ko | grep maxtouch
alias:          of:N*T*Cgeneric,maxtouchC*
alias:          of:N*T*Cgeneric,maxtouch
alias:          i2c:maxtouch

$ grep maxtouch /sys/devices/platform/soc/12e00000.i2c/i2c-8/8-004b/uevent
OF_COMPATIBLE_0=atmel,maxtouch
OF_COMPATIBLE_1=generic,maxtouch
MODALIAS=i2c:maxtouch

For all cases module autoload, driver probe and evtest worked for me.

You said that (3) doesn't work but I don't understand why is failing
for you. Probably I'm missing something.

Best regards,
Javier
