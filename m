Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1B9A1A030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 21:04:01 +1100 (AEDT)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 28 Jan 2016 15:33:14 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0SA1nmD50135040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 15:31:49 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0SA1ha3027819
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 15:31:48 +0530
Subject: Re: [RFC PATCH v3 0/5] vfio-pci: Allow to mmap sub-page MMIO BARs and
 MSI-X table on PPC64 platform
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org
References: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 alex.williamson@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 David Laight <David.Laight@ACULAB.COM>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <56A9E70F.9030503@linux.vnet.ibm.com>
Date: Thu, 28 Jan 2016 18:01:51 +0800
MIME-Version: 1.0
In-Reply-To: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ping...

Alex, any comment?

Regards,
Yongji Xie

On 2016/1/15 15:06, Yongji Xie wrote:
> Current vfio-pci implementation disallows to mmap
> sub-page(size < PAGE_SIZE) MMIO BARs and MSI-X table. This is because
> sub-page BARs' mmio page may be shared with other BARs and MSI-X table
> should not be accessed directly from the guest for security reasons.
>
> But these will easily cause some performance issues for mmio accesses
> in guest when vfio passthrough sub-page BARs or BARs containing MSI-X
> table on PPC64 platform. This is because PAGE_SIZE is 64KB by default
> on PPC64 platform and the big page may easily hit the sub-page MMIO
> BARs' unmmapping and cause the unmmaping of the mmio page which
> MSI-X table locate in, which lead to mmio emulation in host.
>
> For sub-page MMIO BARs' unmmapping, this patchset adds a kernel
> parameter for PCI resource allocator to enforce the alignment of all
> MMIO BARs to be at least PAGE_SZIE and make it enabled by default on
> PPC64 platform so that sub-page BAR's mmio page will not be shared
> with other BARs. Then we can mmap sub-page MMIO BARs in vfio-pci driver
> with this parameter enabled.
>
> For MSI-X table's unmmapping, we think MSI-X table is safe to access
> directly from userspace if PCI host bridge support filtering of MSIs
> which can ensure that a given pci device can only shoot the MSIs
> assigned for it. So we add a pci_host_bridge attribute to indicate
> if this PCI host bridge supports filtering of MSIs. Then we can mmap
> MSI-X table with this attribute set.
>
> With this patchset applied, we can get almost 100% improvement on
> performance for mmio accesses when we passthrough sub-page BARs to guest
> in our test.
>
> The two vfio related patches(patch 2 and patch 5) are based on the
> proposed patchset[1].
>
> Changelog v3:
> - Rebase on new linux kernel mainline with the patchset[1] applied.
> - Add a function to check whether PCI BARs'mmio page is shared with
>    other BARs.
> - Add a host bridge attribute to indicate PCI host bridge support
>    filtering of MSIs.
> - Use the new host bridge attribute to check if MSI-X table can
>    be mmapped instead of CONFIG_EEH.
> - Remove Kconfig option VFIO_PCI_MMAP_MSIX
>
> Changelog v2:
> - Rebase on v4.4-rc6 with the patchset[1] applied.
> - Use kernel parameter to enforce all MMIO BARs to be page aligned
>    on PCI core code instead of doing it on PPC64 arch code.
> - Remove flags: VFIO_DEVICE_FLAGS_PCI_PAGE_ALIGNED
>                  VFIO_DEVICE_FLAGS_PCI_MSIX_MMAP
> - Add a Kconfig option to support for mmapping MSI-X table.
>
> [1] https://lkml.org/lkml/2015/11/23/748
>
> Yongji Xie (5):
>    PCI: Add support for enforcing all MMIO BARs to be page aligned
>    vfio-pci: Allow to mmap sub-page MMIO BARs if the mmio page is exclusive
>    PCI: Add host bridge attribute to indicate filtering of MSIs is supported
>    powerpc/powernv/pci-ioda: Enable msi_filtered bit for any IODA host bridge
>    vfio-pci: Allow to mmap MSI-X table if host bridge supports filtering of MSIs
>
>   Documentation/kernel-parameters.txt       |    5 +++++
>   arch/powerpc/include/asm/pci.h            |   11 +++++++++
>   arch/powerpc/platforms/powernv/pci-ioda.c |    6 +++++
>   drivers/pci/host-bridge.c                 |    6 +++++
>   drivers/pci/pci.c                         |   35 +++++++++++++++++++++++++++++
>   drivers/pci/pci.h                         |    8 ++++++-
>   drivers/vfio/pci/vfio_pci.c               |   13 ++++++++---
>   include/linux/pci.h                       |    7 ++++++
>   8 files changed, 87 insertions(+), 4 deletions(-)
>
