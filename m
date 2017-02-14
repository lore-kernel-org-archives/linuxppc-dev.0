Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN27w3hbxzDqy5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:40:28 +1100 (AEDT)
In-Reply-To: <1486547452-13510-2-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, paulus@samba.org,
 mhiramat@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com
Subject: Re: [v4,1/2] arch/powerpc: Implement Optprobes
Message-Id: <3vN27w1vFGz9s74@ozlabs.org>
Date: Tue, 14 Feb 2017 23:40:28 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-08 at 09:50:51 UTC, Anju T wrote:
> Current infrastructure of kprobe uses the unconditional trap instruction
> to probe a running kernel. Optprobe allows kprobe to replace the trap with
> a branch instruction to a detour buffer. Detour buffer contains instructions
> to create an in memory pt_regs. Detour buffer also has a call to
> optimized_callback() which in turn call the pre_handler().
> After the execution of the pre-handler, a call is made for instruction
> emulation. The NIP is determined in advanced through dummy instruction
> emulation and a branch instruction is created to the NIP at the end of
> the trampoline.
> 
> To address the limitation of branch instruction in POWER architecture,
> detour buffer slot is allocated from a reserved area. For the time being,
> 64KB is reserved in memory for this purpose.
> 
> Instructions which can be emulated using analyse_instr() are the candidates
> for optimization. Before optimization ensure that the address range
> between the detour buffer allocated and the instruction being probed
> is within +/- 32MB.
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/51c9c0843993528bffc920c54c2121

cheers
