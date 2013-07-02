Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9CC712C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 08:01:50 +1000 (EST)
Message-ID: <1372802478.4122.24.camel@pasglop>
Subject: Re: [PATCH] powerpc/powernv: Mark pnv_pci_init_ioda2_phb() as __init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 03 Jul 2013 08:01:18 +1000
In-Reply-To: <20130702182003.28238.61942.stgit@bhelgaas-glaptop>
References: <20130702182003.28238.61942.stgit@bhelgaas-glaptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-02 at 12:20 -0600, Bjorn Helgaas wrote:
> Mark pnv_pci_init_ioda2_phb() as __init.  It is called only from an
> init function (pnv_pci_init()), and it calls an init function
> (pnv_pci_init_ioda_phb()):
> 
>     pnv_pci_init                # init
>       pnv_pci_init_ioda2_phb    # non-init
> 	pnv_pci_init_ioda_phb   # init
> 
> This should fix a section mismatch warning.

Thanks. I should look at those warnings more often...

Cheers,
Ben.

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 9c9d15e..dfbb03d 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1210,7 +1210,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
>  		opal_pci_set_pe(phb_id, 0, 0, 7, 1, 1 , OPAL_MAP_PE);
>  }
>  
> -void pnv_pci_init_ioda2_phb(struct device_node *np)
> +void __init pnv_pci_init_ioda2_phb(struct device_node *np)
>  {
>  	pnv_pci_init_ioda_phb(np, PNV_PHB_IODA2);
>  }
