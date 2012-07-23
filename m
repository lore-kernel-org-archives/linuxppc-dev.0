Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4B0162C0376
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2012 02:45:47 +1000 (EST)
In-Reply-To: <OF85435159.0952793A-ONC1257A42.0058090C-C1257A42.0058F2A6@LocalDomain>
References: <OFDEF2A72A.01F68496-ONC1257A41.0025B7CE-C1257A41.0028192F@transmode.se>
 <EC6BFBB7-DF3B-402A-ACB6-51546C1B6CC9@kernel.crashing.org>
 <OF85435159.0952793A-ONC1257A42.0058090C-C1257A42.0058F2A6@LocalDomain>
Subject: Re: mpc8xxx PCIe hotplug needs fixing, some clues ..
Message-ID: <OF1A29C1FF.28BA9274-ONC1257A44.005B7A8B-C1257A44.005C12EB@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 23 Jul 2012 18:45:41 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund/Transmode wrote on 2012/07/21 18:11:32:
>
> Kumar Gala <galak@kernel.crashing.org> wrote on 2012/07/20 20:53:10:
> >
> >
> > On Jul 20, 2012, at 2:17 AM, Joakim Tjernlund wrote:
> >
> > >
> > > Hi Guys
> > >
> > > I see that you have been hacking Freescale PCI before so I send this to you(and the list)
> > >
> > > We are using PCIe(as RC) on P2010(basically a mpc85xx) and have PCI device that
> > > started from user space (needs advance clock conf) so when linux boots there is
> > > no device at all.
> > > Trying to "hotplug" the device after it is enabled fails, no amount of recan/remove using
> > > either fake or real hotplug makes a difference.
> > >
> > > I found the cause eventually but I can't fix it properly as I known almost nothing about PCI.
> > > Cause:
> > > indirect_pci.c:indirect_read_config() tests for if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK)
> > > and returns  PCIBIOS_DEVICE_NOT_FOUND
> > >
> > > PPC_INDIRECT_TYPE_NO_PCIE_LINK get set by fsl_pci.c (look for fsl_pcie_check_link) but is never cleared.
> > > Clearing it as appropriate makes a small difference. If you
> > > remove the RC and do a few of rescan's then the device appears.
> > >
> > > Hacking some more, like so:
> > >
> > > int fsl_pcie_check_link(struct pci_controller *hose)
> > > {
> > >    u32 val;
> > >
> > >    early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
> > >    hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> > >    if (val < PCIE_LTSSM_L0)
> > >       return 1;
> > >    hose->indirect_type &= ~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> > >    return 0;
> > > }
> > > and then using it carefully(it is easy to make linux hang) in indirect_read_config():
> > > indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
> > >            int len, u32 *val)
> > > {
> > >    struct pci_controller *hose = pci_bus_to_host(bus);
> > >    volatile void __iomem *cfg_data;
> > >    u8 cfg_type = 0;
> > >    u32 bus_no, reg;
> > >
> > >    if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
> > >       if (bus->number != hose->first_busno ||
> > >           devfn != 0) {
> > >          fsl_pcie_check_link(hose);
> > >          return PCIBIOS_DEVICE_NOT_FOUND;
> > >       }
> > >    }
> > >
> > > Now it works, just one rescan and the device appears!
> > > This is a hack, I don't known what other trouble it can cause, I hope you can
> > > sort this out.
> >
> > How are you forcing the re-scan?  We can see if we can add a re-check of the link state in that flow somewhere.
>
> echo 1 > /sys/bus/pci/rescan
>
> Why is that check important? Seems like some very ppc specific workaround for something.
>
> >
> > Can you do a dump_stack() or something to get a call chain?

> here?
> indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
>        int len, u32 *val)
> {
>  struct pci_controller *hose = pci_bus_to_host(bus);
>  volatile void __iomem *cfg_data;
>  u8 cfg_type = 0;
>  u32 bus_no, reg;
>  static int first_dump;
>
>  if (!first_dump) {
>   dump_stack();
>   first_dump = 1;
>  }
> ...
>
> I am not at work and and my board needs a reset button press to recover :(
> Furthermore, my vacation starts next week, not sure I can get it fixed soon enough

So I managed to get someone to connect the BDI. Here is a dump according to the above:
Memory CAM mapping: 256/256 Mb, residual: 0Mb
Linux version 3.4.0+ (jocke@gentoo-jocke) (gcc version 4.5.3 (Gentoo 4.5.3-r2 p1.1, pie-0.4.7) ) #2088 PREEMPT Sat Jul 21 18:05:10 CEST 2012
bootconsole [udbg0] enabled
setup_arch: bootmem
p1010_rdb_setup_arch()
Call Trace:
[c0399e50] [c0006f28] show_stack+0x54/0x158 (unreliable)
[c0399e90] [c0019390] indirect_read_config+0x23c/0x250
[c0399ec0] [c017e630] pci_bus_read_config_byte+0x4c/0x94
[c0399ef0] [c000f4d4] early_read_config_byte+0x30/0x44
[c0399f10] [c0364524] fsl_add_bridge+0x118/0xa5c
[c0399f90] [c03655b4] p1010_rdb_setup_arch+0x8c/0xcc
[c0399fb0] [c0361850] setup_arch+0x1a8/0x1e8
[c0399fc0] [c035d558] start_kernel+0x80/0x2f0
[c0399ff0] [c00003ac] skpinv+0x298/0x2d4
Found FSL PCI host bridge at 0x00000000ff70a000. Firmware bus number: 0->1
PCI host bridge /pcie@ff70a000  ranges:
 MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000
  IO 0x00000000ffc00000..0x00000000ffc0ffff -> 0x0000000000000000
/pcie@ff70a000: PCICSRBAR @ 0xfff00000

So early_read_config_byte uses indirect_read_config so obviously you cannot
use early_read_config_xxx from within indirect_read_config as this gets you
into a nice recursion loop :)

Anyhow, I will be travelling for the better part of this week and will
have very limited Internet access.

 Jocke
