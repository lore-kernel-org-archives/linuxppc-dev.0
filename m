Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EC593B71D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 11:13:35 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB536DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 11:13:35 +1000 (EST)
Date: Fri, 12 Jun 2009 11:13:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v4] 83xx: add support for the kmeter1 board.
Message-ID: <20090612011332.GA9084@yookeroo.seuss>
References: <6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
	<49F544DE.1010307@denx.de>
	<20090427180503.GB10292@ld0162-tx32.am.freescale.net>
	<49F68943.3090800@denx.de>
	<20090428163540.GA2193@ld0162-tx32.am.freescale.net>
	<49F7DC0C.3080409@denx.de>
	<C934E2FC-7597-4D10-AA2F-F28884D1DD1B@kernel.crashing.org>
	<4A30A14D.50907@denx.de>
	<0AFEA008-BBF6-448B-844F-6EBE3DE24F7B@kernel.crashing.org>
	<4A3148A1.3030403@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A3148A1.3030403@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2009 at 08:10:41PM +0200, Heiko Schocher wrote:
> The following series implements basic board support for
> the kmeter1 board from keymile, based on a MPC8360.

[snip]
> +		par_io@1400 {
> +			reg = <0x1400 0x100>;
> +			device_type = "par_io";

This should have a compatible value instead of a device_type value.

[snip]

> +			num-ports = <7>;
> +
> +			pio_ucc1: ucc_pin@00 {

Since these nodes have addresses, they should also have reg
properties.  And the parent should have #address-cells and
#size-cells.

[snip]
> +		qe@100000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			device_type = "qe";

This device_type should not be here.

> +			compatible = "fsl,qe";
> +			ranges = <0x0 0x100000 0x100000>;
> +			reg = <0x100000 0x480>;
> +			clock-frequency = <0>;	/* Filled in by U-Boot */
> +			brg-frequency = <0>;	/* Filled in by U-Boot */
> +			bus-frequency = <0>;	/* Filled in by U-Boot */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
