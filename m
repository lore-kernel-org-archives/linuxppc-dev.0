Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpC9n5y0lzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 15:44:13 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id 185so847997itv.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 22:44:13 -0700 (PDT)
Subject: Re: [PATCH kernel 0/3] vfio-pci: Add support for mmapping MSI-X table
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongji Xie <elohimes@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20170615050642.8197-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b1fc1f3e-a2f4-b829-de34-131159046fbe@ozlabs.ru>
Date: Thu, 15 Jun 2017 15:44:04 +1000
MIME-Version: 1.0
In-Reply-To: <20170615050642.8197-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ouch, this is a wrong one, please ignore. I'll repost in a sec.


On 15/06/17 15:06, Alexey Kardashevskiy wrote:
> Here is a patchset which Yongji was working on before
> leaving IBM LTC. Since we still want to have this functionality
> in the kernel (DPDK is the first user), here is a rebase
> on the current upstream.
> 
> 
> Current vfio-pci implementation disallows to mmap the page
> containing MSI-X table in case that users can write directly
> to MSI-X table and generate an incorrect MSIs.
> 
> However, this will cause some performance issue when there
> are some critical device registers in the same page as the
> MSI-X table. We have to handle the mmio access to these
> registers in QEMU emulation rather than in guest.
> 
> To solve this issue, this series allows to expose MSI-X table
> to userspace when hardware enables the capability of interrupt
> remapping which can ensure that a given PCI device can only
> shoot the MSIs assigned for it. And we introduce a new bus_flags
> PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side
> for different archs.
> 
> The patch 3 are based on the proposed patchset[1].
> 
> Changelog
> v3:
> - rebased on the current upstream
> 
> v2:
> - Make the commit log more clear
> - Replace pci_bus_check_msi_remapping() with pci_bus_msi_isolated()
>   so that we could clearly know what the function does
> - Set PCI_BUS_FLAGS_MSI_REMAP in pci_create_root_bus() instead
>   of iommu_bus_notifier()
> - Reserve VFIO_REGION_INFO_FLAG_CAPS when we allow to mmap MSI-X
>   table so that we can know whether we allow to mmap MSI-X table
>   in QEMU
> 
> [1] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1138820.html
> 
> 
> This is based on sha1
> 63f700aab4c1 Linus Torvalds "Merge tag 'xtensa-20170612' of git://github.com/jcmvbkbc/linux-xtensa".
> 
> Please comment. Thanks.
> 
> 
> 
> Yongji Xie (3):
>   PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
>   pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
>   vfio-pci: Allow to expose MSI-X table to userspace if interrupt
>     remapping is enabled
> 
>  include/linux/pci.h                       |  1 +
>  arch/powerpc/platforms/powernv/pci-ioda.c |  8 ++++++++
>  drivers/vfio/pci/vfio_pci.c               | 18 +++++++++++++++---
>  drivers/vfio/pci/vfio_pci_rdwr.c          |  3 ++-
>  4 files changed, 26 insertions(+), 4 deletions(-)
> 


-- 
Alexey
