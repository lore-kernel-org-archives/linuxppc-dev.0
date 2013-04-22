Return-Path: <andrew.murray@arm.com>
Date: Mon, 22 Apr 2013 11:57:24 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 2/3] of/pci: Provide support for parsing PCI DT
 ranges property
Message-ID: <20130422105724.GB17007@arm.com>
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

> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> But comments below...
> 

I've updated the patchset (now v8) to reflect your feedback, after a closer
look...

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

Actually the first line isn't identical, the original file was inconsistent
with its use of spaces between ':' and '0x%0' - my patch ensured that there
was always a space. I guess this could have been done as a separate patch.

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

I decided not to do this. Mainly because ARM drivers use the parser directly
(instead of pci_process_bridge_OF_ranges function) and it seemed perfectly
valid for the parser to return a range of size 0 if that is what was present in
the DT.

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

I think this was an artifact of the patches evolution, I've reverted back to
the switch.

> 
> But those are mostly nitpicks. If this is deferred to v3.10 then I would
> suggest fixing them up and posting for another round of review.

Andrew Murray
