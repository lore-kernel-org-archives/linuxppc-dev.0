Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA6202C00EA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 18:17:47 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 15 Apr 2013 13:43:36 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 82119E002D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 13:49:35 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3F8HWr27340438
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 13:47:32 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3F8HXVI012611
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 18:17:34 +1000
Message-ID: <1366013849.12424.36.camel@ThinkPad-T5421.cn.ibm.com>
Subject: Re: [RFC PATCH v2 1/4] powerpc: Move the setting of rflags out of
 loop in __hash_page_huge
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 15 Apr 2013 16:17:29 +0800
In-Reply-To: <20130415063258.GE21147@concordia>
References: <1365733021-28912-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1365733021-28912-2-git-send-email-zhong@linux.vnet.ibm.com>
 <20130415063258.GE21147@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-04-15 at 16:32 +1000, Michael Ellerman wrote:
> On Fri, Apr 12, 2013 at 10:16:57AM +0800, Li Zhong wrote:
> > It seems that rflags don't get changed in  the repeating loop, so move
> > it out of the loop.

> You've also changed the way new_pte is handled on repeat, but I think
> that's OK too.

OK, I'll add it in the description :)

Thanks, Zhong

> cheers
> 
> > diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> > index cecad34..edb4129 100644
> > --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> > +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> > @@ -87,10 +87,6 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
> >  
> >  		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
> >  
> > -repeat:
> > -		hpte_group = ((hash & htab_hash_mask) *
> > -			      HPTES_PER_GROUP) & ~0x7UL;
> > -
> >  		/* clear HPTE slot informations in new PTE */
> >  #ifdef CONFIG_PPC_64K_PAGES
> >  		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HPTE_SUB0;
> 
> ie. here new_pte was updated on repeat, but now it's not.
> 
> > @@ -101,6 +97,10 @@ repeat:
> >  		rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
> >  				      _PAGE_COHERENT | _PAGE_GUARDED));
> >  
> > +repeat:
> > +		hpte_group = ((hash & htab_hash_mask) *
> > +			      HPTES_PER_GROUP) & ~0x7UL;
> > +
> >  		/* Insert into the hash table, primary slot */
> >  		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
> >  					  mmu_psize, ssize);
> 
