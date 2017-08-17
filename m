Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYCWF6HzSzDr4J
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 03:14:33 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7HHES1m069032
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 13:14:30 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cdbqqwv5f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 13:14:29 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 17 Aug 2017 11:14:21 -0600
Date: Thu, 17 Aug 2017 10:14:08 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org
Subject: Re: [RFC v7 24/25] powerpc: Deliver SEGV signal on pkey violation
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-25-git-send-email-linuxram@us.ibm.com>
 <87378zkuil.fsf@linux.vnet.ibm.com>
 <87a836csdl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a836csdl.fsf@concordia.ellerman.id.au>
Message-Id: <20170817171408.GF5505@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 11, 2017 at 08:26:30PM +1000, Michael Ellerman wrote:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> 
> > Ram Pai <linuxram@us.ibm.com> writes:
> >
> >> The value of the AMR register at the time of exception
> >> is made available in gp_regs[PT_AMR] of the siginfo.
> >>
> >> The value of the pkey, whose protection got violated,
> >> is made available in si_pkey field of the siginfo structure.
> >
> > Should the IAMR also be made available?
> >
> > Also, should the AMR and IAMR be accesible to userspace (e.g., to GDB)
> > via ptrace and the core file?
> 
> Yes if they're part of the thread's context they should be accessible
> via ptrace and in core files.

ok. Some more code needed. :(

> 
> >> --- a/arch/powerpc/kernel/signal_32.c
> >> +++ b/arch/powerpc/kernel/signal_32.c
> >> @@ -500,6 +500,11 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
> >>  				   (unsigned long) &frame->tramp[2]);
> >>  	}
> >>
> >> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> >> +	if (__put_user(get_paca()->paca_amr, &frame->mc_gregs[PT_AMR]))
> >> +		return 1;
> >> +#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> >> +
> >>  	return 0;
> >>  }
> >
> > frame->mc_gregs[PT_AMR] has 32 bits, but paca_amr has 64 bits. Does this
> > work as intended?

hmm..i think we should just disable pkey support for 32 bit apps, till
we figure out all the edge cases.

> 
> I don't understand why we are putting it in there at all?
> 
> Is there some special handling of the actual register on signals? I
> haven't seen it. In which case the process can get the value of AMR by
> reading the register. ??

The value of AMR register at the time of the key-exception may not be
the same when the signal handler is invoked. 

RP
