Return-Path: <thomas.petazzoni@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [88.190.12.23])
 by ozlabs.org (Postfix) with ESMTP id A028B2C032B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2012 04:22:51 +1100 (EST)
Date: Mon, 10 Dec 2012 18:15:25 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: monstr@monstr.eu
Subject: Re: pci and pcie device-tree binding - range No cells
Message-ID: <20121210181525.3ccd87c6@skate>
In-Reply-To: <50C60839.70603@monstr.eu>
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com>
 <50C601B6.2080107@monstr.eu>
 <AE90C24D6B3A694183C094C60CF0A2F6026B70E7@saturn3.aculab.com>
 <50C60839.70603@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Rob Herring <rob.herring@calxeda.com>, David Laight <David.Laight@ACULAB.COM>,
 Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Michal Simek,

On Mon, 10 Dec 2012 17:05:13 +0100, Michal Simek wrote:

> CC: Thomas: I think it will be interesting to see this discussion
> because you are using size-cell/address-cells equal 1.
> http://www.spinics.net/lists/arm-kernel/msg211839.html

Thanks for Cc'ing me.

The thing is that on Marvell SoCs, we don't need to describe statically
in the Device Tree the translation between CPU addresses and PCI device
addresses, because those translations are set up dynamically at run
time through address decoding windows.

Marvell SoCs have up to 20 configurable address windows, which allow
you, at run time, to say "I would like the range from physical address
0xYYYYYYYY to 0xZZZZZZZZ to correspond to the PCIe device in port 1,
lane 2, or to the NAND, or to this or that device". Therefore, in the
PCIe driver I proposed for the Armada 370/XP SoCs [1], there is no need
to encode all those ranges statically in the DT.

The only "ranges" property I'm using is to allow the DT sub-nodes
describing each PCIe port/lane to access the CPU registers that allow
to see if the PCIe link is up or down, access the PCI configuration
space and so on. So all ranges in my "ranges" property correspond to
normal CPU registers, like the one you would put in the "reg" property
for any device. The fact that those devices are PCIe is really
orthogonal here.

Of course, I have no idea if I'm doing a correct usage of the DT, but I
certainly don't need those 6 values ranges with bits to say if it's I/O
space, memory space, bus number, device number and so on. The physical
addresses at which I'm setting up my address decoding windows are
decided dynamically at runtime, depending on the number of PCIe devices
that are found in the different PCIe slots (for now, those windows have
a statically defined size, but I'd ideally would like to size them to
match exactly the size of the PCIe device memory, in order to avoid
wasting physical address space, but I haven't found how to get the size
needed for each PCIe device during the ARM pcibios initialization
sequence).

For those willing to have a look at the PCIe patch set for Armada
370/XP, see:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/136455.html.
The core of the PCIe driver and its DT binding documentation is at
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/136711.html.

Thanks a lot for your comments,

Thomas

[1] that I hope to extend to cover previous Marvell SoCs as well, they
    work basically the same way
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
