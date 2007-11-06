Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Nov 2007 09:36:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH v3 07/13] [POWERPC] TQM5200 DTS
Message-ID: <20071106223646.GD31367@localhost.localdomain>
References: <20071106200446.10913.29338.stgit@hekate.izotz.org>
	<20071106200548.10913.42168.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071106200548.10913.42168.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 06, 2007 at 09:05:48PM +0100, Marian Balakowicz wrote:
> Add device tree source file for TQM5200 board.
> 
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>

[snip]
> +		usb@1000 {
> +			device_type = "usb-ohci-be";

This device_type is bogus.  Remember having a valid device_type is the
exception not the rule.  Really the only common device_type values are
"cpu", "memory", "network" and "serial".

> +			compatible = "mpc5200-ohci","ohci-be";
> +			reg = <1000 ff>;
> +			interrupts = <2 6 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};
> +
> +		dma-controller@1200 {
> +			compatible = "mpc5200-bestcomm";
> +			reg = <1200 80>;
> +			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
> +			              3 4 0  3 5 0  3 6 0  3 7 0
> +			              3 8 0  3 9 0  3 a 0  3 b 0
> +			              3 c 0  3 d 0  3 e 0  3 f 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};
> +
> +		xlb@1f00 {
> +			compatible = "mpc5200-xlb";
> +			reg = <1f00 100>;
> +		};
> +
> +		serial@2000 {		// PSC1
> +			device_type = "serial";
> +			compatible = "mpc5200-psc-uart";
> +			port-number = <0>;  // Logical port assignment

I know you said this is still needed, but the driver really needs to
be fixed.  This is not a proper way of using the device tree for
logical numbering.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
