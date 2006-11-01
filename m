Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add Efika platform support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <1162419546.25682.460.camel@localhost.localdomain>
References: <45490394.8020202@bplan-gmbh.de>
	<1162419546.25682.460.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 10:25:46 +1100
Message-Id: <1162423546.25682.486.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-11-02 at 09:19 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2006-11-01 at 21:29 +0100, Nicolas DET wrote:

Ooops ... here's the english version :)

> > +
> > +static void __init efika_init_IRQ(void)
> > +{
> > +	mpc52xx_init_irq();
> > +}
> 
> Ya pas moyen que mpc52xx_init_irq() ait le bon prototype pour que tu le
> colle directement dans ppc_md. ?

It would be better if mpc52xx_init_irq() had the right prototype so it
can be hooked directly from ppc_md.

> > +
> > +	ISA_DMA_THRESHOLD = ~0L;
> > +	DMA_MODE_READ = 0x44;
> > +	DMA_MODE_WRITE = 0x48;
> 
> Ca viens de CHRP ca ? Je suis pas sur que ca soit super utile... mais
> bon, ca mange pas de pain.. Au cas ou qqun colle un southbridge ISA sur
> le bus PCI :)

This comes from CHRP ? I'm not sure it's terribly useful, at least for
Efika, though it doesn't hurt. Maybe some day somebody will stick an ISA
southbridge on the 5200 PCI bus :)

> > +void __init efika_pcisetup(void)
> > +{
> > +	const int *bus_range;
> > +	int len;
> > +	struct pci_controller *hose;
> > +	struct device_node *root;
> > +	struct device_node *pcictrl;
> > +
> > +	root = of_find_node_by_path("/");
> > +	if (root == NULL) {
> > +		printk(KERN_WARNING EFIKA_PLATFORM_NAME
> > +		       ": Unable to find the root node\n");
> > +		return;
> > +	}
> > +
> > +	for (pcictrl = NULL;;) {
> > +		pcictrl = of_get_next_child(root, pcictrl);
> > +		if ((pcictrl == NULL) || (strcmp(pcictrl->name, "pci") == 0))
> > +			break;
> > +	}
> > +
> > +	if (pcictrl == NULL) {
> > +		printk(KERN_WARNING EFIKA_PLATFORM_NAME
> > +		       ": Unable to find the PCI bridge node\n");
> > +		return;
> > +	}
> > +
> > +	of_node_put(pcictrl);
> > +	of_node_put(root);
> 
> Euh... non... tu fait pas of_node_put(pcictrl) avant de t'en servir...
> tu fait ca quand tu as fini. Ca veut dire probablement changer test
> "return" en "goto bail;" ou un truc du genre.

Don't do an of_node_put(pcictrl) before you use that node... Do it when
you are done with it, which probably means changing "return" statements
into something like "goto bail;"

> > +	if (bus_range[1] == bus_range[0])
> > +		printk(KERN_INFO EFIKA_PLATFORM_NAME ": PCI bus %d",
> > +		       bus_range[0]);
> > +	else
> > +		printk(KERN_INFO EFIKA_PLATFORM_NAME ": PCI buses %d..%d",
> > +		       bus_range[0], bus_range[1]);
> > +	printk(" controlled by %s", pcictrl->full_name);
> > +	printk("\n");
> 
> You really need the above printk's ? 

Ah, that one was good :)

> > +	hose = pcibios_alloc_controller();
> > +	if (!hose) {
> > +		printk(KERN_WARNING EFIKA_PLATFORM_NAME
> > +		       ": Can't allocate PCI controller structure for %s\n",
> > +		       pcictrl->full_name);
> > +		return;
> > +	}
> > +
> > +	hose->arch_data = pcictrl;
> 
> Et ici, tu garde une reference, donc to fait

Here's you are keeping a reference to the node, thus you should do:

> 	hose->arch_data = of_node_get(pcictrl);
> 
> > +	hose->first_busno = bus_range[0];
> > +	hose->last_busno = bus_range[1];
> > +	hose->ops = &rtas_pci_ops;
> > +
> > +	pci_process_bridge_OF_ranges(hose, pcictrl, 0);
> > +}
> 
> Le reste est bon.
> 
> On y est presque ! :)

The rest is good, we're almost there :)

Ben.
