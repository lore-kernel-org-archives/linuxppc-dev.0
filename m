Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66B95DDDE3
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 18:26:50 +1100 (EST)
Subject: Re: [PATCH] powerpc: remove unused variable from pci_dlpar.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20081103180712.0494af2b.sfr@canb.auug.org.au>
References: <20081103180712.0494af2b.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 03 Nov 2008 18:26:33 +1100
Message-Id: <1225697193.8004.241.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, pauus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-11-03 at 18:07 +1100, Stephen Rothwell wrote:
> And get rid of this build warning:
> 
> arch/powerpc/platforms/pseries/pci_dlpar.c: In function 'init_phb_dynamic':
> arch/powerpc/platforms/pseries/pci_dlpar.c:192: warning: unused variable 'b'
> 
> This is one of the very few warnings left in a ppc64_defconfig build and
> getting rid of it will make it easier to see future introduced ones (in
> fact this was introduced very recently).
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---

Ack.

>  arch/powerpc/platforms/pseries/pci_dlpar.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> This patch is against Linus' tree and so could go into 2.6.28 if you
> think it should.  This is also fixed by one of Ben's ominbus patches
> (http://patchwork.ozlabs.org/patch/6041/) but this is more suitable for
> upstream merge.
> 
> diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
> index 31481dc..7190493 100644
> --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
> +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
> @@ -189,7 +189,6 @@ struct pci_controller * __devinit init_phb_dynamic(struct device_node *dn)
>  {
>  	struct pci_controller *phb;
>  	int primary;
> -	struct pci_bus *b;
>  
>  	primary = list_empty(&hose_list);
>  	phb = pcibios_alloc_controller(dn);
> -- 
> 1.5.6.5
> 
