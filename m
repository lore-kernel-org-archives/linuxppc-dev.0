Return-Path: <paulus@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDJYt3kLRzDqsx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 15:03:14 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6L4wZPh091199
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 01:03:11 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bu1mev3kk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 01:03:11 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulus@au1.ibm.com>;
 Fri, 21 Jul 2017 15:03:08 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6L52vJh31260878
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 15:03:05 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6L52WKF020847
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 15:02:33 +1000
Date: Fri, 21 Jul 2017 15:01:58 +1000
From: Paul Mackerras <paulus@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com,
 npiggin@gmail.com, Paul Mackerras <pmac@au1.ibm.com>
Subject: Re: [PATCH v4] powerpc/mm/radix: Workaround prefetch issue with KVM
References: <1500536216.3350.66.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500536216.3350.66.camel@kernel.crashing.org>
Message-Id: <20170721050158.tej3nvi3vb4qiri5@oak.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 20, 2017 at 05:36:56PM +1000, Benjamin Herrenschmidt wrote:
> There's a somewhat architectural issue with Radix MMU and KVM.
> 
> When coming out of a guest with AIL (ie, MMU enabled), we start
> executing hypervisor code with the PID register still containing
> whatever the guest has been using.
> 
> The problem is that the CPU can (and will) then start prefetching
> or speculatively load from whatever host context has that same
> PID (if any), thus bringing translations for that context into
> the TLB, which Linux doesn't know about.
> 
> This can cause stale translations and subsequent crashes.
> 
> Fixing this in a way that is neither racy nor a huge performance
> impact is difficult. We could just make the host invalidations
> always use broadcast forms but that would hurt single threaded
> programs for example.
> 
> We chose to fix it instead by partitioning the PID space between
> guest and host. This is possible because today Linux only use 19
> out of the 20 bits of PID space, so existing guests will work
> if we make the host use the top half of the 20 bits space.
> 
> We additionally add a property to indicate to Linux the size of
> the PID register which will be useful if we eventually have
> processors with a larger PID space available.
> 
> There is still an issue with malicious guests purposefully setting
> the PID register to a value in the host range. Hopefully future HW
> can prevent that, but in the meantime, we handle it with a pair of
> kludges:
> 
>  - On the way out of a guest, before we clear the current VCPU
> in the PACA, we check the PID and if it's outside of the permitted
> range we flush the TLB for that PID.
> 
>  - When context switching, if the mm is "new" on that CPU (the
> corresponding bit was set for the first time in the mm cpumask), we
> check if any sibling thread is in KVM (has a non-NULL VCPU pointer
> in the PACA). If that is the case, we also flush the PID for that
> CPU (core).
> 
> This second part is needed to handle the case where a process is
> migrated (or starts a new pthread) on a sibling thread of the CPU
> coming out of KVM, as there's a window where stale translations
> can exist before we detect it and flush them out.
> 
> A future optimization could be added by keeping track of whether
> the PID has ever been used and avoid doing that for completely
> fresh PIDs. We could similarily mark PIDs that have been the subject of
> a global invalidation as "fresh". But for now this will do.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Mostly looks fine.  I have one comment below about the tlbiels we do
when we detect the case that the guest used a PID value that it
shouldn't have:

[snip]
> +	/* Illegal PID, flush the TLB for this PID/LPID */
> +	isync
> +	ld	r6,VCPU_KVM(r9)
> +	lwz	r0,KVM_TLB_SETS(r6)
> +	mtctr	r0
> +	li	r7,0x400		/* IS field = 0b01 */
> +	ptesync
> +	sldi	r0,r3,32		/* RS has PID */
> +3:	PPC_TLBIEL(7,0,2,1,1)		/* RIC=2, PRS=1, R=1 */

The architecture says tlbiel in this form invalidates entries whose
lpid matches the value in LPIDR.  At this point in the code, LPIDR
still contains the guest lpid, but we're trying to invalidate host
entries, aren't we?  In general at this point in the code we can't
switch LPIDR (though on P9 we could) since we don't know at this point
that the other (POWER8) threads are out of the guest.

> +	addi	r7,r7,0x1000
> +	bdnz	3b
> +	ptesync
> +
> +4:	/* Flush the ERAT on radix P9 DD1 guest exit */
>  BEGIN_FTR_SECTION
>  	PPC_INVALIDATE_ERAT
>  END_FTR_SECTION_IFSET(CPU_FTR_POWER9_DD1)
>  
> +5:
>  	/*
>  	 * POWER7/POWER8 guest -> host partition switch code.
>  	 * We don't have to lock against tlbies but we do
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index abed1fe6992f..f74455dec087 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -25,6 +25,10 @@
>  #include <asm/mmu_context.h>
>  #include <asm/pgalloc.h>
>  
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +#include <asm/kvm_book3s_asm.h>
> +#endif

What is this include for?  Nothing you add to this file seems to use
anything from kvm_book3s_asm.h.

Paul.
