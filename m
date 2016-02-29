Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7ACE91A0324
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 09:38:10 +1100 (AEDT)
Message-ID: <1456785480.5360.60.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>, Kumar Gala
 <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Feb 2016 16:38:00 -0600
In-Reply-To: <1456397825-1786-2-git-send-email-alessio.bogani@elettra.eu>
References: <1456397825-1786-1-git-send-email-alessio.bogani@elettra.eu>
 <1456397825-1786-2-git-send-email-alessio.bogani@elettra.eu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC PATCH v1 2/2] powerpc/86xx: Introduce and use common dtsi
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-25 at 11:57 +0100, Alessio Igor Bogani wrote:
> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> ---
>  arch/powerpc/boot/dts/fsl/gef_ppc9a.dts        | 284 +++-------------------
>  arch/powerpc/boot/dts/fsl/gef_sbc310.dts       | 276 +++------------------
>  arch/powerpc/boot/dts/fsl/gef_sbc610.dts       | 284 +++-------------------
>  arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts     | 318 ++++------------------
> ---
>  arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts | 317 ++++------------------
> --
>  arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi  | 124 ++++++++++
>  arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi   |  59 +++++
>  arch/powerpc/boot/dts/fsl/sbc8641d.dts         | 314 +++-------------------
> --
>  8 files changed, 400 insertions(+), 1576 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
>  create mode 100644 arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi

Could you post a diff of what the decompiled trees look like before and after
this change (e.g. interrupts went from 2-cell to 4-cell)?  It is very hard to
review in this form.  Or better, like the config change, have a commit that
first makes changes to what the unified trees will be, and then a second
commit that generates the same output using includes.

> +/include/ "qoriq-mpic.dtsi"
> +	pic@40000 {
> +		compatible = "chrp,open-pic";
> +	};

This is removing the fsl,mpic compatible, which is required for 4-cell
interrupt specifiers.

> +&pci0 {
> +	compatible = "fsl,mpc8641-pcie";
> +	device_type = "pci";
> +	#size-cells = <2>;
> +	#address-cells = <3>;
> +	bus-range = <0x0 0xff>;
> +	clock-frequency = <33333333>;

The clock frequency of PCI Express is not 33 MHz.


> diff --git a/arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi
> b/arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi
> new file mode 100644
> index 0000000..026fa58
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi
> @@ -0,0 +1,59 @@
> +/*
> + * MPC8641 Silicon/SoC Device Tree Source (pre include)
> + *
> + * Copyright 2016 Elettra-Sincrotrone Trieste S.C.p.A.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	compatible = "fsl,MPC8641";

This compatible is pointless -- it will be overwritten by the board
compatible.

-Scott
