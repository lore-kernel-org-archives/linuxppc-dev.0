Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.226])
	by ozlabs.org (Postfix) with ESMTP id 9E6A6DDF00
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 15:42:11 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d8so2681078qbc.37
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 22:42:10 -0700 (PDT)
Date: Sat, 28 Jun 2008 23:42:07 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: John Rigby <jrigby@freescale.com>, galak@kernel.crashing.org
Subject: Re: [PATCH 6/6] MPC5121 Hide pci bridge
Message-ID: <20080629054207.GE13876@secretlab.ca>
References: <1213981119-1979-1-git-send-email-jrigby@freescale.com>
	<1213981119-1979-2-git-send-email-jrigby@freescale.com>
	<1213981119-1979-3-git-send-email-jrigby@freescale.com>
	<1213981119-1979-4-git-send-email-jrigby@freescale.com>
	<1213981119-1979-5-git-send-email-jrigby@freescale.com>
	<1213981119-1979-6-git-send-email-jrigby@freescale.com>
	<1213981119-1979-7-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1213981119-1979-7-git-send-email-jrigby@freescale.com>
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

On Fri, Jun 20, 2008 at 10:58:39AM -0600, John Rigby wrote:
> The class of the MPC5121 pci host bridge is PCI_CLASS_BRIDGE_OTHER
> while other freescale host bridges have class set to
> PCI_CLASS_PROCESSOR_POWERPC.
> 
> This patch makes fixup_hide_host_resource_fsl match
> PCI_CLASS_BRIDGE_OTHER in addition to PCI_CLASS_PROCESSOR_POWERPC.
> 
> Signed-off-by: John Rigby <jrigby@freescale.com>

This looks right to me, but I'm not really qualified to say if it is
correct or not (limited PCI experience).  I don't know who needs to look
at it.  Kumar perhaps?

Cheers,
g.

> ---
>  arch/powerpc/kernel/pci_32.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> index 88db4ff..3d33935 100644
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
> +	if ((class == PCI_CLASS_PROCESSOR_POWERPC
> +		    || class == PCI_CLASS_BRIDGE_OTHER) &&
>  		(dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
>  		(dev->bus->parent == NULL)) {
>  		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> -- 
> 1.5.6.rc0.46.gd2b3
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
