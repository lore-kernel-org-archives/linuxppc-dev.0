Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F4F61A0D0E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:54:59 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 22 Dec 2014 15:54:59 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 82A2C2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:54:56 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBM5suE134603144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:54:56 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBM5stow020611
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:54:56 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V10 06/17] powerpc/pci: Add PCI resource alignment
 documentation
Date: Mon, 22 Dec 2014 13:54:26 +0800
Message-Id: <1419227677-12312-7-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1419227677-12312-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1419227677-12312-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

In order to enable SRIOV on PowerNV platform, the PF's IOV BAR needs to be
adjusted:
    1. size expaned
    2. aligned to M64BT size

This patch documents this change on the reason and how.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 .../powerpc/pci_iov_resource_on_powernv.txt        |  215 ++++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100644 Documentation/powerpc/pci_iov_resource_on_powernv.txt

diff --git a/Documentation/powerpc/pci_iov_resource_on_powernv.txt b/Documentation/powerpc/pci_iov_resource_on_powernv.txt
new file mode 100644
index 0000000..10d4ac2
--- /dev/null
+++ b/Documentation/powerpc/pci_iov_resource_on_powernv.txt
@@ -0,0 +1,215 @@
+Wei Yang <weiyang@linux.vnet.ibm.com>
+Benjamin Herrenschmidt <benh@au1.ibm.com>
+26 Aug 2014
+
+This document describes the requirement from hardware for PCI MMIO resource
+sizing and assignment on PowerNV platform and how generic PCI code handle this
+requirement. The first two sections describes the concept to PE and the
+implementation on P8 (IODA2)
+
+1. General Introduction on the Purpose of PE
+PE stands for Partitionable Endpoint.
+
+The concept of PE is a way to group the various resources associated
+with a device or a set of device to provide isolation between partitions
+(ie. filtering of DMA, MSIs etc...) and to provide a mechanism to freeze
+a device that is causing errors in order to limit the possibility of
+propagation of bad data.
+
+There is thus, in HW, a table of PE states that contains a pair of
+"frozen" state bits (one for MMIO and one for DMA, they get set together
+but can be cleared independently) for each PE.
+
+When a PE is frozen, all stores in any direction are dropped and all loads
+return all 1's value. MSIs are also blocked. There's a bit more state that
+captures things like the details of the error that caused the freeze etc...
+but that's not critical.
+
+The interesting part is how the various type of PCIe transactions (MMIO,
+DMA,...) are matched to their corresponding PEs.
+
+Following section provides a rough description of what we have on P8 (IODA2).
+Keep in mind that this is all per PHB (host bridge). Each PHB is a completely
+separate HW entity which replicates the entire logic, so has its own set
+of PEs etc...
+
+2. Implementation of PE on P8 (IODA2)
+First, P8 has 256 PEs per PHB.
+
+ * Inbound
+
+For DMA, MSIs and inbound PCIe error messages, we have a table (in memory but
+accessed in HW by the chip) that provides a direct correspondence between
+a PCIe RID (bus/dev/fn) with a "PE" number. We call this the RTT.
+
+ - For DMA we then provide an entire address space for each PE that can contains
+two "windows", depending on the value of PCI bit 59. Each window can then be
+configured to be remapped via a "TCE table" (iommu translation table), which has
+various configurable characteristics which we can describe another day.
+
+ - For MSIs, we have two windows in the address space (one at the top of the 32-bit
+space and one much higher) which, via a combination of the address and MSI value,
+will result in one of the 2048 interrupts per bridge being triggered. There's
+a PE value in the interrupt controller descriptor table as well which is compared
+with the PE obtained from the RTT to "authorize" the device to emit that specific
+interrupt.
+
+ - Error messages just use the RTT.
+
+ * Outbound. That's where the tricky part is.
+
+The PHB basically has a concept of "windows" from the CPU address space to the
+PCI address space. There is one M32 window and 16 M64 windows. They have different
+characteristics. First what they have in common: they are configured to forward a
+configurable portion of the CPU address space to the PCIe bus and must be naturally
+aligned power of two in size. The rest is different:
+
+  - The M32 window:
+
+    * It is limited to 4G in size
+
+    * It drops the top bits of the address (above the size) and replaces them with
+a configurable value. This is typically used to generate 32-bit PCIe accesses. We
+configure that window at boot from FW and don't touch it from Linux, it's usually
+set to forward a 2G portion of address space from the CPU to PCIe
+0x8000_0000..0xffff_ffff. (Note: The top 64K are actually reserved for MSIs but
+this is not a problem at this point, we just need to ensure Linux doesn't assign
+anything there, the M32 logic ignores that however and will forward in that space
+if we try).
+
+    * It is divided into 256 segments of equal size. A table in the chip provides
+for each of these 256 segments a PE#. That allows to essentially assign portions
+of the MMIO space to PEs on a segment granularity. For a 2G window, this is 8M.
+
+Now, this is the "main" window we use in Linux today (excluding SR-IOV). We
+basically use the trick of forcing the bridge MMIO windows onto a segment
+alignment/granularity so that the space behind a bridge can be assigned to a PE.
+
+Ideally we would like to be able to have individual functions in PE's but that
+would mean using a completely different address allocation scheme where individual
+function BARs can be "grouped" to fit in one or more segments....
+
+ - The M64 windows.
+
+   * Their smallest size is 1M
+
+   * They do not translate addresses (the address on PCIe is the same as the
+address on the PowerBus. There is a way to also set the top 14 bits which are
+not conveyed by PowerBus but we don't use this).
+
+   * They can be configured to be segmented or not. When segmented, they have
+256 segments, however they are not remapped. The segment number *is* the PE
+number. When no segmented, the PE number can be specified for the entire
+window.
+
+   * They support overlaps in which case there is a well defined ordering of
+matching (I don't remember off hand which of the lower or higher numbered
+window takes priority but basically it's well defined).
+
+We have code (fairly new compared to the M32 stuff) that exploits that for
+large BARs in 64-bit space:
+
+We create a single big M64 that covers the entire region of address space that
+has been assigned by FW for the PHB (about 64G, ignore the space for the M32,
+it comes out of a different "reserve"). We configure that window as segmented.
+
+Then we do the same thing as with M32, using the bridge aligment trick, to
+match to those giant segments.
+
+Since we cannot remap, we have two additional constraints:
+
+  - We do the PE# allocation *after* the 64-bit space has been assigned since
+the segments used will derive directly the PE#, we then "update" the M32 PE#
+for the devices that use both 32-bit and 64-bit spaces or assign the remaining
+PE# to 32-bit only devices.
+
+  - We cannot "group" segments in HW so if a device ends up using more than
+one segment, we end up with more than one PE#. There is a HW mechanism to
+make the freeze state cascade to "companion" PEs but that only work for PCIe
+error messages (typically used so that if you freeze a switch, it freezes all
+its children). So we do it in SW. We lose a bit of effectiveness of EEH in that
+case, but that's the best we found. So when any of the PEs freezes, we freeze
+the other ones for that "domain". We thus introduce the concept of "master PE"
+which is the one used for DMA, MSIs etc... and "secondary PEs" that are used
+for the remaining M64 segments.
+
+We would like to investigate using additional M64's in "single PE" mode to
+overlay over specific BARs to work around some of that, for example for devices
+with very large BARs (some GPUs), it would make sense, but we haven't done it
+yet.
+
+Finally, the plan to use M64 for SR-IOV, which will be described more in next
+two sections. So for a given IOV BAR, we need to effectively reserve the
+entire 256 segments (256 * IOV BAR size) and then "position" the BAR to start at
+the beginning of a free range of segments/PEs inside that M64.
+
+The goal is of course to be able to give a separate PE for each VF...
+
+3. Hardware requirement on PowerNV platform for SRIOV
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
+4. How generic PCI code handle it
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
