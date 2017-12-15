Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yz23v2QL2zDsFj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 07:25:15 +1100 (AEDT)
Date: Fri, 15 Dec 2017 14:25:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Darren Stevens <darren@stevens-zone.net>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] SB600 for the Nemo board has non-zero devices on
 non-root bus
Message-ID: <20171215202509.GZ30595@bhelgaas-glaptop.roam.corp.google.com>
References: <20171202230052.34y2ivxgpgr3osct@localhost>
 <CAOesGMhfMpt+xG1vhVHU+O5o4W5y2S5mZyn9tp+CPn9G6XrNVA@mail.gmail.com>
 <4CEE49CE-68F3-457F-B302-54BA8550F36A@xenosoft.de>
 <1d5276c3-1d29-114a-c868-6f022eee58e7@xenosoft.de>
 <99f78122-cd53-100f-4f58-be5bf7927d4e@xenosoft.de>
 <87fu8odnfk.fsf@concordia.ellerman.id.au>
 <20171206210637.GO23510@bhelgaas-glaptop.roam.corp.google.com>
 <877etxh1lf.fsf@concordia.ellerman.id.au>
 <f5fe03d3-87f8-2a2d-2d83-fbefcd489a77@xenosoft.de>
 <98c7e034-b523-a703-e637-957e2857ab32@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <98c7e034-b523-a703-e637-957e2857ab32@xenosoft.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 15, 2017 at 09:04:51AM +0100, Christian Zigotzky wrote:
> On 09 December 2017 at 7:03PM, Christian Zigotzky wrote:
> > On 08 December 2017 at 12:59PM, Michael Ellerman wrote:
> > >
> > >> Darren's idea of doing it at the same time you tweak the SB600 "relax
> > >> pci-e" bit is ideal because then the two pieces are obviously
> > >> connected and it wouldn't affect any other systems at all.
> > >
> > > Yes that would be ideal. That patch is currently out-of-tree I gather,
> > > but I guess everyone who's using these machines must have that patch
> > > anyway.
> > >
> > > Darren what does that code look like? Can we get it upstream and close
> > > the loop on this?
> > >
> > > cheers
> > >
> >
> > Hi Michael,
> >
> > Please find attached the code.
> >
> > Thanks,
> > Christian
> 
> Hi All,
> 
> I haven't received any response yet. Is this the correct patch you
> are looking for?

This is a powerpc patch that doesn't affect the PCI core, so I would
say this is Michael's bailiwick.

I guess you're only looking for a hint about whether this is the right
approach, because it's obviously fully baked yet (no changelog,
signed-off-by, etc, not a "safe for all powerpc" run-time solution,
not in Linux indentation style, etc).

It looks like the "pasemi,1682m-iob" DT property is required and
possibly sufficient to identify this system at run-time.

My advice is to finish that stuff up, post it to the powerpc
maintainers and the linuxppc-dev@lists.ozlabs.org list, and go from
there.

> diff -rupN a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
> --- a/arch/powerpc/platforms/pasemi/pci.c	2017-11-16 08:18:35.078874462 +0100
> +++ b/arch/powerpc/platforms/pasemi/pci.c	2017-11-16 08:17:22.034367975 +0100
> @@ -27,6 +27,7 @@
>  #include <linux/pci.h>
>  
>  #include <asm/pci-bridge.h>
> +#include <asm/isa-bridge.h>
>  #include <asm/machdep.h>
>  
>  #include <asm/ppc-pci.h>
> @@ -108,6 +109,69 @@ static int workaround_5945(struct pci_bu
>  	return 1;
>  }
>  
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +static int sb600_bus = 5;
> +static void __iomem *iob_mapbase = NULL;
> +
> +static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
> +                             int offset, int len, u32 *val);
> +
> +static void sb600_set_flag(int bus)
> +{
> +    struct resource res;
> +    struct device_node *dn;
> +       struct pci_bus *busp;
> +       u32 val;
> +       int err;
> +
> +       if (sb600_bus == -1)
> +       {
> +               busp = pci_find_bus(0, 0);
> +               pa_pxp_read_config(busp, PCI_DEVFN(17,0), PCI_SECONDARY_BUS, 1, &val);
> +
> +               sb600_bus = val;
> +
> +               printk(KERN_CRIT "NEMO SB600 on bus %d.\n",sb600_bus);
> +       }
> +
> +       if (iob_mapbase == NULL)
> +       {
> +        dn = of_find_compatible_node(NULL, "isa", "pasemi,1682m-iob");
> +        if (!dn)
> +        {
> +               printk(KERN_CRIT "NEMO SB600 missing iob node\n");
> +                       return;
> +               }
> +
> +               err = of_address_to_resource(dn, 0, &res);
> +        of_node_put(dn);
> +
> +               if (err)
> +               {
> +               printk(KERN_CRIT "NEMO SB600 missing resource\n");
> +                       return;
> +               }
> +
> +               printk(KERN_CRIT "NEMO SB600 IOB base %08lx\n",res.start);
> +
> +               iob_mapbase = ioremap(res.start + 0x100, 0x94);
> +       }
> +
> +       if (iob_mapbase != NULL)
> +       {
> +               if (bus == sb600_bus)
> +               {
> +                       out_le32(iob_mapbase + 4, in_le32(iob_mapbase + 4) | 0x800);
> +               }
> +               else
> +               {
> +                       out_le32(iob_mapbase + 4, in_le32(iob_mapbase + 4) & ~0x800);
> +               }
> +       }
> +}
> +#endif
> +
> +
>  static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
>  			      int offset, int len, u32 *val)
>  {
> @@ -126,6 +190,10 @@ static int pa_pxp_read_config(struct pci
>  
>  	addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
>  
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +       sb600_set_flag(bus->number);
> +#endif
> +
>  	/*
>  	 * Note: the caller has already checked that offset is
>  	 * suitably aligned and that len is 1, 2 or 4.
> @@ -210,6 +278,9 @@ static int __init pas_add_bridge(struct
>  	/* Interpret the "ranges" property */
>  	pci_process_bridge_OF_ranges(hose, dev, 1);
>  
> +	/* Scan for an isa bridge. */
> +	isa_bridge_find_early(hose);
> +
>  	return 0;
>  }
