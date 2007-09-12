Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C6CC3DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 02:36:48 +1000 (EST)
Date: Wed, 12 Sep 2007 11:36:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v4] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Message-ID: <20070912163638.GA16326@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0709121119160.19430@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0709121119160.19430@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2007 at 11:20:06AM -0500, Kumar Gala wrote:
> +		pcie@0 {
> +			reg = <0 0 0 0 0>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			device_type = "pci";
> +			uli1575@0 {

You need a ranges; in the pcie node, or else nothing can be translated
through it.  Linux may let us get away with it currently, but other
parsing code won't.

> +					i8259: interrupt-controller@20 {
> +						reg = <1 20 2
> +						       1 a0 2
> +						       1 4d0 2>;
> +						clock-frequency = <0>;
> +						interrupt-controller;
> +						device_type = "interrupt-controller";
> +						#address-cells = <0>;
> +						#interrupt-cells = <2>;
> +						built-in;
> +						compatible = "chrp,iic";
> +						interrupts = <9 2>;
> +						interrupt-parent =
> +							<&mpic>;
> +					};

I'd get rid of clock-frequency and built-in.

-Scott
