Return-Path: <glikely@secretlab.ca>
Received: from mail-pb0-f42.google.com (mail-pb0-f42.google.com
 [209.85.160.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 147BC2C050D
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2012 01:59:48 +1000 (EST)
Received: by pbbrp8 with SMTP id rp8so1419631pbb.15
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2012 08:59:46 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1345735866-10001-1-git-send-email-w.sang@pengutronix.de>
References: <1345735866-10001-1-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 23 Aug 2012 16:59:26 +0100
Message-ID: <CACxGe6si6a6=9511e0W_YDsQTUr98KOkqTpzYJryakcAAqQvew@mail.gmail.com>
Subject: Re: [PATCH] powerpc: dts: 52xx: drop critical IRQ from dts files
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Bonesio <bones@secretlab.ca>, linuxppc-dev@ozlabs.org,
 Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 23, 2012 at 4:31 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> The wakeup-gpios have been assigned a critical IRQ in current
> devicetrees. The PIC driver does not support critical IRQs, though, which
> leads to the following error when booting (a PCM030 in this case):
>
>         mpc52xx_irqhost_map: invalid irq: virq=16, l1=0, l2=3
>         irq: irq-16==>hwirq-0x3 mapping failed: -22
>         [WARNing skipped]
>
> Remove these entries until they are supported, if ever.

The warning is a bug since the irq specifier is valid. Removing the
irqs from the .dts files isn't the solution.

g.

>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: John Bonesio <bones@secretlab.ca>
> Cc: Anatolij Gustschin <agust@denx.de>
> ---
>  arch/powerpc/boot/dts/lite5200.dts  |    2 +-
>  arch/powerpc/boot/dts/mpc5200b.dtsi |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
> index 179a178..25adace 100644
> --- a/arch/powerpc/boot/dts/lite5200.dts
> +++ b/arch/powerpc/boot/dts/lite5200.dts
> @@ -141,7 +141,7 @@
>                 gpio@c00 {
>                         compatible = "fsl,mpc5200-gpio-wkup";
>                         reg = <0xc00 0x40>;
> -                       interrupts = <1 8 0 0 3 0>;
> +                       interrupts = <1 8 0>;
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                 };
> diff --git a/arch/powerpc/boot/dts/mpc5200b.dtsi b/arch/powerpc/boot/dts/mpc5200b.dtsi
> index 7ab286a..e610d68 100644
> --- a/arch/powerpc/boot/dts/mpc5200b.dtsi
> +++ b/arch/powerpc/boot/dts/mpc5200b.dtsi
> @@ -141,7 +141,7 @@
>                 gpio_wkup: gpio@c00 {
>                         compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
>                         reg = <0xc00 0x40>;
> -                       interrupts = <1 8 0 0 3 0>;
> +                       interrupts = <1 8 0>;
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                 };
> --
> 1.7.10.4
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
