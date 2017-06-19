Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrqqk5Tm2zDqgp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:22:42 +1000 (AEST)
In-Reply-To: <1497534408-4591-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, acme@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 alexander.shishkin@linux.intel.com, paulus@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org
Subject: Re: ppc64/perf: Fix oops when kthread execs user process
Message-Id: <3wrqqk4YKVz9s9N@ozlabs.org>
Date: Mon, 19 Jun 2017 22:22:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-15 at 13:46:48 UTC, Ravi Bangoria wrote:
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
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/bf05fc25f268cd62f147f368fe65ad

cheers
