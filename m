Return-Path: <dgibson@ozlabs.org>
Date: Mon, 5 Nov 2007 11:56:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH v2 11/12] [POWERPC] Promess Motion-PRO DTS
Message-ID: <20071105005626.GI19867@localhost.localdomain>
References: <20071103235210.31906.83423.stgit@hekate.izotz.org>
	<20071103235317.31906.46911.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071103235317.31906.46911.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 04, 2007 at 12:53:17AM +0100, Marian Balakowicz wrote:
> Add device tree source file for Motion-PRO board.
> 
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>

Same comments as for the other two device trees, plus those below:

[snip]
> +		motionpro-statusled@660 {	// Motion-PRO status LED
> +			compatible = "promess,motionpro-statusled";
> +			cell-index = <6>;
> +			reg = <660 10>;
> +			interrupts = <1 f 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +			blink-delay = <64>; // 100 msec
> +		};
> +
> +		motionpro-readyled@670 {	// Motion-PRO ready LED
> +			compatible = "promess,motionpro-readyled";
> +			cell-index = <7>;

These cell-index values for the LEDs look very strange.  How are they
used?

> +			reg = <670 10>;
> +			interrupts = <1 10 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};
> +
> +		rtc@800 {	// Real time clock
> +			compatible = "mpc5200b-rtc","mpc5200-rtc";
> +			device_type = "rtc";
> +			reg = <800 100>;
> +			interrupts = <1 5 0 1 6 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};
> +
> +		mscan@980 {
> +			compatible = "mpc5200b-mscan","mpc5200-mscan";
> +			cell-index = <1>;

As for serial and gpt, is cell-index really suitable here?

> +			interrupts = <2 12 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +			reg = <980 80>;
> +		};

[snip]
> +		spi@f00 {
> +			device_type = "spi";
> +			compatible = "mpc5200b-spi","mpc5200-spi";
> +			reg = <f00 20>;
> +			interrupts = <2 d 0 2 e 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};
[snip]
> +		// PSC2 in spi master mode 
> +		spi@2200 {		// PSC2
> +			device_type = "spi";
> +			compatible = "mpc5200b-psc-spi","mpc5200-psc-spi";
> +			cell-index = <1>;

cell-index present for one spi, but not the other makes be even more
suspicious about it's applicability here...

> +			reg = <2200 100>;
> +			interrupts = <2 2 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};

[snip]
> +	lpb {
> +		model = "fsl,lpb";
> +		compatible = "fsl,lpb";

Is lpb another one of these chipselect/offset configurable bus bridge
things?  If so, you should use a 2-cell addressing convention for the
subnodes like fsl localbus and 4xx EBC.

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <50000000 50000000 00030000
> +			  ff000000 ff000000 01000000>;
> +
> +		// 8-bit DualPort SRAM on LocalPlus Bus CS1
> +		kollmorgen@50000000 {
> +			compatible = "promess,motionpro-kollmorgen";
> +			reg = <50000000 ffff>;
> +			interrupts = <1 1 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};
> +
> +		// 8-bit board CPLD on LocalPlus Bus CS2
> +		cpld@50010000 {
> +			compatible = "promess,motionpro-cpld";
> +			reg = <50010000 ffff>;
> +		};
> +
> +		// 8-bit custom Anybus Module on LocalPlus Bus CS3
> +		anybus50020000 {

Missing '@'.

> +			compatible = "promess,motionpro-anybus";
> +			reg = <50020000 ffff>;
> +		};
> +		pro_module_general@50020000 {
> +			compatible = "promess,pro_module_general";
> +			reg = <50020000 3>;
> +		};
> +		pro_module_dio@50020800 {
> +			compatible = "promess,pro_module_dio";
> +			reg = <50020800 2>;
> +		};
> +	};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
