Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHQqf0Nl9zDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 08:56:13 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9ILiLv8013034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:56:11 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dpc479x2s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:56:10 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 18 Oct 2017 17:56:10 -0400
Date: Wed, 18 Oct 2017 14:56:03 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mhocko@kernel.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [RFC v7 16/25] powerpc: helper to validate key-access
 permissions of a pte
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-17-git-send-email-linuxram@us.ibm.com>
 <50c2a845-93aa-519f-732f-ee0d44be687c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50c2a845-93aa-519f-732f-ee0d44be687c@linux.vnet.ibm.com>
Message-Id: <20171018215603.GN5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2017 at 06:08:34PM +0200, Laurent Dufour wrote:
> 
> 
> On 31/07/2017 02:12, Ram Pai wrote:
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
> > index 060a1b2..2bec0f6 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > @@ -477,6 +477,10 @@ static inline void write_uamor(u64 value)
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
> > index 4b7e3f4..ba7bff6 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -85,6 +85,18 @@ static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
> >  		((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL));
> >  }
> > 
> > +static inline u16 pte_to_pkey_bits(u64 pteflags)
> > +{
> > +	if (!pkey_inited)
> > +		return 0x0UL;
> 
> Is it really needed to make such a check in this low level function ?
> The only caller is already checking for pkey_inited before making the call.

There are two callers to this function. get_pte_pkey() is one among
them and it calls this function ignorant of the status of the
pkey-subsystem.

Thanks,
RP
