Return-Path: <dgibson@ozlabs.org>
Date: Tue, 16 Oct 2007 11:15:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v4 9/9] add MPC837x MDS board default device tree
Message-ID: <20071016011504.GB26787@localhost.localdomain>
References: <1192460210-26920-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192460210-26920-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 15, 2007 at 10:56:50PM +0800, Li Yang wrote:
> Signed-off-by: Li Yang <leoli@freescale.com>

[snip]
> +		mdio@24520 {
> +			device_type = "mdio";
> +			compatible = "gianfar";
> +			reg = <24520 20>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			phy2: ethernet-phy@2 {
> +				interrupt-parent = < &ipic >;
> +				interrupts = <11 8>;
> +				reg = <2>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy3: ethernet-phy@3 {
> +				interrupt-parent = < &ipic >;
> +				interrupts = <12 8>;
> +				reg = <3>;
> +				device_type = "ethernet-phy";
> +			};
> +		};
> +
> +		ethernet@24000 {
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";

This isn't a problem with *this* patch per se, but we have *got* to
fix that fucked up binding which gives both the mdio and ethernet
devices the same compatible property.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
