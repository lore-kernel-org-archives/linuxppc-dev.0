Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2DF90DDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 14:52:28 +1000 (EST)
In-Reply-To: <466EEC01.6080807@am.sony.com>
References: <20070612181825.730300780@am.sony.com>>
	<466EEC01.6080807@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
Date: Wed, 13 Jun 2007 06:52:20 +0200
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Geoff,

Not much that can be wrong in this tree, so I'll get really
pedantic, so you can have the best device tree ever ;-)

There is one real bug though.

> +/ {
> +	model = "PS3 Game Console";

model = "sony,some-model-number" or similar

> +	compatible = "PS3";

name = "sony,ps3"

> +	/*
> +	 * Need to keep linux,platform for a while, not used by kernel.
> +	 */

Why that?

> +	 * Seems the only way currently to indicate a processor has multiple
> +	 * threads is with an ibm,ppc-interrupt-server#s entry.

Yes, a better way should be defined.  Any suggestions?

> +		CBE,PPE {

PowerPC,CBE@0 or cpu@0 -- the important thing is you need
the @0 unit address.

> +			device_type = "cpu";
> +			reg = <0>;
> +			ibm,ppc-interrupt-server#s = <0 1>;
> +			clock-frequency = <0>;
> +			timebase-frequency = <0>;
> +			i-cache-size = <8000>;
> +			d-cache-size = <8000>;

I thought DL1 was 64kB, I might be wrong though?


Segher
