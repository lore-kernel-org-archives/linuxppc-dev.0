Return-Path: <oohall@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429H7Y4Bz1zF36K
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 19:49:44 +1000 (AEST)
Received: by mail-io0-x241.google.com with SMTP id n18-v6so1007793ioa.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 02:49:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180911115620.10507-1-s.miroshnichenko@yadro.com>
References: <20180911115620.10507-1-s.miroshnichenko@yadro.com>
From: Oliver <oohall@gmail.com>
Date: Wed, 12 Sep 2018 19:49:41 +1000
Message-ID: <CAOSf1CFnqtQbR793fLt01cXWSm9AvQa_pPG10ip_kyC+TgXcwQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc/powernv/pci: Discover surprise-hotplugged
 PCIe devices during rescan
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2018 at 9:56 PM, Sergey Miroshnichenko
<s.miroshnichenko@yadro.com> wrote:
> This patchset allows hotplugged PCIe devices to be enumerated during a bus
> rescan being issued via sysfs on PowerNV platforms, when the "Presence
> Detect Changed" interrupt is not available.

Seems to be on par with the sysfs slot power hack that pnv_php uses.

> As a first part of our work on adding support for hotplugging PCIe bridges
> full of devices (without special requirement such as Hot-Plug Controller,
> reservation of bus numbers and memory regions by firmware, etc.), this
> serie is intended to solve the first two problems of the listed below:
>
> I   PowerNV doesn't discover new hotplugged PCIe devices
> II  EEH is falsely triggered when poking empty slots during the PCIe rescan

We avoid this problem in pnv_php by having OPAL to do the rescan and
Linux requests
a FDT fragment of everything under the slot. I'm don't think it's a
great system, but
it keeps firmware and the OS on the same page.

> III The PCI subsystem is not prepared to runtime changes of BAR addresses
> IV  Device drivers don't track changes of their BAR addresses
> V   BARs of working devices don't move to make space for new ones

I'm having a really hard to figuring out what would make this
necessary. Keep in mind
that each PHB has it's own set of bus numbers and it's own MMIO space,
so it's not
like you're short on either.

How are you planning on making this sort of live-device-migration work? And what
are you trying to do that makes the added complexity worth it?

> Tested on:
>  - POWER8 PowerNV+OPAL ppc64le (our Vesnin server) w/ and w/o pci=realloc;
>  - POWER8 IBM 8247-42L (pSeries);
>  - POWER8 IBM 8247-42L (PowerNV+OPAL) w/ and w/o pci=realloc.
>
> Changes since v2:
>  - Don't reassign bus numbers on PowerNV by default (to retain the default
>    behavior), but only when pci=realloc is passed;
>  - Less code affected;
>  - pci_add_device_node_info is refactored with add_one_dev_pci_data;
>  - Minor code cleanup.
>
> Changes since v1:
>  - Fixed build for ppc64le and ppc64be when CONFIG_PCI_IOV is disabled;
>  - Fixed build for ppc64e when CONFIG_EEH is disabled;
>  - Fixed code style warnings.
>
> Sergey Miroshnichenko (6):
>   powerpc/pci: Access PCI config space directly w/o pci_dn
>   powerpc/pci: Create pci_dn on demand
>   powerpc/pci: Use DT to create pci_dn for root bridges only
>   powerpc/powernv/pci: Enable reassigning the bus numbers
>   PCI/powerpc/eeh: Add pcibios hooks for preparing to rescan
>   powerpc/pci: Reduce code duplication in pci_add_device_node_info
>
>  arch/powerpc/include/asm/eeh.h               |   2 +
>  arch/powerpc/kernel/eeh.c                    |  12 ++
>  arch/powerpc/kernel/pci_dn.c                 | 119 ++++++++++++++-----
>  arch/powerpc/kernel/rtas_pci.c               |  97 ++++++++++-----
>  arch/powerpc/platforms/powernv/eeh-powernv.c |  22 ++++
>  arch/powerpc/platforms/powernv/pci.c         |  64 ++++++----
>  drivers/pci/probe.c                          |  14 +++
>  include/linux/pci.h                          |   2 +
>  8 files changed, 253 insertions(+), 79 deletions(-)
>
> --
> 2.17.1
>
