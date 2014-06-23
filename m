Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 910851A0018
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 16:29:28 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 23 Jun 2014 11:59:23 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 325CAE0053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 12:00:31 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5N6TY3g61079786
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 11:59:34 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5N6TIc3030239
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 11:59:18 +0530
Date: Mon, 23 Jun 2014 14:29:15 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH V3 02/17] pci/of: Match PCI VFs to dev-tree nodes
 dynamically
Message-ID: <20140623062915.GA5172@richard>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140623050747.GB5069@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140623050747.GB5069@shangw>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 linux-pci@vger.kernel.org, yan@linux.vnet.ibm.com, bhelgaas@google.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2014 at 03:07:47PM +1000, Gavin Shan wrote:
>On Tue, Jun 10, 2014 at 09:56:24AM +0800, Wei Yang wrote:
>>As introduced by commit 98d9f30c82 ("pci/of: Match PCI devices to dev-tree nodes
>>dynamically"), we need to match PCI devices to their corresponding dev-tree
>>nodes. While for VFs, this step was missed.
>>
>>This patch matches VFs' PCI devices to dev-tree nodes dynamically.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>---
>> drivers/pci/iov.c |    1 +
>> 1 file changed, 1 insertion(+)
>>
>>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>index 589ef7d..1d21f43 100644
>>--- a/drivers/pci/iov.c
>>+++ b/drivers/pci/iov.c
>>@@ -67,6 +67,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>>
>> 	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
>> 	virtfn->vendor = dev->vendor;
>>+	pci_set_of_node(virtfn);
>
>If the VF and PF seats on different PCI buses, I guess pci_set_of_node() always
>binds nothing with the VF. It might be one of the problem your code missed and
>I didn't catch this in the code review done previously. However, it shouldn't
>be a real problem if we're not going to rely on dynamic device_node.
>

Thanks for the comment.

This case is not took into consideration yet, so it is not supported now.
While I think it is time to think about the solution now.

Hmm... after reading the code a while, this seems some change in current code.

1. The hierarchy of VF's device node
   
                    +---------+
                    |P2P      |parent
                    +----+----+
                         |       pbus
            +------------+------------+              vbus
            |                         |           ---------------+
       +---------+              +-----+---+          |
       |DEV      |child1        |DEV      |child2    |
       +---------+              +---------+          |
                                                  +----+------+
                                                  |VF         | vchild
                                                  +-----------+

   From the chart above, the left side is the device node hierarchy without
   VFs. Each pci device is the direct child of the P2P bridge. When match pci
   device and its device node, the code go through the parent bus node's child
   list and find the one with same devfn.(in pci_set_of_node()). And we can
   tell the parent bus node is the P2P bridge's device node.

   This works fine, untill VFs need to be added. vbus is a child of the pbus,
   and vbus->self is NULL. So first thing is to set the correct device node
   for this virtual bus. From the chart above, looks both P2P bridge and the
   DEV could be the device node. While the later one seems more reasonable.

2. Reserve virtual bus number in firmware
   This is not a big issue, just reserve enough bus number in firmware.
   Otherwise, pci device and device node may not match.

>> 	pci_|ead_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
>> 	pci_setup_device(virtfn);
>> 	virtfn->dev.parent = dev->dev.parent;
>
>Thanks,
>Gavin

-- 
Richard Yang
Help you, Help me
