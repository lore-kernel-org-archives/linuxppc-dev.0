Return-Path: <robherring2@gmail.com>
Message-ID: <50C66F3C.3010204@gmail.com>
Date: Mon, 10 Dec 2012 17:24:44 -0600
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: pci and pcie device-tree binding - range No cells
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com>
 <50C601B6.2080107@monstr.eu>
 <AE90C24D6B3A694183C094C60CF0A2F6026B70E7@saturn3.aculab.com>
 <50C60839.70603@monstr.eu> <20121210181525.3ccd87c6@skate>
In-Reply-To: <20121210181525.3ccd87c6@skate>
Content-Type: text/plain; charset=ISO-8859-1
Cc: monstr@monstr.eu, linux-pci@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Rob Herring <rob.herring@calxeda.com>, David Laight <David.Laight@ACULAB.COM>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/10/2012 11:15 AM, Thomas Petazzoni wrote:
> Dear Michal Simek,
> 
> On Mon, 10 Dec 2012 17:05:13 +0100, Michal Simek wrote:
> 
>> CC: Thomas: I think it will be interesting to see this discussion
>> because you are using size-cell/address-cells equal 1.
>> http://www.spinics.net/lists/arm-kernel/msg211839.html
> 
> Thanks for Cc'ing me.
> 
> The thing is that on Marvell SoCs, we don't need to describe statically
> in the Device Tree the translation between CPU addresses and PCI device
> addresses, because those translations are set up dynamically at run
> time through address decoding windows.
> 
> Marvell SoCs have up to 20 configurable address windows, which allow
> you, at run time, to say "I would like the range from physical address
> 0xYYYYYYYY to 0xZZZZZZZZ to correspond to the PCIe device in port 1,
> lane 2, or to the NAND, or to this or that device". Therefore, in the
> PCIe driver I proposed for the Armada 370/XP SoCs [1], there is no need
> to encode all those ranges statically in the DT.

That's not a unique feature. I'm not sure if any powerpc systems do that
though.

> The only "ranges" property I'm using is to allow the DT sub-nodes
> describing each PCIe port/lane to access the CPU registers that allow
> to see if the PCIe link is up or down, access the PCI configuration
> space and so on. So all ranges in my "ranges" property correspond to
> normal CPU registers, like the one you would put in the "reg" property
> for any device. The fact that those devices are PCIe is really
> orthogonal here.

That doesn't really sound right.

> Of course, I have no idea if I'm doing a correct usage of the DT, but I
> certainly don't need those 6 values ranges with bits to say if it's I/O
> space, memory space, bus number, device number and so on. The physical
> addresses at which I'm setting up my address decoding windows are
> decided dynamically at runtime, depending on the number of PCIe devices
> that are found in the different PCIe slots (for now, those windows have
> a statically defined size, but I'd ideally would like to size them to
> match exactly the size of the PCIe device memory, in order to avoid
> wasting physical address space, but I haven't found how to get the size
> needed for each PCIe device during the ARM pcibios initialization
> sequence).

I don't think deviating from the normal binding is the right approach.
Perhaps the host driver should fill in the ranges property with the
addresses it uses. Then any child devices will get the right address
translation.

Also, while the h/w may support practically any config, there are
practical constraints of what Linux will use like there's no reason to
support more than 64K i/o space. PCI memory addresses generally start at
0x100000. You probably don't need more than 1 memory window per root
complex (although prefetchable memory may also be needed).

You could let the DT settings drive the address window configuration.

Rob

> For those willing to have a look at the PCIe patch set for Armada
> 370/XP, see:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/136455.html.
> The core of the PCIe driver and its DT binding documentation is at
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/136711.html.
> 
> Thanks a lot for your comments,
> 
> Thomas
> 
> [1] that I hope to extend to cover previous Marvell SoCs as well, they
>     work basically the same way
> 
