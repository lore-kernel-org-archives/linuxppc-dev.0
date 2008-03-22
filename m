Return-Path: <dgibson@ozlabs.org>
Date: Sat, 22 Mar 2008 11:12:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Bartlomiej Sieka <tur@semihalf.com>
Subject: Re: [POWERPC] mpc52xx: Amalgamated dts fixes and updates
Message-ID: <20080322001242.GA29812@localhost.localdomain>
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>
	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>
	<47E2FC3E.1020705@semihalf.com>
	<fa686aa40803201720l3e42c983se121ebc257c89912@mail.gmail.com>
	<20080321235633.GB345@frozen.semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080321235633.GB345@frozen.semihalf.com>
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 22, 2008 at 12:56:35AM +0100, Bartlomiej Sieka wrote:
> The bulk of this patch is taken from
> http://patchwork.ozlabs.org/linuxppc/patch?q=Balakowicz&id=16197, with few
> other updates, in particluar one posted by Anatolij Gustschin, which fixes
> an Oops during boot.
>     
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> ---
> Anatolij, would you like to add your S-O-B?
> 
> diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
> index 30737ea..8b2e8e4 100644
> --- a/arch/powerpc/boot/dts/cm5200.dts
> +++ b/arch/powerpc/boot/dts/cm5200.dts
> @@ -159,6 +159,7 @@
>  		};
>  
>  		dma-controller@1200 {
> +			device_type = "dma-controller";

This is not right.  If adding device_type here fixes something, then
the driver is wrong and should be fixed instead.

[snip]
> +		mdio@3000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "mdio";

Likewise device_type should not appear here.

[snip]
>  		i2c@3d40 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;

Looks like incorrect indentation here.

[snip]
> +		mscan@900 {
> +			compatible = "mpc5200b-mscan\0mpc5200-mscan";

Use "mpc5200b-mscan", "mpc5200-mscan" instead of the embedded \0.

[snip]
>  		dma-controller@1200 {
> +			device_type = "dma-controller";

As above.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
