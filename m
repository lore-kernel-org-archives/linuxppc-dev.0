Return-Path: <robherring2@gmail.com>
Message-ID: <50C8BEF1.7060200@gmail.com>
Date: Wed, 12 Dec 2012 11:29:21 -0600
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: pci and pcie device-tree binding - range No cells
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com>
 <50C601B6.2080107@monstr.eu>
 <AE90C24D6B3A694183C094C60CF0A2F6026B70E7@saturn3.aculab.com>
 <50C60839.70603@monstr.eu> <20121210181525.3ccd87c6@skate>
 <50C66F3C.3010204@gmail.com> <20121212171651.346b81ab@skate>
In-Reply-To: <20121212171651.346b81ab@skate>
Content-Type: text/plain; charset=ISO-8859-1
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

On 12/12/2012 10:16 AM, Thomas Petazzoni wrote:
> Dear Rob Herring,
> 
> On Mon, 10 Dec 2012 17:24:44 -0600, Rob Herring wrote:
> 
>>> Marvell SoCs have up to 20 configurable address windows, which allow
>>> you, at run time, to say "I would like the range from physical
>>> address 0xYYYYYYYY to 0xZZZZZZZZ to correspond to the PCIe device
>>> in port 1, lane 2, or to the NAND, or to this or that device".
>>> Therefore, in the PCIe driver I proposed for the Armada 370/XP SoCs
>>> [1], there is no need to encode all those ranges statically in the
>>> DT.
>>
>> That's not a unique feature. I'm not sure if any powerpc systems do
>> that though.
> 
> Yes, probably not an unique feature.
> 
>>> The only "ranges" property I'm using is to allow the DT sub-nodes
>>> describing each PCIe port/lane to access the CPU registers that
>>> allow to see if the PCIe link is up or down, access the PCI
>>> configuration space and so on. So all ranges in my "ranges"
>>> property correspond to normal CPU registers, like the one you would
>>> put in the "reg" property for any device. The fact that those
>>> devices are PCIe is really orthogonal here.
>>
>> That doesn't really sound right.
> 
> Very likely, but I still don't get what is "the right way".
> 
>> I don't think deviating from the normal binding is the right approach.
>> Perhaps the host driver should fill in the ranges property with the
>> addresses it uses. Then any child devices will get the right address
>> translation.
> 
> I don't really understand what you mean here. If you look at the host
> driver code (arch/arm/mach-mvebu/pcie.c), for each PCIe interface
> is simply does:
> 
>  * Create an address decoding window for the memory BAR
>  * Create an address decoding window for the I/O BAR
>  * Associate the memory BAR window address and the I/O bar window
>    address with the PCIe interface
> 
> And that's it. See
> https://github.com/MISL-EBU-System-SW/mainline-public/blob/marvell-pcie-v1/arch/arm/mach-mvebu/pcie.c#L107.
> 
> So this driver is both "deciding" of the physical addresses for each
> PCIe interface, and "associating" them with the PCIe interfaces. How is
> it useful to feed some addresses back into the Device Tree?

I'm not completely sure for PCI, but the ranges is necessary to
translate addresses of child nodes.

If you don't need ranges then you could omit it. If you need ranges,
then you should follow the PCI binding whether it is put in the DTS or
you dynamically fill it in. This could be filled in by the bootloader as
well if you have PCI devices you need to boot from.

>> Also, while the h/w may support practically any config, there are
>> practical constraints of what Linux will use like there's no reason to
>> support more than 64K i/o space. PCI memory addresses generally start
>> at 0x100000. You probably don't need more than 1 memory window per
>> root complex (although prefetchable memory may also be needed).
> 
> I allocate one 64K I/O window and one memory window per PCIe interface
> whose link is up (i.e a PCIe device is connected).
> 
>> You could let the DT settings drive the address window configuration.
> 
> No, because I don't want to have absolute addresses for the windows: I
> have 10 PCIe interfaces, but often, only a few of them are used. So I
> don't want in the Device Tree to over-allocate hundreds of MB of
> physical address space if it's not useful.

How many you have is probably board dependent and not probe-able, right?
So you would at least know the subset of root complexes that you are
using. I know you want to find the size of all the cards up front and
size windows based on that, but I don't think that is going to be possible.

> 
> PCIe is dynamic, address window configuration is dynamic. And we should
> hardcode all this configuration statically in the DT? Doesn't seem like
> the right solution.

I'm just throwing out ideas. There are many cases of flexibility in h/w
designs which are never used. H/w is often designed in a vacuum without
s/w input. Not saying that is the case here, but you do have to consider
that.

Rob

> 
> Best regards,
> 
> Thomas
> 
