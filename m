Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHRBH0bLmzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 09:12:22 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9IM9F4M093253
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 18:12:20 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dp9p6b2kt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 18:12:19 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 18 Oct 2017 18:12:18 -0400
Date: Wed, 18 Oct 2017 15:12:12 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mhocko@kernel.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [RFC v7 15/25] powerpc: Program HPTE key protection bits
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-16-git-send-email-linuxram@us.ibm.com>
 <24a039cb-526c-6baa-15b8-906963ae62b7@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <24a039cb-526c-6baa-15b8-906963ae62b7@linux.vnet.ibm.com>
Message-Id: <20171018221212.GP5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2017 at 06:15:40PM +0200, Laurent Dufour wrote:
> 
> 
> On 31/07/2017 02:12, Ram Pai wrote:
> > Map the PTE protection key bits to the HPTE key protection bits,
> > while creating HPTE  entries.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/mmu-hash.h |    5 +++++
> >  arch/powerpc/include/asm/mmu_context.h        |    6 ++++++
> >  arch/powerpc/include/asm/pkeys.h              |   13 +++++++++++++
> >  arch/powerpc/mm/hash_utils_64.c               |    1 +
> >  4 files changed, 25 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> > index 6981a52..f7a6ed3 100644
> > --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> > +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> > @@ -90,6 +90,8 @@
> >  #define HPTE_R_PP0		ASM_CONST(0x8000000000000000)
> >  #define HPTE_R_TS		ASM_CONST(0x4000000000000000)
> >  #define HPTE_R_KEY_HI		ASM_CONST(0x3000000000000000)
> > +#define HPTE_R_KEY_BIT0		ASM_CONST(0x2000000000000000)
> > +#define HPTE_R_KEY_BIT1		ASM_CONST(0x1000000000000000)
> >  #define HPTE_R_RPN_SHIFT	12
> >  #define HPTE_R_RPN		ASM_CONST(0x0ffffffffffff000)
> >  #define HPTE_R_RPN_3_0		ASM_CONST(0x01fffffffffff000)
> > @@ -104,6 +106,9 @@
> >  #define HPTE_R_C		ASM_CONST(0x0000000000000080)
> >  #define HPTE_R_R		ASM_CONST(0x0000000000000100)
> >  #define HPTE_R_KEY_LO		ASM_CONST(0x0000000000000e00)
> > +#define HPTE_R_KEY_BIT2		ASM_CONST(0x0000000000000800)
> > +#define HPTE_R_KEY_BIT3		ASM_CONST(0x0000000000000400)
> > +#define HPTE_R_KEY_BIT4		ASM_CONST(0x0000000000000200)
> > 
> >  #define HPTE_V_1TB_SEG		ASM_CONST(0x4000000000000000)
> >  #define HPTE_V_VRMA_MASK	ASM_CONST(0x4001ffffff000000)
> > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> > index 7232484..2eb7f80 100644
> > --- a/arch/powerpc/include/asm/mmu_context.h
> > +++ b/arch/powerpc/include/asm/mmu_context.h
> > @@ -190,6 +190,12 @@ static inline int vma_pkey(struct vm_area_struct *vma)
> >  {
> >  	return 0;
> >  }
> > +
> > +static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
> > +{
> > +	return 0x0UL;
> > +}
> > +
> >  #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > 
> >  #endif /* __KERNEL__ */
> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > index 1ded6df..4b7e3f4 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -72,6 +72,19 @@ static inline int vma_pkey(struct vm_area_struct *vma)
> >  #define AMR_RD_BIT 0x1UL
> >  #define AMR_WR_BIT 0x2UL
> >  #define IAMR_EX_BIT 0x1UL
> > +
> > +static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
> > +{
> > +	if (!pkey_inited)
> > +		return 0x0UL;
> 
> Why making such a check here, is it to avoid the following check during the
> boot process only ?
> IIUC, there is no way to get H_PAGE_PKEY_BIT* set when pkey_inited is false.

I know its a little paronia. Trying to avoid a case where the
uninitialized pkey bits in the pte are erroneously interpreted as valid
by this function. Remember that the caller of this function will use the
return value to program the hpte. Nothing really bad should happen
since none of the keys are enabled. But ... just playing it safe.

thanks,
RP
