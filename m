Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSWVD68sKzDvn1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:56:36 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAT4s60T011246
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:56:33 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 270ygtq088-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:56:33 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 29 Nov 2016 14:56:30 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3694B2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:56:27 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAT4uRnJ59441230
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:56:27 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAT4uQGP025561
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:56:27 +1100
Date: Tue, 29 Nov 2016 15:57:47 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, clsoto@us.ibm.com,
 benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v4 4/7] PCI: Don't update VF BARs while VF memory space
 is enabled
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129041521.21453.33146.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161129041521.21453.33146.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20161129045747.GA22347@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2016 at 10:15:21PM -0600, Bjorn Helgaas wrote:
>If we update a VF BAR while it's enabled, there are two potential problems:
>
>  1) Any driver that's using the VF has a cached BAR value that is stale
>     after the update, and
>
>  2) We can't update 64-bit BARs atomically, so the intermediate state
>     (new lower dword with old upper dword) may conflict with another
>     device, and an access by a driver unrelated to the VF may cause a bus
>     error.
>
>Warn about attempts to update VF BARs while they are enabled.  This is a
>programming error, so use dev_WARN() to get a backtrace.
>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> drivers/pci/iov.c |    8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index d00ed5c..a800ba2 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -584,6 +584,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno)
> 	struct resource *res = dev->resource + resno;
> 	int vf_bar = resno - PCI_IOV_RESOURCES;
> 	struct pci_bus_region region;
>+	u16 cmd;
> 	u32 new;
> 	int reg;
>
>@@ -595,6 +596,13 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno)
> 	if (!iov)
> 		return;
>
>+	pci_read_config_word(dev, iov->pos + PCI_SRIOV_CTRL, &cmd);
>+	if ((cmd & PCI_SRIOV_CTRL_VFE) && (cmd & PCI_SRIOV_CTRL_MSE)) {
>+		dev_WARN(&dev->dev, "can't update enabled VF BAR%d %pR\n",
>+			 vf_bar, res);
>+		return;
>+	}
>+
> 	/*
> 	 * Ignore unimplemented BARs, unused resource slots for 64-bit
> 	 * BARs, and non-movable resources, e.g., those described via
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
