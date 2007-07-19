Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8FBA7DE09B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 01:51:32 +1000 (EST)
In-Reply-To: <1184750539.27603.7.camel@localhost.localdomain>
References: <1184750539.27603.7.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F4643E18-47E4-4077-819F-01E298025BF3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Add 8548CDS with Arcadia 3.0 support
Date: Thu, 19 Jul 2007 17:51:17 +0200
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	compatible = "MPC8548CDS", "MPC85xxCDS";

No new "xx" please.

> +	memory {
> +		device_type = "memory";
> +		reg = <00000000 08000000>;	// 128M at 0x0

memory@0.  Simplified rule: whenever there is a "reg",
there is an "@".

> +	soc8548@e0000000 {

soc@e0000000

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";

No "device_type".  Missing "compatible".

> +		ranges = <0 e0000000 00100000>;
> +		reg = <e0000000 00100000>;	// CCSRBAR 1M

"reg" and "ranges" overlap, that can't be right.

> +		i2c@3000 {
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";

Please put a more exact "compatible" entry in there.  If
you need to keep "fsl-i2c" as well, for backwards compatibility
reasons, that's fine; but do put a better name in.

> +			dfsrr;

This wins the prize for worst-name property ever!  :-)

> +		serial@4500 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4500 100>; 	// reg base, size

I wonder how it can be NS16550-compatible if its register
bank is a completely different size.


> +		pci1: pci@8000 {
> +			interrupt-map-mask = <f800 0 0 7>;
> +			interrupt-map = <
> +
> +				/* IDSEL 0x2 (PCIX Tsi310 bridge) */
> +				1000 0 0 1 &mpic 0 1
> +				1000 0 0 2 &mpic 1 1
> +				1000 0 0 3 &mpic 2 1
> +				1000 0 0 4 &mpic 3 1

You map all dev#s' interrupts identically, you could just do

	interrupt-map-mask = <0 0 0 7>

and do one set of four mappings in the interrupt-map, with the
device number field set to 0.

The mask exists to not have to write out lots of huge tables :-)

> +		pci@9000 {
> +			interrupt-map-mask = <f800 0 0 7>;
> +			interrupt-map = <
> +
> +				/* IDSEL 0x15 */
> +				a800 0 0 1 &mpic b 1
> +				a800 0 0 2 &mpic b 1
> +				a800 0 0 3 &mpic b 1
> +				a800 0 0 4 &mpic b 1>;

You can do a similar mask trick here.

> +		mpic: pic@40000 {

interrupt-controller@40000


Segher
