Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYD540vc8zDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 03:40:23 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7HHcnjP004053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 13:40:21 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cdba60afr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 13:40:21 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 17 Aug 2017 13:40:20 -0400
Date: Thu, 17 Aug 2017 10:40:14 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org
Subject: Re: [RFC v7 25/25] powerpc: Enable pkey subsystem
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-26-git-send-email-linuxram@us.ibm.com>
 <871sojkta1.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871sojkta1.fsf@linux.vnet.ibm.com>
Message-Id: <20170817174014.GG5505@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 10, 2017 at 06:27:34PM -0300, Thiago Jung Bauermann wrote:
> 
> Ram Pai <linuxram@us.ibm.com> writes:
> > --- a/arch/powerpc/include/asm/cputable.h
> > +++ b/arch/powerpc/include/asm/cputable.h
> > @@ -214,6 +214,7 @@ enum {
> >  #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
> >  #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
> >  #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
> > +#define CPU_FTR_PKEY			LONG_ASM_CONST(0x2000000000000000)
> >  #define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x4000000000000000)
> >
> >  #ifndef __ASSEMBLY__
> > @@ -452,7 +453,7 @@ enum {
> >  	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
> >  	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
> >  	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | \
> > -	    CPU_FTR_VMX_COPY | CPU_FTR_HAS_PPR | CPU_FTR_DABRX)
> > +	    CPU_FTR_VMX_COPY | CPU_FTR_HAS_PPR | CPU_FTR_DABRX | CPU_FTR_PKEY)
> 
> P7 supports protection keys for data access (AMR) but not for
> instruction access (IAMR), right? There's nothing in the code making
> this distinction, so either CPU_FTR_PKEY shouldn't be enabled in P7 or
> separate feature bits for AMR and IAMR should be used and checked before
> trying to access the IAMR.

did'nt David say P7 supports both? P6, i think, only support data.
my pkey tests have passed on p7.

> 
> >  #define CPU_FTRS_POWER8 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
> >  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
> >  	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
> > @@ -462,7 +463,7 @@ enum {
> >  	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
> >  	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
> >  	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
> > -	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP)
> > +	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_PKEY)
> >  #define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
> >  #define CPU_FTRS_POWER8_DD1 (CPU_FTRS_POWER8 & ~CPU_FTR_DBELL)
> >  #define CPU_FTRS_POWER9 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
> > @@ -474,7 +475,8 @@ enum {
> >  	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
> >  	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
> >  	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
> > -	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300)
> > +	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | \
> > +	    CPU_FTR_PKEY)
> >  #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
> >  			     (~CPU_FTR_SAO))
> >  #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
> > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> > index a1cfcca..acd59d8 100644
> > --- a/arch/powerpc/include/asm/mmu_context.h
> > +++ b/arch/powerpc/include/asm/mmu_context.h
> > @@ -188,6 +188,7 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
> >
> >  #define pkey_initialize()
> >  #define pkey_mm_init(mm)
> > +#define pkey_mmu_values(total_data, total_execute)
> >
> >  static inline int vma_pkey(struct vm_area_struct *vma)
> >  {
> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > index ba7bff6..e61ed6c 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -1,6 +1,8 @@
> >  #ifndef _ASM_PPC64_PKEYS_H
> >  #define _ASM_PPC64_PKEYS_H
> >
> > +#include <asm/firmware.h>
> > +
> >  extern bool pkey_inited;
> >  extern int pkeys_total; /* total pkeys as per device tree */
> >  extern u32 initial_allocation_mask;/* bits set for reserved keys */
> > @@ -227,6 +229,24 @@ static inline void pkey_mm_init(struct mm_struct *mm)
> >  	mm->context.execute_only_pkey = -1;
> >  }
> >
> > +static inline void pkey_mmu_values(int total_data, int total_execute)
> > +{
> > +	/*
> > +	 * since any pkey can be used for data or execute, we
> > +	 * will  just  treat all keys as equal and track them
> > +	 * as one entity.
> > +	 */
> > +	pkeys_total = total_data + total_execute;
> > +}
> 
> Right now this works because the firmware reports 0 execute keys in the
> device tree, but if (when?) it is fixed to report 32 execute keys as
> well as 32 data keys (which are the same keys), any place using
> pkeys_total expecting it to mean the number of keys that are available
> will be broken. This includes pkey_initialize and mm_pkey_is_allocated.

Good point. we should just ignore total_execute. It should
be the same value as total_data on the latest platforms.
On older platforms it will continue to be zero.

> 
> Perhaps pkeys_total should use total_data as the number of keys
> supported in the system, and total_execute just as a flag to say whether
> there's a IAMR? Or, since P8 and later have IAMR and P7 is unlikely to
> have the firmware fixed, maybe the kernel should just ignore
> total_execute altogether?
> 
> > +static inline bool pkey_mmu_enabled(void)
> > +{
> > +	if (firmware_has_feature(FW_FEATURE_LPAR))
> > +		return pkeys_total;
> > +	else
> > +		return cpu_has_feature(CPU_FTR_PKEY);
> > +}
> > +
> >  static inline void pkey_initialize(void)
> >  {
> >  	int os_reserved, i;
> > @@ -236,9 +256,17 @@ static inline void pkey_initialize(void)
> >  	 * line will enable it.
> >  	 */
> >  	pkey_inited = false;
> > +	if (pkey_mmu_enabled())
> > +		pkey_inited = !radix_enabled();
> > +
> > +	if (!pkey_inited)
> > +		return;
> >
> > -	/* Lets assume 32 keys */
> > -	pkeys_total = 32;
> > +	/* Lets assume 32 keys if we are not told
> > +	 * the number of pkeys.
> > +	 */
> > +	if (!pkeys_total)
> > +		pkeys_total = 32;
> >
> >  #ifdef CONFIG_PPC_4K_PAGES
> >  	/*
> 
> This patch should remove the comment "disable the pkey system till
> everything is in place. A patch further down the line will enable it.".

Yes.

RP
