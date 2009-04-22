Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 60895DE055
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 02:44:21 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3MGi2QK026778
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 09:44:12 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n3MGi1Cf009344
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 11:44:01 -0500 (CDT)
Date: Wed, 22 Apr 2009 11:44:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/85xx: Add P2020DS board support
Message-ID: <20090422164400.GA9592@ld0162-tx32.am.freescale.net>
References: <1240371105-18400-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1240371105-18400-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 21, 2009 at 10:31:45PM -0500, Kumar Gala wrote:
> +	localbus@ffe05000 {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		compatible = "fsl,elbc", "simple-bus";

If this has an elbc more recent than 1.0 (looks like it), we should
indicate that here.

> +		reg = <0 0xffe00000 0 0x1000>;	// CCSRBAR & soc regs, remove once parse code for immrbase fixed

The immrbase code was fixed a long time ago -- this can go away.

> +static int __init p2020_ds_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (of_flat_dt_is_compatible(root, "fsl,P2020DS")) {
> +#ifdef CONFIG_PCI
> +		primary_phb_addr = 0x9000;
> +#endif
> +		return 1;
> +	} else {
> +		return 0;
> +	}
> +}

Unnecessary "else".

-Scott
