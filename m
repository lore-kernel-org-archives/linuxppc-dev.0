Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8B0D9140094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 07:34:19 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 27 Mar 2014 16:34:15 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 2AAB7C90041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 16:34:09 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2RKYCs99568592
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 20:34:12 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2RKYCWd022914
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 16:34:12 -0400
Date: Thu, 27 Mar 2014 13:33:54 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: Bug in reclaim logic with exhausted nodes?
Message-ID: <20140327203354.GA16651@linux.vnet.ibm.com>
References: <20140311210614.GB946@linux.vnet.ibm.com>
 <20140313170127.GE22247@linux.vnet.ibm.com>
 <20140324230550.GB18778@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251116490.16557@nuc>
 <20140325162303.GA29977@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251152250.16870@nuc>
 <20140325181010.GB29977@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251323030.26744@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1403251323030.26744@nuc>
Cc: linux-mm@kvack.org, mgorman@suse.de, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, rientjes@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christoph,

On 25.03.2014 [13:25:30 -0500], Christoph Lameter wrote:
> On Tue, 25 Mar 2014, Nishanth Aravamudan wrote:
> 
> > On power, very early, we find the 16G pages (gpages in the powerpc arch
> > code) in the device-tree:
> >
> > early_setup ->
> > 	early_init_mmu ->
> > 		htab_initialize ->
> > 			htab_init_page_sizes ->
> > 				htab_dt_scan_hugepage_blocks ->
> > 					memblock_reserve
> > 						which marks the memory
> > 						as reserved
> > 					add_gpage
> > 						which saves the address
> > 						off so future calls for
> > 						alloc_bootmem_huge_page()
> >
> > hugetlb_init ->
> > 		hugetlb_init_hstates ->
> > 			hugetlb_hstate_alloc_pages ->
> > 				alloc_bootmem_huge_page
> >
> > > Not sure if I understand that correctly.
> >
> > Basically this is present memory that is "reserved" for the 16GB usage
> > per the LPAR configuration. We honor that configuration in Linux based
> > upon the contents of the device-tree. It just so happens in the
> > configuration from my original e-mail that a consequence of this is that
> > a NUMA node has memory (topologically), but none of that memory is free,
> > nor will it ever be free.
> 
> Well dont do that
> 
> > Perhaps, in this case, we could just remove that node from the N_MEMORY
> > mask? Memory allocations will never succeed from the node, and we can
> > never free these 16GB pages. It is really not any different than a
> > memoryless node *except* when you are using the 16GB pages.
> 
> That looks to be the correct way to handle things. Maybe mark the node as
> offline or somehow not present so that the kernel ignores it.

This is a SLUB condition:

mm/slub.c::early_kmem_cache_node_alloc():
...
        page = new_slab(kmem_cache_node, GFP_NOWAIT, node);
...
        if (page_to_nid(page) != node) {
                printk(KERN_ERR "SLUB: Unable to allocate memory from "
                                "node %d\n", node);
                printk(KERN_ERR "SLUB: Allocating a useless per node structure "
                                "in order to be able to continue\n");
        }
...

Since this is quite early, and we have not set up the nodemasks yet,
does it make sense to perhaps have a temporary init-time nodemask that
we set bits in here, and "fix-up" those nodes when we setup the
nodemasks?

Thanks,
Nish
