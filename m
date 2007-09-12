Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28FD3DDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 12:09:55 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0709121154120.19816@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0709121154120.19816@blarg.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <919c9b76c3e6e45af6e3fb887611a681@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] DTS cleanup
Date: Thu, 13 Sep 2007 00:10:38 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> * 32-bit in cpu node -- doesn't exist in any spec and not used by 
> kernel

Yeah.

> * built-in for non-standard buses (ISA, PCI)

"built-in" is some weird CHRP property, so yes we don't need it
or want it.

> * Removed #interrupt-cells in places they don't need to be set

Great :-)

> * Fixed ranges on lite5200*

This has a problem still:

>  		model = "fsl,mpc5200";
>  		compatible = "mpc5200";
>  		revision = "";			// from bootloader
> -		#interrupt-cells = <3>;
>  		device_type = "soc";
> -		ranges = <0 f0000000 f0010000>;
> -		reg = <f0000000 00010000>;
> +		ranges = <0 f0000000 0000c000>;
> +		reg = <f0000000 0000c000>;

That makes "reg" and "ranges" identify an identical address range,
which means no subnode can claim any address in that range, so the
"ranges" property should go.  Alternatively, the "reg" might be
claiming too big a space.

Which is it?


Segher
