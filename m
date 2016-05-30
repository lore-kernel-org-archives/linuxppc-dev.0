Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJGzs41TKzDqW8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:04:41 +1000 (AEST)
Received: from pps.filterd (m0075771.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4UD4HdQ039543
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:04:39 -0400
Message-Id: <201605301304.u4UD4HdQ039543@mx0a-001b2d01.pphosted.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 238hnbq1es-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:04:39 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 30 May 2016 18:34:35 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id A1B61E005E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:37:54 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4UD4VRm33751178
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:34:31 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4UD4RNS026135
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:34:30 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH v2 0/4] PCI: Add support for enforcing all MMIO BARs not to
 share PAGE_SIZE
Date: Mon, 30 May 2016 21:00:14 +0800
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
of PAGE_SIZE. It's flexible. And we can default to enable it on  
some archs which may easily hit the performance issue because of  
their 64K page.

In this series, patch 1 fixed a bug of resource_alignment; patch 2,3 
tried to add a new option for resource_alignment to use 
IORESOURCE_STARTALIGN to specify the alignment of PCI BARs; patch 4 
modified resource_alignment to support syntax which can be used to  
enforce the alignment of all MMIO BARs to be at least PAGE_SIZE.

Changelog v2:
- Ignore enforced alignment to VF BARs on pci_reassigndev_resource_alignment()

Yongji Xie (4):
  PCI: Ignore resource_alignment if PCI_PROBE_ONLY was set
  PCI: Do not Use IORESOURCE_STARTALIGN to identify bridge resources
  PCI: Add a new option for resource_alignment to reassign alignment
  PCI: Add support for enforcing all MMIO BARs to be page aligned

 Documentation/kernel-parameters.txt |    7 ++-
 arch/powerpc/include/asm/pci.h      |    2 +
 drivers/pci/pci.c                   |  109 ++++++++++++++++++++++++++++-------
 drivers/pci/setup-bus.c             |    9 ++-
 4 files changed, 102 insertions(+), 25 deletions(-)

-- 
1.7.9.5
