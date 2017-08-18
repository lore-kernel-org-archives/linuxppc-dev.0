Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYpN63NnhzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 02:25:26 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7IGNgKV094594
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 12:25:23 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cdwm67ww0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 12:25:23 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 18 Aug 2017 10:25:22 -0600
Date: Fri, 18 Aug 2017 09:25:09 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, bauerman@linux.vnet.ibm.com,
 mhocko@kernel.org
Subject: Re: [PATCH 7/7] powerpc: use helper functions to get and set hash
 slots
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1501459876-11357-1-git-send-email-linuxram@us.ibm.com>
 <1501459876-11357-8-git-send-email-linuxram@us.ibm.com>
 <87tw15oyqw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87tw15oyqw.fsf@concordia.ellerman.id.au>
Message-Id: <20170818162509.GA5545@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2017 at 10:18:31PM +1000, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > replace redundant code in __hash_page_64K(), __hash_page_huge(),
> > __hash_page_4K(), __hash_page_4K() and flush_hash_page()   with
> > helper functions pte_get_hash_gslot() and   pte_set_hash_slot()
> 
> This seems out of order.
> 
> At lease some of these are patching or even entirely replacing code you
> just added.
> 
> > diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> > index 5964b6d..e6dcd50 100644
> > --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> > +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> > @@ -112,18 +103,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
> >  			return -1;
> >  		}
> >  
> > -#ifdef CONFIG_PPC_64K_PAGES
> > -		/*
> > -		 * Insert slot number & secondary bit in PTE second half.
> > -		 */
> > -		hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> > -		rpte.hidx &= ~(0xfUL);
> > -		*hidxp = rpte.hidx  | (slot & 0xfUL);
> > -		/*
> > -		 * check __real_pte for details on matching smp_rmb()
> > -		 */
> > -		smp_wmb();
> > -#endif /* CONFIG_PPC_64K_PAGES */
> > +		new_pte |= pte_set_hash_slot(ptep, rpte, 0, slot);
> >  	}
> 
> Here for example. That entire chunk was just added in patch in 2.

Had it that way in my earlier patch series. But others found it
difficult to review its correctness. So had to have the code inline
first, followed by the modularization later; in this patch series.
Looks like you prefer it the earlier way. Will do in the next series.

RP
