Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 Jul 2008 09:53:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] [POWERPC] 52xx: add missing MSCAN FDT nodes for TQM52xx
Message-ID: <20080706235328.GB6267@yookeroo.seuss>
References: <486B50D8.5000009@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <486B50D8.5000009@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 02, 2008 at 11:56:40AM +0200, Wolfgang Grandegger wrote:
> This patch adds the still missing FDT nodes for the MSCAN devices for
> the TQM52xx modules.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> arch/powerpc/boot/dts/tqm5200.dts |   16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
>
> Index: linux-2.6-galak/arch/powerpc/boot/dts/tqm5200.dts
> ===================================================================
> --- linux-2.6-galak.orig/arch/powerpc/boot/dts/tqm5200.dts
> +++ linux-2.6-galak/arch/powerpc/boot/dts/tqm5200.dts
> @@ -70,6 +70,22 @@
> 			fsl,has-wdt;
> 		};
>
> +		can@900 {
> +			compatible = "fsl,mpc5200-mscan";
> +			cell-index = <0>;

What shared resource are these cell-index values used to index into?
Because cell-index is so freqeuntly misunderstood, I strongly
recommend putting a comment describing this.

> +			interrupts = <2 17 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +			reg = <0x900 0x80>;
> +		};
> +
> +		can@980 {
> +			compatible = "fsl,mpc5200-mscan";
> +			cell-index = <1>;
> +			interrupts = <2 18 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +			reg = <0x980 0x80>;
> +		};
> +
> 		gpio@b00 {
> 			compatible = "fsl,mpc5200-gpio";
> 			reg = <0xb00 0x40>;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
