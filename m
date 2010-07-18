Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E35E2B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 19 Jul 2010 09:41:41 +1000 (EST)
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address
	via  proc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Jul 2010 09:41:31 +1000
Message-ID: <1279496491.10390.1725.camel@pasglop>
Mime-Version: 1.0
Cc: Matthew McClintock <msm@freescale.com>,
	Kumar Gala <kumar.gala@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-15 at 00:21 -0600, Grant Likely wrote:
> On Wed, Jul 14, 2010 at 9:18 AM, Matthew McClintock <msm@freescale.com> wrote:
> > To build a proper flat device tree for kexec we need to know which
> > memreserve region was used for the device tree for the currently
> > running kernel, so we can remove it and replace it with the new
> > memreserve for the kexec'ed kernel
> >
> > Signed-off-by: Matthew McClintock <msm@freescale.com>
> 
> Hi Matthew.
> 
> I don't understand.  Why does userspace need to know about the old
> memreserve sections?  Doesn't kexec tear down all of the old
> allocations anyway?  How are they relevant for constructing the dtb
> for the kexec kernel?  I'll need a lot more details before I consider
> merging this.
> 
> Also, please cc: me and Ben Herrenschmidt on powerpc related device
> tree changes.

I admit to be the victim of a similar misunderstanding...

Care to explain in more details ? (with examples)

Cheers,
Ben.

> Cheers,
> g.
> 
> > ---
> > V4: Fixed misspelling
> >
> > V3: Remove unneeded cast, and fixed indentation screw up
> >
> > V2: messed up changes
> >
> >  arch/powerpc/kernel/prom.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 45 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > index fd9359a..ff3e240 100644
> > --- a/arch/powerpc/kernel/prom.c
> > +++ b/arch/powerpc/kernel/prom.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/debugfs.h>
> >  #include <linux/irq.h>
> >  #include <linux/lmb.h>
> > +#include <linux/bootmem.h>
> >
> >  #include <asm/prom.h>
> >  #include <asm/rtas.h>
> > @@ -911,3 +912,47 @@ static int __init export_flat_device_tree(void)
> >  }
> >  __initcall(export_flat_device_tree);
> >  #endif
> > +
> > +#ifdef CONFIG_KEXEC
> > +static phys_addr_t flat_dt_start;
> > +static phys_addr_t flat_dt_end;
> > +
> > +static struct property flat_dt_start_prop = {
> > +       .name = "linux,devicetree-start",
> > +       .length = sizeof(phys_addr_t),
> > +       .value = &flat_dt_start,
> > +};
> > +
> > +static struct property flat_dt_end_prop = {
> > +       .name = "linux,devicetree-end",
> > +       .length = sizeof(phys_addr_t),
> > +       .value = &flat_dt_end,
> > +};
> > +
> > +static int __init export_flat_device_tree_phys_addr(void)
> > +{
> > +       struct property *prop;
> > +       struct device_node *node;
> > +
> > +       node = of_find_node_by_path("/chosen");
> > +       if (!node)
> > +               return -ENOENT;
> > +
> > +       prop = of_find_property(node, "linux,devicetree-start", NULL);
> > +       if (prop)
> > +               prom_remove_property(node, prop);
> > +
> > +       prop = of_find_property(node, "linux,devicetree-end", NULL);
> > +       if (prop)
> > +               prom_remove_property(node, prop);
> > +
> > +       flat_dt_start = virt_to_phys(initial_boot_params);
> > +       flat_dt_end = virt_to_phys(initial_boot_params)
> > +                               + initial_boot_params->totalsize;
> > +       prom_add_property(node, &flat_dt_start_prop);
> > +       prom_add_property(node, &flat_dt_end_prop);
> > +
> > +       return 0;
> > +}
> > +__initcall(export_flat_device_tree_phys_addr);
> > +#endif
> > --
> > 1.6.6.1
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> >
> 
> 
> 
