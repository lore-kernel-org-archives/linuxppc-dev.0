Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4Xj76lV2zDqJn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 18:42:03 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0K7dGxe101100
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 02:42:00 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 283dnrsqg1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 02:42:00 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Fri, 20 Jan 2017 00:41:59 -0700
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 zhong@linux.vnet.ibm.com
Subject: [PATCH v8 0/3] PCI: Introduce a way to enforce all MMIO BARs not to
 share PAGE_SIZE
Date: Fri, 20 Jan 2017 15:41:50 +0800
Message-Id: <1484898113-24939-1-git-send-email-xyjxie@linux.vnet.ibm.com>
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

In this series, patch 1,2 fixed bugs of using resource_alignment;
patch 3 adds a macro to set the default alignment of all MMIO BARs.

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
  PCI: Ignore requested alignment for IOV BARs
  PCI: Make sure the driver could get correct BAR size from pci_resource_len()
  PCI: Add a macro to set default alignment for all PCI devices

 arch/powerpc/include/asm/pci.h |    4 ++++
 drivers/pci/pci.c              |    6 +++++-
 include/linux/pci.h            |    6 +++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
1.7.9.5
