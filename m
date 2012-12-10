Return-Path: <grant.likely@secretlab.ca>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9CFF82C0317
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2012 09:30:04 +1100 (EST)
Received: by mail-we0-f179.google.com with SMTP id r6so1423089wey.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2012 14:30:00 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: pci and pcie device-tree binding - range No cells
To: monstr@monstr.eu, Rob Herring <robherring2@gmail.com>
In-Reply-To: <50C601B6.2080107@monstr.eu>
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com>
 <50C601B6.2080107@monstr.eu>
Date: Mon, 10 Dec 2012 21:43:23 +0000
Message-Id: <20121210214323.6EA733E0921@localhost>
Cc: linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Rob Herring <rob.herring@calxeda.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 10 Dec 2012 16:37:26 +0100, Michal Simek <monstr@monstr.eu> wrote:
> On 12/10/2012 04:21 PM, Rob Herring wrote:
> > On 12/10/2012 09:05 AM, Michal Simek wrote:
> >> On 12/10/2012 03:26 PM, Rob Herring wrote:
> >>> On 12/10/2012 06:20 AM, Michal Simek wrote:
> >>>> Hi Grant and others,
> >>>>
> >>>> I have a question regarding number of cells in ranges property
> >>>> for pci and pcie nodes.
> >>>>
> >>>> Linux pci/pcie powerpc DTSes contain 7 cells (xpedite5370.dts,
> >>>> sequoia.dts, etc)
> >>>> but also 6 cells format too (mpc832x_mds.dts)
> >>>>
> >>>> Here is shown 6 cells ranges format and describe
> >>>> http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge
> >>>>
> >>>> And also in documentation in the linux
> >>>> Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
> >>>>
> >>>> Both format uses:
> >>>> #size-cells = <2>;
> >>>> #address-cells = <3>;
> >>>>
> >>>> What is valid format?
> >>>
> >>> Both. 7 cells are valid when the host (parent) bus is 64-bit and 6 cells
> >>> are valid when the host bus is 32-bit. The ranges property is <<child
> >>> address> <parent address> <size>>. The parent address #address-cells is
> >>> taken from the parent node.
> >>
> >> Ok. Got it.
> >>
> >> Here is what we use on zynq and microblaze - both 32bit which should be
> >> fine.
> >>
> >>      ps7_axi_interconnect_0: axi@0 {
> >>          #address-cells = <1>;
> >>          #size-cells = <1>;
> >>          axi_pcie_0: axi-pcie@50000000 {
> >>              #address-cells = <3>;
> >>              #size-cells = <2>;
> >>              compatible = "xlnx,axi-pcie-1.05.a";
> >>              ranges = < 0x02000000 0 0x60000000 0x60000000 0 0x10000000 >;
> >>              ...
> >>          }
> >>      }
> >>
> >> What I am wondering is pci_process_bridge_OF_ranges() at
> >> arch/powerpc/kernel/pci-common.c
> >> where there are used some hardcoded values which should be probably
> >> loaded from device-tree.
> >>
> >> For example:
> >> 683         int np = pna + 5;
> >> ...
> >> 702                 pci_addr = of_read_number(ranges + 1, 2);
> >> 703                 cpu_addr = of_translate_address(dev, ranges + 3);
> >> 704                 size = of_read_number(ranges + pna + 3, 2);
> >
> > These would always be correct whether you have 6 or 7 cells. pna is the
> > parent bus address cells size. The pci address is fixed at 3 cells.
> 
> Sorry for my pci ignorance (have never got hw for mb/zynq)
> I just want to get better overview how we should we our drivers to be compatible.
> 
> Does it mean that pci is supposed be always 64 bit wide?
> And there is no option to have just 32bit values.

Yes, PCIe addressing is always 64 bits wide. Even on 32bit PCI systems
we use 64 bit PCI addressing in the device tree.

g.
