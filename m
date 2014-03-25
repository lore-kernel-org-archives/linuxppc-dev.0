Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3A4AE140095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 05:37:29 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 25 Mar 2014 12:37:26 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B45451FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 12:37:23 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2PIam3F10289560
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 19:36:48 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2PIbN5L004997
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 12:37:23 -0600
Date: Tue, 25 Mar 2014 11:37:06 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: Bug in reclaim logic with exhausted nodes?
Message-ID: <20140325183706.GA7809@linux.vnet.ibm.com>
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

I appreciate the help you're offering, but that's really not an option.
The customer/user has configured the system in such a way so they can
leverage the gigantic pages. And *most* everything seems to work fine
except for the case I mentioned in my original e-mail. I guess we could
fewer 16GB pages if it would exhaust a NUMA node, but ... I think the
underlying mapping would be a 16GB one, so it will not be accurate from
a performance perspective (although it should perform better).

> > Perhaps, in this case, we could just remove that node from the N_MEMORY
> > mask? Memory allocations will never succeed from the node, and we can
> > never free these 16GB pages. It is really not any different than a
> > memoryless node *except* when you are using the 16GB pages.
> 
> That looks to be the correct way to handle things. Maybe mark the node as
> offline or somehow not present so that the kernel ignores it.

Ok, I'll consider these options. Thanks!

-Nish
