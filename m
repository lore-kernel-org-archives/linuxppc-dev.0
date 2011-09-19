Return-Path: <mgarcia@rossvideo.com>
Received: from mail1.rossvideo.com (mail1.rossvideo.com [72.1.218.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.rossvideo.com",
	Issuer "DigiCert High Assurance CA-3" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CEAA8B70B7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Sep 2011 01:51:00 +1000 (EST)
Subject: RFC [PATCH] fsl pci quirk to __devinit Re: PCIe end-point on FPGA
	doesn't show up on PCI bus when configured
From: Matias Garcia <mgarcia@rossvideo.com>
To: Elie De Brauwer <eliedebrauwer@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <4D4321E1.7060506@gmail.com>
References: <4D430CD4.6060201@rossvideo.com>  <4D4321E1.7060506@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Sep 2011 11:35:11 -0400
Message-ID: <1316446511.10785.34.camel@matias-lnx-host>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-01-28 at 21:06 +0100, Elie De Brauwer wrote:
> On 01/28/11 19:37, Matias Garcia wrote:
> > I'm running a vanilla linux 2.6.37 kernel on a Freescale P2020 dual-core
> > processor, and have the following conundrum: I configure the FPGA which
> > brings up a PCIe interface to the processor. I scan both PCI buses on
> > the system (I believe the second bus is behind the Freescale integrated
> > bridge on the first), and it doesn't show up. I initiate a reset on the
> > processor, and both U-boot and Linux now see the FPGA PCI device at
> > 0000:01:00.00. I've noticed some of the memory mappings in the PCI
> > bridge windows are different between the two boot sequences. I've tried
> > all manner of pci calls (including the pcibios_fixup routines) on the
> > bridge device (including removing and re-scanning it), and on bus 1,
> > which is otherwise empty, to no avail. Following are some debug listings
> > from dmesg; any help/ideas in tracking down the problem (hardware or
> > software) is greatly appreciated.
> >
> > #Boot without FPGA configured:
> > <snip>
> > Found FSL PCI host bridge at 0x00000008ff70a000. Firmware bus number:
> > 0->255
> > PCI host bridge /pcie@8ff70a000 ranges:
> > MEM 0x0000000880000000..0x000000088fffffff -> 0x0000000080000000
> > IO 0x00000008a0000000..0x00000008a000ffff -> 0x0000000000000000
> > /pcie@8ff70a000: PCICSRBAR @ 0xfff00000
> > /pcie@8ff70a000: WARNING: Outbound window cfg leaves gaps in memory map.
> > Adjusting the memory map could reduce unnecessary bounce buffering.
> > /pcie@8ff70a000: DMA window size is 0x80000000
> > MPC85xx RDB board from Freescale Semiconductor
> > <...>
> > PCI: Probing PCI hardware
> > pci 0000:00:00.0: [1957:0070] type 1 class 0x000b20
> > pci 0000:00:00.0: ignoring class b20 (doesn't match header type 01)
> > pci 0000:00:00.0: supports D1 D2
> > pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> > pci 0000:00:00.0: PME# disabled
> > pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > pci 0000:00:00.0: bridge window [io 0x0000-0x0000] (disabled)
> > pci 0000:00:00.0: bridge window [mem 0x00000000-0x000fffff] (disabled)
> > pci 0000:00:00.0: bridge window [mem 0x00000000-0x000fffff pref] (disabled)
> > PCI 0000:00 Cannot reserve Legacy IO [io 0xffbed000-0xffbedfff]
> > pci 0000:00:00.0: PCI bridge to [bus 01-01]
> > pci 0000:00:00.0: bridge window [io 0xffbed000-0xffbfcfff]
> > pci 0000:00:00.0: bridge window [mem 0x880000000-0x88fffffff]
> > pci 0000:00:00.0: bridge window [mem pref disabled]
> > pci 0000:00:00.0: enabling device (0106 -> 0107)
> > pci_bus 0000:00: resource 0 [io 0xffbed000-0xffbfcfff]
> > pci_bus 0000:00: resource 1 [mem 0x880000000-0x88fffffff]
> > pci_bus 0000:01: resource 0 [io 0xffbed000-0xffbfcfff]
> > pci_bus 0000:01: resource 1 [mem 0x880000000-0x88fffffff]
> >
> > #Reset with FPGA configured:
> > <snip>
> > Found FSL PCI host bridge at 0x00000008ff70a000. Firmware bus number:
> > 0->255
> > PCI host bridge /pcie@8ff70a000 ranges:
> > MEM 0x0000000880000000..0x000000088fffffff -> 0x0000000080000000
> > IO 0x00000008a0000000..0x00000008a000ffff -> 0x0000000000000000
> > /pcie@8ff70a000: PCICSRBAR @ 0xfff00000
> > /pcie@8ff70a000: WARNING: Outbound window cfg leaves gaps in memory map.
> > Adjusting the memory map could reduce unnecessary bounce buffering.
> > /pcie@8ff70a000: DMA window size is 0x80000000
> > MPC85xx RDB board from Freescale Semiconductor
> > <...>
> > PCI: Probing PCI hardware
> > pci 0000:00:00.0: [1957:0070] type 1 class 0x000b20
> > pci 0000:00:00.0: ignoring class b20 (doesn't match header type 01)
> > pci 0000:00:00.0: supports D1 D2
> > pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> > pci 0000:00:00.0: PME# disabled
> > pci 0000:01:00.0: [1172:0004] type 0 class 0x001000
> > pci 0000:01:00.0: reg 10: [mem 0x80000000-0x80ffffff]
> > pci 0000:01:00.0: reg 14: [mem 0x81000000-0x81ffffff]
> > pci 0000:01:00.0: reg 18: [mem 0x82000000-0x82ffffff]
> > pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > pci 0000:00:00.0: bridge window [io 0x0000-0x0000] (disabled)
> > pci 0000:00:00.0: bridge window [mem 0x80000000-0x82ffffff]
> > pci 0000:00:00.0: bridge window [mem 0x10000000-0x000fffff pref] (disabled)
> > irq: irq 0 on host /soc@8ff700000/pic@40000 mapped to virtual irq 16
> > PCI 0000:00 Cannot reserve Legacy IO [io 0xffbed000-0xffbedfff]
> > pci 0000:00:00.0: PCI bridge to [bus 01-01]
> > pci 0000:00:00.0: bridge window [io 0xffbed000-0xffbfcfff]
> > pci 0000:00:00.0: bridge window [mem 0x880000000-0x88fffffff]
> > pci 0000:00:00.0: bridge window [mem pref disabled]
> > pci 0000:00:00.0: enabling device (0106 -> 0107)
> > pci_bus 0000:00: resource 0 [io 0xffbed000-0xffbfcfff]
> > pci_bus 0000:00: resource 1 [mem 0x880000000-0x88fffffff]
> > pci_bus 0000:01: resource 0 [io 0xffbed000-0xffbfcfff]
> > pci_bus 0000:01: resource 1 [mem 0x880000000-0x88fffffff]
> 
> 
> Hi Mattias,
> 
> I'm doing the same on a similar setup, also a P2020 but a 2.6.36 and 
> with me it works just fine. However I encountered one problem. I 
> understand it as follows, if there is no physical PCIe link then 
> somewhere a flag PPC_INDIRECT_TYPE_NO_PCIE_LINK gets set. This has as 
> result that reading the PCIe config space will fail with a 
> PCIBIOS_DEVICE_NOT_FOUND (ref 
> http://lxr.linux.no/#linux+v2.6.37/arch/powerpc/sysdev/indirect_pci.c#L24 )
> 
> 
> At 
> http://lxr.linux.no/#linux+v2.6.37/arch/powerpc/include/asm/pci-bridge.h#L105 
> they specify this as a workaround since the PCIe might hang if there is 
> no physical link. So my workaround for this issue was:
> 
> - load the fpga
> - travel down the pci bus to the correct bus where the fpga is attached 
>   use a pci_bus_to_host() to obtain a struct pci_controller, unset the 
> PPC_INDIRECT_TYPE_NO_PCIE_LINK  and call a pci_rescon_bus() on that bus.
> 
> After doing this I can find access the FPGA, and reload it if needed. 
> Not a clue if this is 'the proper way' to do it, but it works for me.
> 
> gr
> E.

Elie et al,

Thanks again for the find. I've been using this method successfully
until now (programming the FPGA from U-Boot and resetting the PCIe
controller as Tiejun suggested was not practical). If anyone has found a
less weird solution, I'd love to hear it. That controller just doesn't
like booting without an end-point on the bus.

We started seeing intermittent failures at the call to
quirk_fsl_pcie_header, particularly on one unit. I finally clued in that
it might be called after initialization with an __init tag. Would it be
uncouth to ask that it be changed to __devinit? I gather it's only
supposed to be called once, but in my case, it gets called more than
once when the controller is re-added in my fpga loader.

Here's the patch against 2.6.37:

Change quirk_fsl_pcie_header from __init to __devinit.

Signed-off-by: Matias Garcia <mgarcia@rossvideo.com>
---
diff --git a/arch/powerpc/sysdev/fsl_pci.c
b/arch/powerpc/sysdev/fsl_pci.c
index 818f7c6..8807d77 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -36,7 +36,7 @@
 
 static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
 
-static void __init quirk_fsl_pcie_header(struct pci_dev *dev)
+static void __devinit quirk_fsl_pcie_header(struct pci_dev *dev)
 {
        /* if we aren't a PCIe don't bother */
        if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
