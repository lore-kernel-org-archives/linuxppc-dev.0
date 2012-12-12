Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Wed, 12 Dec 2012 17:16:51 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Rob Herring <robherring2@gmail.com>
Subject: Re: pci and pcie device-tree binding - range No cells
Message-ID: <20121212171651.346b81ab@skate>
In-Reply-To: <50C66F3C.3010204@gmail.com>
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com>
 <50C601B6.2080107@monstr.eu>
 <AE90C24D6B3A694183C094C60CF0A2F6026B70E7@saturn3.aculab.com>
 <50C60839.70603@monstr.eu> <20121210181525.3ccd87c6@skate>
 <50C66F3C.3010204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: monstr@monstr.eu, Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
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

Dear Rob Herring,

On Mon, 10 Dec 2012 17:24:44 -0600, Rob Herring wrote:

> > Marvell SoCs have up to 20 configurable address windows, which allow
> > you, at run time, to say "I would like the range from physical
> > address 0xYYYYYYYY to 0xZZZZZZZZ to correspond to the PCIe device
> > in port 1, lane 2, or to the NAND, or to this or that device".
> > Therefore, in the PCIe driver I proposed for the Armada 370/XP SoCs
> > [1], there is no need to encode all those ranges statically in the
> > DT.
> 
> That's not a unique feature. I'm not sure if any powerpc systems do
> that though.

Yes, probably not an unique feature.

> > The only "ranges" property I'm using is to allow the DT sub-nodes
> > describing each PCIe port/lane to access the CPU registers that
> > allow to see if the PCIe link is up or down, access the PCI
> > configuration space and so on. So all ranges in my "ranges"
> > property correspond to normal CPU registers, like the one you would
> > put in the "reg" property for any device. The fact that those
> > devices are PCIe is really orthogonal here.
> 
> That doesn't really sound right.

Very likely, but I still don't get what is "the right way".

> I don't think deviating from the normal binding is the right approach.
> Perhaps the host driver should fill in the ranges property with the
> addresses it uses. Then any child devices will get the right address
> translation.

I don't really understand what you mean here. If you look at the host
driver code (arch/arm/mach-mvebu/pcie.c), for each PCIe interface
is simply does:

 * Create an address decoding window for the memory BAR
 * Create an address decoding window for the I/O BAR
 * Associate the memory BAR window address and the I/O bar window
   address with the PCIe interface

And that's it. See
https://github.com/MISL-EBU-System-SW/mainline-public/blob/marvell-pcie-v1/arch/arm/mach-mvebu/pcie.c#L107.

So this driver is both "deciding" of the physical addresses for each
PCIe interface, and "associating" them with the PCIe interfaces. How is
it useful to feed some addresses back into the Device Tree?

> Also, while the h/w may support practically any config, there are
> practical constraints of what Linux will use like there's no reason to
> support more than 64K i/o space. PCI memory addresses generally start
> at 0x100000. You probably don't need more than 1 memory window per
> root complex (although prefetchable memory may also be needed).

I allocate one 64K I/O window and one memory window per PCIe interface
whose link is up (i.e a PCIe device is connected).

> You could let the DT settings drive the address window configuration.

No, because I don't want to have absolute addresses for the windows: I
have 10 PCIe interfaces, but often, only a few of them are used. So I
don't want in the Device Tree to over-allocate hundreds of MB of
physical address space if it's not useful.

PCIe is dynamic, address window configuration is dynamic. And we should
hardcode all this configuration statically in the DT? Doesn't seem like
the right solution.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
