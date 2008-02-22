Return-Path: <dgibson@ozlabs.org>
Date: Fri, 22 Feb 2008 12:48:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 3/5 v3] [POWERPC] Add Canyonlands DTS
Message-ID: <20080222014843.GA2602@localhost.localdomain>
References: <1203603768-13880-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1203603768-13880-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 21, 2008 at 03:22:48PM +0100, Stefan Roese wrote:
> Signed-off-by: Stefan Roese <sr@denx.de>

[snip]
> +		MAL0: mcmal {
> +			compatible = "ibm,mcmal-460ex", "ibm,mcmal2";
> +			dcr-reg = <180 62>;
> +			num-tx-chans = <2>;
> +			num-rx-chans = <10>;
> +			interrupt-parent = <&MAL0>;
> +			interrupts = <0 1 2 3 4>;
> +			#interrupt-cells = <1>;
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			interrupt-map = </*TXEOB*/ 0 &UIC2 6 4
> +					 /*RXEOB*/ 1 &UIC2 7 4
> +					 /*SERR*/  2 &UIC2 3 4
> +					 /*TXDE*/  3 &UIC2 4 4
> +					 /*RXDE*/  4 &UIC2 5 4>;
> +			interrupt-map-mask = <ffffffff>;

Because all the MAL interrupts are on the same UIC, you don't need
this interrupt-map nonsense here - that's just a workaround for the
chips that have the MAL interrupts spread across different UICs.  You
can just use:

	interrupt-parent = <&UIC2>;
	interrupts = <6 4 7 4 3 4 4 4 5 4>;

[snip]
> +			IIC0: i2c@4ef60700 {
> +				device_type = "i2c";

No device_type here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
