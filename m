Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Dec 2007 13:01:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] add MPC837x MDS board default device tree
Message-ID: <20071207020130.GA26412@localhost.localdomain>
References: <1196851073-11801-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196851073-11801-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 05, 2007 at 06:37:53PM +0800, Li Yang wrote:
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Update SATA nodes; remove serdes nodes; add aliases and labels.
> 
>  arch/powerpc/boot/dts/mpc8377_mds.dts |  270 +++++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/mpc8378_mds.dts |  256 +++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/mpc8379_mds.dts |  284 +++++++++++++++++++++++++++++++++
>  3 files changed, 810 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/mpc8377_mds.dts
>  create mode 100644 arch/powerpc/boot/dts/mpc8378_mds.dts
>  create mode 100644 arch/powerpc/boot/dts/mpc8379_mds.dts
> 
> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
> new file mode 100644
> index 0000000..919ffd0
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
[snip]
> +	aliases {
> +		ethernet0 = "/soc@e0000000/ethernet@24000";
> +		ethernet1 = "/soc@e0000000/ethernet@25000";
> +		serial0 = "/soc@e0000000/serial@4500";
> +		serial1 = "/soc@e0000000/serial@4600";
> +		pci0 = "/pci@e0008500";

You can use path references for these now.

> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,837x@0 {

This should absolutely not have a "x" in it.  Either have an exact
model, or just use "cpu@9" (in which case you can put the model in
"compatible").

[snip]
> +		i2c@3000 {
> +			device_type = "i2c";

Drop the device_type.  No "i2c" device_type class is defined.

[snip]
> +		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
> +		usb@23000 {
> +			device_type = "usb";

Drop device_type here too.

> +			compatible = "fsl-usb2-dr";
> +			reg = <23000 1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupt-parent = < &ipic >;
> +			interrupts = <26 8>;
> +			phy_type = "utmi_wide";
> +		};
> +
> +		mdio@24520 {
> +			device_type = "mdio";
> +			compatible = "gianfar";

Grr... not your fault, but this crap in the gianfar driver where it
uses the same compatible property for the mdio and MAC has to be
fixed.

[snip]

> +		serial1:serial@4600 {

Standard style puts a space after the colon.

> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4600 100>;
> +			clock-frequency = <0>;
> +			interrupts = <a 8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		crypto@30000 {
> +			model = "SEC3";
> +			compatible = "talitos";

This driver, also, needs fixing to recognize a better formatted
compatible property.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
