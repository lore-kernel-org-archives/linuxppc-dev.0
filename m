Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 158E6DDF34
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 12:39:22 +1100 (EST)
Date: Tue, 17 Mar 2009 12:39:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v2 1/2] powerpc/86xx: Board support for GE Fanuc's PPC9A
Message-ID: <20090317013918.GA9643@yookeroo.seuss>
References: <20090316102912.10805.98764.stgit@ubuntu8041.localdomain>
	<20090316103048.10805.15368.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090316103048.10805.15368.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, wim@iguana.be
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 16, 2009 at 10:32:18AM +0000, Martyn Welch wrote:
> Support for the PPC9A VME Single Board Computer from GE Fanuc (PowerPC
> MPC8641D).
> 
> This is the basic board support for GE Fanuc's PPC9A, a 6U single board
> computer, based on Freescale's MPC8641D.

Uh.. sorry.  Should have noticed these little nitpicks the first time
around.

> +	localbus@fef05000 {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc8641-localbus", "simple-bus";
> +		reg = <0xfef05000 0x1000>;
> +		interrupts = <19 2>;
> +		interrupt-parent = <&mpic>;
> +
> +		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
> +			  1 0 0xe8000000 0x08000000	// Paged Flash 0
> +			  2 0 0xe0000000 0x08000000	// Paged Flash 1
> +			  3 0 0xfc100000 0x00020000	// NVRAM
> +			  4 0 0xfc000000 0x00008000	// FPGA
> +			  5 0 0xfc008000 0x00008000	// AFIX FPGA
> +			  6 0 0xfd000000 0x00800000	// IO FPGA (8-bit)
> +			  7 0 0xfd800000 0x00800000>;	// IO FPGA (32-bit)
> +
> +		/* flash@0,0 is a mirror of part of the memory in flash@1,0
> +		flash@0,0 {
> +			compatible = "cfi-flash";

It would be nice to have the actual type of flash chips here, although
it's not essential.

[snip]
> +		fpga@4,0 {
> +			compatible = "gef,fpga-regs";

I don't imagine this is the only set of FPGA based control regs GE
Fanuc will ever make, so this should be more precise.  Including the
board type here is probably the way to go.

> +			reg = <0x4 0x0 0x40>;
> +		};
> +
> +		wdt@4,2000 {
> +			compatible = "gef,fpga-wdt";

And likewise here.

> +			reg = <0x4 0x2000 0x8>;
> +			interrupts = <0x1a 0x4>;
> +			interrupt-parent = <&gef_pic>;
> +		};
> +		/* Second watchdog available, driver currently supports one.
> +		wdt@4,2010 {
> +			compatible = "gef,fpga-wdt";
> +			reg = <0x4 0x2010 0x8>;
> +			interrupts = <0x1b 0x4>;
> +			interrupt-parent = <&gef_pic>;
> +		};
> +		*/
> +		gef_pic: pic@4,4000 {
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			compatible = "gef,fpga-pic";

And possibly here, although in this case I imagine several boards
might have compatible FPGA PICs.

> +		i2c1: i2c@3000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl-i2c";

This should list include a compatible string specific to the
particular SoC model before the general name.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
