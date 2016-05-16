Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7kqY750NzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 01:27:53 +1000 (AEST)
Date: Mon, 16 May 2016 10:27:46 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>,
 Alexandre Courbot <gnurou@gmail.com>,
 Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: dt-bindings: add ibm,ppc4xx-gpio binding
Message-ID: <20160516152746.GA13649@rob-hp-laptop>
References: <c7b118c342c161954126e2e82cf1a0a6a127b4c2.1463002267.git.chunkeey@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c7b118c342c161954126e2e82cf1a0a6a127b4c2.1463002267.git.chunkeey@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 12, 2016 at 12:07:48AM +0200, Christian Lamparter wrote:
> This patch adds binding information for IBM/AMCC/APM GPIO
> Controllers of the PowerPC 4XX series and compatible SoCs.
> 
> The "PowerPC 405EP Embedded Processor Data Sheet" has the
> following to say about the GPIO controllers: "
> 
>  - Controller functions and GPIO registers are programmed
>    and accessed via memory-mapped OPB bus master accesses
> 
>  - All GPIOs are pin-shared with other functions. DCRs control
>    whether a particular pin that has GPIO capabilities acts
>    as a GPIO or is used for another purpose.
> 
>  - Each GPIO outputs is separately programmable to emulate
>    an open-drain driver (i.e. drives to zero, threestated if
>    output bit is 1)
> 
> "
> The ppc4xx_gpio.c driver is part of the platform/sysdev drivers
> in arch/powerpc/sysdev.
> 
> Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
> ---
> I looked into arch/powerpc/sysdev/ppc4xx_gpio.c driver and
> it doesn't have support for the tri-state logic (open drain
> is disabled), but the hardware would support it.
> (the #gpio-cells description suffers because of this, since
> the high-z option isn't there).
> 
> Also there's another problem: There's no DCR pinmux driver?!
> So sadly, there's not much information on how to use the DCRs
> to control the which pin is muxed to the GPIO or to a SoC
> function like the i2c.
> 
> This was all the valuable information I could find about the
> hardware, so it is included it in the binding text, even
> though there's no support for it... Is there anything else
> to add?
> ---
>  .../devicetree/bindings/gpio/ibm,ppc4xx-gpio.txt   | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/ibm,ppc4xx-gpio.txt

Normally, we don't allow wildcards for compatible strings, but given 
this is an established binding it is okay.

Acked-by: Rob Herring <robh@kernel.org>
