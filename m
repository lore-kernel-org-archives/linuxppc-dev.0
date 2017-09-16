Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvVM21DqMzDrHr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 21:25:49 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8GBOVQ7010366
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 07:25:45 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d1059w097-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 07:25:45 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Sat, 16 Sep 2017 21:25:42 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8GBPddI38666426
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 21:25:39 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8GBPVd3031661
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 21:25:32 +1000
Date: Sat, 16 Sep 2017 16:55:34 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/5] powerpc/kprobes: Fix warnings from __this_cpu_read()
 on preempt kernels
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
 <63b0f9f3fd3d95d758678a892b87b7c561545c99.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170913173655.1ada3c799d98cab104c45cae@kernel.org>
 <20170914064720.u36di37zsascsqtp@naverao1-tp.localdomain>
 <20170914031019.6660f4533c10691816dd27d1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170914031019.6660f4533c10691816dd27d1@kernel.org>
Message-Id: <20170916112534.7msj3l6gdz7c4tjr@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/09/14 03:10AM, Masami Hiramatsu wrote:
> On Thu, 14 Sep 2017 12:17:20 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > On 2017/09/13 05:36PM, Masami Hiramatsu wrote:
> > > On Thu, 14 Sep 2017 02:50:34 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > > 
> > > > Kamalesh pointed out that we are getting the below call traces with
> > > > livepatched functions when we enable CONFIG_PREEMPT:
> > > > 
> > > > [  495.470721] BUG: using __this_cpu_read() in preemptible [00000000] code: cat/8394
> > > > [  495.471167] caller is is_current_kprobe_addr+0x30/0x90
> > > > [  495.471171] CPU: 4 PID: 8394 Comm: cat Tainted: G              K 4.13.0-rc7-nnr+ #95
> > > > [  495.471173] Call Trace:
> > > > [  495.471178] [c00000008fd9b960] [c0000000009f039c] dump_stack+0xec/0x160 (unreliable)
> > > > [  495.471184] [c00000008fd9b9a0] [c00000000059169c] check_preemption_disabled+0x15c/0x170
> > > > [  495.471187] [c00000008fd9ba30] [c000000000046460] is_current_kprobe_addr+0x30/0x90
> > > > [  495.471191] [c00000008fd9ba60] [c00000000004e9a0] ftrace_call+0x1c/0xb8
> > > > [  495.471195] [c00000008fd9bc30] [c000000000376fd8] seq_read+0x238/0x5c0
> > > > [  495.471199] [c00000008fd9bcd0] [c0000000003cfd78] proc_reg_read+0x88/0xd0
> > > > [  495.471203] [c00000008fd9bd00] [c00000000033e5d4] __vfs_read+0x44/0x1b0
> > > > [  495.471206] [c00000008fd9bd90] [c0000000003402ec] vfs_read+0xbc/0x1b0
> > > > [  495.471210] [c00000008fd9bde0] [c000000000342138] SyS_read+0x68/0x110
> > > > [  495.471214] [c00000008fd9be30] [c00000000000bc6c] system_call+0x58/0x6c
> > > > 
> > > > Commit c05b8c4474c030 ("powerpc/kprobes: Skip livepatch_handler() for
> > > > jprobes") introduced a helper is_current_kprobe_addr() to help determine
> > > > if the current function has been livepatched or if it has a jprobe
> > > > installed, both of which modify the NIP.
> > > > 
> > > > In the case of a jprobe, kprobe_ftrace_handler() disables pre-emption
> > > > before calling into setjmp_pre_handler() which returns without disabling
> > > > pre-emption. This is done to ensure that the jprobe han dler won't
> > > > disappear beneath us if the jprobe is unregistered between the
> > > > setjmp_pre_handler() and the subsequent longjmp_break_handler() called
> > > > from the jprobe handler. Due to this, we can use __this_cpu_read() in
> > > > is_current_kprobe_addr() with the pre-emption check as we know that
> > > > pre-emption will be disabled.
> > > > 
> > > > However, if this function has been livepatched, we are still doing this
> > > > check and when we do so, pre-emption won't necessarily be disabled. This
> > > > results in the call trace shown above.
> > > > 
> > > > Fix this by only invoking is_current_kprobe_addr() when pre-emption is
> > > > disabled. And since we now guard this within a pre-emption check, we can
> > > > instead use raw_cpu_read() to get the current_kprobe value skipping the
> > > > check done by __this_cpu_read().
> > > 
> > > Hmm, can you disable preempt temporary at this function and read it?
> > 
> > Yes, but I felt this approach is more optimal specifically for live 
> > patching. We don't normally expect preemption to be disabled while 
> > handling a livepatched function, so the simple 'if (!preemptible())'
> > check helps us bypass looking at current_kprobe.
> 
> Ah, I see. this is for checking "jprobes", since kprobes/kretprobes
> usually already done there.

Correct.

> 
> > 
> > The check also ensures we can use raw_cpu_read() safely in other 
> > scenarios. Do you see any other concerns with this approach?
> 
> Yes, there are 2 reasons.
> 
> At first, if user's custom kprobe pre-handler changes NIP for their
> custom handwriting livepatching, such handler will enable preemption
> before return. We don't prohibit it. I think this function can not
> detect it.

I thought about this quite a bit since we won't have a way to identify 
if the ftrace handler was a kprobe or a livepatch in such cases.  
Subsequently, I've concluded that this will _not_ be a problem for us.  
Here's why:
- The primary reason is_current_kprobe_addr() was added was to detect 
  jprobes. Jprobes is special since the alternate function does not do a 
  normal return, but uses jprobe_return()/trap to return from the 
  function. In this case, if we don't detect this, we end up needlessly 
  consuming the livepatch stack (the stack frames won't ever be 
  "popped").
- If a kprobe handler were to modify nip, it would likely reset 
  current_kprobe and re-enable pre-emption before returning. We won't be 
  able to detect this scenario. We will end up going through the 
  livepatch_handler(), allocating a stack, branching into the new nip, 
  return back from there and de-allocate the stack before going back.  
  This will be a bit in-efficient, but will work properly.
- Finally, if a custom kprobe handler were to simulate jprobes, it 
  cannot disable pre-emption or reset current_kprobe, since both are 
  needed for proper functioning.

As such, I think the current approach works fine for us.

> 
> And also, the function "name" is very confusing :)
> Especially, since this symbol is exported, if you are checking jprobes
> context, it should be renamed, at least it starts with "__" so that
> show it as local use.

Agreed. I think I will make suitable updates to specifically call out 
jprobes here.

Thanks for the review!
- Naveen
