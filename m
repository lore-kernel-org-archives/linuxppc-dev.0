Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynsqZ4SWBzDsFS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 09:42:50 +1100 (AEDT)
Date: Thu, 30 Nov 2017 16:42:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] SB600 for the Nemo board has non-zero devices on
 non-root bus
Message-ID: <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
References: <f3513294-6da0-456f-0f98-1f8c3bac90c9@xenosoft.de>
 <87tvxl15qx.fsf@concordia.ellerman.id.au>
 <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
 <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
 <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de>
 <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com>
 <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 30, 2017 at 12:39:36AM +0100, Christian Zigotzky wrote:
> On 29 November 2017 at 11:34PM, Bjorn Helgaas wrote:
> > On Wed, Nov 29, 2017 at 2:45 PM, Christian Zigotzky
> >> Thank you for your answer. I have tried to boot the kernel 4.15
> >> RC1 (built without the patch above) with the boot argument
> >> "pci=pcie_scan_all" but without any success.
> >>
> >> Just for info:
> >>
> >> The CPU is a PA Semi “PWRficient” PA6T-1682M. This device
> >> combines dual 1.8GHz PowerPC cores with a 2MB L2 cache, dual
> >> channel DDR2 memory controllers and 24 SerDes channels. The
> >> PowerPC cores adhere to the Power ISA v2.04, and support 64-bit
> >> extensions. They feature a double precision FPU and a VMX
> >> (AltiVec) vector unit. They each have a 64kB I-cache and a 64kB
> >> D-cache.  The SerDes channels support PCI Express, XAUI and SGMII
> >> protocols. The “ENVOI” I/O subsystem which drives them includes
> >> caching, offload and DMA resources to maximise I/O performance.

> >> Nemo uses the AMD/ATI SB600 South Bridge to provide various
> >> integrated I/O functions including SATA/PATA ports, USB and
> >> audio. The SB600 connects to the CPU via a PCIe x4 link. This is
> >> termed an “A-link II Express” link by ATI/AMD. The design team
> >> determined early in the development of Nemo that the link’s
> >> behaviour as an endpoint does not comply fully with the PCI
> >> Express specification. Specifically, it requires the root complex
> >> to use non-zero device numbers in type 0 configuration cycles to
> >> enumerate all the devices within the SB600. This is related to
> >> the PC architecture and is used to allow SB600 devices appear on
> >> logical bus 0.
> >>
> >> More information about the Nemo board:
> >>
> >> https://en.wikipedia.org/wiki/AmigaOne_X1000
> >> http://www.a-eon.com/?page=x1000
> >> http://www.amigaos.net/hardware/35/amigaone-x1000

> > It looks like the SB600 devices actually appear on bus 05 (not 00),
> > right?  I see these devices (among others):
> >
> >   00:10.0 PCI bridge: PA Semi, Inc PWRficient PCI-Express Port
> >   00:11.0 PCI bridge: PA Semi, Inc PWRficient PCI-Express Port
> >   01:00.0 VGA compatible controller: [AMD/ATI] Barts XT [Radeon HD 6870]
> >   05:12.0 SATA controller: [AMD/ATI] SB600 Non-Raid-5 SATA
> >   05:14.4 PCI bridge: [AMD/ATI] SBx00 PCI to PCI Bridge
> >   06:05.0 Ethernet controller: RTL-8100/8101L/8139
> >
> > So 00:10.0 and 00:11.0 are bridges leading to buses 01 and 05-06.
> > Maybe 00:11.0 is the Downstream Port that leads to this magic "A-Link
> > II Express" thing?
> >
> > But I don't think all those SB600 devices on bus 05 are PCIe devices.
> > It would certainly be unconventional to have a PCIe device (00:11.0)
> > at the upstream end of a link and conventional PCI devices (05:12.0,
> > 05:13.0, 05:13.1, etc) at the downstream end, with no visible PCIe
> > port.
> >
> > The usual thing would be that 00:11.0 would be a Root Port or a Switch
> > Downstream Port leading to a Link, and the other end of the Link would
> > terminate in either a Switch Upstream Port or an Upstream Port
> > embedded in an Endpoint.
> >
> > We'll have to think about how to handle this.  But the complete "lspci
> > -vv" output as root will have more useful information.
> 
> Thanks for your reply. Please find attached the complete "lspci -vv"
> output as root.

00:11.0 claims to be a PCIe Root Port leading to [bus 05-06].  That
means there's a Link (presumably this A-Link II Express thing), and the
downstream end of the Link *should* be a PCIe Upstream Port on bus 05,
but no such device is visible.  I suppose the SB600 does implement
some sort of PCIe Port there, but keeps it invisible to software, and
at the same time, contains an invisible bridge that connects the Link
to all the conventional PCI devices on bus 05.

When we scan bus 05, we do this:

  pci_scan_child_bus_extend(bus=05)
    for (devfn = 0; devfn < 0x100; devfn += 8)
      pci_scan_slot(05, 00.0)
        pci_scan_single_device
          pci_scan_device(05, 00.0)           # fails; no 05:00.0
      pci_scan_slot(05, 01.0)
        only_one_child(bus=05)
          parent = 00:11.0
          pci_pcie_type(00:11.0) == ROOT_PORT # returns true

Since only_one_child() sees that 00:11.0 is a Root Port, we give up
before we even get to the PCI_SCAN_ALL_PCIE_DEVS test.

I *think* something like the patch below should make this work if you
use the "pci=pcie_scan_all" parameter.  We have some x86 DMI quirks
that set PCI_SCAN_ALL_PCIE_DEVS automatically.  I don't know how to do
something similar on powerpc, but maybe you do?


commit 75eaf674066590e79b3e03d32488871fc881ab40
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Nov 30 15:22:39 2017 -0600

    PCI: Make PCI_SCAN_ALL_PCIE_DEVS work for Root Ports as well as Downstream
    
    Previously PCI_SCAN_ALL_PCIE_DEVS (set by quirks or the "pci=pcie_scan_all"
    kernel parameter) only affected Switch Downstream Ports, not Root Ports.
    
    Simplify and restructure only_one_child() so PCI_SCAN_ALL_PCIE_DEVS means
    we scan for all possible devices below Root Ports as well as Switch
    Downstream Ports.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 14e0ea1ff38b..9e57d4ef0c1f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2217,20 +2217,28 @@ static int only_one_child(struct pci_bus *bus)
 {
 	struct pci_dev *parent = bus->self;
 
-	if (!parent || !pci_is_pcie(parent))
+	if (!parent)
+		return 0;
+
+	/*
+	 * Systems with unusual topologies set PCI_SCAN_ALL_PCIE_DEVS so
+	 * we scan for all possible devices, not just Device 0.
+	 */
+	if (pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
 		return 0;
-	if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT)
-		return 1;
 
 	/*
-	 * PCIe downstream ports are bridges that normally lead to only a
-	 * device 0, but if PCI_SCAN_ALL_PCIE_DEVS is set, scan all
-	 * possible devices, not just device 0.  See PCIe spec r3.0,
-	 * sec 7.3.1.
+	 * A PCIe Downstream Port normally leads to a Link with only Device
+	 * 0 on it (PCIe spec r3.1, sec 7.3.1).  As an optimization, scan
+	 * only for Device 0 in that situation.
+	 *
+	 * Checking has_secondary_link is a hack to identify Downstream
+	 * Ports because sometimes Switches are configured such that the
+	 * PCIe Port Type labels are backwards.
 	 */
-	if (parent->has_secondary_link &&
-	    !pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
+	if (pci_is_pcie(parent) && parent->has_secondary_link)
 		return 1;
+
 	return 0;
 }
 
