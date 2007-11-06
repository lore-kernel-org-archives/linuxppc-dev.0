Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Nov 2007 09:42:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH v3 12/13] [POWERPC] Promess Motion-PRO DTS
Message-ID: <20071106224200.GE31367@localhost.localdomain>
References: <20071106200446.10913.29338.stgit@hekate.izotz.org>
	<20071106200634.10913.6248.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071106200634.10913.6248.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 06, 2007 at 09:06:34PM +0100, Marian Balakowicz wrote:
> Add device tree source file for Motion-PRO board.
> 
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>

[snip]
> +		motionpro-statusled@660 {	// Motion-PRO status LED
> +			compatible = "promess,motionpro-statusled";
> +			reg = <660 10>;
> +			interrupts = <1 f 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +			blink-delay = <64>; // 100 msec
> +		};
> +
> +		motionpro-readyled@670 {	// Motion-PRO ready LED
> +			compatible = "promess,motionpro-readyled";
> +			reg = <670 10>;
> +			interrupts = <1 10 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};

Is there actually any difference in behaviour betweeen the two LEDs?
If not, they should probably have the same compatible value, and
perhaps a "label" property or some such to associate them with a
particular LED.

[snip]
> +		spi@f00 {
> +			device_type = "spi";

No device_type!

> +			compatible = "mpc5200b-spi","mpc5200-spi";
> +			reg = <f00 20>;
> +			interrupts = <2 d 0 2 e 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};
> +
> +		usb@1000 {
> +			device_type = "usb-ohci-be";

Nor here.

> +			compatible = "mpc5200b-ohci","mpc5200-ohci","ohci-be";
> +			reg = <1000 ff>;
> +			interrupts = <2 6 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};

[snip]
> +		// PSC2 in spi master mode 
> +		spi@2200 {		// PSC2
> +			compatible = "mpc5200b-psc-spi","mpc5200-psc-spi";
> +			cell-index = <1>;

>From your description, this is an incorrect usage of cell-index - it
should *only* be used to index into SoC shared registers; never for
logical numbering.

> +			reg = <2200 100>;
> +			interrupts = <2 2 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
