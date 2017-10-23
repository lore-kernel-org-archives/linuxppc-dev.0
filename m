Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLMLg0gBZzDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 03:29:46 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9NGOJap120926
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 12:29:44 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dsjcfvt4j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 12:29:44 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 23 Oct 2017 10:29:43 -0600
Date: Mon, 23 Oct 2017 09:29:34 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 3/7] powerpc: Free up four 64K PTE bits in 4K backed HPTE
 pages
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-4-git-send-email-linuxram@us.ibm.com>
 <87o9p3kedg.fsf@concordia.ellerman.id.au>
 <871slu9ro4.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871slu9ro4.fsf@linux.vnet.ibm.com>
Message-Id: <20171023162934.GA5454@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 23, 2017 at 02:17:39PM +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > Ram Pai <linuxram@us.ibm.com> writes:
> >
> >> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> >> index 1a68cb1..c6c5559 100644
> >> --- a/arch/powerpc/mm/hash64_64k.c
> >> +++ b/arch/powerpc/mm/hash64_64k.c
> >> @@ -126,18 +113,13 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >>  	if (__rpte_sub_valid(rpte, subpg_index)) {
> >>  		int ret;
> >>  
> >> -		hash = hpt_hash(vpn, shift, ssize);
> >> -		hidx = __rpte_to_hidx(rpte, subpg_index);
> >> -		if (hidx & _PTEIDX_SECONDARY)
> >> -			hash = ~hash;
> >> -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> >> -		slot += hidx & _PTEIDX_GROUP_IX;
> >> +		gslot = pte_get_hash_gslot(vpn, shift, ssize, rpte,
> >> +					subpg_index);
> >> +		ret = mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn,
> >> +			MMU_PAGE_4K, MMU_PAGE_4K, ssize, flags);
> >
> > This was formatted correctly before:
> >   
> >> -		ret = mmu_hash_ops.hpte_updatepp(slot, rflags, vpn,
> >> -						 MMU_PAGE_4K, MMU_PAGE_4K,
> >> -						 ssize, flags);
> >>  		/*
> >> -		 *if we failed because typically the HPTE wasn't really here
> >> +		 * if we failed because typically the HPTE wasn't really here
> >
> > If you're fixing it up please make it "If ...".
> >
> >>  		 * we try an insertion.
> >>  		 */
> >>  		if (ret == -1)
> >> @@ -148,6 +130,15 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >>  	}
> >>  
> >>  htab_insert_hpte:
> >> +
> >> +	/*
> >> +	 * initialize all hidx entries to invalid value,
> >> +	 * the first time the PTE is about to allocate
> >> +	 * a 4K hpte
> >> +	 */
> >
> > Should be:
> > 	/*
> > 	 * Initialize all hidx entries to invalid value, the first time
> >          * the PTE is about to allocate a 4K HPTE.
> > 	 */
> >
> >> +	if (!(old_pte & H_PAGE_COMBO))
> >> +		rpte.hidx = ~0x0UL;
> >> +
> >
> > Paul had the idea that if we biased the slot number by 1, we could make
> > the "invalid" value be == 0.
> >
> > That would avoid needing to that above, and also mean the value is
> > correctly invalid from the get-go, which would be good IMO.
> >
> > I think now that you've added the slot accessors it would be pretty easy
> > to do.
> 
> That would be imply, we loose one slot in primary group, which means we
> will do extra work in some case because our primary now has only 7
> slots. And in case of pseries, the hypervisor will always return the
> least available slot, which implie we will do extra hcalls in case of an
> hpte insert to an empty group?


No. that is not the idea.  The idea is that slot 'F' in the seconday
will continue to be a invalid slot, but will be represented as
offset-by-one in the PTE.  In other words, 0 will be repesented as 1,
1 as 2....   and  n as (n+1)%32

The idea seems feasible.  It has the advantage -- where 0 in the PTE
means invalid slot. But it can be confusing to the casual code-
reader. Will need to put in a big-huge comment to explain that.

RP
