Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com
 [209.85.213.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 096F614008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 May 2014 02:30:22 +1000 (EST)
Received: by mail-ig0-f179.google.com with SMTP id hn18so29949igb.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 09:30:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1398417515-8740-1-git-send-email-wangyijing@huawei.com>
References: <1398417515-8740-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 30 Apr 2014 10:29:52 -0600
Message-ID: <CAErSpo4fa=fmajhxGA7PRm42S1fS2wV_7w+EWaVh_qiawRAQxA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Refactor pci_is_brdige() to simplify code
To: Yijing Wang <wangyijing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Cc: Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 25, 2014 at 3:18 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> This patchset rename the current pci_is_bridge() to pci_has_subordinate(),
> and introduce a new pci_is_bridge() which determine pci bridge by check
> dev->hdr_type. The new one is more accurate. PCIe Spec define the pci
> device is a bridge by the dev->hdr_type = 0x01 || 0x02.

This needs to be posted to the linux-pci list.  The fact that it
wasn't means it's not in patchwork, so it's not on my to-do list.

Currently we have one interface: pci_is_bridge().

After your series, we would have two interfaces: pci_is_bridge() and
pci_has_subordinate().  Presumably, both are used, and you should
explain how you decided which to use at each place.

I assume the difference is that the old pci_is_bridge() is true for a
bridge that has a subordinate bus.  The new pci_is_bridge() is true
for any bridge, even if there is no subordinate bus.  When do we even
have a bridge with no subordinate bus?  This is the sort of stuff you
need to explain so we know why we should apply these patches.

Bjorn

> Yijing Wang (13):
>   PCI: rename pci_is_bridge() to pci_has_subordinate()
>   PCI: Introduce new pci_is_bridge() helper function
>   PCI: Use new pci_is_bridge() to simplify code
>   x86/PCI: Use new pci_is_bridge() to simplify code
>   IA64/PCI: Use new pci_is_bridge() to simplify code
>   powerpc/PCI: Use new pci_is_bridge() to simplify code
>   sparc/PCI: Use new pci_is_bridge() to simplify code
>   PCI, rpaphp: Use new pci_is_bridge() to simplify code
>   PCI, shpchp: Use new pci_is_bridge() to simplify code
>   PCI, cpcihp: Use new pci_is_bridge() to simplify code
>   PCI, acpiphp: Use new pci_is_bridge() to simplify code
>   PCI, pcmcia: Use new pci_is_bridge() to simplify code
>   PCI, pciehp: Use new pci_is_bridge() to simplify code
>
>  arch/ia64/pci/fixup.c                  |    4 +---
>  arch/powerpc/kernel/pci-hotplug.c      |    3 +--
>  arch/powerpc/kernel/pci_of_scan.c      |    3 +--
>  arch/sparc/kernel/pci.c                |    3 +--
>  arch/x86/pci/fixup.c                   |    4 +---
>  drivers/pci/hotplug/acpiphp_glue.c     |    3 +--
>  drivers/pci/hotplug/cpci_hotplug_pci.c |    3 +--
>  drivers/pci/hotplug/pciehp_pci.c       |    3 +--
>  drivers/pci/hotplug/rpadlpar_core.c    |    3 +--
>  drivers/pci/hotplug/shpchp_pci.c       |    3 +--
>  drivers/pci/pci-acpi.c                 |    8 +-------
>  drivers/pci/pci-driver.c               |    8 ++++----
>  drivers/pci/pci.h                      |    2 +-
>  drivers/pci/probe.c                    |    3 +--
>  drivers/pci/setup-bus.c                |    4 +---
>  drivers/pcmcia/cardbus.c               |    3 +--
>  include/linux/pci.h                    |    6 ++++++
>  17 files changed, 25 insertions(+), 41 deletions(-)
>
>
