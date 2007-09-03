Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F523DDED3
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Sep 2007 20:24:09 +1000 (EST)
In-Reply-To: <20070829061300.GF3206@localhost.localdomain>
References: <20070829061300.GF3206@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <143067874eed1b4ee9c75d5272bb5958@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Document and implement an improved flash device binding
Date: Mon, 3 Sep 2007 12:23:34 +0200
To: David Gibson <dwg@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +   j) CFI or JEDEC memory-mapped NOR flash
>
>      Flash chips (Memory Technology Devices) are often used for solid 
> state
>      file systems on embedded devices.

Well, almost everything has a NOR flash on it, not just
embedded boards ;-)

> +     - bank-width : Width (in bytes) of the flash bank.  Equal to the
> +       device width times the number of interleaved chips.
> +     - device-width : (optional) Width of a single flash chip.  If
> +       omitted, assumed to be equal to 'bank-width'.

Let's have bank-width optional instead, it's more natural
that way for the common case of just one chip.  Or, you can
say that either is optional.

> +	flash@ff000000 {
> +		compatible = "amd,am29lv128ml", "cfi-flash";
> +		reg = <ff000000 01000000>;
> +		bank-width = <4>;

This is an 8/16-bit part, you need a device-width ;-)

Need #address-cells here for the child nodes:

> +		fs@0 {
> +			reg = <0 f80000>;
> +		};

[big snip]

> +					OpenBIOS@0 {

This show immediately why node name = partition name won't
work out.  You're not supposed to start a node name with a
capital like this.


Segher
