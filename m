Date: Wed, 8 Jan 2003 10:05:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: devel list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: get_pteptr mystery
Message-ID: <20030107230553.GA7851@zax.zax>
References: <1040256384.30597.70.camel@granite.austin.ibm.com> <1041896173.1207.49.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1041896173.1207.49.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 06, 2003 at 05:35:58PM -0600, Hollis Blanchard wrote:
>
> On Wed, 2002-12-18 at 18:06, Hollis Blanchard wrote:
> >
> > I need to mark the first kernel code page writeable because I need to
> > write to 0xc00000fc. Can someone tell me why the following code fails?
> > get_pteptr returns 0.
> >
> > 	addr = 0xc00000fc;
> > 	if (0 != get_pteptr(&init_mm, addr, &ptep)) {
> > 		/* mark it writable */
> > 		*ptep = pte_mkwrite(*ptep);
> > 		/* flush this page from hw TLB */
> > 		flush_tlb_range(&init_mm, addr, addr+1);
> > 	} else {
> > 		printk(KERN_ERR "couldn't get PTE!\n");
> > 	}
>
> FYI: whoever added HIGHMEM support to mm/init.c:paging_init() already
> had this problem, and solved it by calling map_page(addr, 0, 0) first.
>
> I guess that the page is really not present in the software pagetable,
> and the map_page call forces it in:
> 	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
> 	pkmap_page_table = pte_offset(pmd_offset(pgd_offset_k(PKMAP_BASE),
> 	                              PKMAP_BASE), PKMAP_BASE);
> (get_pteptr just calls pte/pmd/pgd_offset with some error checking.)

Erm.. be very careful about this in 2.5.  Since we use a large-page
mapping for that address there, it won't in fact have a "normal" PTE.
So attempting to frob it could cause bad things to happen.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
