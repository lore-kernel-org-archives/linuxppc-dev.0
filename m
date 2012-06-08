Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A0EC2B6FC2
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jun 2012 08:49:05 +1000 (EST)
Message-ID: <1339195731.24838.53.camel@pasglop>
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Collins <bcollins@ubuntu.com>
Date: Sat, 09 Jun 2012 08:48:51 +1000
In-Reply-To: <BA42176E-B45B-4628-A143-EA7465233651@ubuntu.com>
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
 <4FCFC870.40004@freescale.com>
 <16AB27C3-8709-4A7C-AFFE-42A0B658AC1D@servergy.com>
 <1339061428.24838.24.camel@pasglop>
 <489B8149-6E40-48B3-880F-EF8BE72E94BF@servergy.com>
 <1339104753.24838.30.camel@pasglop>
 <BA42176E-B45B-4628-A143-EA7465233651@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-06-08 at 14:38 -0400, Ben Collins wrote:
> >> pci_bus 0000:00: root bus resource [io  0xffbeb000-0xffbfafff] (bus
> >> address [0x100000000-0x10000ffff])
> >> 
> >> I only have one PCIe RAID card on the bare metal system. Not
> >> surprising I never noticed the problem on it directly.
> > 
> > Can you show me the device-tree node for that PCI host bridge ?
> 
> 
> It's a p4080ds, so it's in arch/powerpc/boot/
> 
> And that means that this bug affects a real hardware platform, so I
> think it makes it more valid to include it. The only reason it didn't
> affect me directly is because my only PCIe card doesn't have io, just
> mem BARs. 

Something doesn't make sense. The bus address printed above are clearly
not right, the .dts contains for the "ranges" entries for IO space of
all 3 bridges:

  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000
  0x01000000 0 0x00000000 0xf 0xf8010000 0x0 0x00010000
  0x01000000 0 0x00000000 0xf 0xf8020000 0x0 0x00010000

So something is wrong with the printing of the bus address, there's a
stale top bit (overflow from the 64-bit substraction somewhere ?)

Cheers,
Ben.
