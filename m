Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7111DDEFE
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 03:49:07 +1000 (EST)
Message-Id: <17325743-606C-4B3D-88C0-2D0B7902B4E1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080501164228.GA17992@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
Date: Thu, 1 May 2008 12:48:55 -0500
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<18457.1279.401197.763726@cargo.ozlabs.ibm.com>
	<A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
	<18457.32297.485053.356477@cargo.ozlabs.ibm.com>
	<2DF41779-732B-4477-9DAC-147CDC5C9885@kernel.crashing.org>
	<20080501161451.GH17142@ld0162-tx32.am.freescale.net>
	<78125A27-D99A-447D-9C65-4705DD153567@kernel.crashing.org>
	<20080501164228.GA17992@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2008, at 11:42 AM, Scott Wood wrote:

> On Thu, May 01, 2008 at 11:33:34AM -0500, Kumar Gala wrote:
>> Let me ask the question differently.  Are there cases that some event
>> occurs in the system and a signal is delivered to the current process
>> regardless of what that process is.
>
> Yes, timers that expire based on CPU usage.
>
>> I'm guessing so, based on the tty example.
>
> I don't think tty interrupts would -- it'd go to the process group
> associated with the tty.
>
>> So for the specific case I'm looking at (kprobes & debug exceptions
>> from kernel space), I think its reasonable to BUG_ON() if  
>> thread_info-
>>> flags changes such that TIF_SIGPENDING or TIF_NEED_RESCHED get set
>> we aren't from user-space.
>
> Why?  It may not happen currently, but it seems more future-proof to  
> just
> copy the flags.  And it's certainly not reasonable for normal  
> interrupts.

copying the flags isn't the issue.  Its acting on the flags thats the  
problem.  I'm not 100% sure the C code that might clear the flags is  
consistent on how it access them.  So if one bit of code clears  
task_struct->stack->thread_info->flags and other clears  
thread_info(STACK)->flags we get into an issue on how to merge after  
that.

I'd rather be safe for now since we don't need to send a signal in the  
debug from kernel case.

- k
