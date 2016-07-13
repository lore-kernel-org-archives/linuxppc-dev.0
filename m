Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqWrj0qpwzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:17:56 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DL94KK043099
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:17:54 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452yq4ddp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:17:54 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 14 Jul 2016 07:17:51 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1A78C2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:17:50 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DLHo4722413442
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:17:50 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DLHncg024839
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:17:49 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH v3] powerpc / cxl: Add support for the Mellanox CX4 in cxl mode
Date: Thu, 14 Jul 2016 07:16:59 +1000
Message-Id: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds support for the Mellanox CX4 network adapter operating in cxl
mode to the cxl driver and the PowerNV PHB code. The Mellanox developers will
submit a separate patch series that makes use of this in the mlx5 driver.

The CX4 card can operate in either pci mode, or cxl mode. In cxl mode, memory
accesses from the card go through the XSL (Translation Service Layer,
essentially a stripped down version of the Power Service Layer), allowing it to
transparently access unpinned memory with the cxl driver handling faulting in
pages as necessary, etc. Most of the support for the XSL is already upstream,
though this series does include a bug fix to enable bus mastering for this
(patch 3).

Patch 2 in this series provides an API which the mlx5 driver can query to check
if it is in a cxl capable slot. The card will come up in pci mode, and the mlx5
driver can choose to switch it to cxl mode, wherein it will reappear with an
additional physical function representing the XSL that the cxl driver will bind
to. Patches 13-15 add support for switching the card's mode, including using
the PCI hotplug support to re-enumerate the device tree and re-probind the
card.

Unlike previous users of the cxl kernel API where we used a virtual PHB and
exposed PCI devices under it, the Mellanox CX4 uses a peer model where cxl
binds to one of the physical functions of the card and the mlx5_core driver
binds to the other networking physical functions. Patch 6 skips creating a vPHB
for AFUs without any AFU configuration records (including devices using the
peer model) and opts out of EEH handling. Patches 7 and 8 add support for using
the cxl kernel API with the real PHB to enable this peer model. Patches 4 and
5 are prepatory patches exposing some APIs that the PHB will need to call.

While in cxl mode, interrupts from the CX4 are a little unusual - they are
neither pci interrupts, nor cxl interrutps, but rather a hybrid of the two. The
interrupts are passed from the networking hardware to the XSL using a custom
format in the MSIX table, and from there are treated as cxl interrupts. These
are configured mostly transparently using the standard msix APIs - the PHB
handles allocating and configuring the cxl interrupts, associating them with
the default context, and the mlx5 driver handles filling out the MSIX table
with their custom format (not included in this series). See patch 11.

Additionally, the CX4 has a hard limitation of the number of interrupts that
can be associated with a given context, so to overcome this patches 9 and 10
expose an API to allow the mlx5 driver to inform us of the limit, and the
interrupt allocation code in patch 11 will allocate additional contexts to
associate these with.

Patch 1 is a prepatory cleanup patch to reorganise cxl code in arch/powerpc
into a separate file.

Patch 12 is a workaround for a hardware limitation in the CX4 where a context
with PE=0 cannot be used.

The entire series is bisectable.

Changes since v2:
	Addressed feedback from Andrew Donnellan:
	- Fixed typos in several comments
	- Moved _cxl_pci_associate_default_context and
	  _cxl_pci_disable_device from vphb.c to a new file phb.c since
	  they are used by both the vPHB and peer models. (Patch 5)
	- Changed two exported symbols to EXPORT_SYMBOL_GPL (Patch 7)
	- Undid change to remove static from pnv_pci_release_device and
	  pci_controller_ops and declare them in the header, both of
	  which were left over from an earlier cut. (Patch 7)

Changes since v1:
	- New patch 6 to skip creating a vPHB if there are no AFU configuration
	  records, and opt out of EEH handling (partially split from patch 8).
	- Updated comments in various patches (1, 2, 7, 10, 15) with feedback
	  from Andrew Donnellan and Frederic Barrat
	- Handle error case if cxl_next_msi_hwirq returns 0 signifying
	  that an AFU IRQ is not mapped to a hardware interrupt (Patch 11)
	- Dropped extraneous "select HOTPLUG_PCI_POWERNV_BASE" in Kconfig,
	  which was accidentally left in from an earlier non-public
	  revision. Thanks to Gavin Shan for pointing it out (Patch 13)
	- Added new error label for error paths calling pci_dev_put() -
	  suggested by Ian Munsie (Patch 15)
	- Added newline at end of Kconfig (Patch 15)
