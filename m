Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E40661A001D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 15:07:50 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 23 Jun 2014 15:07:49 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2C312357804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 15:07:48 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5N4jWv89503060
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 14:45:32 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5N57kb2015140
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 15:07:47 +1000
Date: Mon, 23 Jun 2014 15:07:47 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH V3 02/17] pci/of: Match PCI VFs to dev-tree nodes
 dynamically
Message-ID: <20140623050747.GB5069@shangw>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-3-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402365399-5121-3-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 yan@linux.vnet.ibm.com, bhelgaas@google.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 10, 2014 at 09:56:24AM +0800, Wei Yang wrote:
>As introduced by commit 98d9f30c82 ("pci/of: Match PCI devices to dev-tree nodes
>dynamically"), we need to match PCI devices to their corresponding dev-tree
>nodes. While for VFs, this step was missed.
>
>This patch matches VFs' PCI devices to dev-tree nodes dynamically.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> drivers/pci/iov.c |    1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index 589ef7d..1d21f43 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -67,6 +67,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>
> 	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
> 	virtfn->vendor = dev->vendor;
>+	pci_set_of_node(virtfn);

If the VF and PF seats on different PCI buses, I guess pci_set_of_node() always
binds nothing with the VF. It might be one of the problem your code missed and
I didn't catch this in the code review done previously. However, it shouldn't
be a real problem if we're not going to rely on dynamic device_node.

> 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
> 	pci_setup_device(virtfn);
> 	virtfn->dev.parent = dev->dev.parent;

Thanks,
Gavin
