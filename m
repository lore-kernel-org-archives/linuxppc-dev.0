Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yM1v96pGPzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 05:26:44 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9OIP1Dj126381
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 14:26:42 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dtahp16a9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 14:26:41 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 24 Oct 2017 12:26:41 -0600
Date: Tue, 24 Oct 2017 11:26:33 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 20/25] powerpc: Handle exceptions caused by pkey violation
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-29-git-send-email-linuxram@us.ibm.com>
 <874lqo4kf9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <874lqo4kf9.fsf@concordia.ellerman.id.au>
Message-Id: <20171024182633.GK5454@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 24, 2017 at 05:47:38PM +0200, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > Handle Data and  Instruction exceptions caused by memory
> > protection-key.
> >
> > The CPU will detect the key fault if the HPTE is already
> > programmed with the key.
> >
> > However if the HPTE is not  hashed, a key fault will not
> > be detected by the  hardware. The   software will detect
> > pkey violation in such a case.
> 
> That seems like the wrong trade off to me.
> 
> It means every fault has to go through arch_vma_access_permitted(),
> which is at least a function call in the best case, even when pkeys are
> not in use, and/or the range in question is not protected by a key.
> 
> Why not instead just service the fault and let the hardware catch it?
> 
> If that access to a protected page is a bug then the process will
> probably just exit, in which case who cares about the overhead of the
> extra fault.
> 
> If the access is not currently allowed, but the process wants to take
> the signal and do something to allow it, then is the overhead of the
> extra fault going to matter vs the signal etc?
> 
> I think we should just let the hardware take a 2nd fault, unless someone
> can demonstrate a workload where the cost of that is prohibitive.
> 
> Or does that not work for some reason?

It does not work, because the arch-neutral code error-outs the fault
without letting the power-specific code to page-in the faulting page.

So neither does the page gets faulted, nor does the key-fault gets 
signalled.

> 
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index 4797d08..a16bc43 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -391,11 +408,9 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
> >  		return 0;
> >  
> >  	if (unlikely(page_fault_is_bad(error_code))) {
> > -		if (is_user) {
> > -			_exception(SIGBUS, regs, BUS_OBJERR, address);
> > -			return 0;
> > -		}
> > -		return SIGBUS;
> > +		if (!is_user)
> > +			return SIGBUS;
> > +		return bad_page_fault_exception(regs, address, error_code);
> 
> I don't see why we want to handle the key fault here.
> 
> I know it's caught here at the moment, because it's in
> DSISR_BAD_FAULT_64S, but I think now that we support keys we should
> remove DSISR_KEYFAULT from DSISR_BAD_FAULT_64S.
> 
> Then we should let it fall through to further down, and handle it in
> access_error().
> 
> That way eg. the page fault accounting will work as normal etc.

Bit tricky to do that. Will try. For one if I take out DSISR_KEYFAULT
from DSISR_BAD_FAULT_64S, than the assembly code in do_hash_page() will
not call  __do_page_fault().  We want it called, but somehow
special-handle DSISR_KEYFAULT to call access_error().

> 
> > @@ -492,6 +507,18 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
> >  	if (unlikely(access_error(is_write, is_exec, vma)))
> >  		return bad_area(regs, address);
> >  
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
> > +			is_exec, 0))
> > +		return __bad_area(regs, address, SEGV_PKUERR);
> > +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > +
> > +
> > +	/* handle_mm_fault() needs to know if its a instruction access
> > +	 * fault.
> > +	 */
> > +	if (is_exec)
> > +		flags |= FAULT_FLAG_INSTRUCTION;
> 
> What is this doing here? We already do that further up.

The more I think of this, I find that the code can be optimized and
remove redundancy.  I am unnecessarily called arch_vma_access_permitted()
above, when all the hardwork anyway gets done by handle_mm_fault().
handle_mm_fault() anyway calls arch_vma_access_permitted().

I could rather use the return value of handle_mm_fault() to signal
a key-error to the userspace.

RP
