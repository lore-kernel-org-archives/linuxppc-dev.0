Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJfyb4cVMzDqmr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 17:06:15 +1000 (AEST)
Date: Fri, 28 Jul 2017 09:06:12 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/3] mm/hugetlb: Allow arch to override and call the
 weak function
Message-ID: <20170728070611.GG2274@dhcp22.suse.cz>
References: <20170727061828.11406-1-aneesh.kumar@linux.vnet.ibm.com>
 <20170727130123.GE27766@dhcp22.suse.cz>
 <e963e910-1999-ddff-87cf-9e8c356fea82@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e963e910-1999-ddff-87cf-9e8c356fea82@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 27-07-17 21:50:35, Aneesh Kumar K.V wrote:
> 
> 
> On 07/27/2017 06:31 PM, Michal Hocko wrote:
> >On Thu 27-07-17 11:48:26, Aneesh Kumar K.V wrote:
> >>For ppc64, we want to call this function when we are not running as guest.
> >
> >What does this mean?
> >
> 
> ppc64 guest (aka LPAR) support a different mechanism for hugetlb
> allocation/reservation. The LPAR management application called HMC can be
> used to reserve a set of hugepages and we pass the details of reserved pages
> via device tree to the guest. You can find the details in
> htab_dt_scan_hugepage_blocks() . We do the memblock_reserve of the range and
> later in the boot sequence, we just add the reserved range to
> huge_boot_pages.
> 
> For baremetal config (when we are not running as guest) we want to follow
> what other architecture does, that is look at the command line and do
> memblock allocation. Hence the need to call generic function
> __alloc_bootmem_huge_page() in that case.
> 
> I can add all these details in to the commit message if that makes it easy ?

It certainly helped me to understand the context much better. Thanks! As
you are patching a generic code this would be appropriate IMHO.
-- 
Michal Hocko
SUSE Labs
