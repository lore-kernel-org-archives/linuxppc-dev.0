Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CC782DDDF8
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 01:21:42 +1000 (EST)
In-Reply-To: <1179154675.3420.22.camel@zod.rchland.ibm.com>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
	<1179154675.3420.22.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <92b3319be989145b0191cf9693ddd90c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Bamboo DTS
Date: Mon, 14 May 2007 17:21:26 +0200
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

> +			i-cache-size = <2000000>;
> +			d-cache-size = <2000000>;

32MB yeah right :-)

> +		MAL0: mcmal {

> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			interrupt-map-mask = <ffffffff>;

These three properties aren't needed (map-mask defaults
to all bits, #size is never used, #address defaults to 0
for interrupt mapping and isn't used in any other context).

> +		  	ranges = <00000000 0 00000000 80000000
> +			          80000000 0 80000000 80000000>;

You can avoid having two ranges by using #size-cells = 2
in the root node.  Having two ranges is a problem if any
mapping straddles the boundary between the two.


Segher
