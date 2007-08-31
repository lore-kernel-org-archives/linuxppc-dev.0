Return-Path: <dgibson@ozlabs.org>
Date: Fri, 31 Aug 2007 12:43:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] bootwrapper: In cuImage,
	print message for ENET devices not found in tree
Message-ID: <20070831024356.GA19271@localhost.localdomain>
References: <20070830202618.9927.32588.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070830202618.9927.32588.stgit@trillian.cg.shawcable.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 02:26:18PM -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> CC: Scott Wood <scottwood@freescale.com>
> CC: Kumar Gala <galak@kernel.crashing.org>
> CC: David Gibson <david@gibson.dropbear.id.au>

Hrm... I thought Scott had deliberately removed that message in his
patch set, to work with the way PlanetCore generates Ethernet
addresses.

> ---
> 
>  arch/powerpc/boot/devtree.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
> index e1b8122..8451a1c 100644
> --- a/arch/powerpc/boot/devtree.c
> +++ b/arch/powerpc/boot/devtree.c
> @@ -99,14 +99,14 @@ void __dt_fixup_mac_addresses(u32 startindex, ...)
>  	while ((addr = va_arg(ap, const u8 *))) {
>  		devp = find_node_by_prop_value(NULL, "linux,network-index",
>  					       (void*)&index, sizeof(index));
> -
> -		printf("ENET%d: local-mac-address <-"
> -		       " %02x:%02x:%02x:%02x:%02x:%02x\n\r", index,
> -		       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
> -
> -		if (devp)
> +		if (devp) {
> +			printf("ENET%d: local-mac-address <-"
> +			       " %02x:%02x:%02x:%02x:%02x:%02x\n\r", index,
> +			       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
>  			setprop(devp, "local-mac-address", addr, 6);
> -
> +		} else {
> +			printf("ENET%d: no device in tree\n\r", index);
> +		}
>  		index++;
>  	}
>  	va_end(ap);
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
