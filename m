Return-Path: <dgibson@ozlabs.org>
Date: Mon, 3 Dec 2007 12:52:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Li Li <r64360@freescale.com>
Subject: Re: [PATCH] Add IPIC MSI interrupt support
Message-ID: <20071203015209.GD26919@localhost.localdomain>
References: <1196394519.29683.8.camel@Guyver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196394519.29683.8.camel@Guyver>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 30, 2007 at 11:48:39AM +0800, Li Li wrote:
> The IPIC MSI is introduced on MPC837x chip.
> Implements the IPIC MSI as two level interrupt controller.
> 
> Signed-off-by: Tony Li <tony.li@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8377_mds.dts     |   14 ++
>  arch/powerpc/boot/dts/mpc8378_mds.dts     |   14 ++
>  arch/powerpc/boot/dts/mpc8379_mds.dts     |   14 ++
>  arch/powerpc/platforms/83xx/Kconfig       |    6 +
>  arch/powerpc/platforms/83xx/mpc837x_mds.c |   11 +
>  arch/powerpc/sysdev/Makefile              |    1 +
>  arch/powerpc/sysdev/ipic_msi.c            |  359 +++++++++++++++++++++++++++++
>  include/asm-powerpc/ipic_msi.h            |   54 +++++
>  8 files changed, 473 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/ipic_msi.c
>  create mode 100644 include/asm-powerpc/ipic_msi.h
> 
> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
> index 1f7819e..1068fe2 100644
> --- a/arch/powerpc/boot/dts/mpc8377_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
> @@ -210,6 +210,20 @@
>  			#interrupt-cells = <2>;
>  			reg = <700 100>;
>  		};
> +
> +		ipic-msi@7c0 {
> +			compatible = "fsl,ipic-msi";
> +			reg = <7c0 40>;
> +			interrupts = < 43 8
> +				       4  8
> +				       51 8
> +				       52 8
> +				       56 8
> +				       57 8
> +				       58 8
> +				       59 8 >;
> +			interrupt-parent = < &ipic >;
> +		};

I'm not sure why the MSI needs a device node of its own.  What actual
piece of hardware is this representing?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
