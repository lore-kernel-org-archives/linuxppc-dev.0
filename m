Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wq9b6504WzDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 05:36:02 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5GJXqnT133003
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 15:36:00 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b4kfmvn0d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 15:36:00 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 16 Jun 2017 15:35:59 -0400
Date: Fri, 16 Jun 2017 12:35:52 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com
Subject: Re: [RFC PATCH 7/7 v1]powerpc: Deliver SEGV signal on protection key
 violation.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
 <1496711109-4968-8-git-send-email-linuxram@us.ibm.com>
 <87zid8uqnu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zid8uqnu.fsf@concordia.ellerman.id.au>
Message-Id: <20170616193552.GC17588@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 16, 2017 at 09:18:29PM +1000, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> > diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> > index 8036b38..109d0c2 100644
> > --- a/arch/powerpc/include/uapi/asm/ptrace.h
> > +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> > @@ -49,6 +49,8 @@ struct pt_regs {
> >  	unsigned long dar;		/* Fault registers */
> >  	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
> >  	unsigned long result;		/* Result of a system call */
> > +	unsigned long dscr;		/* contents of the DSCR register */
> > +	unsigned long amr;		/* contents of AMR register */
> >  };
> 
> You can't change pt_regs, it's ABI.
> 
> > @@ -109,7 +111,8 @@ struct pt_regs {
> >  #define PT_DSISR 42
> >  #define PT_RESULT 43
> >  #define PT_DSCR 44
> > -#define PT_REGS_COUNT 44
> > +#define PT_AMR 45
> > +#define PT_REGS_COUNT 45
> 
> You can add PT_AMR, but it has to be synthetic like DSCR, ie. not
> actually in pt_regs but available via ptrace.

ok.

> 
> But do we want to do that? How does the x86 code export the key(s) of a
> process? Or doesn't it?

The semantics defined on x86 is, 

    signal handler has to have a way of knowing the contents of the
    PKRU; (the x86 equivalent of AMR).  Also the signal handler
    has to have the ability to modify the PKRU before it returns
    from the signal handler. This modified information will be
    used by the kernel to program the CPU's PKRU register.

    if the signal handler does not have the ability to do so, than
    when the signal handler returns and the user code restarts executing
    where it had left, it will continue to access the same protected 
    address and fault again, which will again invoke the signal handler
    and this will continue infinitely.

We have to provide the same semantics on powerpc. The way I intend to
do it is to use one of the unused field in the gp_regs and fill that 
with the contents of the AMR register. PT_AMR, at offset 45 in gp_regs
is not used currently. offset 45, 46, and 47 are available AFIACT.


Dave: Why is it not ok to reprogram the PKRU from the signal handler,
        instead of telling the kernel to do so on its behalf? Or
	have I got my understanding of the semantics wrong?


> 
> cheers

-- 
Ram Pai
