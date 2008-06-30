Return-Path: <dgibson@ozlabs.org>
Date: Mon, 30 Jun 2008 14:15:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: Add dma nodes to 83xx, 85xx and 86xx boards
Message-ID: <20080630041525.GD24012@yookeroo.seuss>
References: <Pine.LNX.4.64.0806271449540.9071@blarg.am.freescale.net>
	<48654D6D.1090309@freescale.com>
	<E57F448A-7217-4893-A77B-6367B0C3118A@kernel.crashing.org>
	<Pine.LNX.4.64.0806271609540.10625@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0806271609540.10625@blarg.am.freescale.net>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 27, 2008 at 04:10:17PM -0500, Kumar Gala wrote:
> Added DMA nodes for the elo/elo-plus DMA engines.
> 
> Renamed the interrupt controller alias in mpc832x_rdb.dts to ipic so that
> its the same as all the other boards.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

[snip]
> diff --git a/arch/powerpc/boot/dts/asp834x-redboot.dts b/arch/powerpc/boot/dts/asp834x-redboot.dts
> index 972cf78..8b1bb0e 100644
> --- a/arch/powerpc/boot/dts/asp834x-redboot.dts
> +++ b/arch/powerpc/boot/dts/asp834x-redboot.dts
> @@ -118,6 +118,41 @@
>  			mode = "cpu";
>  		};
> 
> +		dma@82a8 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,mpc8347-dma", "fsl,elo-dma";
> +			reg = <0x82a8 4>;
> +			ranges = <0 0x8100 0x1a8>;
> +			interrupt-parent = <&ipic>;
> +			interrupts = <71 8>;
> +			cell-index = <0>;

What's the cell-index in these nodes used to index?  Given the
confusion there's been about the proper use of this property, a
comment indicating which shared registers this is used to index is
probably a good idea.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
