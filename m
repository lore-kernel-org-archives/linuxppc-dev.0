Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 214981A060B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:41:54 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 3 Nov 2014 01:41:53 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 360AA2BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:41:51 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA2FfnaD27197576
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:41:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA2Ffojg028094
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:41:50 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V9 05/18] powerpc/pci: Add PCI resource alignment documentation
Date: Sun,  2 Nov 2014 23:41:21 +0800
Message-Id: <1414942894-17034-6-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to enable SRIOV on PowerNV platform, the PF's IOV BAR needs to be
adjusted:
    1. size expaned
    2. aligned to M64BT size

This patch documents this change on the reason and how.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 .../powerpc/pci_iov_resource_on_powernv.txt        |   75 ++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/powerpc/pci_iov_resource_on_powernv.txt

diff --git a/Documentation/powerpc/pci_iov_resource_on_powernv.txt b/Documentation/powerpc/pci_iov_resource_on_powernv.txt
new file mode 100644
index 0000000..8b3f346
--- /dev/null
+++ b/Documentation/powerpc/pci_iov_resource_on_powernv.txt
@@ -0,0 +1,75 @@
+Wei Yang <weiyang@linux.vnet.ibm.com>
+26 Aug 2014
+
+This document describes the requirement from hardware for PCI MMIO resource
+sizing and assignment on PowerNV platform and how generic PCI code handle this
+requirement.
+
+1. Hardware requirement on PowerNV platform
+On PowerNV platform, IODA2 version, it has 16 M64 BARs, which is used to map
+MMIO range to PE#. Each M64 BAR would cover one MMIO range and this range is
+divided by *total_pe* number evenly with one piece corresponding to one PE.
+
+We decide to leverage this M64 BAR to map VFs to their individual PE, since
+for SRIOV VFs their BAR share the same size.
+
+By doing so, it introduces another problem. The *total_pe* number usually is
+bigger than the total_VFs. If we map one IOV BAR directly to one M64 BAR, some
+part in M64 BAR will map to another devices MMIO range.
+
+     0      1                     total_VFs - 1
+     +------+------+-     -+------+------+
+     |      |      |  ...  |      |      |
+     +------+------+-     -+------+------+
+
+                           IOV BAR
+     0      1                     total_VFs - 1          total_pe - 1
+     +------+------+-     -+------+------+-      -+------+------+
+     |      |      |  ...  |      |      |   ...  |      |      |
+     +------+------+-     -+------+------+-      -+------+------+
+
+                           M64 BAR
+
+		Figure 1.0 Direct map IOV BAR
+
+As Figure 1.0 indicates, the range [total_VFs, total_pe - 1] in M64 BAR may
+map to some MMIO range on other device.
+
+The solution currently we have is to expand the IOV BAR to *total_pe* number.
+
+     0      1                     total_VFs - 1          total_pe - 1
+     +------+------+-     -+------+------+-      -+------+------+
+     |      |      |  ...  |      |      |   ...  |      |      |
+     +------+------+-     -+------+------+-      -+------+------+
+
+                           IOV BAR
+     0      1                     total_VFs - 1          total_pe - 1
+     +------+------+-     -+------+------+-      -+------+------+
+     |      |      |  ...  |      |      |   ...  |      |      |
+     +------+------+-     -+------+------+-      -+------+------+
+
+                           M64 BAR
+
+		Figure 1.1 Map expanded IOV BAR
+
+By expanding the IOV BAR, this ensures the whole M64 range will not effect
+others.
+
+2. How generic PCI code handle it
+Till now, it looks good to make it work, while another problem comes. The M64
+BAR start address needs to be size aligned, while the original generic PCI
+code assign the IOV BAR with individual VF BAR size aligned.
+
+Since usually one SRIOV VF BAR size is the same as its PF size, the original
+generic PCI code will not count in the IOV BAR alignment. (The alignment is
+the same as its PF.) With the change from PowerNV platform, this changes. The
+alignment of the IOV BAR is now the total size, then we need to count in it.
+
+From:
+	alignment(IOV BAR) = size(VF BAR) = size(PF BAR)
+To:
+	alignment(IOV BAR) = size(IOV BAR)
+
+In commit(PCI: Take additional IOV BAR alignment in sizing and assigning), it
+has add_align to track the alignment from IOV BAR and use it to meet the
+requirement.
-- 
1.7.9.5
