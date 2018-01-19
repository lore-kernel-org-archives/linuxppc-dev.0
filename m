Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNJj557rDzF0bh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 22:37:45 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0JBZMUY145557
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 06:37:41 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fke35cpnk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 06:37:40 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 19 Jan 2018 11:37:39 -0000
Date: Fri, 19 Jan 2018 17:07:34 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/kprobes: Fix call trace due to incorrect preempt
 count
To: ananth@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180117122224.19860-1-naveen.n.rao@linux.vnet.ibm.com>
 <20180117164822.GA3932@in.ibm.com> <87bmhqayeq.fsf@concordia.ellerman.id.au>
In-Reply-To: <87bmhqayeq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1516361701.t6a4isef65.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com> writes:
>=20
>> On Wed, Jan 17, 2018 at 05:52:24PM +0530, Naveen N. Rao wrote:
>>> Michael Ellerman reported the following call trace when running
>>> ftracetest:
>>>=20
>>> BUG: using __this_cpu_write() in preemptible [00000000] code: ftracetes=
t/6178
>>> caller is opt_pre_handler+0xc4/0x110
>>> CPU: 1 PID: 6178 Comm: ftracetest Not tainted 4.15.0-rc7-gcc6x-gb2cd1df=
 #1
>>> Call Trace:
>>> [c0000000f9ec39c0] [c000000000ac4304] dump_stack+0xb4/0x100 (unreliable=
)
>>> [c0000000f9ec3a00] [c00000000061159c] check_preemption_disabled+0x15c/0=
x170
>>> [c0000000f9ec3a90] [c000000000217e84] opt_pre_handler+0xc4/0x110
>>> [c0000000f9ec3af0] [c00000000004cf68] optimized_callback+0x148/0x170
>>> [c0000000f9ec3b40] [c00000000004d954] optinsn_slot+0xec/0x10000
>>> [c0000000f9ec3e30] [c00000000004bae0] kretprobe_trampoline+0x0/0x10
>>>=20
>>> This is showing up since OPTPROBES is now enabled with CONFIG_PREEMPT.
>>>=20
>>> trampoline_probe_handler() considers itself to be a special kprobe
>>> handler for kretprobes. In doing so, it expects to be called from
>>> kprobe_handler() on a trap, and re-enables preemption before returning =
a
>>> non-zero return value so as to suppress any subsequent processing of th=
e
>>> trap by the kprobe_handler().
>>>=20
>>> However, with optprobes, we don't deal with special handlers (we ignore
>>> the return code) and just try to re-enable preemption causing the above
>>> trace.
>>>=20
>>> To address this, modify trampoline_probe_handler() to not be special.
>>> The only additional processing done in kprobe_handler() is to emulate
>>> the instruction (in this case, a 'nop'). We adjust the value of
>>> regs->nip for the purpose and delegate the job of re-enabling
>>> preemption and resetting current kprobe to the probe handlers
>>> (kprobe_handler() or optimized_callback()).
>>>=20
>>> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
>>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>
>> Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
>=20
> Fixes: 51c9c0843993 ("powerpc/kprobes: Implement Optprobes")

Fixes: 8a2d71a3f2737e ("powerpc/kprobes: Disable preemption before=20
invoking probe handler for optprobes")

I think this is more appropriate. I should have caught this issue with=20
kretprobes, but I am fairly certain that I ran ftracetest at that point,
but didn't see any call traces.

Regards,
Naveen

=
