Return-Path: <Johannes.Thumshirn@men.de>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.170])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 645152C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 03:01:23 +1100 (EST)
Date: Wed, 19 Mar 2014 16:54:04 +0100
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: Re: EDAC PCIe errors when scannning the bus
Message-ID: <20140319155404.GA2045@jtlinux>
References: <532991AD.6020903@keymile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <532991AD.6020903@keymile.com>
Cc: linux-pci@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2014 at 01:46:37PM +0100, Valentin Longchamp wrote:
> Hello,
>
> We have a board that is based on Freescale's P2041 SoC. The boards has 2 PCIe
> buses with this topology:
>
> PCIe 0 <---> PEX8505 switch <---> 4 network devices
> PCIE 2 <---> FPGA
>
> On 3.10.33 + a subset of the Freescale SDK 1.4 patches, both PCIe buses work
> well and we are able to use the devices on them.
>
> For each bus, I however keep getting EDAC PCIe errors at the very first stage of
> bus enumeration (please see the attached kernel log, with some debug output from
> arch/powerpc/kernel/pci-common.c and drivers/pci/probe.c) for both buses.
>
> My current "understanding" of the situation is such: since PCI_PROBE_NORMAL is
> used, pcibios_scan_phb() calls pci_scan_child_bus() that does a pci_scan_slot()
> on the bus for 32 slots. The first pci_scan_slot() is successful and it
> discovers the P2041's PCIe Controller. All the 31 other pci_scan_slot() calls
> generate an EDAC PCIe error, that is triggered by the configuration read
> transaction to read an hypothetical vendor ID of a device on the bus. This is
> relevant with that is reported by the EDAC error handler (all the 31 are the same):
>
> > PCIE error(s) detected
> > PCIE ERR_DR register: 0x00020000
>
> ICCA bit is set: Access to an illegal configuration space from
> PEX_CONFIG_ADDR/PEX_CONFIG_DATA was detected.
>
> > PCIE ERR_CAP_STAT register: 0x80000001
>
> To is set: Transaction originated from PEX_CONFIG_ADDR/PEX_CONFIG_DATA.
>
> > PCIE ERR_CAP_R0 register: 0x00000800
>
> FMT: 0b00, TYPE: 0b00100 (Config read I guess)
>
> > PCIE ERR_CAP_R1 register: 0x00000000
> > PCIE ERR_CAP_R2 register: 0x00000000
> > PCIE ERR_CAP_R3 register: 0x00000000
>
> Afterwards, pci_scan_child_bus() calls pcibios_fixup_bus (that maybe helps ?).
> From here, since the P2041's PCIe Controller is a bridge, pci_scan_bridge is
> called for this bus and all the devices are detected without having any
> configuration transaction causing EDAC errors.
>
> Has someone already observed such a behavior ? Why do these initial transaction
> generate an error ? What would be a possible fix to avoid these transaction
> errors for these 31 (unneded ?) pci_scan_slot() calls on the initial bus ?
>
> Best Regards,
>
> Valentin


Hi Valentin,

I've encountered similar problems on a P4080 based design (mine has additional
machine checks that cause an oops). I haven't solved it yet, so I unfortunately
can't offer you a fix. But I was told there are some errata workarounds that
more or less could have an impact on PCIe behavior. Could you show me the output
of U-Boot's errata command?

Especially if the workarounds for A-004580 and A-004849 are in place.

Johannes
