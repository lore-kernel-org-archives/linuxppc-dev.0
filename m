Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D4A16DDF0A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 06:22:20 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m08JMAdK025928
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 12:22:16 -0700 (MST)
Date: Tue, 8 Jan 2008 13:22:23 -0600
From: Scott Wood <scottwood@freescale.com>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 4/7] Device tree for MPC5121 ADS
Message-ID: <20080108192223.GA5296@loki.buserror.net>
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<1199808093-15929-5-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1199808093-15929-5-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 08, 2008 at 09:01:30AM -0700, John Rigby wrote:
> +	cpld@82000000 {
> +		device_type = "board-control";
> +		reg = <82000000 8000>;
> +	};

Should be:

baord-control@82000000 {
	compatible = "fsl,mpc5121ads-cpld";
	reg = <82000000 8000>;
};

> +		ref-frequency = <3ef1480>;	// 66MHz ref
> +		bus-frequency = <5e69ec0>;	// 99MHz ips ref

Please specify these in decimal rather than hex (using the d# prefix, or
better yet /dts-v1/).

> +		// IPIC
> +		// interrupts cell = <intr #, sense>
> +		// sense values match linux IORESOURCE_IRQ_* defines:
> +		// sense == 8: Level, low assertion
> +		// sense == 2: Edge, high-to-low change
> +		//
> +		ipic: pic@c00 {
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <c00 100>;
> +			built-in;
> +			device_type = "ipic";
> +		};

Remove built-in.

-Scott
