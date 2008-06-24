Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3FC0DDFD5
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 08:21:59 +1000 (EST)
Subject: Re: Exit points for returning from kernel mode to user mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mitesh <miteshnet@hotmail.com>
In-Reply-To: <BAY124-DS415CCF7A303D59AD03437BEA10@phx.gbl>
References: <BAY124-DS415CCF7A303D59AD03437BEA10@phx.gbl>
Content-Type: text/plain
Date: Wed, 25 Jun 2008 08:21:51 +1000
Message-Id: <1214346111.8011.374.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-06-24 at 15:22 -0600, Mitesh wrote:
>  I am trying to understand exit points from kernel mode to user mode.
> I believe this happens when the scheduler is invoked, there are
> interrupts, exceptions, or the kernel is executing system call in
> process context. 
>  
> Is there a single function which is called in the ppc kernel when the
> mode is switched back to user mode ? 
>  
> I have linux 2.6.16.21 kernel running on a 4-way p550 IBM pSeries with
> POWER5 processors. Everytime before a process begins executing in user
> mode I want to execute a special SMT thread priority assembler
> instruction. 
>  
> What code files should I be looking at, is there one place this can be
> done? Any tips are appreciated.

You need to look for the code path that returns from an interrupt (ie.
that includes system call exceptions).

There are actually a few flavours of this for 64 bits:

 - If the interrupt is an SLB miss, this is a fairly fast path,
all assembly, all in real mode. However, it doesn't have any existing
code to differenciate return to userspace or return to the kernel. This
is in head_64.S, function slb_miss_realmode.

 - There is similar code for STAB exceptions (pre-POWER4 machines)

 - fast_exception_return, still in head_64.S, is used for short
exceptions that don't change the interrupt or scheduling status of the
task, such as servicing an FP or VMX unavailable interrupt. Note that
this can be used to return to the kernel as well as userspace. There is
some conditional code for user (look at the virt CPU accounting bits)
but it's a fair way before the actual rfid.

 - in entry_64.S, the main syscall exit path when there is no "work"
(ie, no pending signal, no need to schedule, ...) which is some way
after the "syscall_error_cont:" label.

 - same file, some way after the "restore:" label, this is the "main"
path when returning from an interrupt (ie, all the cases not above).


Cheers,
Ben.
