Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BB99FDDF70
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 03:00:41 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2OG0bZO023534
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 09:00:38 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n2OG0bp4005942
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 11:00:37 -0500 (CDT)
Date: Tue, 24 Mar 2009 11:00:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/83xx: Update ranges in gianfar node to match
	other dts
Message-ID: <20090324160032.GB24778@ld0162-tx32.am.freescale.net>
References: <1237901745-27418-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1237901745-27418-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 24, 2009 at 08:35:45AM -0500, Kumar Gala wrote:
> The gianfar node @ 25000 was missing its ranges prop for the mdio bus
> and provided an explicit ranges property on gianfar@24000 to match
> all other .dts
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/boot/dts/mpc8313erdb.dts |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
> index 3ebf7ec..20a0fa8 100644
> --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> @@ -180,7 +180,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			sleep = <&pmc 0x20000000>;
> -			ranges;
> +			ranges = <0x0 0x24000 0x1000>;
>  
>  			cell-index = <0>;
>  			device_type = "network";

You need to fix the reg property of the child node to match this change
in ranges.  Was this boot-tested (or is it a case of Linux's device tree
parsing being excessively tolerant of broken trees)?

-Scott
