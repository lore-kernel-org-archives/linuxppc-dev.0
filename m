Return-Path: <ananth@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMChc0jRHzF0gH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 03:48:31 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0HGlTC8081542
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 11:48:29 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fj7nj0jfe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 11:48:28 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@linux.vnet.ibm.com>;
 Wed, 17 Jan 2018 11:48:27 -0500
Date: Wed, 17 Jan 2018 22:18:22 +0530
From: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/kprobes: Fix call trace due to incorrect preempt
 count
Reply-To: ananth@linux.vnet.ibm.com
References: <20180117122224.19860-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180117122224.19860-1-naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <20180117164822.GA3932@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 17, 2018 at 05:52:24PM +0530, Naveen N. Rao wrote:
> Michael Ellerman reported the following call trace when running
> ftracetest:
> 
> BUG: using __this_cpu_write() in preemptible [00000000] code: ftracetest/6178
> caller is opt_pre_handler+0xc4/0x110
> CPU: 1 PID: 6178 Comm: ftracetest Not tainted 4.15.0-rc7-gcc6x-gb2cd1df #1
> Call Trace:
> [c0000000f9ec39c0] [c000000000ac4304] dump_stack+0xb4/0x100 (unreliable)
> [c0000000f9ec3a00] [c00000000061159c] check_preemption_disabled+0x15c/0x170
> [c0000000f9ec3a90] [c000000000217e84] opt_pre_handler+0xc4/0x110
> [c0000000f9ec3af0] [c00000000004cf68] optimized_callback+0x148/0x170
> [c0000000f9ec3b40] [c00000000004d954] optinsn_slot+0xec/0x10000
> [c0000000f9ec3e30] [c00000000004bae0] kretprobe_trampoline+0x0/0x10
> 
> This is showing up since OPTPROBES is now enabled with CONFIG_PREEMPT.
> 
> trampoline_probe_handler() considers itself to be a special kprobe
> handler for kretprobes. In doing so, it expects to be called from
> kprobe_handler() on a trap, and re-enables preemption before returning a
> non-zero return value so as to suppress any subsequent processing of the
> trap by the kprobe_handler().
> 
> However, with optprobes, we don't deal with special handlers (we ignore
> the return code) and just try to re-enable preemption causing the above
> trace.
> 
> To address this, modify trampoline_probe_handler() to not be special.
> The only additional processing done in kprobe_handler() is to emulate
> the instruction (in this case, a 'nop'). We adjust the value of
> regs->nip for the purpose and delegate the job of re-enabling
> preemption and resetting current kprobe to the probe handlers
> (kprobe_handler() or optimized_callback()).
> 
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
