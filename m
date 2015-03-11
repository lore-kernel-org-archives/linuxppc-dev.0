Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B53DC1A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:20:00 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 15:19:59 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 74BA92CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:19:56 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2B5JmW112976130
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:19:56 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2B5JNka004269
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:19:23 +1100
Date: Wed, 11 Mar 2015 16:18:59 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] powerpc/eeh: fix start/end/flags type in struct
 pci_io_addr_range{}
Message-ID: <20150311051859.GB10336@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1425871052-13118-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1425871052-13118-2-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425871052-13118-2-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 09, 2015 at 11:17:29AM +0800, Wei Yang wrote:
>struct pci_io_addr_range{} stores the information of pci resources. It
>would be better to keep these related fields have the same type as in
>struct resource{}.
>
>This patch fixes the start/end/flags type in struct pci_io_addr_range{} to
>have the same type as in struct resource{}.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> arch/powerpc/kernel/eeh_cache.c |   16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
>index 07d8a24..a30ed67 100644
>--- a/arch/powerpc/kernel/eeh_cache.c
>+++ b/arch/powerpc/kernel/eeh_cache.c
>@@ -48,11 +48,11 @@
>  */
> struct pci_io_addr_range {
> 	struct rb_node rb_node;
>-	unsigned long addr_lo;
>-	unsigned long addr_hi;
>+	resource_size_t addr_lo;
>+	resource_size_t addr_hi;
> 	struct eeh_dev *edev;
> 	struct pci_dev *pcidev;
>-	unsigned int flags;
>+	unsigned long flags;
> };
>
> static struct pci_io_addr_cache {
>@@ -125,8 +125,8 @@ static void eeh_addr_cache_print(struct pci_io_addr_cache *cache)
>
> /* Insert address range into the rb tree. */
> static struct pci_io_addr_range *
>-eeh_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
>-		      unsigned long ahi, unsigned int flags)
>+eeh_addr_cache_insert(struct pci_dev *dev, resource_size_t alo,
>+		      resource_size_t ahi, unsigned long flags)
> {
> 	struct rb_node **p = &pci_io_addr_cache_root.rb_root.rb_node;
> 	struct rb_node *parent = NULL;
>@@ -200,9 +200,9 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
>
> 	/* Walk resources on this device, poke them into the tree */
> 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>-		unsigned long start = pci_resource_start(dev,i);
>-		unsigned long end = pci_resource_end(dev,i);
>-		unsigned int flags = pci_resource_flags(dev,i);
>+		resource_size_t start = pci_resource_start(dev,i);
>+		resource_size_t end = pci_resource_end(dev,i);
>+		unsigned long flags = pci_resource_flags(dev,i);
>
> 		/* We are interested only bus addresses, not dma or other stuff */
> 		if (0 == (flags & (IORESOURCE_IO | IORESOURCE_MEM)))
>-- 
>1.7.9.5
>
