Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri1.pp.htv.fi (filtteri1.pp.htv.fi [213.243.153.184])
 by ozlabs.org (Postfix) with ESMTP id 6D82D2C00AB
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2012 07:01:23 +1000 (EST)
Date: Sat, 18 Aug 2012 00:01:17 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PPC64 & DMA zone
Message-ID: <20120817210117.GB1908@harshnoise.musicnaut.iki.fi>
References: <20120817200406.GA1908@harshnoise.musicnaut.iki.fi>
 <1345236056.11781.1.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345236056.11781.1.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Sat, Aug 18, 2012 at 06:40:56AM +1000, Benjamin Herrenschmidt wrote:
> > The problem I have is that b43 driver (wireless chip) insists a 30-bit
> > DMA mask, but I have 1.5 GB physical memory. So the only way I can get
> > the wireless connection to work is to boot with "mem=1024MB". And as a
> > result my bloaty applications will loose much needed memory...
> 
> Or force the iommu to be enabled, it should be able to service
> constrained DMA (iommu=force on the command line).

I still get the same failure:

DART IOMMU initialized for U3 type chipset
[...]
Kernel command line: ramdisk_size=8192 iommu=force
[...]
Top of RAM: 0x60000000, Total RAM: 0x60000000
Memory hole size: 0MB
Zone ranges:
  DMA      [mem 0x00000000-0x5fffffff]
  Normal   empty
[...]
b43-pci-bridge 0001:01:01.0: Warning: IOMMU window too big for device mask
b43-pci-bridge 0001:01:01.0: mask: 0x3fffffff, table end: 0x80000000
b43-phy0 ERROR: The machine/kernel does not support the required 30-bit DMA mask

A.
