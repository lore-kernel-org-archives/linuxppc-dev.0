Return-Path: <timur.tabi@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.186])
	by ozlabs.org (Postfix) with ESMTP id 8ED5EDDDDF
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 10:10:33 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so3287525rnf.16
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Dec 2008 15:10:31 -0800 (PST)
Message-ID: <ed82fe3e0812031510i5bb0745axb0c515c3d62e38d8@mail.gmail.com>
Date: Wed, 3 Dec 2008 17:10:30 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/83xx: add support for MCU on 8349emitx,
	837xrdb and 8315erdb boards
In-Reply-To: <20081017185709.GB30008@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081017185709.GB30008@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 17, 2008 at 12:57 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> MCU is an external Freescale MC9S08QG8 microcontroller, mainly used to
> provide soft power-off function, but also exports two GPIOs (wired to
> the LEDs and also available from the external headers).
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Kumar, I think you merged this patch incorrectly ...

> diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
> index 7fc5414..4bdbaf4 100644
> --- a/arch/powerpc/boot/dts/mpc8349emitx.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
> @@ -91,6 +91,14 @@
>                                interrupts = <18 0x8>;
>                                interrupt-parent = <&ipic>;
>                        };
> +
> +                       mcu_pio: mcu@a {
> +                               #gpio-cells = <2>;
> +                               compatible = "fsl,mc9s08qg8-mpc8349emitx",
> +                                            "fsl,mcu-mpc8349emitx";
> +                               reg = <0x0a>;
> +                               gpio-controller;
> +                       };

This node is supposed to go under the I2C node, but you put it under
the DMA node.

-- 
Timur Tabi
Linux kernel developer at Freescale
