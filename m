Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtm8S2SYjzDr11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 01:43:51 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MFhklW045477
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 11:43:49 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b8beu0u8r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 11:43:49 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 23 Jun 2017 01:43:41 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5MFhc4o3604878
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 01:43:38 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5MFhbJl006233
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 01:43:38 +1000
Date: Thu, 22 Jun 2017 21:13:36 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/6] powerpc/64s: Un-blacklist system_call() from
 kprobes
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <d13eccaed4be643409abed29565dbdd8c7d5af6a.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170622134112.4bd32543@roar.ozlabs.ibm.com>
 <8737ass29e.fsf@concordia.ellerman.id.au>
 <20170622231411.75ef990b@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170622231411.75ef990b@roar.ozlabs.ibm.com>
Message-Id: <20170622154336.z2q2wja35cvva4ms@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/22 11:14PM, Nicholas Piggin wrote:
> On Thu, 22 Jun 2017 21:14:21 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Nicholas Piggin <npiggin@gmail.com> writes:
> > 
> > > On Thu, 22 Jun 2017 00:08:40 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > >  
> > >> It is actually safe to probe system_call() in entry_64.S, but only till
> > >> we unset MSR_RI. To allow this, add a new symbol system_call_exit()
> > >> after the mtmsrd and blacklist that. Though the mtmsrd instruction
> > >> itself is now whitelisted, we won't be allowed to probe on it as we
> > >> don't allow probing on rfi and mtmsr instructions (checked for in
> > >> arch_prepare_kprobe()).  
> > >
> > > Can you add a little comment to say probes aren't allowed, and it's
> > > located after the mtmsr in order to avoid contaminating traces?

Hmm.. it's actually after the mtmsrd since we can probe until that 
point. In v2, I converted .Lsyscall_exit() into a different label and 
blacklisted all of it. But Michael prefers to only blacklist what we 
must. It is helpful if we ever want to probe after returning from a 
syscall. That said, please see further below (*)

> > >
> > > Also I wonder if a slightly different name would be more instructive?
> > > I don't normally care, but the system_call_common code isn't trivial
> > > to follow. system_call_exit might give the impression that it is the
> > > entire exit path (which would pair with system_call for entry).  
> > 
> > It is the entire path in the happy case isn't it? I'm not sure I know
> > what you mean.
> 
> Oh, yes you're right, I thought it was moved down further.
> 
> > If you're tracing etc. then you'll be in syscall_exit_work, isn't 
> > that sufficient to differentiate the two?

Not sure how much this matters, but the new symbol (system_call_exit) is 
actually a few instructions from after the syscall return 
(.Lsyscall_exit). And I have converted syscall_exit_work to a private 
symbol as well.

In general, from kprobes standpoint, there are places there where we can 
probe safely but doing so may require new symbols to be introduced, 
which could make traces look weird, as well as distribute samples among 
different symbols.

I'm not sure how best to proceed. In this current series, I pretty much 
blacklist all of system_call_common() through to syscall_exit() except 
for the small part in between in system_call(). All other symbols have 
been made private, so nothing else apart from system_call_common(), 
system_call() and system_call_exit() show up in traces.

We could probably retain syscall_dotrace(), syscall_enosys() and parts 
of syscall_exit_work() after RI is restored, which will allow those to 
be probed, but end up showing these symbols in traces.

What would be preferable?


-----
(*)
The other suggestion Michael had was to just put a nop after the bctrl 
and to again make .Lsyscall_exit public and blacklist that (though he 
wasn't all for it). I suppose it does solve this issue in a nice way - 
the call traces when in a system call show the proper symbol and we do 
have a 'nop' instruction on which we can probe to catch returns from 
system calls. Is that something we can re-consider? Something like this 
(along with converting other .Lsyscall_exit references):

--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -175,8 +175,9 @@ system_call:                        /* label this so stack traces look sane */
        ldx     r12,r11,r0      /* Fetch system call handler [ptr] */
        mtctr   r12
        bctrl                   /* Call handler */
+       nop

-.Lsyscall_exit:
+system_call_exit:
        std     r3,RESULT(r1)
        CURRENT_THREAD_INFO(r12, r1)



Thanks,
Naveen
