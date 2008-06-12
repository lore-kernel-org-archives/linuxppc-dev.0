Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 15A51DDE41
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 16:36:18 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so2090132ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 23:36:17 -0700 (PDT)
Message-ID: <fa686aa40806112336n6b997b7dw94d471ed680d18a2@mail.gmail.com>
Date: Thu, 12 Jun 2008 00:36:17 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Jander" <david.jander@protonic.nl>
Subject: Re: [PATCH 1/2] Added support for PRTLVT based boards (MPC5121)
In-Reply-To: <200806111143.08905.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806111143.08905.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Looking good.  A few more comments below.

On Wed, Jun 11, 2008 at 3:43 AM, David Jander <david.jander@protonic.nl> wrote:
>
> Made MPC5121_ADS board support generic

This description isn't verbose enough.  Describe what this patch
changes in more detail please.

>
> Signed-off-by: David Jander <david@protonic.nl>
> ---
> diff --git a/arch/powerpc/boot/dts/prtlvt.dts b/arch/powerpc/boot/dts/prtlvt.dts
> new file mode 100644
> index 0000000..93d2fa2
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/prtlvt.dts
> @@ -0,0 +1,267 @@
> +       soc@80000000 {
> +               compatible = "fsl,mpc5121-immr";

As Scott mentioned, this should be:

compatible = "fsl,mpc5121-immr", "simple-bus";

> +               //axe@2000 {
> +               //      compatible = "mpc512x-axe";

Even though this is commented out; the compatible value is in the wrong form.

> +               // port1 using extern ULPI PHY
> +               usb@3000 {
> +                       device_type = "usb";
> +                       compatible = "fsl,fsl-usb2-dr";

Poor compatible form.  fsl,fsl-usb2-dr does not specify a particular
implementation of the device and is rather redundant.  Should probably
be:

compatible = "fsl,mpc5121-usb2-dr", "fsl-usb2-dr";

Which means: 'this is a usb-dr controller on the MPC5121, which is
also compatible with the pre-existing "fsl-usb2-dr" device tree
binding.'  "fsl-usb2-dr" is used on line 656 of fsl_soc.c.  It's not a
very good values for a compatible field (for various reasons), but it
is already in existence so it is okay to claim compatibility with it.

If this USB controller is *not* compatible with fsl-usb2-dr, then you
should not have that value.

> +               // port0 using internal UTMI PHY
> +               usb@4000 {
> +                       device_type = "usb";
> +                       compatible = "fsl,fsl-usb2-dr";

Ditto

> diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
> index 4c0da0c..67707f2 100644
> --- a/arch/powerpc/platforms/512x/Kconfig
> +++ b/arch/powerpc/platforms/512x/Kconfig
> @@ -9,11 +9,26 @@ config PPC_MPC5121
>        select PPC_MPC512x
>        default n
>
> +config MPC5121_GENERIC
> +       bool
> +       default n
> +
>  config MPC5121_ADS
>        bool "Freescale MPC5121E ADS"
>        depends on PPC_MULTIPLATFORM && PPC32
>        select DEFAULT_UIMAGE
>        select PPC_MPC5121
> +       select MPC5121_GENERIC
>        help
>          This option enables support for the MPC5121E ADS board.
>        default n
> +
> +config PRTLVT
> +       bool "Protonic LVT family of MPC5121 based boards"
> +       depends on PPC_MULTIPLATFORM && PPC32
> +       select DEFAULT_UIMAGE
> +       select PPC_MPC5121
> +       select MPC5121_GENERIC
> +       help
> +         This option enables support for the Protonic LVT family (ZANMCU and VICVT2).
> +       default n

Personally, I wouldn't bother with separate Kconfig entrys for each
supported board.  Just have a single MPC5121_GENERIC config property
and add to the help text the list of boards that it supports.  Boards
that require extra platform code can add extra Kconfig entries.

> diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
> index 232c89f..9d40a2e 100644
> --- a/arch/powerpc/platforms/512x/Makefile
> +++ b/arch/powerpc/platforms/512x/Makefile
> @@ -1,4 +1,4 @@
>  #
>  # Makefile for the Freescale PowerPC 512x linux kernel.
>  #
> -obj-$(CONFIG_MPC5121_ADS)      += mpc5121_ads.o
> +obj-$(CONFIG_MPC5121_GENERIC)  += mpc5121_generic.o
> +static int __init mpc5121_generic_probe(void)
> +{
> +       unsigned long root = of_get_flat_dt_root();
> +
> +       return of_flat_dt_is_compatible(root, "fsl,mpc5121ads") ||
> +                       of_flat_dt_is_compatible(root, "prt,prtlvt");

This list is just going to get bigger.  Maybe consider a list like is
used in arch/powerpc/platforms/52xx/mpc5200_simple.c

Otherwise, this patch is looking pretty good.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
