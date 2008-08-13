Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id A3EC9DDED5
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 15:17:01 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2712424rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 22:17:00 -0700 (PDT)
Date: Tue, 12 Aug 2008 23:16:57 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 5121 pci 3/3] powerpc: pci: 5121: Hide pci bridge.
Message-ID: <20080813051657.GF17587@secretlab.ca>
References: <1218130587-31176-1-git-send-email-jrigby@freescale.com>
	<1218130587-31176-2-git-send-email-jrigby@freescale.com>
	<1218130587-31176-3-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1218130587-31176-3-git-send-email-jrigby@freescale.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 07, 2008 at 11:36:27AM -0600, John Rigby wrote:
> The class of the MPC5121 pci host bridge is PCI_CLASS_BRIDGE_OTHER
> while other freescale host bridges have class set to
> PCI_CLASS_PROCESSOR_POWERPC.
> 
> This patch makes fixup_hide_host_resource_fsl match
> PCI_CLASS_BRIDGE_OTHER in addition to PCI_CLASS_PROCESSOR_POWERPC.
> 
> Signed-off-by: John Rigby <jrigby@freescale.com>

I think this is okay, but it might need to be more conservative.  I'm
not the PCI expert.  Kumar, thoughts?

g.

> ---
>  arch/powerpc/kernel/pci_32.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> index 88db4ff..162c3a8 100644
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -54,11 +54,12 @@ LIST_HEAD(hose_list);
>  static int pci_bus_count;
>  
>  static void
> -fixup_hide_host_resource_fsl(struct pci_dev* dev)
> +fixup_hide_host_resource_fsl(struct pci_dev *dev)
>  {
>  	int i, class = dev->class >> 8;
>  
> -	if ((class == PCI_CLASS_PROCESSOR_POWERPC) &&
> +	if ((class == PCI_CLASS_PROCESSOR_POWERPC ||
> +	     class == PCI_CLASS_BRIDGE_OTHER) &&
>  		(dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
>  		(dev->bus->parent == NULL)) {
>  		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> -- 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
