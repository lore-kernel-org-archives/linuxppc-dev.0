Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtFkM4S5rzDqrC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 20:53:15 +1000 (AEST)
Date: Thu, 14 Sep 2017 03:53:12 -0700
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Kamalesh Babulal
 <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/5] powerpc/jprobes: Disable preemption when triggered
 through ftrace
Message-Id: <20170914035312.6750060c7790e31f7728fcef@kernel.org>
In-Reply-To: <20170914102539.3hnz3gtx5my4qm6g@naverao1-tp.localdomain>
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
 <12e85578f8c036d31a0c2197a8956cdb7e0f945b.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170913170549.00b607d35f9c754d4d2ca027@kernel.org>
 <20170914102539.3hnz3gtx5my4qm6g@naverao1-tp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Sep 2017 15:55:39 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On 2017/09/13 05:05PM, Masami Hiramatsu wrote:
> > On Thu, 14 Sep 2017 02:50:35 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> > > KPROBES_SANITY_TEST throws the below splat when CONFIG_PREEMPT is
> > > enabled:
> > > 
> > > [    3.140410] Kprobe smoke test: started
> > > [    3.149680] DEBUG_LOCKS_WARN_ON(val > preempt_count())
> > > [    3.149684] ------------[ cut here ]------------
> > > [    3.149695] WARNING: CPU: 19 PID: 1 at kernel/sched/core.c:3094 preempt_count_sub+0xcc/0x140
> > > [    3.149699] Modules linked in:
> > > [    3.149705] CPU: 19 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc7-nnr+ #97
> > > [    3.149709] task: c0000000fea80000 task.stack: c0000000feb00000
> > > [    3.149713] NIP:  c00000000011d3dc LR: c00000000011d3d8 CTR: c000000000a090d0
> > > [    3.149718] REGS: c0000000feb03400 TRAP: 0700   Not tainted  (4.13.0-rc7-nnr+)
> > > [    3.149722] MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE>  CR: 28000282  XER: 00000000
> > > [    3.149732] CFAR: c00000000015aa18 SOFTE: 0
> > > <snip>
> > > [    3.149786] NIP [c00000000011d3dc] preempt_count_sub+0xcc/0x140
> > > [    3.149790] LR [c00000000011d3d8] preempt_count_sub+0xc8/0x140
> > > [    3.149794] Call Trace:
> > > [    3.149798] [c0000000feb03680] [c00000000011d3d8] preempt_count_sub+0xc8/0x140 (unreliable)
> > > [    3.149804] [c0000000feb036e0] [c000000000046198] kprobe_handler+0x228/0x4b0
> > > [    3.149810] [c0000000feb03750] [c0000000000269c8] program_check_exception+0x58/0x3b0
> > > [    3.149816] [c0000000feb037c0] [c00000000000903c] program_check_common+0x16c/0x170
> > > [    3.149822] --- interrupt: 0 at kprobe_target+0x8/0x20
> > >                    LR = init_test_probes+0x248/0x7d0
> > > [    3.149829] [c0000000feb03ab0] [c000000000e4f048] kp+0x0/0x80 (unreliable)
> > > [    3.149835] [c0000000feb03b10] [c00000000004ea60] livepatch_handler+0x38/0x74
> > > [    3.149841] [c0000000feb03ba0] [c000000000d0de54] init_kprobes+0x1d8/0x208
> > > [    3.149846] [c0000000feb03c40] [c00000000000daa8] do_one_initcall+0x68/0x1d0
> > > [    3.149852] [c0000000feb03d00] [c000000000ce44f0] kernel_init_freeable+0x298/0x374
> > > [    3.149857] [c0000000feb03dc0] [c00000000000dd84] kernel_init+0x24/0x160
> > > [    3.149863] [c0000000feb03e30] [c00000000000bfec] ret_from_kernel_thread+0x5c/0x70
> > > [    3.149867] Instruction dump:
> > > [    3.149871] 419effdc 3d22001b 39299240 81290000 2f890000 409effc8 3c82ffcb 3c62ffcb
> > > [    3.149879] 3884bc68 3863bc18 4803d5fd 60000000 <0fe00000> 4bffffa8 60000000 60000000
> > > [    3.149890] ---[ end trace 432dd46b4ce3d29f ]---
> > > [    3.166003] Kprobe smoke test: passed successfully
> > > 
> > > The issue is that we aren't disabling preemption in
> > > kprobe_ftrace_handler(). Disable it.
> > 
> > Oops, right! Similar patch may need for x86 too.
> 
> Indeed, I will send a patch for that.
> 
> On a related note, I've been looking into why we have !PREEMPT for 
> CONFIG_OPTPROBES. It looks like the primary reason is x86 having to deal 
> with replacing multiple instructions. However, that isn't true with arm 
> and powerpc. So, does it make sense to move 'depends on !PREEMPT' to the 
> x86 code? Are there other scenarios where it might cause issues for 
> arm/powerpc?

Indeed! Whuat I expected was to replace several instructions in RISC processors
for jumping far site (like load & jump), but you chose different approach.
So there is no reason to prehibit that.

Thanks!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
