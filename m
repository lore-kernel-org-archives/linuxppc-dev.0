Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18458.21372.757211.450855@cargo.ozlabs.ibm.com>
Date: Fri, 2 May 2008 09:34:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
In-Reply-To: <2DF41779-732B-4477-9DAC-147CDC5C9885@kernel.crashing.org>
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<18457.1279.401197.763726@cargo.ozlabs.ibm.com>
	<A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
	<18457.32297.485053.356477@cargo.ozlabs.ibm.com>
	<2DF41779-732B-4477-9DAC-147CDC5C9885@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> ok.  Was just wondering how the async exception know that the signal  
> it wanted to send belonged to the particular process that is running.   

Usually the driver would have a reference to the task_struct of the
task that should get the signal, and it would send the signal to that
task, rather than the current task.  That task could be the current
task, of course, but it might not be.

I can't think of a case where an asynchronous interrupt would always
result in a signal being sent to the current task.

> >> how do we provide someone stick a kprobe on such code today?
> >
> > -ENOPARSE
> 
> I was asking how we prevent the cases you were describing working w/ 
> kprobes today.  Since it ends up single stepping in kernel codes its  
> possible that someone sets a kprobe in code that shouldn't be  
> interrupted, yet we'd cause a SingleStep Exception.

I'd have to look more closely at the kprobes code to answer that in
detail.  I assume the kprobes exception handlers are sufficiently
careful about what they do because they are aware they could have
interrupted interrupt-disabled code.

> >> So I'm not if there is any good way to preclude the handlers
> >> associated with these exceptions from doing the things you listed.
> >
> > In that case, you'd better expect to see system freezes, memory
> > corruption and general instability.
> 
> So the case I'm trying to make work is debug and kprobes.  This case  
> seems like we have pretty good control over what the "handler" does.   
> Are there checks we can add to BUG_ON() so we are at least aware of  
> the code attempts to do something it shouldnt?

Well, there's in_interrupt(), and there's the __kprobes marking, which
is used to mark functions where kprobes must not put a breakpoint.
Apart from that I would need to read through the kprobes code to
comment further...

Paul.
