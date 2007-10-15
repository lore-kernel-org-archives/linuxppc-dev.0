Return-Path: <dgibson@ozlabs.org>
Date: Mon, 15 Oct 2007 10:37:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v3 9/9] add MPC837x MDS board default device tree
Message-ID: <20071015003703.GA14108@localhost.localdomain>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-2-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
	<1192195728-24189-4-git-send-email-leoli@freescale.com>
	<1192195728-24189-5-git-send-email-leoli@freescale.com>
	<1192195728-24189-6-git-send-email-leoli@freescale.com>
	<1192195728-24189-7-git-send-email-leoli@freescale.com>
	<1192195728-24189-8-git-send-email-leoli@freescale.com>
	<1192195728-24189-9-git-send-email-leoli@freescale.com>
	<1192195728-24189-10-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192195728-24189-10-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 12, 2007 at 09:28:48PM +0800, Li Yang wrote:
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8377_mds.dts |  288 ++++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/mpc8378_mds.dts |  268 ++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/mpc8379_mds.dts |  308 +++++++++++++++++++++++++++++++++
>  3 files changed, 864 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/mpc8377_mds.dts
>  create mode 100644 arch/powerpc/boot/dts/mpc8378_mds.dts
>  create mode 100644 arch/powerpc/boot/dts/mpc8379_mds.dts
> 
> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts
> b/arch/powerpc/boot/dts/mpc8377_mds.dts
[snip]
> +	soc837x@e0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <0 e0000000 00100000>;
> +		reg = <e0000000 00000200>;
> +		bus-frequency = <0>;
> +
> +		wdt@200 {
> +			device_type = "watchdog";

Drop this device_type.

> +			compatible = "mpc83xx_wdt";
> +			reg = <200 100>;
> +		};
> +
> +		i2c@3000 {
> +			device_type = "i2c";

And this one.

> +			compatible = "fsl-i2c";
> +			reg = <3000 100>;
> +			interrupts = <e 8>;
> +			interrupt-parent = < &ipic >;
> +			dfsrr;
> +		};
> +
> +		i2c@3100 {
> +			device_type = "i2c";

And here.

> +			compatible = "fsl-i2c";
> +			reg = <3100 100>;
> +			interrupts = <f 8>;
> +			interrupt-parent = < &ipic >;
> +			dfsrr;
> +		};
> +
> +		spi@7000 {
> +			device_type = "spi";

And this one.

[snip]
> +		crypto@30000 {
> +			device_type = "crypto";

And definitely this one.

> +			model = "SEC3";
> +			compatible = "talitos";
> +			reg = <30000 10000>;
> +			interrupts = <b 8>;
> +			interrupt-parent = < &ipic >;
> +			/* Rev. 3.0 geometry */
> +			num-channels = <4>;
> +			channel-fifo-len = <18>;
> +			exec-units-mask = <000009fe>;
> +			descriptor-types-mask = <03ab0ebf>;
> +		};
> +
> +		sdhc@2e000 {
> +			model = "eSDHC";
> +			compatible = "fsl,esdhc";
> +			reg = <2e000 1000>;
> +			interrupts = <2a 8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		sata@18000 {
> +			device_type = "sata";

And again.


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
