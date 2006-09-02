Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7549A67B7F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Sep 2006 13:29:41 +1000 (EST)
Subject: Re: [PATCH] Add new, missing argument to of_irq_map_raw().
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1GJAlk-00053S-3U@jdl.com>
References: <E1GJAlk-00053S-3U@jdl.com>
Content-Type: text/plain
Date: Sat, 02 Sep 2006 13:29:06 +1000
Message-Id: <1157167746.4446.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-09-01 at 10:17 -0500, Jon Loeliger wrote:
> Ben speaks; we follow.

Ooops, sorry. I din't grep around thinking nobody would need to use that
low level function but it looks like you do have a good reason to do
so. 

Ben.

> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
> 
> Paul,
> 
> This patch is needed in the 2.6.18 release for 86xx.
> Ben's recent changes to of_irq_map_raw() missed one caller.
> This patch cleans that up.
> 
> Thanks,
> jdl
> 
> 
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> index 4a33d95..cdaf668 100644
> --- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> +++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> @@ -154,7 +154,7 @@ get_pci_irq_from_of(struct pci_controlle
>  
>  	laddr[0] = (hose->first_busno << 16) | (PCI_DEVFN(slot, 0) << 8);
>  	laddr[1] = laddr[2] = 0;
> -	of_irq_map_raw(hosenode, &pin, laddr, &oirq);
> +	of_irq_map_raw(hosenode, &pin, 1, laddr, &oirq);
>  	DBG("mpc86xx_hpcn: pci irq addr %x, slot %d, pin %d, irq %d\n",
>  			laddr[0], slot, pin, oirq.specifier[0]);
>  	return oirq.specifier[0];
