Return-Path: <dgibson@ozlabs.org>
Date: Mon, 23 Jul 2007 11:26:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] Update kuroboxH[GD].dts with i2c rtc entries, cleanup
Message-ID: <20070723012602.GA3272@localhost.localdomain>
References: <Pine.LNX.4.60.0707220028370.13322@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0707220028370.13322@poirot.grange>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 22, 2007 at 12:43:11AM +0200, Guennadi Liakhovetski wrote:
> Let's fix rtc on linkstation ppc machines again, plus .dts cleanup as 
> suggested by Segher Boessenkool.
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
> 
> Device tree update: add rtc nodes on i2c, remove bogus 0-size cache-line 
> declarations, rename interrupt-controller nodes, remove erroneous 
> interrupt-parent line, accidentally introduced by a recent patch.
> 
> Signed-off-by: G. Liakhovetski <g.liakhovetski@gmx.de>
> 


[snip]
> @@ -64,11 +62,19 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
>  			  fef00000 fef00000 00100000>;	/* pci iack */
>  
>  		i2c@80003000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
>  			device_type = "i2c";
>  			compatible = "fsl-i2c";
>  			reg = <80003000 1000>;
>  			interrupts = <5 2>;
>  			interrupt-parent = <&mpic>;
> +
> +			rtc@32 {
> +				device_type = "rtc";
> +				compatible = "ricoh,rs5c372b";
> +				reg = <32>;

Ok, just making sure that rtc at 0x32 (decimal 50) is correct, rather
than at decimal 32.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
