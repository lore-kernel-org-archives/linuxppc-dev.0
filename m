Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A924F2C0330
 for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2012 03:00:09 +1000 (EST)
In-Reply-To: <EC6BFBB7-DF3B-402A-ACB6-51546C1B6CC9@kernel.crashing.org>
References: <OFDEF2A72A.01F68496-ONC1257A41.0025B7CE-C1257A41.0028192F@transmode.se>
 <EC6BFBB7-DF3B-402A-ACB6-51546C1B6CC9@kernel.crashing.org>
Subject: Re: mpc8xxx PCIe hotplug needs fixing, some clues ..
To: Kumar Gala <galak@kernel.crashing.org>
Message-ID: <OFB9E961D6.E5703925-ONC1257A42.005CC202-C1257A42.005D6469@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 21 Jul 2012 19:00:05 +0200
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



Kumar Gala <galak@kernel.crashing.org> wrote on 2012/07/20 20:53:10:

> From: Kumar Gala <galak@kernel.crashing.org>
> To: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
> Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
> Date: 2012/07/20 20:53
> Subject: Re: mpc8xxx PCIe hotplug needs fixing, some clues ..
>
>
> On Jul 20, 2012, at 2:17 AM, Joakim Tjernlund wrote:
>
> >
> > Hi Guys
> >
> > I see that you have been hacking Freescale PCI before so I send this to you(and the list)
> >
> > We are using PCIe(as RC) on P2010(basically a mpc85xx) and have PCI device that
> > started from user space (needs advance clock conf) so when linux boots there is
> > no device at all.
> > Trying to "hotplug" the device after it is enabled fails, no amount of recan/remove using
> > either fake or real hotplug makes a difference.
> >
> > I found the cause eventually but I can't fix it properly as I known almost nothing about PCI.
> > Cause:
> > indirect_pci.c:indirect_read_config() tests for if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK)
> > and returns  PCIBIOS_DEVICE_NOT_FOUND
> >
> > PPC_INDIRECT_TYPE_NO_PCIE_LINK get set by fsl_pci.c (look for fsl_pcie_check_link) but is never cleared.
> > Clearing it as appropriate makes a small difference. If you
> > remove the RC and do a few of rescan's then the device appears.
> >
> > Hacking some more, like so:
> >
> > int fsl_pcie_check_link(struct pci_controller *hose)
> > {
> >    u32 val;
> >
> >    early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
> >    hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> >    if (val < PCIE_LTSSM_L0)
> >       return 1;
> >    hose->indirect_type &= ~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> >    return 0;
> > }
> > and then using it carefully(it is easy to make linux hang) in indirect_read_config():
> > indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
> >            int len, u32 *val)
> > {
> >    struct pci_controller *hose = pci_bus_to_host(bus);
> >    volatile void __iomem *cfg_data;
> >    u8 cfg_type = 0;
> >    u32 bus_no, reg;
> >
> >    if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
> >       if (bus->number != hose->first_busno ||
> >           devfn != 0) {
> >          fsl_pcie_check_link(hose);
> >          return PCIBIOS_DEVICE_NOT_FOUND;
> >       }
> >    }
> >
> > Now it works, just one rescan and the device appears!
> > This is a hack, I don't known what other trouble it can cause, I hope you can
> > sort this out.
>

Related, should not all those fsl quirks be __devinit instead of __init?
See this for motivation
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=85a053fa5f2d67ae5b2968305b16e8d2fe4cdf4d

Could quirk_fsl_pcie_header be moved to early fixup time? I recall some code, maybe is was hotplug,
complaining about not recognising the header because it executed before the header fixup.

 Jocke
