Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySP9F3KxdzDr6C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 23:12:33 +1100 (AEDT)
In-Reply-To: <3174d2c573d0ab29c3894bc9b09aa14a53578302.1509374094.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/2] Revert "powerpc64/elfv1: Only dereference function
 descriptor for non-text symbols"
Message-Id: <3ySP9D69yVz9t2l@ozlabs.org>
Date: Thu,  2 Nov 2017 23:12:32 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-30 at 15:12:08 UTC, "Naveen N. Rao" wrote:
> This reverts commit 83e840c770f2c5 ("powerpc64/elfv1: Only dereference
> function descriptor for non-text symbols").
> 
> Chandan reported that on newer kernels, trying to enable function_graph
> tracer on ppc64 (BE) locks up the system with the following trace:
> 
>   Unable to handle kernel paging request for data at address 0x600000002fa30010
>   Faulting instruction address: 0xc0000000001f1300
>   Thread overran stack, or stack corrupted
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   BE SMP NR_CPUS=2048 DEBUG_PAGEALLOC NUMA pSeries
>   Modules linked in:
>   CPU: 1 PID: 6586 Comm: bash Not tainted 4.14.0-rc3-00162-g6e51f1f-dirty #20
>   task: c000000625c07200 task.stack: c000000625c07310
>   NIP:  c0000000001f1300 LR: c000000000121cac CTR: c000000000061af8
>   REGS: c000000625c088c0 TRAP: 0380   Not tainted  (4.14.0-rc3-00162-g6e51f1f-dirty)
>   MSR:  8000000000001032 <SF,ME,IR,DR,RI>  CR: 28002848  XER: 00000000
>   CFAR: c0000000001f1320 SOFTE: 0
>   GPR00: c000000000121cac c000000625c08b40 c000000001439700 c00000000125c5a8
>   GPR04: c0000000013a0040 c00000000135cbf0 0000000000000000 0000000000000000
>   GPR08: e92d0250812a1a30 e92d025081291a30 600000002fa30000 c000000625c08c50
>   GPR12: 0000000028002842 c00000000fd40580 000000010bacae64 ffffffffffffffff
>   GPR16: 000000010bac96c8 0000000000000000 0000000000000000 0000000000000000
>   GPR20: 0000000000000000 0000000000000000 000000010bac0734 000000000000000a
>   GPR24: 0000000000000000 c000000636cd6610 c000000113258b80 0000000000000000
>   GPR28: c000000000061b10 c000000000061960 c00000000125c5d8 c0000000013a0040
>   NIP [c0000000001f1300] .__is_insn_slot_addr+0x30/0x90
>   LR [c000000000121cac] .kernel_text_address+0x18c/0x1c0
>   Call Trace:
>   [c000000625c08b40] [c0000000001bd040] .is_module_text_address+0x20/0x40 (unreliable)
>   [c000000625c08bc0] [c000000000121cac] .kernel_text_address+0x18c/0x1c0
>   [c000000625c08c50] [c000000000061960] .prepare_ftrace_return+0x50/0x130
>   [c000000625c08cf0] [c000000000061b10] .ftrace_graph_caller+0x14/0x34
>   [c000000625c08d60] [c000000000121b40] .kernel_text_address+0x20/0x1c0
>   [c000000625c08df0] [c000000000061960] .prepare_ftrace_return+0x50/0x130
>   ...
>   [c000000625c0ab30] [c000000000061960] .prepare_ftrace_return+0x50/0x130
>   [c000000625c0abd0] [c000000000061b10] .ftrace_graph_caller+0x14/0x34
>   [c000000625c0ac40] [c000000000121b40] .kernel_text_address+0x20/0x1c0
>   [c000000625c0acd0] [c000000000061960] .prepare_ftrace_return+0x50/0x130
>   [c000000625c0ad70] [c000000000061b10] .ftrace_graph_caller+0x14/0x34
>   [c000000625c0ade0] [c000000000121b40] .kernel_text_address+0x20/0x1c0
>   Instruction dump:
>   7c0802a6 fbc1fff0 fbe1fff8 f8010010 f821ff81 7c7e1b78 7c9f2378 60000000
>   60000000 e95e0031 7faaf040 419e0028 <e92a0010> 7fa9f840 3d090001 7ebf4040
>   ---[ end trace 0870d7d56d703ff4 ]---
> 
> This is because ftrace is using ppc_function_entry() for obtaining the
> address of return_to_handler() in prepare_ftrace_return(). The call to
> kernel_text_address() itself gets traced and we end up in a recursive
> loop.
> 
> Reported-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/63be1a81e40733ecd175713b6a7558

cheers
