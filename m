Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com
 [IPv6:2607:f8b0:4001:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3EAC21A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 09:32:38 +1000 (AEST)
Received: by ieczm2 with SMTP id zm2so121162472iec.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2015 16:32:36 -0700 (PDT)
Date: Mon, 1 Jun 2015 18:32:33 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 04/10] powerpc/eeh: Trace first 7 BARs in address cache
Message-ID: <20150601233233.GE3631@google.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-5-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432032612-21701-5-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The subject says "Trace first 7 BARs..."  I think maybe you meant "Track
first 7 BARs" or maybe "Cache only BARs, not windows or IOV BARs"

On Tue, May 19, 2015 at 06:50:06PM +0800, Wei Yang wrote:
> EEH address cache, which helps to locate the PCI device according to
> the given (physical) MMIO address, didn't cover PCI bridges. 

"doesn't contain PCI bridge windows"?

I see that eeh_addr_cache_insert_dev() ignores bridges because it never
calls __eeh_addr_cache_insert_dev() when "(dev->class >> 16) ==
PCI_BASE_CLASS_BRIDGE".  I think it would be more technically correct if
you removed that test and relied on the "i <= PCI_ROM_RESOURCE" test in
this patch, because it is legal (though rare) for bridge devices to have
two BARs, and I assume you would want to put those in your cache if they
exist.

> Also, it
> shouldn't return PF with address in PF's IOV BARs. Instead, the VFs
> should be returned.
> The patch restricts the address cache to cover first 7 BARs for the
> above purposes.
> 
> [gwshan: changelog]
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/eeh_cache.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
> index eeabeab..f6c5f05 100644
> --- a/arch/powerpc/kernel/eeh_cache.c
> +++ b/arch/powerpc/kernel/eeh_cache.c
> @@ -196,7 +196,7 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
>  	}
>  
>  	/* Walk resources on this device, poke them into the tree */
> -	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
>  		unsigned long start = pci_resource_start(dev,i);
>  		unsigned long end = pci_resource_end(dev,i);
>  		unsigned int flags = pci_resource_flags(dev,i);
> -- 
> 1.7.9.5
> 
