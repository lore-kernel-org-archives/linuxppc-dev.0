Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 63E61B6FFF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 14:33:30 +1100 (EST)
Message-ID: <1331955202.3105.178.camel@pasglop>
Subject: Re: [PATCH v2 5/7] powerpc/PCI: allow reallocation on PA Semi
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 17 Mar 2012 14:33:22 +1100
In-Reply-To: <20120316234819.6649.55979.stgit@bhelgaas.mtv.corp.google.com>
References: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
 <20120316234819.6649.55979.stgit@bhelgaas.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-03-16 at 17:48 -0600, Bjorn Helgaas wrote:
> We believe there's no reason to prevent reallocation on PA Semi, so
> revert to the default of "allow reallocation if necessary."
> 

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: linuxppc-dev@lists.ozlabs.org
> Tested-by: Olof Johansson <olof@lixom.net>
> Acked-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/platforms/pasemi/pci.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
> index b27d886..aa86271 100644
> --- a/arch/powerpc/platforms/pasemi/pci.c
> +++ b/arch/powerpc/platforms/pasemi/pci.c
> @@ -229,9 +229,6 @@ void __init pas_pci_init(void)
>  
>  	/* Setup the linkage between OF nodes and PHBs */
>  	pci_devs_phb_init();
> -
> -	/* Use the common resource allocation mechanism */
> -	pci_add_flags(PCI_PROBE_ONLY);
>  }
>  
>  void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)
