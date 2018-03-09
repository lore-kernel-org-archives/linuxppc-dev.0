Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyNq10XyyzF1q2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2018 21:27:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 1/1] powerpc/ftrace: Exclude real mode code from
In-Reply-To: <1520581934.wrzeu3w6z6.naveen@linux.ibm.com>
References: <cover.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <ecbf7e8d6895a7d56b4eb60cbf7461bd463086b3.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <87efkve0a2.fsf@concordia.ellerman.id.au>
 <1520581934.wrzeu3w6z6.naveen@linux.ibm.com>
Date: Fri, 09 Mar 2018 21:27:07 +1100
Message-ID: <87ina5v91g.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> Michael Ellerman wrote:
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> 
>>> We can't take a trap in most parts of real mode code. Instead of adding
>>> the 'notrace' annotation to all C functions that can be invoked from
>>> real mode, detect that we are in real mode on ftrace entry and return
>>> back.
>>>
>>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>> ---
>>> This RFC only handles -mprofile-kernel to demonstrate the approach being 
>>> considered. We will need to handle other ftrace entry if we decide to 
>>> continue down this path.
>> 
>> Paul and I were talking about having a paca flag for this, ie.
>> paca->safe_to_ftrace (or whatever). I'm not sure if you've talked to
>> him and decided this is a better approach.
>> 
>> I guess I'm 50/50 on which is better, they both have pluses and minuses.
>
> Thanks, I hadn't spoken to Paul, but I now think that this is probably 
> the better approach to take.

OK.

> My earlier assumption was that we have other scenarios when we are in 
> realmode (specifically with MSR_RI unset) where we won't be able to 
> recover from a trap, during function tracing (*). I did a set of 
> experiments yesterday to verify that, but I was not able to uncover any 
> such scenarios with my brief testing. So, we seem to be functioning just 
> fine while tracing realmode C code, except for KVM.

Hmm. If MSR_RI is clear then that should indicate that you can't recover
from an interrupt, typically because you'd lose state in SRR0/1. So I
would expect things to go badly in that case.

But that's sort of orthogonal to real mode. Real mode is different and
we do need to be careful, but a blanket ban on tracing in real mode
might be too broad.

The problem with KVM is that you're running in real mode (MMU off), in
the host kernel, but with the MMU context of the guest loaded. So if you
do anything that turns the MMU on, like a WARN_ON(), then all of a
sudden you're running guest kernel code.

> As such, rather than blacklisting all realmode code, I think it is 
> better to be selective and just disable the tracer for KVM since we know 
> we can't take a trap there. We will be able to use the same approach if 
> we uncover additional scenarios where we can't use function tracing. I 
> will look at implementing a paca field for this purpose.

Thanks. I think it could work well.

We could also use it during early boot, ie. the flag starts out false,
and in the kexec/kdump path as well.

cheers
