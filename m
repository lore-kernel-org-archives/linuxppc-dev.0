Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFE7C1A1D28
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:55:33 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 15:55:33 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 550D42BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:55:30 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2P5tLYi45482078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:55:30 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2P5stDA027793
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:54:56 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V15 13/21] powerpc/pci: Don't unset PCI resources for VFs
Date: Wed, 25 Mar 2015 13:44:49 +0800
Message-Id: <1427262297-5694-14-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1427262297-5694-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1427262297-5694-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Flag PCI_REASSIGN_ALL_RSRC is used to ignore resources information setup by
firmware, so that kernel would re-assign all resources of pci devices.

On powerpc arch, this happens in a header fixup function
pcibios_fixup_resources(), which will clean up the resources if this flag
is set. This works fine for PFs, since after clean up, kernel will
re-assign the resources in pcibios_resource_survey().

Below is a simple call flow on how it works:

    pcibios_init
      pcibios_scan_phb
        pci_scan_child_bus
          ...
            pci_device_add
              pci_fixup_device(pci_fixup_header)
                pcibios_fixup_resources                     # header fixup
                  for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
                    dev->resource[i].start = 0
      pcibios_resource_survey                               # re-assign
        pcibios_allocate_resources

However, the VF resources won't be re-assigned, since the VF resources are
completely determined by the PF resources, and the PF resources have
already been reassigned. This means we need to leave VF's resources
un-cleared in pcibios_fixup_resources().

In this patch, we skip the resource unset process in
pcibios_fixup_resources(), if the pci_dev is a VF.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 2a525c9..8203101 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -788,6 +788,10 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
 		       pci_name(dev));
 		return;
 	}
+
+	if (dev->is_virtfn)
+		return;
+
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 		struct resource *res = dev->resource + i;
 		struct pci_bus_region reg;
-- 
1.7.9.5
