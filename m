Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKxDJ2PYDzDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 15:51:11 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 1 Jun 2016 23:51:09 -0600
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [RESEND PATCH v2 0/4] PCI: Add support for enforcing all MMIO BARs
 not to share PAGE_SIZE
Date: Thu,  2 Jun 2016 13:46:47 +0800
Message-Id: <1464846411-16895-1-git-send-email-xyjxie@linux.vnet.ibm.com>
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
