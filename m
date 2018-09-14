Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BnXF53PtzDrJv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 06:42:53 +1000 (AEST)
Subject: Re: [PATCH v3 0/6] powerpc/powernv/pci: Discover surprise-hotplugged
 PCIe devices during rescan
To: Oliver <oohall@gmail.com>
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, <linux@yadro.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>
References: <20180911115620.10507-1-s.miroshnichenko@yadro.com>
 <CAOSf1CFnqtQbR793fLt01cXWSm9AvQa_pPG10ip_kyC+TgXcwQ@mail.gmail.com>
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Message-ID: <0b70b213-3c95-3914-9710-7712c8ee3561@yadro.com>
Date: Fri, 14 Sep 2018 23:42:38 +0300
MIME-Version: 1.0
In-Reply-To: <CAOSf1CFnqtQbR793fLt01cXWSm9AvQa_pPG10ip_kyC+TgXcwQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Oliver,

On 9/12/18 12:49 PM, Oliver wrote:
> On Tue, Sep 11, 2018 at 9:56 PM, Sergey Miroshnichenko
> <s.miroshnichenko@yadro.com> wrote:
>> This patchset allows hotplugged PCIe devices to be enumerated during a bus
>> rescan being issued via sysfs on PowerNV platforms, when the "Presence
>> Detect Changed" interrupt is not available.
> 
> Seems to be on par with the sysfs slot power hack that pnv_php uses.
> 

Yes, ours is just for manual initiation of rescan, which helps us with
reliable detection of a bridge hotplug in our particular config.

>> As a first part of our work on adding support for hotplugging PCIe bridges
>> full of devices (without special requirement such as Hot-Plug Controller,
>> reservation of bus numbers and memory regions by firmware, etc.), this
>> serie is intended to solve the first two problems of the listed below:
>>
>> I   PowerNV doesn't discover new hotplugged PCIe devices
>> II  EEH is falsely triggered when poking empty slots during the PCIe rescan
> 
> We avoid this problem in pnv_php by having OPAL to do the rescan and
> Linux requests
> a FDT fragment of everything under the slot. I'm don't think it's a
> great system, but
> it keeps firmware and the OS on the same page.
> 

So if we re-enumerate the PCIe topology from the Linux, we must then
synchronize with the firmware? How would you recommend to approach that
for PowerNV and OPAL? Can we can find somewhere a list of criteria to
ensure that they are properly synced?

>> III The PCI subsystem is not prepared to runtime changes of BAR addresses
>> IV  Device drivers don't track changes of their BAR addresses
>> V   BARs of working devices don't move to make space for new ones
> 
> I'm having a really hard to figuring out what would make this
> necessary. Keep in mind
> that each PHB has it's own set of bus numbers and it's own MMIO space,
> so it's not
> like you're short on either.
> 
> How are you planning on making this sort of live-device-migration work? And what
> are you trying to do that makes the added complexity worth it?
> 

With the "pci=realloc" command line argument and with the
PCI_REASSIGN_ALL_BUS flag the kernel doesn't rely on values of bus
numbers and BAR addresses provided by a firmware (OPAL via FDT in our
case, BIOS/UEFI/Coreboot for x86_64), but re-enumerates the PCIe
topology by its own means, and it arranges BARs quite compactly.

Let's say we have two bridges plugged into neighboring ports of the
root/PHB, each of them have a few NVME drives inserted and several empty
slots, when the system boots. Linux makes their bridge windows adjacent,
so if we plug in a new NVME into the first of them, there will be just
no free space to put its BARs.

Without considering memory pre-allocation, the only way we see to free
some space for new BARs is to move existing BARs of the second bridge
(in this example).

We've implemented a "firmware-independent" proof-of-concept (not
flawless, though, as you and Ben pointed out) and verified on
PowerNV+OPAL and x86_64 that a running NVME with an ongoing "fio"
benchmark always survives BAR movement during hotplug - of course after
applying a patch that pauses the NVME Linux driver during rescan. The
only visible effect is a bandwidth temporary drops to 0 for a second or
two, until NVME restarts. The same for a network adapter - an SSH
connection just freezes for a while.

This patchset is a first part of our work, and we've just published [1]
a second part (on BAR movement and pausing the drivers) for the
community to review, discuss and validate.

[1] https://www.spinics.net/lists/linux-pci/msg76211.html

Best regards,
Serge

>> Tested on:
>>  - POWER8 PowerNV+OPAL ppc64le (our Vesnin server) w/ and w/o pci=realloc;
>>  - POWER8 IBM 8247-42L (pSeries);
>>  - POWER8 IBM 8247-42L (PowerNV+OPAL) w/ and w/o pci=realloc.
>>
>> Changes since v2:
>>  - Don't reassign bus numbers on PowerNV by default (to retain the default
>>    behavior), but only when pci=realloc is passed;
>>  - Less code affected;
>>  - pci_add_device_node_info is refactored with add_one_dev_pci_data;
>>  - Minor code cleanup.
>>
>> Changes since v1:
>>  - Fixed build for ppc64le and ppc64be when CONFIG_PCI_IOV is disabled;
>>  - Fixed build for ppc64e when CONFIG_EEH is disabled;
>>  - Fixed code style warnings.
>>
>> Sergey Miroshnichenko (6):
>>   powerpc/pci: Access PCI config space directly w/o pci_dn
>>   powerpc/pci: Create pci_dn on demand
>>   powerpc/pci: Use DT to create pci_dn for root bridges only
>>   powerpc/powernv/pci: Enable reassigning the bus numbers
>>   PCI/powerpc/eeh: Add pcibios hooks for preparing to rescan
>>   powerpc/pci: Reduce code duplication in pci_add_device_node_info
>>
>>  arch/powerpc/include/asm/eeh.h               |   2 +
>>  arch/powerpc/kernel/eeh.c                    |  12 ++
>>  arch/powerpc/kernel/pci_dn.c                 | 119 ++++++++++++++-----
>>  arch/powerpc/kernel/rtas_pci.c               |  97 ++++++++++-----
>>  arch/powerpc/platforms/powernv/eeh-powernv.c |  22 ++++
>>  arch/powerpc/platforms/powernv/pci.c         |  64 ++++++----
>>  drivers/pci/probe.c                          |  14 +++
>>  include/linux/pci.h                          |   2 +
>>  8 files changed, 253 insertions(+), 79 deletions(-)
>>
>> --
>> 2.17.1
>>
