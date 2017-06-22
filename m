Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtf1t6jZbzDqkM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 21:07:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/6] powerpc/64s: Blacklist system_call() and
 system_call_common() from kprobes
In-Reply-To: <20170622133640.66861cda@roar.ozlabs.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <e602b626323ee22ac39de305b62385a2a0210018.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170622133640.66861cda@roar.ozlabs.ibm.com>
Date: Thu, 22 Jun 2017 21:07:46 +1000
Message-ID: <87a850s2kd.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Thu, 22 Jun 2017 00:08:39 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>
>> Convert some of the symbols into private symbols and blacklist
>> system_call_common() and system_call() from kprobes. We can't take a
>> trap at parts of these functions as either MSR_RI is unset or the kernel
>> stack pointer is not yet setup.
>> 
>> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>
> I don't have a problem with this bunch of system call labels
> going private. They've never added much for me in profiles.
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>
> Semi-related question, why is system_call: where it is?

Ancient history.

We used to have:

	bne	syscall_dotrace
syscall_dotrace_cont:
	cmpldi	0,r0,NR_syscalls
	bge-	syscall_enosys

system_call:			/* label this so stack traces look sane */


So it was there to hide syscall_dotrace_cont from back traces.

But we made syscall_dotrace_cont local in 2012 and then removed it
entirely in 2015.

> Should we move it up to right after the mtmsrd / wrteei instruction?
> (obviously for another patch). It's pretty common to get PMU
> interrupts coming in right after mtmsr and this makes profiles split
> the syscall into two which is annoying.

Move it wherever makes sense and gives good back traces.

cheers
