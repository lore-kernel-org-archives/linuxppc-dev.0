Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHQ1D6Sl4zDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 08:19:28 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9ILIuB8004873
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:19:26 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dp9p5150k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:19:26 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 18 Oct 2017 17:19:25 -0400
Date: Wed, 18 Oct 2017 14:19:17 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 17/25] powerpc: helper to validate key-access permissions
 of a pte
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-26-git-send-email-linuxram@us.ibm.com>
 <20171018154831.50b2abcb@firefly.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171018154831.50b2abcb@firefly.ozlabs.ibm.com>
Message-Id: <20171018211917.GK5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2017 at 03:48:31PM +1100, Balbir Singh wrote:
> On Fri,  8 Sep 2017 15:45:05 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > helper function that checks if the read/write/execute is allowed
> > on the pte.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/pgtable.h |    4 +++
> >  arch/powerpc/include/asm/pkeys.h             |   12 +++++++++++
> >  arch/powerpc/mm/pkeys.c                      |   28 ++++++++++++++++++++++++++
> >  3 files changed, 44 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > index 5935d4e..bd244b3 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > @@ -492,6 +492,10 @@ static inline void write_uamor(u64 value)
> >  	mtspr(SPRN_UAMOR, value);
> >  }
> >  
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +extern bool arch_pte_access_permitted(u64 pte, bool write, bool execute);
> > +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > +
> >  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
> >  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >  				       unsigned long addr, pte_t *ptep)
> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > index cd3924c..50522a0 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -80,6 +80,18 @@ static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
> >  		((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL));
> >  }
> >  
> > +static inline u16 pte_to_pkey_bits(u64 pteflags)
> > +{
> > +	if (!pkey_inited)
> > +		return 0x0UL;
> > +
> > +	return (((pteflags & H_PAGE_PKEY_BIT0) ? 0x10 : 0x0UL) |
> > +		((pteflags & H_PAGE_PKEY_BIT1) ? 0x8 : 0x0UL) |
> > +		((pteflags & H_PAGE_PKEY_BIT2) ? 0x4 : 0x0UL) |
> > +		((pteflags & H_PAGE_PKEY_BIT3) ? 0x2 : 0x0UL) |
> > +		((pteflags & H_PAGE_PKEY_BIT4) ? 0x1 : 0x0UL));
> > +}
> > +
> >  #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
> >  				VM_PKEY_BIT3 | VM_PKEY_BIT4)
> >  #define AMR_BITS_PER_PKEY 2
> > diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> > index fb1a76a..24589d9 100644
> > --- a/arch/powerpc/mm/pkeys.c
> > +++ b/arch/powerpc/mm/pkeys.c
> > @@ -292,3 +292,31 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot,
> >  	 */
> >  	return vma_pkey(vma);
> >  }
> > +
> > +static bool pkey_access_permitted(int pkey, bool write, bool execute)
> > +{
> > +	int pkey_shift;
> > +	u64 amr;
> > +
> > +	if (!pkey)
> > +		return true;
> 
> Why would we have pkey set to 0, it's reserved. Why do we return true?

pkey 0 is reserved in some weird sense. it is the default key which is
omnipresent, which cannot be allocated or freed, but can be used any time and
allows read/write/execute at all times.

> 
> > +
> > +	pkey_shift = pkeyshift(pkey);
> > +	if (!(read_uamor() & (0x3UL << pkey_shift)))
> > +		return true;
> > +
> > +	if (execute && !(read_iamr() & (IAMR_EX_BIT << pkey_shift)))
> > +		return true;
> > +
> > +	amr = read_amr(); /* delay reading amr uptil absolutely needed*/
> > +	return ((!write && !(amr & (AMR_RD_BIT << pkey_shift))) ||
> > +		(write &&  !(amr & (AMR_WR_BIT << pkey_shift))));
> > +}
> > +
> > +bool arch_pte_access_permitted(u64 pte, bool write, bool execute)
> > +{
> > +	if (!pkey_inited)
> > +		return true;
> 
> Again, don't like the pkey_inited bits :)

suggest something. :) running out of ideas ;)

> 
> > +	return pkey_access_permitted(pte_to_pkey_bits(pte),
> > +			write, execute);
> > +}
> 
> Balbir Singh

-- 
Ram Pai
