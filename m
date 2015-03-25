Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D06191A2BF7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:26:38 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 18:26:37 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CADEC2CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:26:34 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2P8QQcL36110540
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:26:34 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2P8Q0Sr022102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:26:01 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V16 04/20] PCI: Index IOV resources in the conventional style
Date: Wed, 25 Mar 2015 16:23:45 +0800
Message-Id: <1427271841-28749-5-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1427271841-28749-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1427271841-28749-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bjorn Helgaas <bhelgaas@google.com>

Most of PCI uses "res = &dev->resource[i]", not "res = dev->resource + i".
Use that style in iov.c also.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 5bca0e1..27b98c3 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -95,7 +95,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	virtfn->multifunction = 0;
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
-		res = dev->resource + PCI_IOV_RESOURCES + i;
+		res = &dev->resource[i + PCI_IOV_RESOURCES];
 		if (!res->parent)
 			continue;
 		virtfn->resource[i].name = pci_name(virtfn);
@@ -212,7 +212,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		bars |= (1 << (i + PCI_IOV_RESOURCES));
-		res = dev->resource + PCI_IOV_RESOURCES + i;
+		res = &dev->resource[i + PCI_IOV_RESOURCES];
 		if (res->parent)
 			nres++;
 	}
@@ -373,7 +373,7 @@ found:
 
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
-		res = dev->resource + PCI_IOV_RESOURCES + i;
+		res = &dev->resource[i + PCI_IOV_RESOURCES];
 		bar64 = __pci_read_base(dev, pci_bar_unknown, res,
 					pos + PCI_SRIOV_BAR + i * 4);
 		if (!res->flags)
@@ -417,7 +417,7 @@ found:
 
 failed:
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
-		res = dev->resource + PCI_IOV_RESOURCES + i;
+		res = &dev->resource[i + PCI_IOV_RESOURCES];
 		res->flags = 0;
 	}
 
-- 
1.7.9.5
