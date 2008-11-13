Return-Path: <dgibson@ozlabs.org>
Date: Fri, 14 Nov 2008 10:45:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Barkowski <michael.barkowski@freescale.com>
Subject: Re: [PATCH] mpc832x_rdb: fix swapped ethernet ids
Message-ID: <20081113234507.GB32024@yookeroo.seuss>
References: <491C4544.7020707@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <491C4544.7020707@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 13, 2008 at 10:18:28AM -0500, Michael Barkowski wrote:
> ethernet0 (called FSL UEC0 in U-Boot) should be enet1 (UCC3/eth1), and
> ethernet1 should be enet0 (UCC2/eth0), to be consistent with U-Boot so
> that the interfaces do not swap addresses when control passes from
> U-Boot to the kernel.

Um.. why is just swapping the aliases, rather than the enet labels the
right approach here?

> diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> index 226ff06..dea3091 100644
> --- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> @@ -18,8 +18,8 @@
> 	#size-cells = <1>;
>
> 	aliases {
> -		ethernet0 = &enet0;
> -		ethernet1 = &enet1;
> +		ethernet0 = &enet1;
> +		ethernet1 = &enet0;
> 		serial0 = &serial0;
> 		serial1 = &serial1;
> 		pci0 = &pci0;
>
>
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
