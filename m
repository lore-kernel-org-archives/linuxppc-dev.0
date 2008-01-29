Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6B1DADDEA3
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 06:20:09 +1100 (EST)
Date: Tue, 29 Jan 2008 13:20:33 -0600
From: Scott Wood <scottwood@freescale.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 3/4] 82xx: MGCOGE support
Message-ID: <20080129192033.GB4051@loki.buserror.net>
References: <mailman.813.1200609119.6908.linuxppc-dev@ozlabs.org>
	<479EFE71.5090201@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <479EFE71.5090201@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 29, 2008 at 11:22:41AM +0100, Heiko Schocher wrote:
> +	model = "MGCOGE";
> +	compatible = "fsl,mgcoge";

keymile,mgcoge

> +		PowerPC,8247@0 {
[snip]
> +		compatible = "fsl,mpc8248-localbus",

All of these 8248s should be 8247.

> +		// Temporary -- will go away once kernel uses ranges for get_immrbase().
> +		reg = <0xf0000000 0x00053000>;

The patch to use ranges for get_immrbase() just went in, so we can drop this
now.

> +				data@0 {
> +					compatible = "fsl,cpm-muram-data";
> +					reg = <0 0x1100 0x1140
> +					       0xec0 0x9800 0x800>;

This doesn't look right.  You're excluding 0x40 bytes at 0x1100, which is
where planetcore puts SMC1.  However, you're using SMC2 -- and I'm guessing
aren't using planetcore, since this isn't an embedded planet board.

If you're using u-boot, this should be:

reg = <0x80 0x1f80 0x9800 0x800>;

> +			/* Monitor port/SMC2 */
> +			smc2: serial@11a90 {
> +				device_type = "serial";
> +				compatible = "fsl,mpc8248-smc-uart",
> +				             "fsl,cpm2-smc-uart";
> +				reg = <0x11a90 0x20 0x1100 0x40 0x88fc 4>;

If you're using u-boot, this should be <0x11a90 0x20 0x40 0x40>.

> +				current-speed = <0x1c200>;

This should be decimal.

-Scott
