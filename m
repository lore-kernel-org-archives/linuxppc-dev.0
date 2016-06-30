Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgGc40mXQzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 20:53:23 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UAnSuY055043
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 06:53:21 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23utca7njg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 06:53:21 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 16:23:17 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CAA16394005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:23:13 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UArDov33030254
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:23:13 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UArAop029252
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:23:12 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH v3 0/7] PCI: Add support for enforcing all MMIO BARs not to
 share PAGE_SIZE
Date: Thu, 30 Jun 2016 18:53:06 +0800
Message-Id: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series aims to add an option for PCI resource allocator to  
force BARs not to share PAGE_SIZE. This would make sense to VFIO 
driver. Because current VFIO implementation disallows to mmap 
sub-page(size < PAGE_SIZE) MMIO BARs which may share the same page 
with other BARs for security reasons. Thus, we have to handle mmio 
access to these BARs in QEMU emulation rather than in guest which 
will cause some performance loss.

To achieve that, we would like to make use of the existing 
resource_alignment kernel parameter and force a minimum alignment 
of PAGE_SIZE. It's flexible. And we can enable it by default on
some archs which may easily hit the performance issue because of  
their 64K page.

In this series, patch 1,2,3 fixed bugs of using resource_alignment;
patch 4,5 tried to add a new option for resource_alignment to use 
IORESOURCE_STARTALIGN to specify the alignment of PCI BARs; patch 6
modified resource_alignment to support syntax which can be used to
enforce the alignment of all MMIO BARs to be at least PAGE_SIZE;
patch 7 enabled this feature by default on PowerNV platform.

Changelog v3:
- Ignore enforced alignment to fixed BARs
- Fix issue that disabling memory decoding when reassigning the alignment
- Only enable default alignment on PowerNV platform

Changelog v2:
- Ignore enforced alignment to VF BARs on pci_reassigndev_resource_alignment()

Yongji Xie (7):
  PCI: Ignore enforced alignment when kernel uses existing firmware setup
  PCI: Ignore enforced alignment to VF BARs
  PCI: Do not disable memory decoding in pci_reassigndev_resource_alignment()
  PCI: Add a new option for resource_alignment to reassign alignment
  PCI: Do not use IORESOURCE_STARTALIGN to identify bridge resources
  PCI: Add support for enforcing all MMIO BARs to be page aligned
  PCI: Add a macro to set default alignment for all PCI devices

 Documentation/kernel-parameters.txt |    7 +-
 arch/powerpc/include/asm/pci.h      |    4 ++
 drivers/pci/pci.c                   |  123 +++++++++++++++++++++++++++--------
 drivers/pci/setup-bus.c             |    9 ++-
 4 files changed, 111 insertions(+), 32 deletions(-)

-- 
1.7.9.5
