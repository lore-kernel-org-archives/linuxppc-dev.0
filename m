Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjnkT6GjZzDqnx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 23:22:41 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u64DIefs057959
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 09:22:39 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23x9mcwavc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 09:22:39 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 4 Jul 2016 23:22:36 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8349A3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 23:22:33 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u64DMXN313369854
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 23:22:33 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u64DMW5L017780
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 23:22:33 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Subject: powerpc / cxl: Add support for the Mellanox CX4 in cxl mode
Date: Mon,  4 Jul 2016 23:21:58 +1000
Message-Id: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
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
to. Patches 12-14 add support for switching the card's mode, including using
the PCI hotplug support to re-enumerate the device tree and re-probind the
card.

Unlike previous users of the cxl kernel API where we used a virtual PHB and
exposed PCI devices under it, the Mellanox CX4 uses a peer model where cxl
binds to one of the physical functions of the card and the mlx5_core driver
binds to the other networking physical functions. Patches 6 and 7 add support
for using the cxl kernel API with the real PHB to enable this peer model.
Patches 4 and 5 are prepatory patches exposing some APIs that the PHB will need
to call.

While in cxl mode, interrupts from the CX4 are a little unusual - they are
neither pci interrupts, nor cxl interrutps, but rather a hybrid of the two. The
interrupts are passed from the networking hardware to the XSL using a custom
format in the MSIX table, and from there are treated as cxl interrupts. These
are configured mostly transparently using the standard msix APIs - the PHB
handles allocating and configuring the cxl interrupts, associating them with
the default context, and the mlx5 driver handles filling out the MSIX table
with their custom format (not included in this series). See patch 10.

Additionally, the CX4 has a hard limitation of the number of interrupts that
can be associated with a given context, so to overcome this patches 8 and 9
expose an API to allow the mlx5 driver to inform us of the limit, and the
interrupt allocation code in patch 10 will allocate additional contexts to
associate these with.

Patch 1 is a prepatory cleanup patch to reorganise cxl code in arch/powerpc
into a separate file.

Patch 11 is a workaround for a hardware limitation in the CX4 where a context
with PE=0 cannot be used.

Note that patch 2 depends on "cxl: Ignore CAPI adapters misplaced in switched
slot" by Philippe Bergheaud:
http://patchwork.ozlabs.org/patch/642920/

Additionally, the following stand-alone patches related to the CX4 are also
pending on the mainling list, but are *not* dependencies of this series:
- cxl: Fix bug where AFU disable operation had no effect
- cxl: Workaround XSL bug that does not clear the RA bit after a reset
- cxl: Fix NULL pointer dereference on kernel contexts with no AFU interrupts

The entire series is bisectable.
