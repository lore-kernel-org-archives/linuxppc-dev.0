Return-Path: <dgibson@ozlabs.org>
Date: Mon, 24 Sep 2007 15:07:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
Message-ID: <20070924050709.GM8058@localhost.localdomain>
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
	<20070920133528.GC14820@ld0162-tx32.am.freescale.net>
	<874pholbdk.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <874pholbdk.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 09:35:03AM +0200, Peter Korsgaard wrote:
> >>>>> "Scott" == Scott Wood <scottwood@freescale.com> writes:
> 
> Hi,
> 
>  Scott> #size-cells is zero on i2c, so it should just be reg = <68>.
> 
>  Scott> You'll probably need to add #address-cells and #size-cells to the
>  Scott> controller node, as well.

Uh.. yes.. i2c interfaces should really always have #a and #s.

> Ahh - Thanks. This should be better.
> ---
> 
> [PATCH] mpc8349emitx.dts: Add ds1339 RTC
> 
> Add ds1339 I2C RTC chip as child of 2nd I2C controller.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
>  arch/powerpc/boot/dts/mpc8349emitx.dts |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> Index: linux/arch/powerpc/boot/dts/mpc8349emitx.dts
> ===================================================================
> --- linux.orig/arch/powerpc/boot/dts/mpc8349emitx.dts
> +++ linux/arch/powerpc/boot/dts/mpc8349emitx.dts
> @@ -62,12 +62,21 @@
>  		};
>  
>  		i2c@3100 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
>  			device_type = "i2c";

Hrm... we probably want an "i2c" device_type class, but I don't think
we've actually defined one, which is a problem

>  			compatible = "fsl-i2c";
>  			reg = <3100 100>;
>  			interrupts = <f 8>;
>  			interrupt-parent = < &ipic >;
>  			dfsrr;
> +
> +			rtc@68 {
> +				device_type = "rtc";
> +				compatible = "dallas,ds1339";
> +				reg = <68>;
> +			};

I think we want to think a bit more carefully about how to do bindings
for RTC devices.  No "rtc" device_type is defined, but again we might
want to.

I did find one real OF binding for a different Dallas RTC (and NVRAM),
see:

http://playground.sun.com/1275/proposals/Closed/Remanded/Accepted/346-it.txt

It's a little different from the example above.

The fact that NVRAM+RTC chips are so common is a bit of an issue from
the point of view of defining a device class binding - a device can't
have type "rtc" and "nvram".

> +
>  		};
>  
>  		spi@7000 {
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
