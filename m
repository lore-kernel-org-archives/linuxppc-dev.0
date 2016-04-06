Return-Path: <mstsxfx@gmail.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qg3NK4YHTzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 21:27:13 +1000 (AEST)
Received: by mail-wm0-f66.google.com with SMTP id o129so2808879wmo.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Apr 2016 04:27:13 -0700 (PDT)
Date: Wed, 6 Apr 2016 13:27:08 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 James Dykman <jdykman@us.ibm.com>
Subject: Re: [PATCH 1/1] powerpc/mm: Add memory barrier in __hugepte_alloc()
Message-ID: <20160406112708.GF24272@dhcp22.suse.cz>
References: <20160405190547.GA12673@us.ibm.com>
 <20160406095623.GA24283@dhcp22.suse.cz>
 <8737qzxd4i.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8737qzxd4i.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 06-04-16 15:39:17, Aneesh Kumar K.V wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > [ text/plain ]
> > On Tue 05-04-16 12:05:47, Sukadev Bhattiprolu wrote:
> > [...]
> >> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> >> index d991b9e..081f679 100644
> >> --- a/arch/powerpc/mm/hugetlbpage.c
> >> +++ b/arch/powerpc/mm/hugetlbpage.c
> >> @@ -81,6 +81,13 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
> >>  	if (! new)
> >>  		return -ENOMEM;
> >>  
> >> +	/*
> >> +	 * Make sure other cpus find the hugepd set only after a
> >> +	 * properly initialized page table is visible to them.
> >> +	 * For more details look for comment in __pte_alloc().
> >> +	 */
> >> +	smp_wmb();
> >> +
> >
> > what is the pairing memory barrier?
> >
> >>  	spin_lock(&mm->page_table_lock);
> >>  #ifdef CONFIG_PPC_FSL_BOOK3E
> >>  	/*
> 
> This is documented in __pte_alloc(). I didn't want to repeat the same
> here.
> 
> 	/*
> 	 * Ensure all pte setup (eg. pte page lock and page clearing) are
> 	 * visible before the pte is made visible to other CPUs by being
> 	 * put into page tables.
> 	 *
> 	 * The other side of the story is the pointer chasing in the page
> 	 * table walking code (when walking the page table without locking;
> 	 * ie. most of the time). Fortunately, these data accesses consist
> 	 * of a chain of data-dependent loads, meaning most CPUs (alpha
> 	 * being the notable exception) will already guarantee loads are
> 	 * seen in-order. See the alpha page table accessors for the
> 	 * smp_read_barrier_depends() barriers in page table walking code.
> 	 */
> 	smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */

OK, I have missed the reference to __pte_alloc. My bad!

-- 
Michal Hocko
SUSE Labs
