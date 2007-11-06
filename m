Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 7EC5BDDEA3
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 08:04:46 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d23so310692and
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Nov 2007 13:04:45 -0800 (PST)
Message-ID: <fa686aa40711061304k4779d01cu7fd1b17d1d34e5a2@mail.gmail.com>
Date: Tue, 6 Nov 2007 14:04:44 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH v3 04/13] [POWERPC] Add generic support for simple MPC5200
	based boards
In-Reply-To: <20071106200520.10913.47002.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071106200446.10913.29338.stgit@hekate.izotz.org>
	<20071106200520.10913.47002.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/6/07, Marian Balakowicz <m8@semihalf.com> wrote:
> This patch adds support for 'mpc5200-simple-platform' compatible
> boards which do not need a platform specific setup. Such boards
> are supported assuming the following:
>
> - GPIO pins are configured by the firmware,
> - CDM configuration (clocking) is setup correctly by firmware,
> - if the 'fsl,has-wdt' property is present in one of the
>   gpt nodes, then it is safe to use such gpt to reset the board,
> - PCI is supported if enabled in the kernel configuration
>
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> ---
>
>  arch/powerpc/boot/dts/lite5200.dts           |    2 -
>  arch/powerpc/boot/dts/lite5200b.dts          |    2 -
>  arch/powerpc/platforms/52xx/Kconfig          |   18 ++++++-
>  arch/powerpc/platforms/52xx/Makefile         |    1
>  arch/powerpc/platforms/52xx/mpc5200_simple.c |   72 ++++++++++++++++++++++++++
>  5 files changed, 91 insertions(+), 4 deletions(-)
>  create mode 100644 arch/powerpc/platforms/52xx/mpc5200_simple.c
>
>
> diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
> index 6731763..5902362 100644
> --- a/arch/powerpc/boot/dts/lite5200.dts
> +++ b/arch/powerpc/boot/dts/lite5200.dts
> @@ -19,7 +19,7 @@
>  / {
>         model = "fsl,lite5200";
>         // revision = "1.0";
> -       compatible = "fsl,lite5200","generic-mpc5200";
> +       compatible = "fsl,lite5200";
>         #address-cells = <1>;
>         #size-cells = <1>;
>
> diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
> index b540388..b509129 100644
> --- a/arch/powerpc/boot/dts/lite5200b.dts
> +++ b/arch/powerpc/boot/dts/lite5200b.dts
> @@ -19,7 +19,7 @@
>  / {
>         model = "fsl,lite5200b";
>         // revision = "1.0";
> -       compatible = "fsl,lite5200b","generic-mpc5200";
> +       compatible = "fsl,lite5200b";
>         #address-cells = <1>;
>         #size-cells = <1>;
>
> diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
> index 2938d49..b8a6ebc 100644
> --- a/arch/powerpc/platforms/52xx/Kconfig
> +++ b/arch/powerpc/platforms/52xx/Kconfig
> @@ -19,6 +19,22 @@ config PPC_MPC5200_BUGFIX
>
>           It is safe to say 'Y' here
>
> +config PPC_MPC5200_SIMPLE
> +       bool "Generic support for simple MPC5200 based boards"
> +       depends on PPC_MULTIPLATFORM && PPC32
> +       select PPC_MPC5200
> +       default n
> +       help
> +         This option enables support for a simple MPC52xx based boards which
> +         do not need a custom platform specific setup. Such boards are
> +         supported assuming the following:
> +
> +         - GPIO pins are configured by the firmware,
> +         - CDM configuration (clocking) is setup correctly by firmware,
> +         - if the 'fsl,has-wdt' property is present in one of the
> +           gpt nodes, then it is safe to use such gpt to reset the board,
> +         - PCI is supported if enabled in the kernel configuration

... and there is a PCI bus node in the device tree.

I'd also add a list of the known boards that behave like this.

> +/*
> + * Called very early, MMU is off, device-tree isn't unflattened
> + */
> +static int __init mpc5200_simple_probe(void)
> +{
> +       unsigned long node = of_get_flat_dt_root();
> +
> +       if (!of_flat_dt_is_compatible(node, "mpc5200-simple-platform"))
> +               return 0;
> +       return 1;
> +}

I've thought some more about this, and I no longer think that this is
the best approach.  I think having the mpc5200 simple platform is a
good thing, but I don't think we should have the device tree claim
compatibility with "mpc5200-simple-platform"

Trying to define exactly what "mpc5200-simple-platform" describes here
and now is probably over ambitious and there is the tendency to want
it change it's meaning over time.  (just like with the compatible
field in device nodes; better to stick with real devices and not start
making stuff up).

Instead, I think we should drop "mpc5200-simple-platform" from the
device trees themselves and instead make mpc5200_simple_platform()
loop over a list of known boards that work with the simple 5200
platform.

In other words; make the assumption that it is easier to change the
kernel than it is to change the device tree.

So, do something like this:

static int __init mpc5200_simple_probe(void)
{
      const char *board[] = { "promess,motionpro", "schindler,cm5200",
"tqc,tqm5200",
NULL };
      int i = 0;

      while (board[i]) {
            if (of_flat_dt_is_compatible(node, board[i]))
                  break;
            i++;
      }

      return (board[i] != NULL);
}

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
