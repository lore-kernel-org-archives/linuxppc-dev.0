Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2DB5F2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 07:34:40 +1000 (EST)
Message-ID: <1367876070.15842.60.camel@pasglop>
Subject: Re: [PATCH 3/3] powerpc/powernv: Don't configure IO window on PHB3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 07 May 2013 07:34:30 +1000
In-Reply-To: <1367847858-6506-3-git-send-email-shangw@linux.vnet.ibm.com>
References: <1367847858-6506-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1367847858-6506-3-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: yinghai@kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-06 at 21:44 +0800, Gavin Shan wrote:
> We needn't configure IO windows for the corresponding PEs on PHB3
> since that doesn't support IO.

Here too, no need for such a flag, just check that
pci_controller->io_resource.flags is 0.

BTW. Please work on top of the patch I sent already that avoids adding
bogus resources to pci_host_bridge when their flags are 0. I'll send
it to Linus today.

Cheers,
Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 0c3fa29..b4f3edb 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -894,7 +894,9 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>  		    res->start > res->end)
>  			continue;
>  
> -		if (res->flags & IORESOURCE_IO) {
> +		/* We needn't setup IO windows for PHB3 */
> +		if (!(pe->pbus->bus_flags & PCI_BUS_FLAGS_NO_IO) &&
> +		    res->flags & IORESOURCE_IO) {
>  			region.start = res->start - phb->ioda.io_pci_base;
>  			region.end   = res->end - phb->ioda.io_pci_base;
>  			index = region.start / phb->ioda.io_segsize;
