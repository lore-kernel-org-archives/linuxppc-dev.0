Subject: Re: get_pteptr mystery
From: Hollis Blanchard <hollis@austin.ibm.com>
To: devel list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1040256384.30597.70.camel@granite.austin.ibm.com>
References: <1040256384.30597.70.camel@granite.austin.ibm.com>
Content-Type: text/plain
Date: 06 Jan 2003 17:35:58 -0600
Message-Id: <1041896173.1207.49.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2002-12-18 at 18:06, Hollis Blanchard wrote:
>
> I need to mark the first kernel code page writeable because I need to
> write to 0xc00000fc. Can someone tell me why the following code fails?
> get_pteptr returns 0.
>
> 	addr = 0xc00000fc;
> 	if (0 != get_pteptr(&init_mm, addr, &ptep)) {
> 		/* mark it writable */
> 		*ptep = pte_mkwrite(*ptep);
> 		/* flush this page from hw TLB */
> 		flush_tlb_range(&init_mm, addr, addr+1);
> 	} else {
> 		printk(KERN_ERR "couldn't get PTE!\n");
> 	}

FYI: whoever added HIGHMEM support to mm/init.c:paging_init() already
had this problem, and solved it by calling map_page(addr, 0, 0) first.

I guess that the page is really not present in the software pagetable,
and the map_page call forces it in:
	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
	pkmap_page_table = pte_offset(pmd_offset(pgd_offset_k(PKMAP_BASE),
	                              PKMAP_BASE), PKMAP_BASE);
(get_pteptr just calls pte/pmd/pgd_offset with some error checking.)

-Hollis
--
PowerPC Linux
IBM Linux Technology Center

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
