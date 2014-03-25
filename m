Return-Path: <cl@linux.com>
Received: from qmta01.emeryville.ca.mail.comcast.net
 (qmta01.emeryville.ca.mail.comcast.net [76.96.30.16])
 by ozlabs.org (Postfix) with ESMTP id E8666140088
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 05:25:36 +1100 (EST)
Date: Tue, 25 Mar 2014 13:25:30 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: Bug in reclaim logic with exhausted nodes?
In-Reply-To: <20140325181010.GB29977@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1403251323030.26744@nuc>
References: <20140311210614.GB946@linux.vnet.ibm.com>
 <20140313170127.GE22247@linux.vnet.ibm.com>
 <20140324230550.GB18778@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251116490.16557@nuc>
 <20140325162303.GA29977@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251152250.16870@nuc>
 <20140325181010.GB29977@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Tue, 25 Mar 2014, Nishanth Aravamudan wrote:

> On power, very early, we find the 16G pages (gpages in the powerpc arch
> code) in the device-tree:
>
> early_setup ->
> 	early_init_mmu ->
> 		htab_initialize ->
> 			htab_init_page_sizes ->
> 				htab_dt_scan_hugepage_blocks ->
> 					memblock_reserve
> 						which marks the memory
> 						as reserved
> 					add_gpage
> 						which saves the address
> 						off so future calls for
> 						alloc_bootmem_huge_page()
>
> hugetlb_init ->
> 		hugetlb_init_hstates ->
> 			hugetlb_hstate_alloc_pages ->
> 				alloc_bootmem_huge_page
>
> > Not sure if I understand that correctly.
>
> Basically this is present memory that is "reserved" for the 16GB usage
> per the LPAR configuration. We honor that configuration in Linux based
> upon the contents of the device-tree. It just so happens in the
> configuration from my original e-mail that a consequence of this is that
> a NUMA node has memory (topologically), but none of that memory is free,
> nor will it ever be free.

Well dont do that

> Perhaps, in this case, we could just remove that node from the N_MEMORY
> mask? Memory allocations will never succeed from the node, and we can
> never free these 16GB pages. It is really not any different than a
> memoryless node *except* when you are using the 16GB pages.

That looks to be the correct way to handle things. Maybe mark the node as
offline or somehow not present so that the kernel ignores it.
