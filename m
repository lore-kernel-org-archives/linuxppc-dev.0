Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNJJN31qvzDqms
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 22:19:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: ananth@linux.vnet.ibm.com,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/kprobes: Fix call trace due to incorrect preempt
 count
In-Reply-To: <20180117164822.GA3932@in.ibm.com>
References: <20180117122224.19860-1-naveen.n.rao@linux.vnet.ibm.com>
 <20180117164822.GA3932@in.ibm.com>
Date: Fri, 19 Jan 2018 22:19:41 +1100
Message-ID: <87bmhqayeq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com> writes:

> On Wed, Jan 17, 2018 at 05:52:24PM +0530, Naveen N. Rao wrote:
>> Michael Ellerman reported the following call trace when running
>> ftracetest:
>> 
>> BUG: using __this_cpu_write() in preemptible [00000000] code: ftracetest/6178
>> caller is opt_pre_handler+0xc4/0x110
>> CPU: 1 PID: 6178 Comm: ftracetest Not tainted 4.15.0-rc7-gcc6x-gb2cd1df #1
>> Call Trace:
>> [c0000000f9ec39c0] [c000000000ac4304] dump_stack+0xb4/0x100 (unreliable)
>> [c0000000f9ec3a00] [c00000000061159c] check_preemption_disabled+0x15c/0x170
>> [c0000000f9ec3a90] [c000000000217e84] opt_pre_handler+0xc4/0x110
>> [c0000000f9ec3af0] [c00000000004cf68] optimized_callback+0x148/0x170
>> [c0000000f9ec3b40] [c00000000004d954] optinsn_slot+0xec/0x10000
>> [c0000000f9ec3e30] [c00000000004bae0] kretprobe_trampoline+0x0/0x10
>> 
>> This is showing up since OPTPROBES is now enabled with CONFIG_PREEMPT.
>> 
>> trampoline_probe_handler() considers itself to be a special kprobe
>> handler for kretprobes. In doing so, it expects to be called from
>> kprobe_handler() on a trap, and re-enables preemption before returning a
>> non-zero return value so as to suppress any subsequent processing of the
>> trap by the kprobe_handler().
>> 
>> However, with optprobes, we don't deal with special handlers (we ignore
>> the return code) and just try to re-enable preemption causing the above
>> trace.
>> 
>> To address this, modify trampoline_probe_handler() to not be special.
>> The only additional processing done in kprobe_handler() is to emulate
>> the instruction (in this case, a 'nop'). We adjust the value of
>> regs->nip for the purpose and delegate the job of re-enabling
>> preemption and resetting current kprobe to the probe handlers
>> (kprobe_handler() or optimized_callback()).
>> 
>> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>
> Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>

Fixes: 51c9c0843993 ("powerpc/kprobes: Implement Optprobes")

??

cheers
