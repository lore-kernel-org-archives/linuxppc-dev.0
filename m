Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNVCd6jWbzDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 17:45:17 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1F6hTIw091702
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:45:15 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28mcwhs54y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:45:15 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 23:45:14 -0700
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 zhong@linux.vnet.ibm.com
Subject: [PATCH v9 0/3] PCI: Introduce a way to enforce all MMIO BARs not to
 share PAGE_SIZE
Date: Wed, 15 Feb 2017 14:45:03 +0800
Message-Id: <1487141106-2503-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series introduces a way for PCI resource allocator to force
MMIO BARs not to share PAGE_SIZE. This would make sense to VFIO
driver. Because current VFIO implementation disallows to mmap
sub-page(size < PAGE_SIZE) MMIO BARs which may share the same page
with other BARs for security reasons. Thus, we have to handle mmio
access to these BARs in QEMU emulation rather than in guest which
will cause some performance loss.

In our solution, we try to make use of the existing code path of
resource_alignment kernel parameter and add a macro to set default
alignment for it. Thus we can define this macro by default on some
archs which may easily hit the performance issue because of their
64K page.

In this series, patch 1 fixes a bug related to bridge window
size/alignment caculating; patch 2,3 add support for setting default
alignment of all MMIO BAR.

Changelog v9:
- Add a patch to fix for caculating bridge window's size and alignment
- Remove an unrelated patch
- Rework the patch that fix bug that reassign resources's alignment by
  changing its size

Changelog v8:
- Rebased against v4.10-rc4
- Rework the patch 2
- Change the commit log of patch 1

Changelog v7:
- Rebased against v4.9-rc2
- Drop two merged patches
- Rework the patch which fix a bug that resources's size is changed when
  using resource_alignment
- Add a patch that fix a bug for IOV BARs when using resource_alignment

Changelog v6: 
- Remove the option "noresize@" of resource_alignment

Changelog v5: 
- Rebased against v4.8-rc6
- Drop the patch that forbidding disable memory decoding in
  pci_reassigndev_resource_alignment()

Changelog v4: 
- Rebased against v4.8-rc1
- Drop one irrelevant patch
- Drop the patch that adding wildcard to resource_alignment to enforce
  the alignment of all MMIO BARs to be at least PAGE_SIZE
- Change the format of option "noresize" of resource_alignment
- Code style improvements

Changelog v3: 
- Ignore enforced alignment to fixed BARs
- Fix issue that disabling memory decoding when reassigning the alignment
- Only enable default alignment on PowerNV platform

Changelog v2:
- Ignore enforced alignment to VF BARs on pci_reassigndev_resource_alignment()

Yongji Xie (3):
  PCI: A fix for caculating bridge window's size and alignment
  PCI: Add a macro to set default alignment for all PCI devices
  PCI: Don't extend device's size when using default alignment for all devices

 arch/powerpc/include/asm/pci.h |    4 ++++
 drivers/pci/pci.c              |   37 +++++++++++++++++++++++++++----------
 drivers/pci/setup-bus.c        |    4 ++--
 3 files changed, 33 insertions(+), 12 deletions(-)
