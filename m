Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgdBG2D2szDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 10:50:46 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u610nPnk001476
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 20:50:43 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23vvcddb2b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 20:50:43 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 10:50:40 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AAA353578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 10:50:37 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u610obES328044
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 10:50:37 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u610obLS000430
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 10:50:37 +1000
Date: Fri, 1 Jul 2016 10:50:36 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v3 3/7] PCI: Do not disable memory decoding in
 pci_reassigndev_resource_alignment()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1467283993-3185-4-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467283993-3185-4-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <20160701005036.GA18999@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 30, 2016 at 06:53:09PM +0800, Yongji Xie wrote:
>We should not disable memory decoding when we reassign alignment
>in pci_reassigndev_resource_alignment(). It's meaningless and
>have some side effect. For example, some fixup functions such as
>quirk_e100_interrupt() read PCI_COMMAND_MEMORY to know whether
>the devices has been initialized by the firmware or not. If we
>disable memory decoding here, these functions will get a wrong
>information that the devices was not initialized by the firmware
>which may cause a wrong fixup. Besides, disabling memory decoding
>may also break some devices that need to have memory decoding
>always-on during probing.
>

It seems the changelog isn't correct enough if it's talking about
below check in code:

if (!(command & PCI_COMMAND_MEMORY) || !pci_resource_start(dev, 0))
	return;

>Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>---
> drivers/pci/pci.c |    8 +-------
> 1 file changed, 1 insertion(+), 7 deletions(-)
>
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index 6ae02de..6241cfc 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -4820,7 +4820,6 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
> 	int i;
> 	struct resource *r;
> 	resource_size_t align, size;
>-	u16 command;
>
> 	/* We should never try to reassign VF's alignment */
> 	if (dev->is_virtfn)
>@@ -4838,12 +4837,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
> 		return;
> 	}
>
>-	dev_info(&dev->dev,
>-		"Disabling memory decoding and releasing memory resources.\n");
>-	pci_read_config_word(dev, PCI_COMMAND, &command);
>-	command &= ~PCI_COMMAND_MEMORY;
>-	pci_write_config_word(dev, PCI_COMMAND, command);
>-
>+	dev_info(&dev->dev, "Releasing memory resources.\n");

Is there a problem you found with PCI_COMMAND removed? If so, could you
please share more details, thanks.

> 	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
> 		r = &dev->resource[i];
> 		if (!(r->flags & IORESOURCE_MEM))

Thanks,
Gavin
