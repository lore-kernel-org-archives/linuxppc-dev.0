Return-Path: <dgibson@ozlabs.org>
Date: Mon, 2 Jun 2008 12:03:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
Message-ID: <20080602020352.GB19393@yookeroo.seuss>
References: <1212130188-28835-1-git-send-email-wg@grandegger.com>
	<1212130188-28835-2-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1212130188-28835-2-git-send-email-wg@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 30, 2008 at 08:49:45AM +0200, Wolfgang Grandegger wrote:
> This patch adds support for the TQM8548 modules from TQ-Components
> GmbH (http://www.tqc.de).

[snip]
> index 0000000..d09250a
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/tqm8548.dts
> @@ -0,0 +1,370 @@
> +/*
> + * TQM8548 Device Tree Source
> + *
> + * Copyright 2006 Freescale Semiconductor Inc.
> + * Copyright 2008 Wolfgang Grandegger <wg@denx.de>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/dts-v1/;

[snip]
> +		i2c@3000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cell-index = <0>;
[...]
> +		enet0: ethernet@24000 {
> +			cell-index = <0>;
[...]
> +		serial0: serial@4500 {
> +			cell-index = <0>;
[...]
> +	pci0: pci@e0008000 {
> +		cell-index = <0>;

You have a whole lot of 'cell-index' properties through both these
trees, and they all look wrong.  cell-index is a hack, which should be
avoided wherever practical - it should only be used when the index is
used to offset into some global register block, never simply to
differentiate (use reg for that) or name the devices (use aliases for
that).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
