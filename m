Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSWDS4D8xzDwQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:44:40 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAT4i46i020759
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:44:38 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 270w68mp2k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:44:37 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 29 Nov 2016 14:44:34 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 420683578058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:44:32 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAT4iWYr6029644
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:44:32 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAT4iVgs003836
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:44:32 +1100
Date: Tue, 29 Nov 2016 15:45:52 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, clsoto@us.ibm.com,
 benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v4 2/7] PCI: Ignore BAR updates on virtual functions
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129041429.21453.83322.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161129041429.21453.83322.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20161129044552.GA20642@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2016 at 10:14:29PM -0600, Bjorn Helgaas wrote:
>VF BARs are read-only zero, so updating VF BARs will not have any effect.
>See the SR-IOV spec r1.1, sec 3.4.1.11.
>
>We already ignore these updates because of 70675e0b6a1a ("PCI: Don't try to
>restore VF BARs"); this merely restructures it slightly to make it easier
>to split updates for standard and SR-IOV BARs.
>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>CC: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> drivers/pci/pci.c       |    4 ----
> drivers/pci/setup-res.c |    5 ++---
> 2 files changed, 2 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index ba34907..631eac2 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -564,10 +564,6 @@ static void pci_restore_bars(struct pci_dev *dev)
> {
> 	int i;
>
>-	/* Per SR-IOV spec 3.4.1.11, VF BARs are RO zero */
>-	if (dev->is_virtfn)
>-		return;
>-
> 	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++)
> 		pci_update_resource(dev, i);
> }
>diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>index 66c4d8f..d2a32d8 100644
>--- a/drivers/pci/setup-res.c
>+++ b/drivers/pci/setup-res.c
>@@ -36,10 +36,9 @@ void pci_update_resource(struct pci_dev *dev, int resno)
> 	enum pci_bar_type type;
> 	struct resource *res = dev->resource + resno;
>
>-	if (dev->is_virtfn) {
>-		dev_warn(&dev->dev, "can't update VF BAR%d\n", resno);
>+	/* Per SR-IOV spec 3.4.1.11, VF BARs are RO zero */
>+	if (dev->is_virtfn)
> 		return;
>-	}
>
> 	/*
> 	 * Ignore resources for unimplemented BARs and unused resource slots
>
