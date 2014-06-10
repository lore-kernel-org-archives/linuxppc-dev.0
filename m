Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F62A1A0298
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:12 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 10 Jun 2014 07:27:10 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 1DA78394003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:27:08 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5A1vxBf58589344
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:27:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5A1v7KS030277
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:27:07 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Subject: [RFC PATCH V3 09/17] PCI: Add weak pcibios_sriov_resource_alignment()
 interface
Date: Tue, 10 Jun 2014 09:56:31 +0800
Message-Id: <1402365399-5121-10-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com, bhelgaas@google.com,
 yan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The sriov resource alignment is designed to be the individual size of a sriov
resource. This works fine for many platforms, but on powernv platform it needs
some change.

The original alignment works, since at sizing and assigning stage the
requirement is from an individual VF's resource size instead of the big IOV
BAR. This is the reason for the original code to just retrieve the individual
sriov size as the alignment.

On powernv platform, it is required to align the whole IOV BAR to a hardware
aperture. Based on this fact, the alignment of sriov resource should be the
total size of the IOV BAR.

This patch introduces a weak pcibios_sriov_resource_alignment() interface, which
gives platform a chance to implement specific method to calculate the sriov
resource alignment.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9fd4648..dd7fc42 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -628,6 +628,12 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno,
 		4 * (resno - PCI_IOV_RESOURCES);
 }
 
+resource_size_t __weak pcibios_sriov_resource_alignment(struct pci_dev *dev,
+		int resno, resource_size_t align)
+{
+	return align;
+}
+
 /**
  * pci_sriov_resource_alignment - get resource alignment for VF BAR
  * @dev: the PCI device
@@ -642,13 +648,16 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
 {
 	struct resource tmp;
 	enum pci_bar_type type;
+	resource_size_t align;
 	int reg = pci_iov_resource_bar(dev, resno, &type);
 
 	if (!reg)
 		return 0;
 
 	__pci_read_base(dev, type, &tmp, reg);
-	return resource_alignment(&tmp);
+	align = resource_alignment(&tmp);
+
+	return pcibios_sriov_resource_alignment(dev, resno, align);
 }
 
 /**
-- 
1.7.9.5
