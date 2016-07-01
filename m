Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rggV24Z0mzDqps
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 12:34:34 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u612Xwit010323
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 22:34:32 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23w62f20h4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 22:34:31 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 12:34:28 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D890F2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 12:34:24 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u612YOWZ15204526
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 12:34:24 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u612YO5d028281
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 12:34:24 +1000
Date: Fri, 1 Jul 2016 12:34:23 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v3 5/7] PCI: Do not use IORESOURCE_STARTALIGN to identify
 bridge resources
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1467283993-3185-6-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467283993-3185-6-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <20160701023423.GB6739@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 30, 2016 at 06:53:11PM +0800, Yongji Xie wrote:
>Now we use the IORESOURCE_STARTALIGN to identify bridge resources
>in __assign_resources_sorted(). That's quite fragile. We may also
>set flag IORESOURCE_STARTALIGN for SR-IOV resources in some cases,
>for example, using the option "noresize" of parameter
>"pci=resource_alignment".
>
>In this patch, we try to use a more robust way to identify
>bridge resources.
>
>Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Yongji, I think this doesn't have to be part of this series, meaning
it can be sent or merged separately.

>---
> drivers/pci/setup-bus.c |    9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>index 55641a3..216ddbc 100644
>--- a/drivers/pci/setup-bus.c
>+++ b/drivers/pci/setup-bus.c
>@@ -390,6 +390,7 @@ static void __assign_resources_sorted(struct list_head *head,
> 	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
> 	unsigned long fail_type;
> 	resource_size_t add_align, align;
>+	int index;
>
> 	/* Check if optional add_size is there */
> 	if (!realloc_head || list_empty(realloc_head))
>@@ -410,11 +411,13 @@ static void __assign_resources_sorted(struct list_head *head,
>
> 		/*
> 		 * There are two kinds of additional resources in the list:
>-		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
>-		 * 2. SR-IOV resource   -- IORESOURCE_SIZEALIGN
>+		 * 1. bridge resource
>+		 * 2. SR-IOV resource
> 		 * Here just fix the additional alignment for bridge
> 		 */
>-		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
>+		index = dev_res->res - dev_res->dev->resource;
>+		if (index < PCI_BRIDGE_RESOURCES ||
>+			index > PCI_BRIDGE_RESOURCE_END)
> 			continue;
>
> 		add_align = get_res_add_align(realloc_head, dev_res->res);

Thanks,
Gavin
