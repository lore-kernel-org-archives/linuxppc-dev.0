Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2FA41DDE42
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 03:21:50 +1000 (EST)
In-Reply-To: <1178382006.3393.37.camel@zod.rchland.ibm.com>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
	<1178382006.3393.37.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e1d22829fe3f12509018791541073706@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 6/7] Holly DTS
Date: Sat, 5 May 2007 19:21:33 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +/ {
> +	model = "ppc750-tsi109";

"model" should be something really specific; typically
a (unique!) model number.  This means you can't use the
same device tree for Holly and Hickory (but there are
more reasons for that; see below).

> +	compatible = "ppc750-tsi";

The needs to be more specific as well; "ibm,holly"
or something.

> +		PowerPC,750@0 {

Needs to be PowerPC,750CL etc.

> +			name = "PowerPC,750";

You don't need to specify "name" in modern DTS.

> +  	tsi109@c0000000 {
> +		device_type = "tsi-bridge";

Don't put a "device_type" here, it is useless
(and undefined).  There are more like this, but
perhaps Linux (wrongly) probes on "device_type"
for those, so the kernel would need updating
first.

> +		bus-frequency = <0>;

0?

> +		ethernet@6200 {
> +			model = "TSI-ETH";

"model" should be an exact model name.  If you don't
have one, just leave out the "model" property.

> +			address = [ 00 0d 60 f4 3f 04 ];

"local-mac-address" instead.  And you don't want to
hardcode one specific address like this; just keep
it open so if the bootloader fails to fill it in you
notice.  If the bootloader cannot do that, just leave
out this property completely (not compliant, but neither
is filling in the wrong value).

> +		serial@7808 {
> +			reg-shift = <0>;

This is the default value so you can leave it out.

> +	  	MPIC: pic@7400 {
> +			built-in;

Why say this for MPIC only, not for most other nodes?
What binding defines "built-in", anyway?

> +				/*--------------------------------------------+
> +				| AD19.
> +				+--------------------------------------------*/
> +				1800 0 0 1 &RT0 26 0
> +				1800 0 0 2 &RT0 27 0
> +				1800 0 0 3 &RT0 24 0
> +				1800 0 0 4 &RT0 25 0
> +
> +				2000 0 0 1 &RT0 27 0
> +				2000 0 0 2 &RT0 24 0
> +				2000 0 0 3 &RT0 25 0
> +				2000 0 0 4 &RT0 26 0
> +				>;

You forgot to say "AD20" ;-)

> +	chosen {
> +		linux,platform = <0>;
> +		linux,initrd-start = <0>;
> +		linux,initrd-end = <0>;

Do you need to set those zero properties?


Segher
