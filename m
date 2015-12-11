Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A60D1A056F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 19:54:54 +1100 (AEDT)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Fri, 11 Dec 2015 14:24:51 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id AA92C394005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 14:24:48 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBB8sllP10748212
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 14:24:48 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBB8sl20030589
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 14:24:47 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/3] vfio-pci: Allow to mmap sub-page MMIO BARs and MSI-X
 table on PPC64 platform
Date: Fri, 11 Dec 2015 16:53:11 +0800
Message-Id: <1449823994-3356-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current vfio-pci implementation disallows to mmap
sub-page(size < PAGE_SIZE) MMIO BARs and MSI-X table. This is because
sub-page BARs' mmio page may be shared with other BARs and MSI-X table
should not be accessed directly from the guest for security reasons.

But these would cause some performance issues for mmio accesses in guest
when vfio passthrough sub-page BARs or BARs containing MSI-X table on
PPC64 platform. This is because PAGE_SIZE is 64KB by default on PPC64
platform and the big page may easily hit the sub-page MMIO
BARs' unmmapping and cause the unmmaping of the mmio page which
MSI-X table locate in, which lead to mmio emulation in host.

For sub-page MMIO BARs' unmmapping, this patch set enforces all MMIO
BARs to be page aligned on PPC64 platform so that sub-page BAR's mmio
page would not be shared with other BARs. Then we can mmap sub-page
MMIO BARs in vfio-pci driver if all MMIO BARs are page aligned.

For MSI-X table's unmmapping, we think MSI-X table is safe to access
directly from the guest with EEH mechanism enabled which can ensure that
a given pci device can only shoot the MSIs assigned for its PE. So
we add support for mmapping MSI-X table in vfio-pci driver if EEH is
supported.

With this patch set applied, we can get almost 100% improvement on
performance for mmio accesses when we passthrough sub-page BARs in
our test.

The last two patches in the patch set can be used by qemu to:
	- Add support for a VFIO-PCI ioctl to indicate that platform
	  support all PCI BARs are page aligned.
	- Add support for a VFIO-PCI ioctl to indicate that platform
	  support mmapping MSI-X table.

Yongji Xie (3):
  powerpc/pci: Enforce all MMIO BARs to be page aligned
  vfio-pci: Allow to mmap sub-page MMIO BARs if all MMIO BARs are page aligned
  vfio-pci: Allow to mmap MSI-X table if EEH is supported

 arch/powerpc/kernel/pci-common.c    |   10 +++++++++-
 drivers/vfio/pci/vfio_pci.c         |   15 +++++++++++++--
 drivers/vfio/pci/vfio_pci_private.h |   10 ++++++++++
 include/uapi/linux/vfio.h           |    4 ++++
 4 files changed, 36 insertions(+), 3 deletions(-)

-- 
1.7.9.5
