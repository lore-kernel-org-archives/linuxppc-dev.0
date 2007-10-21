Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 66AA6DDE9F
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 02:54:35 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1115945wag
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Oct 2007 09:54:33 -0700 (PDT)
Message-ID: <fa686aa40710210954v3337e82cnf14a487427ecfccc@mail.gmail.com>
Date: Sun, 21 Oct 2007 10:54:33 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH v2 2/4] [POWERPC] Update device tree binding for mpc5200
	gpt
In-Reply-To: <20071018184424.3584.77643.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071018184407.3584.3513.stgit@hekate.izotz.org>
	<20071018184424.3584.77643.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/18/07, Marian Balakowicz <m8@semihalf.com> wrote:
> Add 'fsl,' prefix to 'compatible' property for gpt nodes.
> Add 'fsl,' prefix to empty, GPT0 specific 'has-wdt' property.

Patch doesn't apply; mpc5200_wdt.c watchdog driver is not in the
kernel.  I'll pick up the dts change, but you'll need to coordinate w/
Domen to get the needed changes into his driver before it's picked for
mainline.

Cheers,
g.

>
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> ---
>
>  .../powerpc/mpc52xx-device-tree-bindings.txt       |    4 ++-
>  arch/powerpc/boot/dts/lite5200.dts                 |   26 +++++++-------------
>  arch/powerpc/boot/dts/lite5200b.dts                |   26 +++++++-------------
>  drivers/char/watchdog/mpc5200_wdt.c                |    3 ++
>  4 files changed, 23 insertions(+), 36 deletions(-)
>
>
> diff --git a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt b/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
> index e59fcbb..fedf7ef 100644
> --- a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
> +++ b/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
> @@ -185,7 +185,7 @@ bestcomm@<addr>     dma-controller          mpc5200-bestcomm 5200 pic also requires
>  Recommended soc5200 child nodes; populate as needed for your board
>  name           device_type     compatible        Description
>  ----           -----------     ----------        -----------
> -gpt@<addr>     gpt             mpc5200-gpt       General purpose timers
> +gpt@<addr>     gpt             fsl,mpc5200-gpt   General purpose timers
>  rtc@<addr>     rtc             mpc5200-rtc       Real time clock
>  mscan@<addr>   mscan           mpc5200-mscan     CAN bus controller
>  pci@<addr>     pci             mpc5200-pci       PCI bridge
> @@ -213,7 +213,7 @@ cell-index  int             When multiple devices are present, is the
>  5) General Purpose Timer nodes (child of soc5200 node)
>  On the mpc5200 and 5200b, GPT0 has a watchdog timer function.  If the board
>  design supports the internal wdt, then the device node for GPT0 should
> -include the empty property 'has-wdt'.
> +include the empty property 'fsl,has-wdt'.
>
>  6) PSC nodes (child of soc5200 node)
>  PSC nodes can define the optional 'port-number' property to force assignment
> diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
> index bc45f5f..6731763 100644
> --- a/arch/powerpc/boot/dts/lite5200.dts
> +++ b/arch/powerpc/boot/dts/lite5200.dts
> @@ -70,18 +70,16 @@
>                 };
>
>                 gpt@600 {       // General Purpose Timer
> -                       compatible = "mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200-gpt";
>                         cell-index = <0>;
>                         reg = <600 10>;
>                         interrupts = <1 9 0>;
>                         interrupt-parent = <&mpc5200_pic>;
> -                       has-wdt;
> +                       fsl,has-wdt;
>                 };
>
>                 gpt@610 {       // General Purpose Timer
> -                       compatible = "mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200-gpt";
>                         cell-index = <1>;
>                         reg = <610 10>;
>                         interrupts = <1 a 0>;
> @@ -89,8 +87,7 @@
>                 };
>
>                 gpt@620 {       // General Purpose Timer
> -                       compatible = "mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200-gpt";
>                         cell-index = <2>;
>                         reg = <620 10>;
>                         interrupts = <1 b 0>;
> @@ -98,8 +95,7 @@
>                 };
>
>                 gpt@630 {       // General Purpose Timer
> -                       compatible = "mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200-gpt";
>                         cell-index = <3>;
>                         reg = <630 10>;
>                         interrupts = <1 c 0>;
> @@ -107,8 +103,7 @@
>                 };
>
>                 gpt@640 {       // General Purpose Timer
> -                       compatible = "mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200-gpt";
>                         cell-index = <4>;
>                         reg = <640 10>;
>                         interrupts = <1 d 0>;
> @@ -116,8 +111,7 @@
>                 };
>
>                 gpt@650 {       // General Purpose Timer
> -                       compatible = "mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200-gpt";
>                         cell-index = <5>;
>                         reg = <650 10>;
>                         interrupts = <1 e 0>;
> @@ -125,8 +119,7 @@
>                 };
>
>                 gpt@660 {       // General Purpose Timer
> -                       compatible = "mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200-gpt";
>                         cell-index = <6>;
>                         reg = <660 10>;
>                         interrupts = <1 f 0>;
> @@ -134,8 +127,7 @@
>                 };
>
>                 gpt@670 {       // General Purpose Timer
> -                       compatible = "mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200-gpt";
>                         cell-index = <7>;
>                         reg = <670 10>;
>                         interrupts = <1 10 0>;
> diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
> index 6582c9a..b540388 100644
> --- a/arch/powerpc/boot/dts/lite5200b.dts
> +++ b/arch/powerpc/boot/dts/lite5200b.dts
> @@ -70,18 +70,16 @@
>                 };
>
>                 gpt@600 {       // General Purpose Timer
> -                       compatible = "mpc5200b-gpt","mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>                         cell-index = <0>;
>                         reg = <600 10>;
>                         interrupts = <1 9 0>;
>                         interrupt-parent = <&mpc5200_pic>;
> -                       has-wdt;
> +                       fsl,has-wdt;
>                 };
>
>                 gpt@610 {       // General Purpose Timer
> -                       compatible = "mpc5200b-gpt","mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>                         cell-index = <1>;
>                         reg = <610 10>;
>                         interrupts = <1 a 0>;
> @@ -89,8 +87,7 @@
>                 };
>
>                 gpt@620 {       // General Purpose Timer
> -                       compatible = "mpc5200b-gpt","mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>                         cell-index = <2>;
>                         reg = <620 10>;
>                         interrupts = <1 b 0>;
> @@ -98,8 +95,7 @@
>                 };
>
>                 gpt@630 {       // General Purpose Timer
> -                       compatible = "mpc5200b-gpt","mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>                         cell-index = <3>;
>                         reg = <630 10>;
>                         interrupts = <1 c 0>;
> @@ -107,8 +103,7 @@
>                 };
>
>                 gpt@640 {       // General Purpose Timer
> -                       compatible = "mpc5200b-gpt","mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>                         cell-index = <4>;
>                         reg = <640 10>;
>                         interrupts = <1 d 0>;
> @@ -116,8 +111,7 @@
>                 };
>
>                 gpt@650 {       // General Purpose Timer
> -                       compatible = "mpc5200b-gpt","mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>                         cell-index = <5>;
>                         reg = <650 10>;
>                         interrupts = <1 e 0>;
> @@ -125,8 +119,7 @@
>                 };
>
>                 gpt@660 {       // General Purpose Timer
> -                       compatible = "mpc5200b-gpt","mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>                         cell-index = <6>;
>                         reg = <660 10>;
>                         interrupts = <1 f 0>;
> @@ -134,8 +127,7 @@
>                 };
>
>                 gpt@670 {       // General Purpose Timer
> -                       compatible = "mpc5200b-gpt","mpc5200-gpt";
> -                       device_type = "gpt";
> +                       compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>                         cell-index = <7>;
>                         reg = <670 10>;
>                         interrupts = <1 10 0>;
> diff --git a/drivers/char/watchdog/mpc5200_wdt.c b/drivers/char/watchdog/mpc5200_wdt.c
> index 9cfb975..11f6a11 100644
> --- a/drivers/char/watchdog/mpc5200_wdt.c
> +++ b/drivers/char/watchdog/mpc5200_wdt.c
> @@ -176,6 +176,8 @@ static int mpc5200_wdt_probe(struct of_device *op, const struct of_device_id *ma
>
>         has_wdt = of_get_property(op->node, "has-wdt", NULL);
>         if (!has_wdt)
> +               has_wdt = of_get_property(op->node, "fsl,has-wdt", NULL);
> +       if (!has_wdt)
>                 return -ENODEV;
>
>         wdt = kzalloc(sizeof(*wdt), GFP_KERNEL);
> @@ -254,6 +256,7 @@ static int mpc5200_wdt_shutdown(struct of_device *op)
>
>  static struct of_device_id mpc5200_wdt_match[] = {
>         { .compatible = "mpc5200-gpt", },
> +       { .compatible = "fsl,mpc5200-gpt", },
>         {},
>  };
>  static struct of_platform_driver mpc5200_wdt_driver = {
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
