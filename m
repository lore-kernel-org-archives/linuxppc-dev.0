Return-Path: <mturquette@linaro.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA1B42C01A2
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 09:41:49 +1000 (EST)
Received: by mail-pd0-f169.google.com with SMTP id y11so1179679pdj.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Aug 2013 16:41:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Anatolij Gustschin <agust@denx.de>, linux-arm-kernel@lists.infradead.org,
 devicetree-discuss@lists.ozlabs.org
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1374495298-22019-18-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-18-git-send-email-gsi@denx.de>
Message-ID: <20130802234143.6450.39877@quantum>
Subject: Re: [PATCH v3 17/31] clk: mpc512x: introduce COMMON_CLK for MPC512x
Date: Fri, 02 Aug 2013 16:41:43 -0700
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Gerhard Sittig (2013-07-22 05:14:44)
> this change implements a clock driver for the MPC512x PowerPC platform
> which follows the COMMON_CLK approach and uses common clock drivers
> shared with other platforms
> =

> this driver implements the publicly announced set of clocks (which can
> get referenced by means of symbolic identifiers from the dt-bindings
> header file), as well as generates additional 'struct clk' items where
> the SoC hardware cannot easily get mapped to the common primitives of
> the clock API, or requires "intermediate" clock nodes to represent
> clocks that have both gates and dividers
> =

> the previous PPC_CLOCK implementation is kept in place and remains in
> parallel to the common clock implementation for test and comparison
> during migration, a compile time option picks one of the two
> alternatives (Kconfig switch, common clock used by default)
> =

> some of the clock items get pre-enabled in the clock driver to not have
> them automatically disabled by the underlying clock subsystem because of
> their being unused -- this approach is desirable because
> - some of the clocks are useful to have for diagnostics and information
>   despite their not getting claimed by any drivers (CPU, internal and
>   external RAM, internal busses, boot media)
> - some of the clocks aren't claimed by their peripheral drivers yet,
>   either because of missing driver support or because device tree specs
>   aren't available yet (but the workarounds will get removed as the
>   drivers get adjusted and the device tree provides the clock specs)
> - some help introduce support for and migrate to the common
>   infrastructure, while more appropriate support for specific hardware
>   constraints isn't available yet (remaining changes are strictly
>   internal to the clock driver and won't affect peripheral drivers)
> =

> clkdev registration provides "alias names" for few clock items
> - to not break those peripheral drivers which encode their component
>   index into the name that is used for clock lookup (UART, SPI, USB)
> - to not break those drivers which use names for the clock lookup which
>   were encoded in the previous PPC_CLOCK implementation (NFC, VIU, CAN)
> this workaround will get removed as these drivers get adjusted after
> device tree based clock lookup has become available
> =

> Signed-off-by: Gerhard Sittig <gsi@denx.de>

Hi Gerhard,

This looks OK to me. Do you want me to take it or will you keep the
series together? Note that I took "clk: wrap I/O access for improved
portability" into the clk tree already.

Regards,
Mike

> ---
>  arch/powerpc/platforms/512x/Kconfig           |   14 +-
>  arch/powerpc/platforms/512x/Makefile          |    4 +-
>  arch/powerpc/platforms/512x/clock-commonclk.c |  786 +++++++++++++++++++=
++++++
>  include/linux/clk-provider.h                  |   16 +
>  4 files changed, 818 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/platforms/512x/clock-commonclk.c
> =

> diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms=
/512x/Kconfig
> index fc9c1cb..c5fcdd0 100644
> --- a/arch/powerpc/platforms/512x/Kconfig
> +++ b/arch/powerpc/platforms/512x/Kconfig
> @@ -1,9 +1,21 @@
> +config MPC512x_COMMON_CLK
> +       bool "MPC512x platform uses COMMON_CLK"
> +       default y
> +       depends on PPC_MPC512x
> +       help
> +         This option is only here to support tests and comparison
> +         during development and migration.  This option will get
> +         removed after the COMMON_CLK support for MPC512x has become
> +         fully operational and all drivers were adjusted to explicitly
> +         acquire their required clocks.
> +
>  config PPC_MPC512x
>         bool "512x-based boards"
>         depends on 6xx
>         select FSL_SOC
>         select IPIC
> -       select PPC_CLOCK
> +       select PPC_CLOCK if !MPC512x_COMMON_CLK
> +       select COMMON_CLK if MPC512x_COMMON_CLK
>         select PPC_PCI_CHOICE
>         select FSL_PCI if PCI
>         select ARCH_WANT_OPTIONAL_GPIOLIB
> diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platform=
s/512x/Makefile
> index 72fb934..1e05f9d 100644
> --- a/arch/powerpc/platforms/512x/Makefile
> +++ b/arch/powerpc/platforms/512x/Makefile
> @@ -1,7 +1,9 @@
>  #
>  # Makefile for the Freescale PowerPC 512x linux kernel.
>  #
> -obj-y                          +=3D clock.o mpc512x_shared.o
> +obj-$(CONFIG_PPC_CLOCK)                +=3D clock.o
> +obj-$(CONFIG_COMMON_CLK)       +=3D clock-commonclk.o
> +obj-y                          +=3D mpc512x_shared.o
>  obj-$(CONFIG_MPC5121_ADS)      +=3D mpc5121_ads.o mpc5121_ads_cpld.o
>  obj-$(CONFIG_MPC512x_GENERIC)  +=3D mpc512x_generic.o
>  obj-$(CONFIG_PDM360NG)         +=3D pdm360ng.o
> diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc=
/platforms/512x/clock-commonclk.c
> new file mode 100644
> index 0000000..762ee85
> --- /dev/null
> +++ b/arch/powerpc/platforms/512x/clock-commonclk.c
> @@ -0,0 +1,786 @@
> +/*
> + * Copyright (C) 2013 DENX Software Engineering
> + *
> + * Gerhard Sittig, <gsi@denx.de>
> + *
> + * common clock driver support for the MPC512x platform
> + *
> + * This is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +
> +#include <asm/mpc5121.h>
> +#include <dt-bindings/clock/mpc512x-clock.h>
> +
> +#include "mpc512x.h"           /* our public mpc5121_clk_init() API */
> +
> +/* helpers to keep the MCLK intermediates "somewhere" in our table */
> +enum {
> +       MCLK_IDX_MUX0,
> +       MCLK_IDX_EN0,
> +       MCLK_IDX_DIV0,
> +       MCLK_IDX_MUX1,
> +       MCLK_MAX_IDX,
> +};
> +
> +#define NR_PSCS                        12
> +#define NR_MSCANS              4
> +#define NR_SPDIFS              1
> +#define NR_MCLKS               (NR_PSCS + NR_MSCANS + NR_SPDIFS)
> +
> +/* extend the public set of clocks by adding internal slots for manageme=
nt */
> +enum {
> +       /* arrange for adjacent numbers after the public set */
> +       MPC512x_CLK_START_PRIVATE =3D MPC512x_CLK_LAST_PUBLIC,
> +       /* clocks which aren't announced to the public */
> +       MPC512x_CLK_DDR,
> +       MPC512x_CLK_MEM,
> +       MPC512x_CLK_IIM,
> +       MPC512x_CLK_SDHC_2,
> +       /* intermediates in div+gate combos or fractional dividers */
> +       MPC512x_CLK_DDR_UG,
> +       MPC512x_CLK_SDHC_x4,
> +       MPC512x_CLK_SDHC_UG,
> +       MPC512x_CLK_DIU_x4,
> +       MPC512x_CLK_DIU_UG,
> +       MPC512x_CLK_MBX_BUS_UG,
> +       MPC512x_CLK_MBX_UG,
> +       MPC512x_CLK_MBX_3D_UG,
> +       MPC512x_CLK_PCI_UG,
> +       MPC512x_CLK_NFC_UG,
> +       MPC512x_CLK_LPC_UG,
> +       MPC512x_CLK_SPDIF_TX_IN,
> +       /* intermediates for the mux+gate+div+mux MCLK generation */
> +       MPC512x_CLK_MCLKS_FIRST,
> +       MPC512x_CLK_MCLKS_LAST =3D MPC512x_CLK_MCLKS_FIRST
> +                               + NR_MCLKS * MCLK_MAX_IDX,
> +       /* internal, symbolic spec for the number of slots */
> +       MPC512x_CLK_LAST_PRIVATE,
> +};
> +
> +/* data required for the OF clock provider registration */
> +static struct clk *clks[MPC512x_CLK_LAST_PRIVATE];
> +static struct clk_onecell_data clk_data;
> +
> +/* CCM register access */
> +static struct mpc512x_ccm __iomem *clkregs;
> +static DEFINE_SPINLOCK(clklock);
> +
> +/* convenience wrappers around the common clk API */
> +static inline struct clk *mpc512x_clk_fixed(const char *name, int rate)
> +{
> +       return clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rat=
e);
> +}
> +
> +static inline struct clk *mpc512x_clk_factor(
> +       const char *name, const char *parent_name,
> +       int mul, int div)
> +{
> +       int clkflags;
> +
> +       clkflags =3D CLK_SET_RATE_PARENT;
> +       return clk_register_fixed_factor(NULL, name, parent_name, clkflag=
s,
> +                                        mul, div);
> +}
> +
> +static inline struct clk *mpc512x_clk_divider(
> +       const char *name, const char *parent_name, u8 clkflags,
> +       u32 __iomem *reg, u8 pos, u8 len, int divflags)
> +{
> +       return clk_register_divider(NULL, name, parent_name, clkflags,
> +                                   reg, pos, len, divflags, &clklock);
> +}
> +
> +static inline struct clk *mpc512x_clk_divtable(
> +       const char *name, const char *parent_name,
> +       u32 __iomem *reg, u8 pos, u8 len,
> +       const struct clk_div_table *divtab)
> +{
> +       u8 divflags;
> +
> +       divflags =3D 0;
> +       return clk_register_divider_table(NULL, name, parent_name, 0,
> +                                         reg, pos, len, divflags,
> +                                         divtab, &clklock);
> +}
> +
> +static inline struct clk *mpc512x_clk_gated(
> +       const char *name, const char *parent_name,
> +       u32 __iomem *reg, u8 pos)
> +{
> +       int clkflags;
> +
> +       clkflags =3D CLK_SET_RATE_PARENT;
> +       return clk_register_gate(NULL, name, parent_name, clkflags,
> +                                reg, pos, 0, &clklock);
> +}
> +
> +static inline struct clk *mpc512x_clk_muxed(const char *name,
> +       const char **parent_names, int parent_count,
> +       u32 __iomem *reg, u8 pos, u8 len)
> +{
> +       int clkflags;
> +       u8 muxflags;
> +
> +       clkflags =3D CLK_SET_RATE_PARENT;
> +       muxflags =3D 0;
> +       return clk_register_mux(NULL, name,
> +                               parent_names, parent_count, clkflags,
> +                               reg, pos, len, muxflags, &clklock);
> +}
> +
> +/* helper to isolate a bit field from a register */
> +static inline int get_bit_field(uint32_t __iomem *reg, uint8_t pos, uint=
8_t len)
> +{
> +       uint32_t val;
> +
> +       val =3D in_be32(reg);
> +       val >>=3D pos;
> +       val &=3D (1 << len) - 1;
> +       return val;
> +}
> +
> +/* get the SPMF and translate it into the "sys pll" multiplier */
> +static int get_spmf_mult(void)
> +{
> +       static int spmf_to_mult[] =3D {
> +               68, 1, 12, 16, 20, 24, 28, 32,
> +               36, 40, 44, 48, 52, 56, 60, 64,
> +       };
> +       int spmf;
> +
> +       spmf =3D get_bit_field(&clkregs->spmr, 24, 4);
> +       return spmf_to_mult[spmf];
> +}
> +
> +/*
> + * get the SYS_DIV value and translate it into a divide factor
> + *
> + * values returned from here are a multiple of the real factor since the
> + * divide ratio is fractional
> + */
> +static int get_sys_div_x2(void)
> +{
> +       static int sysdiv_code_to_x2[] =3D {
> +               4, 5, 6, 7, 8, 9, 10, 14,
> +               12, 16, 18, 22, 20, 24, 26, 30,
> +               28, 32, 34, 38, 36, 40, 42, 46,
> +               44, 48, 50, 54, 52, 56, 58, 62,
> +               60, 64, 66,
> +       };
> +       int divcode;
> +
> +       divcode =3D get_bit_field(&clkregs->scfr2, 26, 6);
> +       return sysdiv_code_to_x2[divcode];
> +}
> +
> +/*
> + * get the CPMF value and translate it into a multiplier factor
> + *
> + * values returned from here are a multiple of the real factor since the
> + * multiplier ratio is fractional
> + */
> +static int get_cpmf_mult_x2(void)
> +{
> +       static int cpmf_to_mult[] =3D {
> +               72, 2, 2, 3, 4, 5, 6, 7,
> +       };
> +       int cpmf;
> +
> +       cpmf =3D get_bit_field(&clkregs->spmr, 16, 4);
> +       return cpmf_to_mult[cpmf];
> +}
> +
> +/*
> + * some of the clock dividers do scale in a linear way, yet not all of
> + * their bit combinations are legal; use a divider table to get a
> + * resulting set of applicable divider values
> + */
> +
> +/* applies to the IPS_DIV, and PCI_DIV values */
> +static struct clk_div_table divtab_2346[] =3D {
> +       { .val =3D 2, .div =3D 2, },
> +       { .val =3D 3, .div =3D 3, },
> +       { .val =3D 4, .div =3D 4, },
> +       { .val =3D 6, .div =3D 6, },
> +       { .div =3D 0, },
> +};
> +
> +/* applies to the MBX_DIV, LPC_DIV, and NFC_DIV values */
> +static struct clk_div_table divtab_1234[] =3D {
> +       { .val =3D 1, .div =3D 1, },
> +       { .val =3D 2, .div =3D 2, },
> +       { .val =3D 3, .div =3D 3, },
> +       { .val =3D 4, .div =3D 4, },
> +       { .div =3D 0, },
> +};
> +
> +static int get_freq_from_dt(char *propname)
> +{
> +       struct device_node *np;
> +       const unsigned int *prop;
> +       int val;
> +
> +       val =3D 0;
> +       np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121-immr");
> +       if (np) {
> +               prop =3D of_get_property(np, propname, NULL);
> +               if (prop)
> +                       val =3D *prop;
> +           of_node_put(np);
> +       }
> +       return val;
> +}
> +
> +static void mpc512x_clk_preset_data(void)
> +{
> +       size_t i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(clks); i++)
> +               clks[i] =3D ERR_PTR(-ENODEV);
> +}
> +
> +/*
> + * - receives the "bus frequency" from the caller (that's the IPS clock
> + *   rate, the historical source of clock information)
> + * - fetches the system PLL multiplier and divider values as well as the
> + *   IPS divider value from hardware
> + * - determines the REF clock rate either from the XTAL/OSC spec (if
> + *   there is a device tree node describing the oscillator) or from the
> + *   IPS bus clock (supported for backwards compatibility, such that
> + *   setups without XTAL/OSC specs keep working)
> + * - creates the "ref" clock item in the clock tree, such that
> + *   subsequent code can create the remainder of the hierarchy (REF ->
> + *   SYS -> CSB -> IPS) from the REF clock rate and the returned mul/div
> + *   values
> + */
> +static void mpc512x_clk_setup_ref_clock(int bus_freq,
> +       int *sys_mul, int *sys_div, int *ips_div)
> +{
> +       struct clk *osc_clk;
> +       int calc_freq;
> +
> +       /* fetch mul/div factors from the hardware */
> +       *sys_mul =3D get_spmf_mult();
> +       *sys_mul *=3D 2;          /* compensate for the fractional divide=
r */
> +       *sys_div =3D get_sys_div_x2();
> +       *ips_div =3D get_bit_field(&clkregs->scfr1, 23, 3);
> +
> +       /* lookup the oscillator node */
> +       osc_clk =3D clk_get(NULL, "osc");
> +       if (osc_clk) {
> +               /* descend REF directly from OSC, verify the IPS rate */
> +               clks[MPC512x_CLK_REF] =3D mpc512x_clk_factor("ref", "osc"=
, 1, 1);
> +               calc_freq =3D clk_get_rate(clks[MPC512x_CLK_REF]);
> +               calc_freq *=3D *sys_mul;
> +               calc_freq /=3D *sys_div;
> +               calc_freq /=3D 2;
> +               calc_freq /=3D *ips_div;
> +               if (bus_freq && calc_freq !=3D bus_freq)
> +                       pr_warn("calc rate %d !=3D OF spec %d\n",
> +                               calc_freq, bus_freq);
> +       } else {
> +               /* calculate OSC rate and create REF from the freq value =
*/
> +               calc_freq =3D bus_freq;   /* start with IPS */
> +               calc_freq *=3D *ips_div;  /* IPS -> CSB */
> +               calc_freq *=3D 2;         /* CSB -> SYS */
> +               calc_freq *=3D *sys_div;  /* SYS -> PLL out */
> +               calc_freq /=3D *sys_mul;  /* PLL out -> REF =3D=3D OSC */
> +               clks[MPC512x_CLK_REF] =3D mpc512x_clk_fixed("ref", calc_f=
req);
> +       }
> +}
> +
> +/*
> + * helper code for the MCLK subtree setup
> + *
> + * the overview in section 5.2.4 of the MPC5121e Reference Manual rev4
> + * suggests that all instances of the "PSC clock generation" are equal,
> + * and that one might re-use the PSC setup for MSCAN clock generation
> + * (section 5.2.5) as well, at least the logic if not the data for
> + * description
> + *
> + * the details (starting at page 5-20) show differences in the specific
> + * inputs of the first mux stage ("can clk in", "spdif tx"), and the
> + * factual non-availability of the second mux stage (it's present yet
> + * only one input is valid)
> + *
> + * the MSCAN clock related registers (starting at page 5-35) all
> + * reference "spdif clk" at the first mux stage and don't mention any
> + * "can clk" at all, which somehow is unexpected
> + *
> + * TODO re-check the document, and clarify whether the RM is correct in
> + * the overview or in the details, and whether the difference is a
> + * clipboard induced error or results from chip revisions
> + *
> + * it turns out that the RM rev4 as of 2012-06 talks about "can" for the
> + * PSCs while RM rev3 as of 2008-10 talks about "spdif", so I guess that
> + * first a doc update is required which better reflects reality in the
> + * SoC before the implementation should follow while no questions remain
> + */
> +
> +/*
> + * note that this declaration raises a checkpatch warning, but
> + * it's the very data type which <linux/clk-provider.h> expects,
> + * making this declaration pass checkpatch will break compilation
> + */
> +static const char *parent_names_mux0[] =3D {
> +       "sys", "ref", "psc-mclk-in", "spdif-tx",
> +};
> +
> +enum mclk_type {
> +       MCLK_TYPE_PSC,
> +       MCLK_TYPE_MSCAN,
> +       MCLK_TYPE_SPDIF,
> +};
> +
> +struct mclk_setup_data {
> +       enum mclk_type type;
> +       int comp_idx;
> +       bool has_mclk1;
> +       int bit_sccr1, bit_sccr2;
> +       const char *name_mux0;
> +       const char *name_en0;
> +       const char *name_div0;
> +       const char *parent_names_mux1[2];
> +       const char *name_mux1;
> +       const char *name_mclk;
> +};
> +
> +#define MCLK_SETUP_DATA_PSC(id) { \
> +       MCLK_TYPE_PSC, id, \
> +       0, 27 - id, -1, \
> +       "psc" #id "-mux0", \
> +       "psc" #id "-en0", \
> +       "psc" #id "_mclk_div", \
> +       { "psc" #id "_mclk_div", "dummy", }, \
> +       "psc" #id "_mclk_out", \
> +       "psc" #id "_mclk", \
> +}
> +
> +#define MCLK_SETUP_DATA_MSCAN(id) { \
> +       MCLK_TYPE_MSCAN, id, \
> +       0, -1, 25, \
> +       "mscan" #id "-mux0", \
> +       "mscan" #id "-en0", \
> +       "mscan" #id "_mclk_div", \
> +       { "mscan" #id "_mclk_div", "dummy", }, \
> +       "mscan" #id "_mclk_out", \
> +       "mscan" #id "_mclk", \
> +}
> +
> +#define MCLK_SETUP_DATA_SPDIF { \
> +       MCLK_TYPE_SPDIF, 0, \
> +       1, -1, 23, \
> +       "spdif-mux0", \
> +       "spdif-en0", \
> +       "spdif_mclk_div", \
> +       { "spdif_mclk_div", "spdif-rx", }, \
> +       "spdif_mclk_out", \
> +       "spdif_mclk", \
> +}
> +
> +static struct mclk_setup_data mclk_psc_data[] =3D {
> +       MCLK_SETUP_DATA_PSC(0),
> +       MCLK_SETUP_DATA_PSC(1),
> +       MCLK_SETUP_DATA_PSC(2),
> +       MCLK_SETUP_DATA_PSC(3),
> +       MCLK_SETUP_DATA_PSC(4),
> +       MCLK_SETUP_DATA_PSC(5),
> +       MCLK_SETUP_DATA_PSC(6),
> +       MCLK_SETUP_DATA_PSC(7),
> +       MCLK_SETUP_DATA_PSC(8),
> +       MCLK_SETUP_DATA_PSC(9),
> +       MCLK_SETUP_DATA_PSC(10),
> +       MCLK_SETUP_DATA_PSC(11),
> +};
> +
> +static struct mclk_setup_data mclk_mscan_data[] =3D {
> +       MCLK_SETUP_DATA_MSCAN(0),
> +       MCLK_SETUP_DATA_MSCAN(1),
> +       MCLK_SETUP_DATA_MSCAN(2),
> +       MCLK_SETUP_DATA_MSCAN(3),
> +};
> +
> +static struct mclk_setup_data mclk_spdif_data[] =3D {
> +       MCLK_SETUP_DATA_SPDIF,
> +};
> +
> +/* setup the MCLK clock subtree of an individual PSC/MSCAN/SPDIF */
> +static void mpc512x_clk_setup_mclk(struct mclk_setup_data *entry)
> +{
> +       size_t clks_idx_pub, clks_idx_int;
> +       u32 __iomem *mccr_reg;  /* MCLK control register (mux, en, div) */
> +       u32 __iomem *sccr_reg;  /* system clock control register (enable)=
 */
> +       int sccr_bit;
> +       int div;
> +
> +       /* derive a few parameters from the component type and index */
> +       switch (entry->type) {
> +       case MCLK_TYPE_PSC:
> +               clks_idx_pub =3D MPC512x_CLK_PSC0_MCLK + entry->comp_idx;
> +               clks_idx_int =3D MPC512x_CLK_MCLKS_FIRST
> +                            + (entry->comp_idx) * MCLK_MAX_IDX;
> +               mccr_reg =3D &clkregs->psc_ccr[entry->comp_idx];
> +               break;
> +       case MCLK_TYPE_MSCAN:
> +               clks_idx_pub =3D MPC512x_CLK_MSCAN0_MCLK + entry->comp_id=
x;
> +               clks_idx_int =3D MPC512x_CLK_MCLKS_FIRST
> +                            + (NR_PSCS + entry->comp_idx) * MCLK_MAX_IDX;
> +               mccr_reg =3D &clkregs->mscan_ccr[entry->comp_idx];
> +               break;
> +       case MCLK_TYPE_SPDIF:
> +               clks_idx_pub =3D MPC512x_CLK_SPDIF_MCLK;
> +               clks_idx_int =3D MPC512x_CLK_MCLKS_FIRST
> +                            + (NR_PSCS + NR_MSCANS) * MCLK_MAX_IDX;
> +               mccr_reg =3D &clkregs->spccr;
> +               break;
> +       default:
> +               return;
> +       }
> +       if (entry->bit_sccr1 >=3D 0) {
> +               sccr_reg =3D &clkregs->sccr1;
> +               sccr_bit =3D entry->bit_sccr1;
> +       } else if (entry->bit_sccr2 >=3D 0) {
> +               sccr_reg =3D &clkregs->sccr2;
> +               sccr_bit =3D entry->bit_sccr2;
> +       } else {
> +               sccr_reg =3D NULL;
> +       }
> +
> +       /*
> +        * this was grabbed from the PPC_CLOCK implementation, which
> +        * enforced a specific MCLK divider while the clock was gated
> +        * during setup (that's a documented hardware requirement)
> +        *
> +        * the PPC_CLOCK implementation might even have violated the
> +        * "MCLK <=3D IPS" constraint, the fixed divider value of 1
> +        * results in a divider of 2 and thus MCLK =3D SYS/2 which equals
> +        * CSB which is greater than IPS; the serial port setup may have
> +        * adjusted the divider which the clock setup might have left in
> +        * an undesirable state
> +        *
> +        * initial setup is:
> +        * - MCLK 0 from SYS
> +        * - MCLK DIV such to not exceed the IPS clock
> +        * - MCLK 0 enabled
> +        * - MCLK 1 from MCLK DIV
> +        */
> +       div =3D clk_get_rate(clks[MPC512x_CLK_SYS]);
> +       div /=3D clk_get_rate(clks[MPC512x_CLK_IPS]);
> +       out_be32(mccr_reg, (0 << 16));
> +       out_be32(mccr_reg, (0 << 16) | ((div - 1) << 17));
> +       out_be32(mccr_reg, (1 << 16) | ((div - 1) << 17));
> +
> +       /*
> +        * create the 'struct clk' items of the MCLK's clock subtree
> +        *
> +        * note that by design we always create all nodes and won't take
> +        * shortcuts here, because
> +        * - the "internal" MCLK_DIV and MCLK_OUT signal in turn are
> +        *   selectable inputs to the CFM while those who "actually use"
> +        *   the PSC/MSCAN/SPDIF (serial drivers et al) need the MCLK
> +        *   for their bitrate
> +        * - in the absence of "aliases" for clocks we need to create
> +        *   individial 'struct clk' items for whatever might get
> +        *   referenced or looked up, even if several of those items are
> +        *   identical from the logical POV (their rate value)
> +        * - for easier future maintenance and for better reflection of
> +        *   the SoC's documentation, it appears appropriate to generate
> +        *   clock items even for those muxers which actually are NOPs
> +        *   (those with two inputs of which one is reserved)
> +        */
> +       clks[clks_idx_int + MCLK_IDX_MUX0] =3D mpc512x_clk_muxed(
> +                       entry->name_mux0,
> +                       &parent_names_mux0[0], ARRAY_SIZE(parent_names_mu=
x0),
> +                       mccr_reg, 14, 2);
> +       clks[clks_idx_int + MCLK_IDX_EN0] =3D mpc512x_clk_gated(
> +                       entry->name_en0, entry->name_mux0,
> +                       mccr_reg, 16);
> +       clks[clks_idx_int + MCLK_IDX_DIV0] =3D mpc512x_clk_divider(
> +                       entry->name_div0,
> +                       entry->name_en0, CLK_SET_RATE_GATE,
> +                       mccr_reg, 17, 15, 0);
> +       if (entry->has_mclk1) {
> +               clks[clks_idx_int + MCLK_IDX_MUX1] =3D mpc512x_clk_muxed(
> +                               entry->name_mux1,
> +                               &entry->parent_names_mux1[0],
> +                               ARRAY_SIZE(entry->parent_names_mux1),
> +                               mccr_reg, 7, 1);
> +       } else {
> +               clks[clks_idx_int + MCLK_IDX_MUX1] =3D mpc512x_clk_factor(
> +                               entry->name_mux1, entry->parent_names_mux=
1[0],
> +                               1, 1);
> +       }
> +       if (sccr_reg) {
> +               clks[clks_idx_pub] =3D mpc512x_clk_gated(
> +                               entry->name_mclk,
> +                               entry->name_mux1, sccr_reg, sccr_bit);
> +       } else {
> +               clks[clks_idx_pub] =3D mpc512x_clk_factor(
> +                               entry->name_mclk,
> +                               entry->name_mux1, 1, 1);
> +       }
> +
> +       /*
> +        * without this "clock device" registration, "simple" lookups in
> +        * the SPI master initialization and serial port setup will fail
> +        *
> +        * those drivers need to get adjusted to lookup their required
> +        * clocks from device tree specs, and device tree nodes need to
> +        * provide the clock specs, before this clkdev registration
> +        * becomes obsolete
> +        */
> +       clk_register_clkdev(clks[clks_idx_pub], entry->name_mclk, NULL);
> +}
> +
> +static void mpc512x_clk_setup_mclks(struct mclk_setup_data *table, size_=
t count)
> +{
> +       while (count-- > 0)
> +               mpc512x_clk_setup_mclk(table++);
> +}
> +
> +static void mpc512x_clk_setup_clock_tree(int busfreq)
> +{
> +       int sys_mul, sys_div, ips_div;
> +       int mul, div;
> +       int freq;
> +
> +       /*
> +        * TODO
> +        * - consider whether to handle clocks which have both gates and
> +        *   dividers via intermediates or by means of composites
> +        * - fractional dividers appear to not map well to composites
> +        *   since they can be seen as a fixed multiplier and an
> +        *   adjustable divider, while composites can only combine at
> +        *   most one of a mux, div, and gate each into one 'struct clk'
> +        *   item
> +        * - PSC/MSCAN/SPDIF clock generation OTOH already is very
> +        *   specific and cannot get mapped to componsites (at least not
> +        *   a single one, maybe two of them, but see the comment about
> +        *   "intermediates are referenced from elsewhere, too")
> +        * - trim the list of auto-enabled clocks after drivers acquire
> +        *   them correctly as needed
> +        */
> +
> +       /* regardless of whether XTAL/OSC exists, have REF created */
> +       mpc512x_clk_setup_ref_clock(busfreq, &sys_mul, &sys_div, &ips_div=
);
> +
> +       /* now setup the REF -> SYS -> CSB -> IPS hierarchy */
> +       clks[MPC512x_CLK_SYS] =3D mpc512x_clk_factor("sys", "ref",
> +                                                  sys_mul, sys_div);
> +       clks[MPC512x_CLK_CSB] =3D mpc512x_clk_factor("csb", "sys", 1, 2);
> +       clks[MPC512x_CLK_IPS] =3D mpc512x_clk_divtable("ips", "csb",
> +                                                    &clkregs->scfr1, 23,=
 3,
> +                                                    divtab_2346);
> +
> +       /* now setup anything below SYS and CSB and IPS */
> +       clks[MPC512x_CLK_DDR_UG] =3D mpc512x_clk_factor("ddr-ug", "sys", =
1, 2);
> +       clks[MPC512x_CLK_SDHC_x4] =3D mpc512x_clk_factor("sdhc-x4", "csb"=
, 4, 1);
> +       clks[MPC512x_CLK_SDHC_UG] =3D mpc512x_clk_divider("sdhc-ug", "sdh=
c-x4", 0,
> +                                                       &clkregs->scfr2, =
0, 8,
> +                                                       CLK_DIVIDER_ONE_B=
ASED);
> +       clks[MPC512x_CLK_DIU_x4] =3D mpc512x_clk_factor("diu-x4", "csb", =
4, 1);
> +       clks[MPC512x_CLK_DIU_UG] =3D mpc512x_clk_divider("diu-ug", "diu-x=
4", 0,
> +                                                      &clkregs->scfr1, 0=
, 8,
> +                                                      CLK_DIVIDER_ONE_BA=
SED);
> +
> +       /*
> +        * the "power architecture PLL" was setup from data which was
> +        * sampled from the reset config word, at this point in time the
> +        * configuration can be considered fixed and read only (i.e. no
> +        * longer adjustable, or no longer in need of adjustment), which
> +        * is why we don't register a PLL here but assume fixed factors
> +        */
> +       mul =3D get_cpmf_mult_x2();
> +       div =3D 2;        /* compensate for the fractional factor */
> +       clks[MPC512x_CLK_E300] =3D mpc512x_clk_factor("e300", "csb", mul,=
 div);
> +
> +       clks[MPC512x_CLK_MBX_BUS_UG] =3D mpc512x_clk_factor("mbx-bus-ug",=
 "csb",
> +                                                         1, 2);
> +       clks[MPC512x_CLK_MBX_UG] =3D mpc512x_clk_divtable("mbx-ug", "mbx-=
bus-ug",
> +                                                       &clkregs->scfr1, =
14, 3,
> +                                                       divtab_1234);
> +       clks[MPC512x_CLK_MBX_3D_UG] =3D mpc512x_clk_factor("mbx-3d-ug", "=
mbx-ug",
> +                                                        1, 1);
> +       clks[MPC512x_CLK_PCI_UG] =3D mpc512x_clk_divtable("pci-ug", "csb",
> +                                                       &clkregs->scfr1, =
20, 3,
> +                                                       divtab_2346);
> +       clks[MPC512x_CLK_NFC_UG] =3D mpc512x_clk_divtable("nfc-ug", "ips",
> +                                                       &clkregs->scfr1, =
8, 3,
> +                                                       divtab_1234);
> +       clks[MPC512x_CLK_LPC_UG] =3D mpc512x_clk_divtable("lpc-ug", "ips",
> +                                                       &clkregs->scfr1, =
11, 3,
> +                                                       divtab_1234);
> +
> +       clks[MPC512x_CLK_LPC] =3D mpc512x_clk_gated("lpc", "lpc-ug",
> +                                                 &clkregs->sccr1, 30);
> +       clks[MPC512x_CLK_NFC] =3D mpc512x_clk_gated("nfc", "nfc-ug",
> +                                                 &clkregs->sccr1, 29);
> +       clks[MPC512x_CLK_PATA] =3D mpc512x_clk_gated("pata", "ips",
> +                                                  &clkregs->sccr1, 28);
> +       mpc512x_clk_setup_mclks(mclk_psc_data, ARRAY_SIZE(mclk_psc_data));
> +       clks[MPC512x_CLK_PSC_FIFO] =3D mpc512x_clk_gated("psc-fifo", "ips=
",
> +                                                      &clkregs->sccr1, 1=
5);
> +       clks[MPC512x_CLK_SATA] =3D mpc512x_clk_gated("sata", "ips",
> +                                                  &clkregs->sccr1, 14);
> +       clks[MPC512x_CLK_FEC] =3D mpc512x_clk_gated("fec", "ips",
> +                                                 &clkregs->sccr1, 13);
> +       clks[MPC512x_CLK_PCI] =3D mpc512x_clk_gated("pci", "pci-ug",
> +                                                 &clkregs->sccr1, 11);
> +       clks[MPC512x_CLK_DDR] =3D mpc512x_clk_gated("ddr", "ddr-ug",
> +                                                 &clkregs->sccr1, 10);
> +
> +       clks[MPC512x_CLK_DIU] =3D mpc512x_clk_gated("diu", "diu-ug",
> +                                                 &clkregs->sccr2, 31);
> +       clks[MPC512x_CLK_AXE] =3D mpc512x_clk_gated("axe", "csb",
> +                                                 &clkregs->sccr2, 30);
> +       clks[MPC512x_CLK_MEM] =3D mpc512x_clk_gated("mem", "ips",
> +                                                 &clkregs->sccr2, 29);
> +       clks[MPC512x_CLK_USB1] =3D mpc512x_clk_gated("usb1", "csb",
> +                                                  &clkregs->sccr2, 28);
> +       clks[MPC512x_CLK_USB2] =3D mpc512x_clk_gated("usb2", "csb",
> +                                                  &clkregs->sccr2, 27);
> +       clks[MPC512x_CLK_I2C] =3D mpc512x_clk_gated("i2c", "ips",
> +                                                 &clkregs->sccr2, 26);
> +       mpc512x_clk_setup_mclks(mclk_mscan_data, ARRAY_SIZE(mclk_mscan_da=
ta));
> +       clks[MPC512x_CLK_SDHC] =3D mpc512x_clk_gated("sdhc", "sdhc-ug",
> +                                                  &clkregs->sccr2, 24);
> +       mpc512x_clk_setup_mclks(mclk_spdif_data, ARRAY_SIZE(mclk_spdif_da=
ta));
> +       clks[MPC512x_CLK_MBX_BUS] =3D mpc512x_clk_gated("mbx-bus", "mbx-b=
us-ug",
> +                                                     &clkregs->sccr2, 22=
);
> +       clks[MPC512x_CLK_MBX] =3D mpc512x_clk_gated("mbx", "mbx-ug",
> +                                                 &clkregs->sccr2, 21);
> +       clks[MPC512x_CLK_MBX_3D] =3D mpc512x_clk_gated("mbx-3d", "mbx-3d-=
ug",
> +                                                    &clkregs->sccr2, 20);
> +       clks[MPC512x_CLK_IIM] =3D mpc512x_clk_gated("iim", "csb",
> +                                                 &clkregs->sccr2, 19);
> +       clks[MPC512x_CLK_VIU] =3D mpc512x_clk_gated("viu", "csb",
> +                                                 &clkregs->sccr2, 18);
> +       clks[MPC512x_CLK_SDHC_2] =3D mpc512x_clk_gated("sdhc-2", "sdhc-ug=
",
> +                                                    &clkregs->sccr2, 17);
> +
> +       /*
> +        * externally provided clocks (when implemented in hardware,
> +        * device tree may specify values which otherwise were unknown)
> +        */
> +       freq =3D get_freq_from_dt("psc_mclk_in");
> +       if (!freq)
> +               freq =3D 25000000;
> +       clks[MPC512x_CLK_PSC_MCLK_IN] =3D mpc512x_clk_fixed("psc_mclk_in"=
, freq);
> +       freq =3D get_freq_from_dt("spdif_tx_in");
> +       clks[MPC512x_CLK_SPDIF_TX_IN] =3D mpc512x_clk_fixed("spdif_tx_in"=
, freq);
> +       freq =3D get_freq_from_dt("spdif_rx_in");
> +       clks[MPC512x_CLK_SPDIF_TX_IN] =3D mpc512x_clk_fixed("spdif_rx_in"=
, freq);
> +
> +       /* fixed frequency for AC97, always 24.567MHz */
> +       clks[MPC512x_CLK_AC97] =3D mpc512x_clk_fixed("ac97", 24567000);
> +
> +       /* clkdev registration for compatibility reasons */
> +       clk_register_clkdev(clks[MPC512x_CLK_REF], "ref_clk", NULL);
> +       clk_register_clkdev(clks[MPC512x_CLK_SYS], "sys_clk", NULL);
> +       clk_register_clkdev(clks[MPC512x_CLK_VIU], "viu_clk", NULL);
> +       clk_register_clkdev(clks[MPC512x_CLK_NFC], "nfc_clk", NULL);
> +       clk_register_clkdev(clks[MPC512x_CLK_USB1], "usb1_clk", NULL);
> +       clk_register_clkdev(clks[MPC512x_CLK_USB2], "usb2_clk", NULL);
> +
> +       pr_debug("clock tree setup complete\n");
> +       freq =3D clk_get_rate(clks[MPC512x_CLK_E300]);
> +       pr_debug("derived PPC freq [%d]\n", freq);
> +       freq =3D clk_get_rate(clks[MPC512x_CLK_IPS]);
> +       pr_debug("derived IPS freq [%d]\n", freq);
> +       freq =3D clk_get_rate(clks[MPC512x_CLK_LPC]);
> +       pr_debug("derived LPC freq [%d]\n", freq);
> +
> +       /* enable some of the clocks here unconditionally because ... */
> +       pr_debug("automatically enabling some clocks\n");
> +       /* some are essential yet never get claimed by any driver */
> +       clk_prepare_enable(clks[MPC512x_CLK_DUMMY]);
> +       clk_prepare_enable(clks[MPC512x_CLK_E300]);     /* PowerPC CPU */
> +       clk_prepare_enable(clks[MPC512x_CLK_DDR]);      /* DRAM */
> +       clk_prepare_enable(clks[MPC512x_CLK_MEM]);      /* SRAM */
> +       clk_prepare_enable(clks[MPC512x_CLK_IPS]);      /* SoC periph */
> +       clk_prepare_enable(clks[MPC512x_CLK_LPC]);      /* boot media */
> +       /* some are required yet no dependencies were declared */
> +       clk_prepare_enable(clks[MPC512x_CLK_PSC_FIFO]);
> +       /* some are not yet acquired by their respective drivers */
> +       clk_prepare_enable(clks[MPC512x_CLK_PSC3_MCLK]);/* serial console=
 */
> +       clk_prepare_enable(clks[MPC512x_CLK_FEC]);      /* network, NFS */
> +       clk_prepare_enable(clks[MPC512x_CLK_DIU]);      /* display */
> +       clk_prepare_enable(clks[MPC512x_CLK_I2C]);
> +       /*
> +        * some have their individual clock subtree with separate clock
> +        * items and their individual enable counters, yet share a
> +        * common gate (refer to the same register location) while the
> +        * common clock driver code is not aware of the fact and the
> +        * platform's code doesn't provide specific support either
> +        *
> +        * what might happen is that e.g. enabling two MSCAN clock items
> +        * and disabling one of them will disable the common gate and
> +        * thus break the other MSCAN clock as well
> +        */
> +       clk_prepare_enable(clks[MPC512x_CLK_MSCAN0_MCLK]);
> +       clk_prepare_enable(clks[MPC512x_CLK_MSCAN1_MCLK]);
> +       clk_prepare_enable(clks[MPC512x_CLK_MSCAN2_MCLK]);
> +       clk_prepare_enable(clks[MPC512x_CLK_MSCAN3_MCLK]);
> +}
> +
> +/*
> + * registers the set of public clocks (those listed in the dt-bindings/
> + * header file) for OF lookups, keeps the intermediates private to us
> + */
> +static void mpc5121_clk_register_of_provider(struct device_node *np)
> +{
> +       clk_data.clks =3D clks;
> +       clk_data.clk_num =3D MPC512x_CLK_LAST_PUBLIC + 1; /* _not_ ARRAY_=
SIZE() */
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +}
> +
> +int __init mpc5121_clk_init(void)
> +{
> +       struct device_node *clk_np;
> +       int busfreq;
> +
> +       /* map the clock control registers */
> +       clk_np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121-clock=
");
> +       if (!clk_np)
> +               return -ENODEV;
> +       clkregs =3D of_iomap(clk_np, 0);
> +       WARN_ON(!clkregs);
> +
> +       /* invalidate all not yet registered clock slots */
> +       mpc512x_clk_preset_data();
> +
> +       /*
> +        * have the device tree scanned for "fixed-clock" nodes (which
> +        * includes the oscillator node if the board's DT provides one)
> +        */
> +       of_clk_init(NULL);
> +
> +       /*
> +        * add a dummy clock for those situations where a clock spec is
> +        * required yet no real clock is involved
> +        */
> +       clks[MPC512x_CLK_DUMMY] =3D mpc512x_clk_fixed("dummy", 0);
> +
> +       /*
> +        * have all the real nodes in the clock tree populated from REF
> +        * down to all leaves, either starting from the OSC node or from
> +        * a REF root that was created from the IPS bus clock input
> +        */
> +       busfreq =3D get_freq_from_dt("bus-frequency");
> +       mpc512x_clk_setup_clock_tree(busfreq);
> +
> +       /* register as an OF clock provider */
> +       mpc5121_clk_register_of_provider(clk_np);
> +
> +       return 0;
> +}
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index c4f7799..7f8fc64 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -497,6 +497,20 @@ static inline const char *of_clk_get_parent_name(str=
uct device_node *np,
>   * for improved portability across platforms
>   */
>  =

> +#if IS_ENABLED(CONFIG_PPC)
> +
> +static inline u32 clk_readl(u32 __iomem *reg)
> +{
> +       return ioread32be(reg);
> +}
> +
> +static inline void clk_writel(u32 val, u32 __iomem *reg)
> +{
> +       iowrite32be(val, reg);
> +}
> +
> +#else  /* platform dependent I/O accessors */
> +
>  static inline u32 clk_readl(u32 __iomem *reg)
>  {
>         return readl(reg);
> @@ -507,5 +521,7 @@ static inline void clk_writel(u32 val, u32 __iomem *r=
eg)
>         writel(val, reg);
>  }
>  =

> +#endif /* platform dependent I/O accessors */
> +
>  #endif /* CONFIG_COMMON_CLK */
>  #endif /* CLK_PROVIDER_H */
> -- =

> 1.7.10.4
