Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AD911A0C44
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 17:38:15 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 30 Oct 2015 16:38:14 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8B6F52BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 17:38:11 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9U6c3DS61276352
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 17:38:11 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9U6bcCN020413
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 17:37:39 +1100
Date: Fri, 30 Oct 2015 14:37:13 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 05/12] powerpc/eeh: Cache only BARs, not windows or
 IOV BARs
Message-ID: <20151030063713.GB5940@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-6-git-send-email-weiyang@linux.vnet.ibm.com>
 <5632E283.7000601@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5632E283.7000601@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 30, 2015 at 02:22:43PM +1100, Alexey Kardashevskiy wrote:
>On 10/26/2015 02:15 PM, Wei Yang wrote:
>>EEH address cache, which helps to locate the PCI device according to
>>the given (physical) MMIO address, didn't cover PCI bridges. Also, it
>>shouldn't return PF
>
>"it shouldn't return" is about the cache, right? eeh_addr_cache_get_dev() -
>this guy can "return", the cache cannot.
>

Here I want to say if we cache the PF's IOV BAR, eeh_addr_cache_get_dev()
would return PF when the address is for VF.

>>with address in PF's IOV BARs. Instead, the VFs
>>should be returned.
>>
>>Also, by doing so, it removes the type check in
>>eeh_addr_cache_insert_dev(), since bridge's window would not be cached.
>>
>>The patch restricts the address cache to cover first 7 BARs for the
>>above purposes.
>
>
>I'd better understand something like this :)
>
>This restricts the EEH address cache to use only first 7 BARs. This makes
>__eeh_addr_cache_insert_dev() ignore PCI bridge windows and IOV BARs. As the
>result of this change, eeh_addr_cache_get_dev() will return VFs from VF's
>resource addresses instead of parent PFs.
>
>This removes extra check for a PCI bridge as we limit
>__eeh_addr_cache_insert_dev() to 7 BARs and this effectively excludes PCI
>bridges from being cached.
>

Yep, I think this one is more clear. Would use this one.

>
>>
>>[gwshan: changelog]
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/kernel/eeh_cache.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>>diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
>>index a1e86e1..e6887f0 100644
>>--- a/arch/powerpc/kernel/eeh_cache.c
>>+++ b/arch/powerpc/kernel/eeh_cache.c
>>@@ -196,7 +196,7 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
>>  	}
>>
>>  	/* Walk resources on this device, poke them into the tree */
>>-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>>+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
>>  		resource_size_t start = pci_resource_start(dev,i);
>>  		resource_size_t end = pci_resource_end(dev,i);
>>  		unsigned long flags = pci_resource_flags(dev,i);
>>@@ -222,10 +222,6 @@ void eeh_addr_cache_insert_dev(struct pci_dev *dev)
>>  {
>>  	unsigned long flags;
>>
>>-	/* Ignore PCI bridges */
>>-	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
>>-		return;
>>-
>>  	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
>>  	__eeh_addr_cache_insert_dev(dev);
>>  	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
>>
>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me
