Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpQ8S1c29zDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:57:27 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 20:57:27 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 25DF92CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:57:16 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3IAv8rr65405174
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:57:16 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3IAugnC012859
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:56:43 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC v6 02/10] PCI: Do not Use IORESOURCE_STARTALIGN to identify
 bridge resources
Date: Mon, 18 Apr 2016 18:55:58 +0800
Message-Id: <1460976961-29328-2-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1460976961-29328-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1460976961-29328-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now we use the IORESOURCE_STARTALIGN to identify bridge resources
in __assign_resources_sorted(). That's quite fragile. We can't
make sure that the PCI devices' resources will not use
IORESOURCE_STARTALIGN any more.

In this patch, we try to use a more robust way to identify
bridge resources.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7796d0a..45fc484 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -391,6 +391,7 @@ static void __assign_resources_sorted(struct list_head *head,
 	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
 	unsigned long fail_type;
 	resource_size_t add_align, align;
+	int index;
 
 	/* Check if optional add_size is there */
 	if (!realloc_head || list_empty(realloc_head))
@@ -411,11 +412,13 @@ static void __assign_resources_sorted(struct list_head *head,
 
 		/*
 		 * There are two kinds of additional resources in the list:
-		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
-		 * 2. SR-IOV resource   -- IORESOURCE_SIZEALIGN
+		 * 1. bridge resource
+		 * 2. SR-IOV resource
 		 * Here just fix the additional alignment for bridge
 		 */
-		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
+		index = dev_res->res - dev_res->dev->resource;
+		if (index < PCI_BRIDGE_RESOURCES ||
+			index > PCI_BRIDGE_RESOURCE_END)
 			continue;
 
 		add_align = get_res_add_align(realloc_head, dev_res->res);
-- 
1.7.9.5
