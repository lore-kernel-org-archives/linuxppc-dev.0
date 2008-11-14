Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F4081DDDE3
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 15:45:18 +1100 (EST)
Date: Fri, 14 Nov 2008 07:45:13 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1102187680.20081114074513@emcraft.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re[2]: [PATCH] katmai.dts: extend DMA ranges; add dma/sysace nodes
In-Reply-To: <1226568352.7178.44.camel@pasglop>
References: <200811131149.14715.yur@emcraft.com>
	<1226568352.7178.44.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Wolfgang Denk <wd@denx.de>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0A Hello Ben,

On Thursday, November 13, 2008 you wrote:

> On Thu, 2008-11-13 at 11:49 +0300, Yuri Tikhonov wrote:
>> Hello,
>>=20
>> This patch extends DMA ranges for PCI(X) to 4GB, so that it could
>> work on Katmais with 4GB RAM installed.

> And where do you put MMIO ?

> The 32 bit part of the PCI space need to be split between MMIO and DMA.

 My understanding was that the dma-ranges property is responsible for=20
setting up the inbound ranges of RAM's physical addresses, where PCI=20
could DMA to/from. As regarding the outbound property, this patch=20
doesn't change this, and there we have the PCI space split (2 GB of=20
memory, and 64K of I/O spaces mapped from the 64-bit physical=20
addresses into 32-bit PCI address space). Am I missing something ?

 With the default 2GB dma-ranges we just get the following on Katmai=20
with 4GB of SDRAM installed:

...
PCIE0: Checking link...
PCIE0: Device detected, waiting for link...
PCIE0: link is up !
PCI host bridge /plb/pciex@d00000000 (primary) ranges:
 MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000=20
  IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
/plb/pciex@d00000000: dma-ranges too small (size=3D80000000 total_memory=3D=
100000000)
PCIE1: Checking link...
PCIE1: Device detected, waiting for link...
PCIE1: link is up !
PCI host bridge /plb/pciex@d20000000 (primary) ranges:
 MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000=20
  IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
/plb/pciex@d20000000: dma-ranges too small (size=3D80000000 total_memory=3D=
100000000)
PCIE2: Checking link...
PCIE2: Device detected, waiting for link...
PCIE2: link is up !
PCI host bridge /plb/pciex@d40000000 (primary) ranges:
 MEM 0x0000000f00000000..0x0000000f7fffffff -> 0x0000000080000000=20
  IO 0x0000000f80020000..0x0000000f8002ffff -> 0x0000000000000000
/plb/pciex@d40000000: dma-ranges too small (size=3D80000000 total_memory=3D=
100000000)
PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
 MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000=20
  IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
/plb/pci@c0ec00000: dma-ranges too small (size=3D80000000 total_memory=3D10=
0000000)
...


> Ideally, for 64-bit capable DMA, device, we should create a second DMA
> range mapping the whole memory at something like 1T or so on PCI, and
> keep a smaller (ie. 2G) DMA range for 32-bit only devices backed with
> swiotlb.

> Cheers,
> Ben.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
