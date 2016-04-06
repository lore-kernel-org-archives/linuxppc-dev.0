Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfpRg5TffzDq6L
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 11:44:15 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 6 Apr 2016 11:44:14 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0F4753578056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 11:44:08 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u361hxPW62062674
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 11:44:08 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u361hYfs024963
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 11:43:35 +1000
Date: Wed, 6 Apr 2016 11:43:09 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, alex.williamson@redhat.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 gwshan@linux.vnet.ibm.com
Subject: Re: [RFC v5 3/7] PCI: Add a new option for resource_alignment to
 reassign alignment
Message-ID: <20160406014309.GA17201@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1459863813-2830-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1459863813-2830-4-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459863813-2830-4-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 05, 2016 at 09:43:31PM +0800, Yongji Xie wrote:
>When using resource_alignment kernel parameter,
>the current implement reassigns the alignment by
>changing resources' size which can potentially
>break some drivers. For example, the driver uses
>the size to locate some register whose length is
>related to the size.
>
>This adds a new option "noresize" for the
>parameter to solve this problem.
>
>Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>---
> Documentation/kernel-parameters.txt |    5 ++++-
> drivers/pci/pci.c                   |   37 +++++++++++++++++++++++++----------
> 2 files changed, 31 insertions(+), 11 deletions(-)
>
>diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>index 9a53c92..d8b29ab 100644
>--- a/Documentation/kernel-parameters.txt
>+++ b/Documentation/kernel-parameters.txt
>@@ -2912,13 +2912,16 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
> 				window. The default value is 64 megabytes.
> 		resource_alignment=
> 				Format:
>-				[<order of align>@][<domain>:]<bus>:<slot>.<func>[; ...]
>+				[<order of align>@][<domain>:]<bus>:<slot>.<func>
>+				[:noresize][; ...]

If I'm correct enough, it breaks existing application using this interface. "noresize"
would be a optinal parallel property to "align". So the string would have below format
if nobody else objects:

	order,noresize@domain:bus:slot.func

> 				Specifies alignment and device to reassign
> 				aligned memory resources.
> 				If <order of align> is not specified,
> 				PAGE_SIZE is used as alignment.
> 				PCI-PCI bridge can be specified, if resource
> 				windows need to be expanded.
>+				noresize: Don't change the resources' sizes when
>+				reassigning alignment.
> 		ecrc=		Enable/disable PCIe ECRC (transaction layer
> 				end-to-end CRC checking).
> 				bios: Use BIOS/firmware settings. This is the
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index 1db9267..7271ce3 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -4594,11 +4594,13 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
> /**
>  * pci_specified_resource_alignment - get resource alignment specified by user.
>  * @dev: the PCI device to get
>+ * @resize: whether or not to change resources' size when reassigning alignment
>  *
>  * RETURNS: Resource alignment if it is specified.
>  *          Zero if it is not specified.
>  */
>-static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>+static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>+		bool *resize)
> {
> 	int seg, bus, slot, func, align_order, count;
> 	resource_size_t align = 0;
>@@ -4632,6 +4634,11 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
> 			}
> 		}
> 		p += count;
>+		if (!strncmp(p, ":noresize", 9)) {
>+			*resize = false;
>+			p += 9;
>+		} else
>+			*resize = true;
> 		if (seg == pci_domain_nr(dev->bus) &&
> 			bus == dev->bus->number &&
> 			slot == PCI_SLOT(dev->devfn) &&
>@@ -4664,11 +4671,12 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
> {
> 	int i;
> 	struct resource *r;
>+	bool resize = true;
> 	resource_size_t align, size;
> 	u16 command;
>
> 	/* check if specified PCI is target device to reassign */
>-	align = pci_specified_resource_alignment(dev);
>+	align = pci_specified_resource_alignment(dev, &resize);
> 	if (!align)
> 		return;
>
>@@ -4690,15 +4698,24 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
> 		if (!(r->flags & IORESOURCE_MEM))
> 			continue;
> 		size = resource_size(r);
>-		if (size < align) {
>-			size = align;
>-			dev_info(&dev->dev,
>-				"Rounding up size of resource #%d to %#llx.\n",
>-				i, (unsigned long long)size);
>+		if (resize) {
>+			if (size < align) {
>+				size = align;
>+				dev_info(&dev->dev,
>+					"Rounding up size of resource #%d to %#llx.\n",
>+					i, (unsigned long long)size);
>+			}
>+			r->flags |= IORESOURCE_UNSET;
>+			r->end = size - 1;
>+			r->start = 0;
>+		} else {
>+			if (size > align)
>+				align = size;
>+			r->flags &= ~IORESOURCE_SIZEALIGN;
>+			r->flags |= IORESOURCE_STARTALIGN | IORESOURCE_UNSET;
>+			r->start = align;
>+			r->end = r->start + size - 1;

It could be something like below if you like:

			r->start = max(align, size);
			r->end = r->start + size - 1;

> 		}
>-		r->flags |= IORESOURCE_UNSET;
>-		r->end = size - 1;
>-		r->start = 0;
> 	}
> 	/* Need to disable bridge's resource window,
> 	 * to enable the kernel to reassign new resource

Thanks,
Gavin

>-- 
>1.7.9.5
>
