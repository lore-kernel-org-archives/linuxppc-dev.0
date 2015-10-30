Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0AD301A03D5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 14:22:50 +1100 (AEDT)
Received: by pasz6 with SMTP id z6so59754443pas.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 20:22:48 -0700 (PDT)
Subject: Re: [PATCH V10 05/12] powerpc/eeh: Cache only BARs, not windows or
 IOV BARs
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-6-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5632E283.7000601@ozlabs.ru>
Date: Fri, 30 Oct 2015 14:22:43 +1100
MIME-Version: 1.0
In-Reply-To: <1445829362-2738-6-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/26/2015 02:15 PM, Wei Yang wrote:
> EEH address cache, which helps to locate the PCI device according to
> the given (physical) MMIO address, didn't cover PCI bridges. Also, it
> shouldn't return PF

"it shouldn't return" is about the cache, right? eeh_addr_cache_get_dev() - 
this guy can "return", the cache cannot.

> with address in PF's IOV BARs. Instead, the VFs
> should be returned.
>
> Also, by doing so, it removes the type check in
> eeh_addr_cache_insert_dev(), since bridge's window would not be cached.
>
> The patch restricts the address cache to cover first 7 BARs for the
> above purposes.


I'd better understand something like this :)

This restricts the EEH address cache to use only first 7 BARs. This makes 
__eeh_addr_cache_insert_dev() ignore PCI bridge windows and IOV BARs. As 
the result of this change, eeh_addr_cache_get_dev() will return VFs from 
VF's resource addresses instead of parent PFs.

This removes extra check for a PCI bridge as we limit 
__eeh_addr_cache_insert_dev() to 7 BARs and this effectively excludes PCI 
bridges from being cached.


>
> [gwshan: changelog]
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kernel/eeh_cache.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
> index a1e86e1..e6887f0 100644
> --- a/arch/powerpc/kernel/eeh_cache.c
> +++ b/arch/powerpc/kernel/eeh_cache.c
> @@ -196,7 +196,7 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
>   	}
>
>   	/* Walk resources on this device, poke them into the tree */
> -	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
>   		resource_size_t start = pci_resource_start(dev,i);
>   		resource_size_t end = pci_resource_end(dev,i);
>   		unsigned long flags = pci_resource_flags(dev,i);
> @@ -222,10 +222,6 @@ void eeh_addr_cache_insert_dev(struct pci_dev *dev)
>   {
>   	unsigned long flags;
>
> -	/* Ignore PCI bridges */
> -	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
> -		return;
> -
>   	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
>   	__eeh_addr_cache_insert_dev(dev);
>   	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
>


-- 
Alexey
