Return-Path: <SRS0=6MgZ=OL=denx.de=sr@srs.kundenserver.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 3/4] 4xx: Convert Walnut flash mappings to new binding
Date: Sat, 15 Sep 2007 05:23:12 +0200
References: <20070914185410.387074000@linux.vnet.ibm.com>
	<20070914185410.387074000@linux.vnet.ibm.com>>
	<20070914185649.272138000@linux.vnet.ibm.com>>
In-Reply-To: <20070914185649.272138000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709150523.12817.sr@denx.de>
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 14 September 2007, Josh Boyer wrote:
> A new binding for flash devices was recently introduced.  This updates the
> Walnut DTS to use the new binding.
>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> ---
>  arch/powerpc/boot/dts/walnut.dts |   17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> --- linux-2.6.orig/arch/powerpc/boot/dts/walnut.dts
> +++ linux-2.6/arch/powerpc/boot/dts/walnut.dts
> @@ -137,6 +137,10 @@
>  			dcr-reg = <012 2>;
>  			#address-cells = <2>;
>  			#size-cells = <1>;
> +			/* The ranges property is supplied by the bootwrapper
> +			 * and is based on the firmware's configuration of the
> +			 * EBC bridge
> +			 */
>  			clock-frequency = <0>; /* Filled in by zImage */
>
>  			sram@0,0 {
> @@ -144,13 +148,16 @@
>  			};
>
>  			flash@0,80000 {
> -				device_type = "rom";
> -				compatible = "direct-mapped";
> -				probe-type = "JEDEC";
> +				compatible = "jedec-flash";
>  				bank-width = <1>;
> -				partitions = <0 80000>;
> -				partition-names = "OpenBIOS";
>  				reg = <0 80000 80000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				partition@0 {
> +					label = "OpenBIOS";
> +					reg = <0 80000>;
> +					read-only;
> +				};

There are not only Bamboo board running PIBS, but running U-Boot too. How 
should we handle this different FLASH partitioning? Same goes for Ebony too 
btw.

Best regards,
Stefan
