Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wchby391CzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 04:15:25 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4UI8t9x069395
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:15:21 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ascc6cd3c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:15:20 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 31 May 2017 04:15:18 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4UIF9g1852274
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 04:15:17 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4UIEiug021883
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 04:14:44 +1000
Date: Tue, 30 May 2017 23:44:26 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 1/2] powerpc/jprobes: Save and restore the parameter save
 area
References: <0572aa31dd57bef6f158ac97d0b666a0c545356a.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
 <87d1b6lox5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87d1b6lox5.fsf@concordia.ellerman.id.au>
Message-Id: <20170530181426.GR19390@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/05/18 03:22PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > As pointed out in x86 setjmp_pre_handler(), we need to save and restore
> > the parameter save area since the jprobe hook might overwrite it. Since
> > there is no easy way to identify the size of the parameter save area,
> > we choose to save/restore a fixed 16 [double]word-sized area including
> > the stack frame header.
> >
> > We introduce STACK_FRAME_PARM_SAVE to encode the offset of the parameter
> > save area from the stack frame pointer. Remove the similarly named
> > PARAMETER_SAVE_AREA_OFFSET in ptrace.c as those are currently not used
> > anywhere.
> >
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> > Michael,
> > I've set the limit to 16 parameters as being a "reasonable" number, but
> > we could very well make this 24 or 32 if we want to be sure. Let me
> > know what you prefer.
> 
> That sounds incredibly fragile. Are we really just guessing at the size
> required? What happens if we under estimate, do we crash, silently
> corrupt data .. ?

There is a _chance_ of crashing/corrupting data, yes. The conditions 
required for that include:
- a function that takes > 8 parameters, hence requiring parameters to be 
  passed on the stack
- the jprobe hook replacing that function having to clobber one of those 
  parameters passed on the stack.

Assuming C code, I am not sure what conditions could trigger gcc to emit 
code that may do the latter. However, per the ABI, this is possible as 
the parameter save area is owned by the callee and the caller can't 
assume that it'll remain intact.

Given the slim probability, I felt that saving/restoring a fixed amount 
of stack is sufficient to mitigate this. The other option is to 
save/restore the entire stack frame, but that may be quite large and 
just a lot of overhead in most cases.

Thoughts?

- Naveen
