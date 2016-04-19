Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqMTN30JPzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:00:24 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 10:00:23 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C712F2BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:00:18 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K00AAN3867120
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:00:18 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3JNxipN019674
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 09:59:45 +1000
Date: Wed, 20 Apr 2016 09:59:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 03/45] powerpc/pci: Cleanup on struct pci_controller_ops
Message-ID: <20160419235919.GA11304@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <570DDE99.7070103@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570DDE99.7070103@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2016 at 03:52:25PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:43 PM, Gavin Shan wrote:
>>Each PHB has one instance of "struct pci_controller_ops", which
>>includes various callbacks called by PCI subsystem. In the definition
>>of this struct, some callbacks have explicit names for its arguments,
>>but the left don't have.
>>
>>This adds all explicit names of the arguments to the callbacks in
>>"struct pci_controller_ops" so that the code looks consistent.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>Reviewed-by: Daniel Axtens <dja@axtens.net>
>
>With tiny nit below,
>
>Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
>
>
>>---
>>  arch/powerpc/include/asm/pci-bridge.h | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>index b688d04..4dd6ef4 100644
>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>@@ -21,18 +21,19 @@ struct pci_controller_ops {
>>  	void		(*dma_dev_setup)(struct pci_dev *dev);
>>  	void		(*dma_bus_setup)(struct pci_bus *bus);
>>
>>-	int		(*probe_mode)(struct pci_bus *);
>>+	int		(*probe_mode)(struct pci_bus *bus);
>>
>>  	/* Called when pci_enable_device() is called. Returns true to
>>  	 * allow assignment/enabling of the device. */
>>-	bool		(*enable_device_hook)(struct pci_dev *);
>>+	bool		(*enable_device_hook)(struct pci_dev *dev);
>
>
>"pdev" is slightly better as it is of the "pci_dev" type (4130 occurrences of
>"pci_dev *pdev" and just 2833 of "pci_dev *dev" in the current kernel), "dev"
>is for "struct device".
>

Thanks for your review. I don't know if "dev" is for "struct device" only.
Usually, "dev" and "pdev" are interchangeably used for "struct pci_dev".
Especially the code written in old days uses "dev" for "struct pci_dev"
heavily.

Yes, I agree "pdev" is better than "dev" in this case and I'm going to
fix this up in next revision.

>>
>>-	void		(*disable_device)(struct pci_dev *);
>>+	void		(*disable_device)(struct pci_dev *dev);
>>
>>-	void		(*release_device)(struct pci_dev *);
>>+	void		(*release_device)(struct pci_dev *dev);
>>
>>  	/* Called during PCI resource reassignment */
>>-	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
>>+	resource_size_t (*window_alignment)(struct pci_bus *bus,
>>+					    unsigned long type);
>>  	void		(*setup_bridge)(struct pci_bus *bus,
>>  					unsigned long type);
>>  	void		(*reset_secondary_bus)(struct pci_dev *dev);
>>@@ -46,7 +47,7 @@ struct pci_controller_ops {
>>  	int             (*dma_set_mask)(struct pci_dev *dev, u64 dma_mask);
>>  	u64		(*dma_get_required_mask)(struct pci_dev *dev);
>>
>>-	void		(*shutdown)(struct pci_controller *);
>>+	void		(*shutdown)(struct pci_controller *hose);
>>  };
>>
>>  /*
>>
>
>
>-- 
>Alexey
>
