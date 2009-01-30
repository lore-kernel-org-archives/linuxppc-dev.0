Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 16E64DE203
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 03:59:39 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so180577yxg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 08:59:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1233329630876-git-send-email-gjb@semihalf.com>
References: <1233329630876-git-send-email-gjb@semihalf.com>
Date: Fri, 30 Jan 2009 09:59:36 -0700
Message-ID: <fa686aa40901300859t4da76ce3hf943adc48abb9b9c@mail.gmail.com>
Subject: Re: [PATCH] Add support for the digsy MTC board.
From: Grant Likely <grant.likely@secretlab.ca>
To: Grzegorz Bernacki <gjb@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 30, 2009 at 8:33 AM, Grzegorz Bernacki <gjb@semihalf.com> wrote:
> This is the InterControl custom device based on the MPC5200B chip.
>
> Signed-off-by: Grzegorz Bernacki <gjb@semihalf.com>

Hi Grzogorz,

Thanks for the patch.  Comments below.

g.

>
> diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
> new file mode 100644
> index 0000000..a92a6b7
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/digsy_mtc.dts
> @@ -0,0 +1,287 @@
> +/*
> + * Digsy MTC board Device Tree Source
> + *
> + * Copyright (C) 2009 Semihalf
> + *
> + * Based on the CM5200 by M. Balakowicz
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +       model = "mtc,digsy";
> +       compatible = "mtc,digsy";

This should be something like:  "intercontrol,digsy-mtc".  Compatible
values should be in the form "<vendor>,<model>".

> +               mpc5200_pic: interrupt-controller@500 {
> +                       // 5200 interrupts are encoded into two levels;
> +                       interrupt-controller;
> +                       #interrupt-cells = <3>;
> +                       device_type = "interrupt-controller";

Drop device_type here.

> +                       compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
> +                       reg = <0x500 0x80>;
> +               };
> +
> +               timer@600 {     // General Purpose Timer
> +                       compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> +                       cell-index = <0>;

Drop cell-index on all the timer nodes.  If you compare this file with
the current cm5200.dts in mainline then you'll see the properties that
you can drop.

Otherwise the device tree looks pretty good.

> diff --git a/arch/powerpc/configs/52xx/digsy_mtc_defconfig b/arch/powerpc/configs/52xx/digsy_mtc_defconfig
> new file mode 100644
> index 0000000..ad70d5b
> --- /dev/null
> +++ b/arch/powerpc/configs/52xx/digsy_mtc_defconfig
[...]

Do you *really* need your own defconfig for the digsy_mtc.  I've
grudgingly accepted them for other boards under the argument that the
defconfig reflects a specific application of the board.  However, I'd
much rather see the digsy added to the multiplatform
mpc5200_defconfig, especially considering that the MTC looks like it's
supposed to be a general purpose platform.

> diff --git a/arch/powerpc/platforms/52xx/digsy_mtc.c b/arch/powerpc/platforms/52xx/digsy_mtc.c
> new file mode 100644
> index 0000000..8cd8cae
> --- /dev/null
> +++ b/arch/powerpc/platforms/52xx/digsy_mtc.c
> @@ -0,0 +1,157 @@
> +/*
> + * Digsy MTC board support
> + *
> + * Based on Lite5200 support by Grant Likely <grant.likely@secretlab.ca>
> + *
> + * Copyright (C) Secret Lab Technologies Ltd. 2006.
> + * Copyright (C) Freescale Semicondutor, Inc. 2006.
> + * Copyright (C) Semihalf 2009.
> + * All rights reserved.

I don't think "All rights reserved" is appropriate here.

> +/*
> + * Fix setting of port_config register.
> + */
> +static void __init
> +digsy_fix_port_config(void)
[...]
> +static void __init
> +digsy_fix_clock_config(void)
[...]

There is a lot of direct copy/paste from the lite5200.c board file,
but the big scary warning comment about not duplicating this code was
deleted in the copy (so I know you saw it).  Is Semihalf responsible
for the U-Boot port to the digsy-mtc?  If so then please fix the
port_config and clock settings in u-boot.

If it is not possible to update the u-boot image, or if there are
already to many deployed systems to rely on getting the firmware fix,
then calling these functions is okay, but I don't like the verbatim
copy/paste.  I think it would be better to factor out and rename the
lite5200_fix_*() functions to mpc5200_fix_*() functions in
mpc52xx_common.c and have the lite5200 and digsy support code call the
common code.  the fix_port_config function should take to arguments; a
mask and a value that can be applied to the current port_config
setting.  Clock config can probably be copied over as-is.  Split the
refactoring of lite5200_fix_*() changes into a separate patch when you
resubmit.  If you don't have a lite5200, then don't worry about
testing it, just make sure it compiles.  I'll test it before I merge
it into my tree.

Also digsy_fix_port_config() has the lines:
>+	port_config &= ~0x00007000;	/* USB port : Differential mode	*/
>+	port_config |= 0x00002000;	/*            USB 1 only	*/

These lines were modified from lite5200.c to select 2 UARTs instead of
USB, but the comment was left the same.

> +static void __init digsy_setup_arch(void)
> +{
> +       if (ppc_md.progress)
> +               ppc_md.progress("digsy_setup_arch()", 0);
> +
> +       /* Map important registers from the internal memory map */
> +       mpc52xx_map_common_devices();
> +
> +       /* Some mpc5200 & mpc5200b related configuration */
> +       mpc5200_setup_xlb_arbiter();
> +
> +       /* Fix things that firmware should have done. */
> +       digsy_fix_clock_config();
> +       digsy_fix_port_config();
> +
> +       mpc52xx_setup_pci();
> +}
> +
> +define_machine(digsy) {
> +       .name           = "digsy",

would 'digsy-mts' be better here?
