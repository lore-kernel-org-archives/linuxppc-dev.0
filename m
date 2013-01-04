Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B6C5E2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2013 13:24:45 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 3 Jan 2013 19:24:40 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id F28F819D8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jan 2013 19:24:37 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r042ObhC389950
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Jan 2013 19:24:38 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r042ObQZ002982
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Jan 2013 19:24:37 -0700
Date: Fri, 4 Jan 2013 10:24:39 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] EEH/OF: checking for CONFIG_EEH is not needed
Message-ID: <20130104022439.GA15123@shangw.(null)>
References: <20121228120616.GB21831@oc0268524204.ibm.com>
 <1356721999-25159-1-git-send-email-cascardo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1356721999-25159-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, shangw@linux.vnet.ibm.com
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 28, 2012 at 05:13:18PM -0200, Thadeu Lima de Souza Cascardo wrote:
>The functions used are already defined as empty inline functions for the
>case where EEH is disabled.
>
>Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>

Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>

>---
> arch/powerpc/kernel/of_platform.c |    4 ----
> 1 files changed, 0 insertions(+), 4 deletions(-)
>
>diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
>index 2049f2d..c5fc6b2 100644
>--- a/arch/powerpc/kernel/of_platform.c
>+++ b/arch/powerpc/kernel/of_platform.c
>@@ -71,10 +71,8 @@ static int __devinit of_pci_phb_probe(struct platform_device *dev)
> 	eeh_dev_phb_init_dynamic(phb);
>
> 	/* Register devices with EEH */
>-#ifdef CONFIG_EEH
> 	if (dev->dev.of_node->child)
> 		eeh_add_device_tree_early(dev->dev.of_node);
>-#endif /* CONFIG_EEH */
>
> 	/* Scan the bus */
> 	pcibios_scan_phb(phb);
>@@ -88,9 +86,7 @@ static int __devinit of_pci_phb_probe(struct platform_device *dev)
> 	pcibios_claim_one_bus(phb->bus);
>
> 	/* Finish EEH setup */
>-#ifdef CONFIG_EEH
> 	eeh_add_device_tree_late(phb->bus);
>-#endif
>
> 	/* Add probed PCI devices to the device model */
> 	pci_bus_add_devices(phb->bus);

Thanks,
Gavin
