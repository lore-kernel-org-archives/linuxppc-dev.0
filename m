Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 9E7121A027B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 10:11:29 +1100 (AEDT)
Date: Tue, 27 Oct 2015 18:11:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
 aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 00/12] VF EEH on Power8
Message-ID: <20151027231113.GB5155@localhost>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 26, 2015 at 11:15:50AM +0800, Wei Yang wrote:
> This patchset enables EEH on SRIOV VFs. The general idea is to create proper
> VF edev and VF PE and handle them properly.
> ...

> Gavin Shan (1):
>   powerpc/eeh: Don't block PCI config on resetting VF PE
> 
> Wei Yang (11):
>   PCI/IOV: Rename and export virtfn_add/virtfn_remove
>   PCI: Add pcibios_bus_add_device() weak function
>   powerpc/pci: Cache VF index in pci_dn
>   powerpc/pci: Remove VFs prior to PF
>   powerpc/eeh: Cache only BARs, not windows or IOV BARs
>   powerpc/powernv: EEH device for VF
>   powerpc/eeh: Create PE for VFs
>   powerpc/powernv: Support EEH reset for VF PE
>   powerpc/powernv: Support PCI config restore for VFs
>   powerpc/eeh: Support error recovery for VF PE
>   powerpc/eeh: Handle hot removed VF when PF is EEH aware
> 
>  arch/powerpc/include/asm/eeh.h               |  10 ++
>  arch/powerpc/include/asm/pci-bridge.h        |   2 +
>  arch/powerpc/kernel/eeh.c                    |  17 ++-
>  arch/powerpc/kernel/eeh_cache.c              |   6 +-
>  arch/powerpc/kernel/eeh_dev.c                |   1 +
>  arch/powerpc/kernel/eeh_driver.c             | 130 ++++++++++++----
>  arch/powerpc/kernel/eeh_pe.c                 |  13 +-
>  arch/powerpc/kernel/pci-hotplug.c            |   2 +-
>  arch/powerpc/kernel/pci_dn.c                 |  16 +-
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 220 ++++++++++++++++++++++++++-
>  arch/powerpc/platforms/powernv/pci.c         |  18 +++
>  drivers/pci/bus.c                            |   3 +
>  drivers/pci/iov.c                            |  10 +-
>  include/linux/pci.h                          |   8 +
>  14 files changed, 408 insertions(+), 48 deletions(-)

This really only affects powerpc, so I assume this series will go through
the powerpc tree.  Let me know if you want me to do anything else.

Bjorn
