Return-Path: <andrew.murray@arm.com>
Date: Thu, 18 Apr 2013 15:24:34 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 2/3] of/pci: Provide support for parsing PCI DT
 ranges property
Message-ID: <20130418142434.GA18881@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-3-git-send-email-Andrew.Murray@arm.com>
 <20130418134401.84AEE3E1319@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130418134401.84AEE3E1319@localhost>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
 Liviu Dudau <Liviu.Dudau@arm.com>, "paulus@samba.org" <paulus@samba.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "jg1.han@samsung.com" <jg1.han@samsung.com>,
 "jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
 "thomas.abraham@linaro.org" <thomas.abraham@linaro.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>,
 "monstr@monstr.eu" <monstr@monstr.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "suren.reddy@samsung.com" <suren.reddy@samsung.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 18, 2013 at 02:44:01PM +0100, Grant Likely wrote:
> On Tue, 16 Apr 2013 11:18:27 +0100, Andrew Murray <Andrew.Murray@arm.com> wrote:
> > This patch factors out common implementation patterns to reduce overall kernel
> > code and provide a means for host bridge drivers to directly obtain struct
> > resources from the DT's ranges property without relying on architecture specific
> > DT handling. This will make it easier to write archiecture independent host bridge
> > drivers and mitigate against further duplication of DT parsing code.
> > 
> > This patch can be used in the following way:
> > 
> > 	struct of_pci_range_parser parser;
> > 	struct of_pci_range range;
> > 
> > 	if (of_pci_range_parser(&parser, np))
> > 		; //no ranges property
> > 
> > 	for_each_of_pci_range(&parser, &range) {
> > 
> > 		/*
> > 			directly access properties of the address range, e.g.:
> > 			range.pci_space, range.pci_addr, range.cpu_addr,
> > 			range.size, range.flags
> > 
> > 			alternatively obtain a struct resource, e.g.:
> > 			struct resource res;
> > 			of_pci_range_to_resource(&range, np, &res);
> > 		*/
> > 	}
> > 
> > Additionally the implementation takes care of adjacent ranges and merges them
> > into a single range (as was the case with powerpc and microblaze).
> > 
> > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> > Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> But comments below...
> 
> > ---
> >  drivers/of/address.c       |   67 ++++++++++++++++++++++++++
> >  drivers/of/of_pci.c        |  113 ++++++++++++++++----------------------------
> >  include/linux/of_address.h |   46 ++++++++++++++++++
> >  3 files changed, 154 insertions(+), 72 deletions(-)
> > 
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 04da786..6eec70c 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -227,6 +227,73 @@ int of_pci_address_to_resource(struct device_node *dev, int bar,
> >  	return __of_address_to_resource(dev, addrp, size, flags, NULL, r);
> >  }
> >  EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
> > +
> > +int of_pci_range_parser(struct of_pci_range_parser *parser,
> > +			struct device_node *node)
> > +{
> > +	const int na = 3, ns = 2;
> > +	int rlen;
> > +
> > +	parser->node = node;
> > +	parser->pna = of_n_addr_cells(node);
> > +	parser->np = parser->pna + na + ns;
> > +
> > +	parser->range = of_get_property(node, "ranges", &rlen);
> > +	if (parser->range == NULL)
> > +		return -ENOENT;
> > +
> > +	parser->end = parser->range + rlen / sizeof(__be32);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(of_pci_range_parser);
> 
> "of_pci_range_parser_init" would be a clearer name
> 
> > +struct of_pci_range *of_pci_process_ranges(struct of_pci_range_parser *parser,
> > +						struct of_pci_range *range)
> 
> Similarly, "of_pci_range_parser_one" would be more consistent.
> 
> > +{
> > +	const int na = 3, ns = 2;
> > +
> > +	if (!range)
> > +		return NULL;
> > +
> > +	if (!parser->range || parser->range + parser->np > parser->end)
> > +		return NULL;
> > +
> > +	range->pci_space = parser->range[0];
> > +	range->flags = of_bus_pci_get_flags(parser->range);
> > +	range->pci_addr = of_read_number(parser->range + 1, ns);
> > +	range->cpu_addr = of_translate_address(parser->node,
> > +				parser->range + na);
> > +	range->size = of_read_number(parser->range + parser->pna + na, ns);
> > +
> > +	parser->range += parser->np;
> > +
> > +	/* Now consume following elements while they are contiguous */
> > +	while (parser->range + parser->np <= parser->end) {
> > +		u32 flags, pci_space;
> > +		u64 pci_addr, cpu_addr, size;
> > +
> > +		pci_space = be32_to_cpup(parser->range);
> > +		flags = of_bus_pci_get_flags(parser->range);
> > +		pci_addr = of_read_number(parser->range + 1, ns);
> > +		cpu_addr = of_translate_address(parser->node,
> > +				parser->range + na);
> > +		size = of_read_number(parser->range + parser->pna + na, ns);
> > +
> > +		if (flags != range->flags)
> > +			break;
> > +		if (pci_addr != range->pci_addr + range->size ||
> > +		    cpu_addr != range->cpu_addr + range->size)
> > +			break;
> > +
> > +		range->size += size;
> > +		parser->range += parser->np;
> > +	}
> > +
> > +	return range;
> > +}
> > +EXPORT_SYMBOL_GPL(of_pci_process_ranges);
> > +
> >  #endif /* CONFIG_PCI */
> >  
> >  /*
> > diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> > index 1626172..e5ab604 100644
> > --- a/drivers/of/of_pci.c
> > +++ b/drivers/of/of_pci.c
> > @@ -2,6 +2,7 @@
> >  #include <linux/export.h>
> >  #include <linux/of.h>
> >  #include <linux/of_pci.h>
> > +#include <linux/of_address.h>
> >  #include <asm/prom.h>
> >  
> >  #if defined(CONFIG_PPC32) || defined(CONFIG_PPC64) || defined(CONFIG_MICROBLAZE)
> > @@ -82,67 +83,43 @@ EXPORT_SYMBOL_GPL(of_pci_find_child_device);
> >  void pci_process_bridge_OF_ranges(struct pci_controller *hose,
> >  				  struct device_node *dev, int primary)
> >  {
> > -	const u32 *ranges;
> > -	int rlen;
> > -	int pna = of_n_addr_cells(dev);
> > -	int np = pna + 5;
> >  	int memno = 0, isa_hole = -1;
> > -	u32 pci_space;
> > -	unsigned long long pci_addr, cpu_addr, pci_next, cpu_next, size;
> >  	unsigned long long isa_mb = 0;
> >  	struct resource *res;
> > +	struct of_pci_range range;
> > +	struct of_pci_range_parser parser;
> > +	u32 res_type;
> >  
> >  	pr_info("PCI host bridge %s %s ranges:\n",
> >  	       dev->full_name, primary ? "(primary)" : "");
> >  
> > -	/* Get ranges property */
> > -	ranges = of_get_property(dev, "ranges", &rlen);
> > -	if (ranges == NULL)
> > +	/* Check for ranges property */
> > +	if (of_pci_range_parser(&parser, dev))
> >  		return;
> >  
> > -	/* Parse it */
> >  	pr_debug("Parsing ranges property...\n");
> > -	while ((rlen -= np * 4) >= 0) {
> > +	for_each_of_pci_range(&parser, &range) {
> >  		/* Read next ranges element */
> > -		pci_space = ranges[0];
> > -		pci_addr = of_read_number(ranges + 1, 2);
> > -		cpu_addr = of_translate_address(dev, ranges + 3);
> > -		size = of_read_number(ranges + pna + 3, 2);
> 
> Tip: the diff on this function would be a whole lot simpler if the
> above locals were kept, but updated from the ranges structure. Not at
> all a big problem, but it is something that makes changes like this
> easier to review. The removal of the locals could also be split into a
> separate patch to end up with the same result.
> 
> > -
> > -		pr_debug("pci_space: 0x%08x pci_addr:0x%016llx ",
> > -				pci_space, pci_addr);
> > -		pr_debug("cpu_addr:0x%016llx size:0x%016llx\n",
> > -					cpu_addr, size);
> > -
> > -		ranges += np;
> > +		pr_debug("pci_space: 0x%08x pci_addr: 0x%016llx ",
> > +				range.pci_space, range.pci_addr);
> > +		pr_debug("cpu_addr: 0x%016llx size: 0x%016llx\n",
> > +				range.cpu_addr, range.size);
> 
> Nit: the patch changed whitespace on the pr_debug() statements, so even
> though the first line of each is identical, they look different in the
> patch.
> 
> >  
> >  		/* If we failed translation or got a zero-sized region
> >  		 * (some FW try to feed us with non sensical zero sized regions
> >  		 * such as power3 which look like some kind of attempt
> >  		 * at exposing the VGA memory hole)
> >  		 */
> > -		if (cpu_addr == OF_BAD_ADDR || size == 0)
> > +		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
> >  			continue;
> 
> Can this also be rolled into the parsing iterator?
> 

Yes I think that would make sense.

> >  
> > -		/* Now consume following elements while they are contiguous */
> > -		for (; rlen >= np * sizeof(u32);
> > -		     ranges += np, rlen -= np * 4) {
> > -			if (ranges[0] != pci_space)
> > -				break;
> > -			pci_next = of_read_number(ranges + 1, 2);
> > -			cpu_next = of_translate_address(dev, ranges + 3);
> > -			if (pci_next != pci_addr + size ||
> > -			    cpu_next != cpu_addr + size)
> > -				break;
> > -			size += of_read_number(ranges + pna + 3, 2);
> > -		}
> > -
> >  		/* Act based on address space type */
> >  		res = NULL;
> > -		switch ((pci_space >> 24) & 0x3) {
> > -		case 1:		/* PCI IO space */
> > +		res_type = range.flags & IORESOURCE_TYPE_BITS;
> > +		if (res_type == IORESOURCE_IO) {
> 
> Why the change from switch() to an if/else if sequence?

Russell King suggested this change - see 
https://patchwork.kernel.org/patch/2323941/

> 
> But those are mostly nitpicks. If this is deferred to v3.10 then I would
> suggest fixing them up and posting for another round of review.

Thanks for the feedback. I'll update the patch in the future.

Andrew Murray
