Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 784081007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 30 Jan 2011 14:05:32 +1100 (EST)
Message-ID: <4D44D5DE.1060104@windriver.com>
Date: Sun, 30 Jan 2011 11:07:10 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Elie De Brauwer <eliedebrauwer@gmail.com>,
	Matias Garcia <mgarcia@rossvideo.com>
Subject: Re: PCIe end-point on FPGA doesn't show up on PCI bus when configured
References: <4D430CD4.6060201@rossvideo.com> <4D4321E1.7060506@gmail.com>
In-Reply-To: <4D4321E1.7060506@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Elie De Brauwer wrote:
> On 01/28/11 19:37, Matias Garcia wrote:
>> I'm running a vanilla linux 2.6.37 kernel on a Freescale P2020 dual-core
>> processor, and have the following conundrum: I configure the FPGA which
>> brings up a PCIe interface to the processor. I scan both PCI buses on
>> the system (I believe the second bus is behind the Freescale integrated
>> bridge on the first), and it doesn't show up. I initiate a reset on the
>> processor, and both U-boot and Linux now see the FPGA PCI device at
>> 0000:01:00.00. I've noticed some of the memory mappings in the PCI
>> bridge windows are different between the two boot sequences. I've tried
>> all manner of pci calls (including the pcibios_fixup routines) on the
>> bridge device (including removing and re-scanning it), and on bus 1,
>> which is otherwise empty, to no avail. Following are some debug listings
>> from dmesg; any help/ideas in tracking down the problem (hardware or
>> software) is greatly appreciated.
>>
>> #Boot without FPGA configured:
>> <snip>
>> Found FSL PCI host bridge at 0x00000008ff70a000. Firmware bus number:
>> 0->255
>> PCI host bridge /pcie@8ff70a000 ranges:
>> MEM 0x0000000880000000..0x000000088fffffff -> 0x0000000080000000
>> IO 0x00000008a0000000..0x00000008a000ffff -> 0x0000000000000000
>> /pcie@8ff70a000: PCICSRBAR @ 0xfff00000
>> /pcie@8ff70a000: WARNING: Outbound window cfg leaves gaps in memory map.
>> Adjusting the memory map could reduce unnecessary bounce buffering.
>> /pcie@8ff70a000: DMA window size is 0x80000000
>> MPC85xx RDB board from Freescale Semiconductor
>> <...>
>> PCI: Probing PCI hardware
>> pci 0000:00:00.0: [1957:0070] type 1 class 0x000b20
>> pci 0000:00:00.0: ignoring class b20 (doesn't match header type 01)
>> pci 0000:00:00.0: supports D1 D2
>> pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> pci 0000:00:00.0: PME# disabled
>> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>> pci 0000:00:00.0: bridge window [io 0x0000-0x0000] (disabled)
>> pci 0000:00:00.0: bridge window [mem 0x00000000-0x000fffff] (disabled)
>> pci 0000:00:00.0: bridge window [mem 0x00000000-0x000fffff pref]
>> (disabled)
>> PCI 0000:00 Cannot reserve Legacy IO [io 0xffbed000-0xffbedfff]
>> pci 0000:00:00.0: PCI bridge to [bus 01-01]
>> pci 0000:00:00.0: bridge window [io 0xffbed000-0xffbfcfff]
>> pci 0000:00:00.0: bridge window [mem 0x880000000-0x88fffffff]
>> pci 0000:00:00.0: bridge window [mem pref disabled]
>> pci 0000:00:00.0: enabling device (0106 -> 0107)
>> pci_bus 0000:00: resource 0 [io 0xffbed000-0xffbfcfff]
>> pci_bus 0000:00: resource 1 [mem 0x880000000-0x88fffffff]
>> pci_bus 0000:01: resource 0 [io 0xffbed000-0xffbfcfff]
>> pci_bus 0000:01: resource 1 [mem 0x880000000-0x88fffffff]
>>
>> #Reset with FPGA configured:
>> <snip>
>> Found FSL PCI host bridge at 0x00000008ff70a000. Firmware bus number:
>> 0->255
>> PCI host bridge /pcie@8ff70a000 ranges:
>> MEM 0x0000000880000000..0x000000088fffffff -> 0x0000000080000000
>> IO 0x00000008a0000000..0x00000008a000ffff -> 0x0000000000000000
>> /pcie@8ff70a000: PCICSRBAR @ 0xfff00000
>> /pcie@8ff70a000: WARNING: Outbound window cfg leaves gaps in memory map.
>> Adjusting the memory map could reduce unnecessary bounce buffering.
>> /pcie@8ff70a000: DMA window size is 0x80000000
>> MPC85xx RDB board from Freescale Semiconductor
>> <...>
>> PCI: Probing PCI hardware
>> pci 0000:00:00.0: [1957:0070] type 1 class 0x000b20
>> pci 0000:00:00.0: ignoring class b20 (doesn't match header type 01)
>> pci 0000:00:00.0: supports D1 D2
>> pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> pci 0000:00:00.0: PME# disabled
>> pci 0000:01:00.0: [1172:0004] type 0 class 0x001000
>> pci 0000:01:00.0: reg 10: [mem 0x80000000-0x80ffffff]
>> pci 0000:01:00.0: reg 14: [mem 0x81000000-0x81ffffff]
>> pci 0000:01:00.0: reg 18: [mem 0x82000000-0x82ffffff]
>> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>> pci 0000:00:00.0: bridge window [io 0x0000-0x0000] (disabled)
>> pci 0000:00:00.0: bridge window [mem 0x80000000-0x82ffffff]
>> pci 0000:00:00.0: bridge window [mem 0x10000000-0x000fffff pref]
>> (disabled)
>> irq: irq 0 on host /soc@8ff700000/pic@40000 mapped to virtual irq 16
>> PCI 0000:00 Cannot reserve Legacy IO [io 0xffbed000-0xffbedfff]
>> pci 0000:00:00.0: PCI bridge to [bus 01-01]
>> pci 0000:00:00.0: bridge window [io 0xffbed000-0xffbfcfff]
>> pci 0000:00:00.0: bridge window [mem 0x880000000-0x88fffffff]
>> pci 0000:00:00.0: bridge window [mem pref disabled]
>> pci 0000:00:00.0: enabling device (0106 -> 0107)
>> pci_bus 0000:00: resource 0 [io 0xffbed000-0xffbfcfff]
>> pci_bus 0000:00: resource 1 [mem 0x880000000-0x88fffffff]
>> pci_bus 0000:01: resource 0 [io 0xffbed000-0xffbfcfff]
>> pci_bus 0000:01: resource 1 [mem 0x880000000-0x88fffffff]
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
>  use a pci_bus_to_host() to obtain a struct pci_controller, unset the
> PPC_INDIRECT_TYPE_NO_PCIE_LINK  and call a pci_rescon_bus() on that bus.
> 
> After doing this I can find access the FPGA, and reload it if needed.
> Not a clue if this is 'the proper way' to do it, but it works for me.

Looks this may be really related to the PCIe Link Training. So you have to reset
the PCIe after load the FPGA, but I think we should do this in the u-boot. For
more detail on this please refer to the code segments defined by
CONFIG_FSL_PCIE_RESET in the file, drivers/pci/fsl_pci_init.c.

Tiejun

> 
> gr
> E.
> 
