Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgcy23VbWzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 10:40:08 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u610cOit139464
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 20:40:06 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v6yf7md7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 20:40:06 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 10:40:03 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 729962CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 10:40:01 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u610e19A8651258
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 10:40:01 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u610e0YM014865
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 10:40:01 +1000
Date: Fri, 1 Jul 2016 10:39:59 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v3 2/7] PCI: Ignore enforced alignment to VF BARs
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1467283993-3185-3-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467283993-3185-3-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <20160701003959.GB15147@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 30, 2016 at 06:53:08PM +0800, Yongji Xie wrote:
>VF BARs are read-only zeroes according to SRIOV spec,
>the normal way(writing BARs) of allocating resources wouldn't
>be applied to VFs. The VFs' resources would be allocated
>when we enable SR-IOV capability. So we should not try to
>reassign alignment after we enable VFs. It's meaningless
>and will release the allocated resources which leads to a bug.
>
>Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>---
> drivers/pci/pci.c |    4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index be8f72c..6ae02de 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -4822,6 +4822,10 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
> 	resource_size_t align, size;
> 	u16 command;
>
>+	/* We should never try to reassign VF's alignment */
>+	if (dev->is_virtfn)
>+		return;
>+

Yongji, I think it's correct to ignore VF's BARs. Another concern is:
it's safe to apply alignment to PF's IOV BARs? Lets have an extreme
example here: one PF has 16 VFs; each VF has only one 1KB. It means
the only PF IOV BAR is 16KB. I don't see how it works after expanding
it to 64KB which is the page size. It might be not a problem on PowerNV
platform, but potentially a issue on x86?

> 	/* check if specified PCI is target device to reassign */
> 	align = pci_specified_resource_alignment(dev);
> 	if (!align)

Thanks,
Gavin
