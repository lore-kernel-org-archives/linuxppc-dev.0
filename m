Return-Path: <bhelgaas@google.com>
Received: from mail-ob0-x22e.google.com (mail-ob0-x22e.google.com
 [IPv6:2607:f8b0:4003:c01::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCECD1A09CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 10:44:39 +1100 (AEDT)
Received: by mail-ob0-f174.google.com with SMTP id wo20so4325837obc.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2015 15:44:36 -0800 (PST)
Date: Wed, 4 Feb 2015 17:44:33 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V11 06/17] powerpc/pci: Add PCI resource alignment
 documentation
Message-ID: <20150204234433.GC11271@google.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-7-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421288887-7765-7-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 15, 2015 at 10:27:56AM +0800, Wei Yang wrote:
> In order to enable SRIOV on PowerNV platform, the PF's IOV BAR needs to be
> adjusted:
>     1. size expaned
>     2. aligned to M64BT size
> 
> This patch documents this change on the reason and how.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  .../powerpc/pci_iov_resource_on_powernv.txt        |  215 ++++++++++++++++++++
>  1 file changed, 215 insertions(+)
>  create mode 100644 Documentation/powerpc/pci_iov_resource_on_powernv.txt
> 
> diff --git a/Documentation/powerpc/pci_iov_resource_on_powernv.txt b/Documentation/powerpc/pci_iov_resource_on_powernv.txt
> new file mode 100644
> index 0000000..10d4ac2
> --- /dev/null
> +++ b/Documentation/powerpc/pci_iov_resource_on_powernv.txt

I added the following two patches on top of this because I'm still confused
about the difference between the M64 window and the M64 BARs.  Several
parts of the writeup seem to imply that there are several M64 windows, but
that seems to be incorrect.

And I tried to write something about M64 BARs, too.  But it could well be
incorrect.

Please correct as necessary.  Ultimately I'll just fold everything into the
original patch so there's only one.

Bjorn


commit 6f46b79d243c24fd02c662c43aec6c829013ff64
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Jan 30 11:01:59 2015 -0600

    Try to fix references to M64 window vs M64 BARs.  If there really is only
    one M64 window, I'm still a little confused about why there are so many
    places that seem to mention multiple M64 windows.

diff --git a/Documentation/powerpc/pci_iov_resource_on_powernv.txt b/Documentation/powerpc/pci_iov_resource_on_powernv.txt
index 10d4ac2f25b5..140df9cb58bd 100644
--- a/Documentation/powerpc/pci_iov_resource_on_powernv.txt
+++ b/Documentation/powerpc/pci_iov_resource_on_powernv.txt
@@ -59,7 +59,7 @@ interrupt.
  * Outbound. That's where the tricky part is.
 
 The PHB basically has a concept of "windows" from the CPU address space to the
-PCI address space. There is one M32 window and 16 M64 windows. They have different
+PCI address space. There is one M32 window and one M64 window. They have different
 characteristics. First what they have in common: they are configured to forward a
 configurable portion of the CPU address space to the PCIe bus and must be naturally
 aligned power of two in size. The rest is different:
@@ -89,29 +89,31 @@ Ideally we would like to be able to have individual functions in PE's but that
 would mean using a completely different address allocation scheme where individual
 function BARs can be "grouped" to fit in one or more segments....
 
- - The M64 windows.
+ - The M64 window:
 
-   * Their smallest size is 1M
+   * Must be at least 256MB in size
 
-   * They do not translate addresses (the address on PCIe is the same as the
+   * Does not translate addresses (the address on PCIe is the same as the
 address on the PowerBus. There is a way to also set the top 14 bits which are
 not conveyed by PowerBus but we don't use this).
 
-   * They can be configured to be segmented or not. When segmented, they have
+   * Can be configured to be segmented or not. When segmented, it has
 256 segments, however they are not remapped. The segment number *is* the PE
 number. When no segmented, the PE number can be specified for the entire
 window.
 
-   * They support overlaps in which case there is a well defined ordering of
+   * Supports overlaps in which case there is a well defined ordering of
 matching (I don't remember off hand which of the lower or higher numbered
 window takes priority but basically it's well defined).
+^^^^^^ This sounds like there are multiple M64 windows.   Or maybe this
+paragraph is really about overlaps between M64 *BARs*, not M64 windows.
 
 We have code (fairly new compared to the M32 stuff) that exploits that for
 large BARs in 64-bit space:
 
-We create a single big M64 that covers the entire region of address space that
+We configure the M64 to cover the entire region of address space that
 has been assigned by FW for the PHB (about 64G, ignore the space for the M32,
-it comes out of a different "reserve"). We configure that window as segmented.
+it comes out of a different "reserve"). We configure it as segmented.
 
 Then we do the same thing as with M32, using the bridge aligment trick, to
 match to those giant segments.
@@ -133,15 +135,15 @@ the other ones for that "domain". We thus introduce the concept of "master PE"
 which is the one used for DMA, MSIs etc... and "secondary PEs" that are used
 for the remaining M64 segments.
 
-We would like to investigate using additional M64's in "single PE" mode to
+We would like to investigate using additional M64 BARs (?) in "single PE" mode to
 overlay over specific BARs to work around some of that, for example for devices
 with very large BARs (some GPUs), it would make sense, but we haven't done it
 yet.
 
-Finally, the plan to use M64 for SR-IOV, which will be described more in next
+Finally, the plan to use M64 BARs for SR-IOV, which will be described more in next
 two sections. So for a given IOV BAR, we need to effectively reserve the
 entire 256 segments (256 * IOV BAR size) and then "position" the BAR to start at
-the beginning of a free range of segments/PEs inside that M64.
+the beginning of a free range of segments/PEs inside that M64 BAR.
 
 The goal is of course to be able to give a separate PE for each VF...
 

commit 0f069e6a30e4c3de02f8c60aadd64fb64d434e7d
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Jan 29 13:37:49 2015 -0600

    This adds description about M64 BARs.  Previously, these were mentioned,
    but I don't think there was actually anything specific about how they
    worked.

diff --git a/Documentation/powerpc/pci_iov_resource_on_powernv.txt b/Documentation/powerpc/pci_iov_resource_on_powernv.txt
index 140df9cb58bd..2e4811fae7fb 100644
--- a/Documentation/powerpc/pci_iov_resource_on_powernv.txt
+++ b/Documentation/powerpc/pci_iov_resource_on_powernv.txt
@@ -58,7 +58,7 @@ interrupt.
 
  * Outbound. That's where the tricky part is.
 
-The PHB basically has a concept of "windows" from the CPU address space to the
+Like other PCI host bridges, the Power8 IODA2 PHB supports "windows" from the CPU address space to the
 PCI address space. There is one M32 window and one M64 window. They have different
 characteristics. First what they have in common: they are configured to forward a
 configurable portion of the CPU address space to the PCIe bus and must be naturally
@@ -140,6 +140,69 @@ overlay over specific BARs to work around some of that, for example for devices
 with very large BARs (some GPUs), it would make sense, but we haven't done it
 yet.
 
+ - The M64 BARs.
+
+IODA2 has 16 M64 "BARs."  These are not traditional PCI BARs that assign
+space for device registers or memory, and they're not normal window
+registers that describe the base and size of a bridge aperture.
+
+Rather, these M64 BARs associate pieces of an existing M64 window with PEs.
+The BAR describes a region of a window, and the region is divided into 256
+segments, just like a segmented M64 window.  As with segmented M64 windows,
+there's no lookup table: the segment number is the PE#.  The minimum size
+of a segment is 1MB, so each M64 BAR covers at least 256MB of space in an
+M64 window.
+
+The advantage of the M64 BARs is that they can be programmed to cover only
+part of an M64 window, and you can use several of them at the same time.
+That makes them useful for SR-IOV Virtual Functions, because each VF can be
+assigned to a separate PE.
+
+SR-IOV BACKGROUND
+
+The PCIe SR-IOV feature allows a single Physical Function (PF) to support
+several Virtual Functions (VFs).  Registers in the PF's SR-IOV Capability
+control the number of VFs, whether the VFs are enabled, and the MMIO
+resources assigned to the VFs.
+
+Each VF has its own VF BARs.  Software can write to a normal PCI BAR to
+discover the BAR size and assign address for it.  VF BARs aren't like that;
+the size discovery and address assignment is done via BARs in the *PF*
+SR-IOV Capability, and the BARs in VF config space are read-only zeros.
+
+When a PF SR-IOV BAR is programmed, it sets the base address for all the
+corresponding VF BARs.  For example, if the PF SR-IOV Capability is
+programmed to enable eight VFs, and it describes a 1MB BAR 0 for those VFs,
+the address in that PF BAR sets the base of an 8MB region that contains all
+eight of the VF BARs.
+
+STRATEGIES FOR ISOLATING VFs IN PEs:
+
+- M32 window: There's one M32 window, and it is split into 256
+  equally-sized segments.  The finest granularity possible is a 256MB
+  window with 1MB segments.  VF BARs that are 1MB or larger could be mapped
+  to separate PEs in this window.  Each segment can be individually mapped
+  to a PE via the lookup table, so this is quite flexible, but it works
+  best when all the VF BARs are the same size.  If they are different
+  sizes, the entire window has to be small enough that the segment matches
+  the smallest VF BAR, and larger VF BARs span several segments.
+
+- M64 window: A non-segmented M64 window is mapped entirely to a single PE,
+  so it could only isolate one VF.  A segmented M64 window could be used
+  just like the M32 window, but the segments can't be individually mapped
+  to PEs (the segment number is the PE number), so there isn't as much
+  flexibility.  A VF with multiple BARs would have to be be in a "domain"
+  of multiple PEs, which is not as well isolated as a single PE.
+
+- M64 BAR: An M64 BAR effectively segments a region of an M64 window.  As
+  usual, the region is split into 256 equally-sized pieces, and as in
+  segmented M64 windows, the segment number is the PE number.  But there
+  are several M64 BARs, and they can be set to different base addresses and
+  different segment sizes.  So if we have VFs that each have a 1MB BAR and
+  a 32MB BAR, we could use one M64 BAR to assign 1MB segments and another
+  M64 BAR to assign 32MB segments.
+
+
 Finally, the plan to use M64 BARs for SR-IOV, which will be described more in next
 two sections. So for a given IOV BAR, we need to effectively reserve the
 entire 256 segments (256 * IOV BAR size) and then "position" the BAR to start at
