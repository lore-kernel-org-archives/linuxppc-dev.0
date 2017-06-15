Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpS7N541JzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 01:28:00 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5FFOm3Z025220
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 11:27:58 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b3q4nr2p7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 11:27:57 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 16 Jun 2017 01:27:54 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5FFRqdi6160706
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 01:27:52 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5FFRgaS016603
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 01:27:43 +1000
Date: Thu, 15 Jun 2017 20:57:49 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 mingo@kernel.org, peterz@infradead.org, acme@kernel.org,
 alexander.shishkin@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64/perf: Fix oops when kthread execs user process
References: <1497534408-4591-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497534408-4591-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <20170615152749.GA2800@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/15 07:16PM, Ravi Bangoria wrote:
> When a kthread makes a call_usermodehelper() call the steps are:
>  a. allocates current->mm
>  b. load_elf_binary()
>  c. populates current->thread.regs
> 
> While doing this, interrupts are not disabled. If there is a perf
> interrupt in the middle of this process (i.e. step 'a' has completed
> but not yet reached to step 'c') and if perf tries to read userspace
> regs, kernel oops with following log:
> 
>   [  131.217172] Unable to handle kernel paging request for data at address 0x00000000
>   [  131.217731] Faulting instruction address: 0xc0000000000da0fc
>   ...
>   [  131.235555] Call Trace:
>   [  131.235714] [c0000000bbaaad60] [c00000000025dedc] perf_output_sample_regs+0x6c/0xd0
>   [  131.236020] [c0000000bbaaadb0] [c000000000269b44] perf_output_sample+0x4e4/0x830
>   [  131.236362] [c0000000bbaaae40] [c00000000026a354] perf_event_output_forward+0x64/0x90
>   [  131.236668] [c0000000bbaaaeb0] [c00000000026298c] __perf_event_overflow+0x8c/0x1e0
>   [  131.236979] [c0000000bbaaaf00] [c0000000000dc330] record_and_restart+0x220/0x5c0
>   [  131.237306] [c0000000bbaab230] [c0000000000dd1d8] perf_event_interrupt+0x2d8/0x4d0
>   [  131.237611] [c0000000bbaab320] [c0000000000294a4] performance_monitor_exception+0x54/0x70
>   [  131.237891] [c0000000bbaab350] [c00000000000a0a8] performance_monitor_common+0x158/0x160
>   [  131.238208] --- interrupt: f01 at avtab_search_node+0x150/0x1a0
>   [  131.238208]     LR = avtab_search_node+0x100/0x1a0
>   [  131.238617] [c0000000bbaab640] [c000000000526770] context_struct_compute_av+0x220/0x5b0 (unreliable)
>   [  131.238948] [c0000000bbaab730] [c0000000005278b4] security_compute_av+0x174/0x390
>   [  131.239231] [c0000000bbaab7e0] [c0000000005050e4] avc_compute_av+0x84/0x260
>   [  131.239471] [c0000000bbaab890] [c000000000506198] avc_has_perm+0xf8/0x1c0
>   [  131.239708] [c0000000bbaab980] [c00000000050f32c] file_has_perm+0x6c/0xd0
>   [  131.239972] [c0000000bbaab9e0] [c0000000004ff0fc] security_mmap_file+0xac/0x140
>   [  131.240256] [c0000000bbaaba50] [c0000000002b1fc0] vm_mmap_pgoff+0x80/0x160
>   [  131.240532] [c0000000bbaabb30] [c0000000003f7db4] elf_map+0xa4/0x180
>   [  131.240771] [c0000000bbaabb90] [c0000000003f9a48] load_elf_binary+0x6e8/0x15a0
>   [  131.241060] [c0000000bbaabc90] [c000000000374f58] search_binary_handler+0xe8/0x290
>   [  131.241347] [c0000000bbaabd20] [c000000000375c14] do_execveat_common.isra.14+0x5f4/0x840
>   [  131.241631] [c0000000bbaabdf0] [c00000000010be70] call_usermodehelper_exec_async+0x170/0x210
>   [  131.241955] [c0000000bbaabe30] [c00000000000bae0] ret_from_kernel_thread+0x5c/0x7c
> 
> Fix it by setting abi to PERF_SAMPLE_REGS_ABI_NONE when userspace
> pt_regs are not set. 

So, this only shows up with --call-graph=dwarf. This should be:
Fixes: 17ed7c38427ff8 ("powerpc: Add HAVE_PERF_USER_STACK_DUMP support")

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
> Note: this should go to stable as well. I've not checked below 4.4
> kernel but I'm able to reproduce it with 4.4 kernel.

Hmm... are you sure it's the same issue? The above commit only went into 
v4.7, which means we weren't able to use --call-graph=dwarf till v4.7.

Apart from that:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


- Naveen

> 
>  arch/powerpc/perf/perf_regs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
> index cbd82fd..09ceea6 100644
> --- a/arch/powerpc/perf/perf_regs.c
> +++ b/arch/powerpc/perf/perf_regs.c
> @@ -101,5 +101,6 @@ void perf_get_regs_user(struct perf_regs *regs_user,
>  			struct pt_regs *regs_user_copy)
>  {
>  	regs_user->regs = task_pt_regs(current);
> -	regs_user->abi  = perf_reg_abi(current);
> +	regs_user->abi = (regs_user->regs) ? perf_reg_abi(current) :
> +			 PERF_SAMPLE_REGS_ABI_NONE;
>  }
> -- 
> 2.9.4
> 
