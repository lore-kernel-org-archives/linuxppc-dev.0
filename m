Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8EE4CDDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 00:58:03 +1000 (EST)
In-Reply-To: <E1IAnwC-0003Xm-6U@jdl.com>
References: <E1IAnwC-0003Xm-6U@jdl.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <630B6BC9-389F-4F5C-AE8F-9C3131C4543E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Add StorCenter DTS first draft.
Date: Tue, 17 Jul 2007 16:57:27 +0200
To: Jon Loeliger <jdl@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Comments welcome, of course.

Well you asked for it :-)

> +/ {
> +	model = "StorCenter";

If you can find a real model number, put it in here,
instead.

> +	compatible = "storcenter";

Needs a manufacturer name in there.

> +		PowerPC,603e {			/* Really 8241 */

So say "PowerPC,8241@0", or "PowerPC,e300@0" (or whatever
the CPU core in there is), or simply "cpu@0", following
the generic naming recommended practice.

> +			bus-frequency = <0>;

Is this filled in anywhere?  Please document that, if so.

> +			/* Following required by dtc but not used */
> +			i-cache-line-size = <0>;
> +			d-cache-line-size = <0>;
> +			i-cache-size = <4000>;
> +			d-cache-size = <4000>;

Not used _by the Linux kernel_, it's required by the
PowerPC binding.  Perhaps that should be modified
for flat device tree use, there are many more required
properties that no flat tree has anyway.

> +	flash@ff800000 {
> +		device_type = "rom";

I'm sure you know I find this "rom" binding to be crap.
However, I didn't yet write up the "cfi" binding, so I
can't complain ;-)

> +		partitions = <
> +				00000000 0000E000
> +				0000E000 00002000
> +				00010000 00040000
> +				00050000 00200000
> +				00250000 004B0000
> +				00700000 00020000
> +				00720000 00010000
> +				00730000 00010000
> +				00740000 000B0000
> +		>;

Nothing from 7f0000 to 7fffff?

> +	soc10x {

Bad name.  Where is the binding for this?  I don't think
I saw it before.

> +		compatible = "mpc10x";

"manufacturer,106-host" or similar.  But this isn't an 10x
at all, is it?

> +		store-gathering = <0>; /* 0 == off, !0 == on */

Don't define this as "!0", but as "1".

> +		i2c@fdf03000 {
> +			device_type = "i2c";

No device_type, there is no I2C binding.

> +			compatible = "fsl-i2c";

Needs to be more specific.

> +		mpic: pic@fdf40000 {

interrupt-controller@fdf40000

> +			#interrupt-cells = <2>;
> +			#address-cells = <0>;

No #address-cells here.

> +			device_type = "open-pic";

device_type = "interrupt-controller" I believe, unless
the mpic binding does something weird.

> +		pci@fe800000 {
> +			clock-frequency = <d# 100000000>; /* Hz */

100MHz PCI?  Interesting.

> +			interrupt-map = <
> +				/* IDSEL 0x15 - ETH */
> +				7800 0 0 1 &mpic 0 1

7800 isn't device 0x15.  I think you meant 15.


Segher
