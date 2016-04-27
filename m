Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvzXl64FTzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:19:19 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 22:19:17 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D7AAE2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:19:04 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3RCIuZY64815332
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:19:04 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3RCIUbP004601
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:18:32 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [PATCH 0/4] PCI: Add support for enforcing all MMIO BARs not to share
 PAGE_SIZE
Date: Wed, 27 Apr 2016 20:17:07 +0800
Message-Id: <1461759432-5030-1-git-send-email-xyjxie@linux.vnet.ibm.com>
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

Yongji Xie (4):
  PCI: Ignore resource_alignment if PCI_PROBE_ONLY was set
  PCI: Do not Use IORESOURCE_STARTALIGN to identify bridge resources
  PCI: Add a new option for resource_alignment to reassign alignment
  PCI: Add support for enforcing all MMIO BARs to be page aligned

 Documentation/kernel-parameters.txt |    7 ++-
 arch/powerpc/include/asm/pci.h      |    2 +
 drivers/pci/pci.c                   |  105 ++++++++++++++++++++++++++++-------
 drivers/pci/setup-bus.c             |    9 ++-
 4 files changed, 98 insertions(+), 25 deletions(-)

-- 
1.7.9.5
