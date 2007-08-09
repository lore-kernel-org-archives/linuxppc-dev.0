Return-Path: <dgibson@ozlabs.org>
Date: Thu, 9 Aug 2007 13:07:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v3 1/2] [POWERPC] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Message-ID: <20070809030752.GB8261@localhost.localdomain>
References: <20070808170728.GA21118@localhost.localdomain>
	<20070808170921.GA21487@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070808170921.GA21487@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 08, 2007 at 09:09:21PM +0400, Anton Vorontsov wrote:
> mmc_spi already tested to work. When it will hit mainline
> the only change that will be needed is replacing "spidev"
> by "mmc_spi".
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/boot/dts/mpc832x_rdb.dts     |    4 ++-
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c |   52 +++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> index e9c332f..664dd16 100644
> --- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> @@ -207,15 +207,17 @@
>  
>  		spi@4c0 {
>  			device_type = "spi";
> +			fsl,device-id = <1>;

Hrm... Freescale is using these 'fsl,device-id' properties, I'm
guessing they're basically the same thing as the 'cell-index' used in
the EMAC binding.

We should co-ordinate better on this, if it's to become a
convention...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
