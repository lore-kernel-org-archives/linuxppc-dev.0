Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgm9Q50LRzDql7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 16:05:29 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6160adM080980
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 02:05:27 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23wbt332u2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 02:05:26 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 16:05:23 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3F6462CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 16:05:21 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6165LP422348026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 16:05:21 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6165KQF002366
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 16:05:21 +1000
Date: Fri, 1 Jul 2016 16:05:19 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-doc@vger.kernel.org, aik@ozlabs.ru,
 linux-pci@vger.kernel.org, corbet@lwn.net,
 linux-kernel@vger.kernel.org, warrier@linux.vnet.ibm.com,
 alex.williamson@redhat.com, paulus@samba.org, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/7] PCI: Ignore enforced alignment to VF BARs
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1467283993-3185-3-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160701003959.GB15147@gwshan>
 <21112bd7-d343-46b6-1df1-b20cc1c1b24e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <21112bd7-d343-46b6-1df1-b20cc1c1b24e@linux.vnet.ibm.com>
Message-Id: <20160701060519.GA8863@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 01, 2016 at 01:27:17PM +0800, Yongji Xie wrote:
>>On Thu, Jun 30, 2016 at 06:53:08PM +0800, Yongji Xie wrote:
>>>VF BARs are read-only zeroes according to SRIOV spec,
>>>the normal way(writing BARs) of allocating resources wouldn't
>>>be applied to VFs. The VFs' resources would be allocated
>>>when we enable SR-IOV capability. So we should not try to
>>>reassign alignment after we enable VFs. It's meaningless
>>>and will release the allocated resources which leads to a bug.
>>>
>>>Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>>>---
>>>drivers/pci/pci.c |    4 ++++
>>>1 file changed, 4 insertions(+)
>>>
>>>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>index be8f72c..6ae02de 100644
>>>--- a/drivers/pci/pci.c
>>>+++ b/drivers/pci/pci.c
>>>@@ -4822,6 +4822,10 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>>>	resource_size_t align, size;
>>>	u16 command;
>>>
>>>+	/* We should never try to reassign VF's alignment */
>>>+	if (dev->is_virtfn)
>>>+		return;
>>>+
>>Yongji, I think it's correct to ignore VF's BARs. Another concern is:
>>it's safe to apply alignment to PF's IOV BARs? Lets have an extreme
>>example here: one PF has 16 VFs; each VF has only one 1KB. It means
>>the only PF IOV BAR is 16KB. I don't see how it works after expanding
>>it to 64KB which is the page size. It might be not a problem on PowerNV
>>platform, but potentially a issue on x86?
>
>Seems like the alignment would not be applied to IOV BARs because
>pci_reassigndev_resource_alignment() will be called before
>sriov_init().
>

Correct, thanks for the claim. I guess the alignment applied to PF IOV
BARs should be ignored as well? Anyway, the IOV BARs are retireved from
SRIOV capability. It deserves a comment if you plan to take the change.
Actually, the comment here (for ignoring alignment to VF BARs) can be
improved a bit as well, it'd better why the alignment cannot be applied.

Thanks,
Gavin
