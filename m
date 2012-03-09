Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 96A18B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 14:29:53 +1100 (EST)
Message-ID: <1331263785.3105.52.camel@pasglop>
Subject: Re: 3.3.0-rc6-next-20120308 boot failure on POWER7 blade
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Fri, 09 Mar 2012 14:29:45 +1100
In-Reply-To: <20120309142555.7ec5e0ac@kryten>
References: <20120309142555.7ec5e0ac@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: sfr@ozlabs.org, linuxppc-dev@lists.ozlabs.org, yinghai@kernel.org,
 linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-03-09 at 14:25 +1100, Anton Blanchard wrote:
> Hi,
> 
> I'm seeing this on a POWER7 blade booting 3.3.0-rc6-next-20120308:

Looks like something that got fixed but the new patches from Bjorn
aren't in next yet. I'll fwd you the patch separately to apply on top of
what you have see if that helps (to confirm that's indeed the issue).

Cheers,
Ben.
> 
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x100000-0x10ffff] (bus address [0xf0000-0xfffff])
> pci_bus 0000:00: root bus resource [mem 0x3b0000000000-0x3b001fffffff] (bus address [0xe0000000-0xffffffff])
> IOMMU table initialized, virtual merging enabled
> PCI host bridge to bus 0001:00
> pci_bus 0001:00: root bus resource [io  0x210000-0x21ffff] (bus address [0xf0000-0xfffff])
> pci_bus 0001:00: root bus resource [mem 0x3b0080000000-0x3b00ffffffff] (bus address [0x80000000-0xffffffff])
> PCI host bridge to bus 0002:01
> pci_bus 0002:01: root bus resource [io  0x320000-0x32ffff] (bus address [0xf0000-0xfffff])
> pci_bus 0002:01: root bus resource [mem 0x3b0400000000-0x3b041fefffff] (bus address [0xe0000000-0xffefffff])
> PCI: Cannot allocate resource region 0 of device 0000:00:01.0, will remap
> PCI: Cannot allocate resource region 2 of device 0000:00:01.0, will remap
> PCI: Cannot allocate resource region 6 of device 0000:00:01.0, will remap
> PCI: Cannot allocate resource region 0 of device 0001:00:01.0, will remap
> PCI: Cannot allocate resource region 0 of device 0001:00:01.1, will remap
> PCI: Cannot allocate resource region 0 of device 0001:00:01.2, will remap
> PCI: Cannot allocate resource region 0 of device 0002:01:00.0, will remap
> PCI: Cannot allocate resource region 2 of device 0002:01:00.0, will
> remap
> 
> ...
> 
> pci 0001:00:01.0: device not available (can't reserve [mem 0x00000000-0x00000fff])
> pci 0001:00:01.0: Can't enable PCI device, BIOS handoff failed.
> pci 0001:00:01.1: device not available (can't reserve [mem 0x00000000-0x00000fff])
> pci 0001:00:01.1: Can't enable PCI device, BIOS handoff failed.
> pci 0001:00:01.2: device not available (can't reserve [mem 0x00000000-0x000000ff])
> pci 0001:00:01.2: Can't enable PCI device, BIOS handoff failed.
> 
> 
> Then we fail to find the root device. I haven't had a chance
> to chase the cause of it down yet.
> 
> Anton
