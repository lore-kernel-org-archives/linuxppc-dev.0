Return-Path: <mhiramat@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 812BADDED8
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 21:53:59 +1100 (EST)
Message-ID: <49C375B7.5090806@redhat.com>
Date: Fri, 20 Mar 2009 06:53:43 -0400
From: Masami Hiramatsu <mhiramat@redhat.com>
MIME-Version: 1.0
To: ananth@in.ibm.com
Subject: Re: [RFC][PATCH -tip 4/9] power: add kernel_trap_sp()
References: <49C2B4BF.4080904@redhat.com> <1237527760.25062.567.camel@pasglop>
	<20090320073334.GA10519@in.ibm.com>
In-Reply-To: <20090320073334.GA10519@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linuxppc-dev@ozlabs.org, systemtap-ml <systemtap@sources.redhat.com>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ananth N Mavinakayanahalli wrote:
> On Fri, Mar 20, 2009 at 04:42:40PM +1100, Benjamin Herrenschmidt wrote:
>> On Thu, 2009-03-19 at 17:10 -0400, Masami Hiramatsu wrote:
>>> Add kernel_trap_sp() on powerpc, based on systemtap's runtime/regs.h.
>>>
>>> Signed-off-by: Masami Hiramatsu <mhiramat@redhat.com>
>> I haven't looked at the usage of it, but it's weird to have something
>> call "kernel_trap_sp" that returns the -user- stack pointer... is
>> this really what's expected here ?
> 
> In the current usage scenario, this gets called only with a pt_regs
> snapshot from in kernel. user_stack_pointer() is a misnomer though;
> all this macro needs is to return the stack pointer from the given
> pt_regs.

Indeed,
I expect kernel_trap_sp() returns the top of stack from pt_regs in the kernel.
Why I'm using user_stack_pointer() for kernel_trap_sp() is just that the
definitions of both are same...

Perhaps, should I define as below, even it is same as user_stack_pointer()?
#define kernel_trap_sp(regs) ((regs)->gpr[1])

Thank you,

> 
> Ananth
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Masami Hiramatsu

Software Engineer
Hitachi Computer Products (America) Inc.
Software Solutions Division

e-mail: mhiramat@redhat.com
