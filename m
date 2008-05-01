Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18457.32297.485053.356477@cargo.ozlabs.ibm.com>
Date: Thu, 1 May 2008 18:24:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
In-Reply-To: <A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<18457.1279.401197.763726@cargo.ozlabs.ibm.com>
	<A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
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

> > It depends on whether a critical or machine check handler can ever do
> > anything to generate a signal or a reschedule.  If they can't, then
> > there is no problem.
> 
> They can if the come from user space.  I'm question what it means to  
> send a signal based on receiving an async exception.

The most common cases are (a) something that ultimately generates
input on a tty (e.g. a character arriving on a serial port) and that
input turns out to be a ^C or similar, or (b) something that signals
I/O completion and the program doing the I/O has requested
notification by a SIGIO.  But in general any driver code can send a
signal to userspace if it wants.

> > If they can, then we have to be very careful.  If a critical or
> > machine check happens at a point where normal interrupts are disabled
> > then we have to be extremely careful not to do anything that the code
> > we've interrupted assumes can't happen - so we'd better not try to
> > take any spinlocks, for example.  That severely limits what the
> > handler can do.  It probably shouldn't even call printk, for
> > instance, or wake any process up, and definitely shouldn't call
> > schedule (or schedule_preempt) on the way out.
> 
> how do we provide someone stick a kprobe on such code today?

-ENOPARSE

> So I'm not if there is any good way to preclude the handlers  
> associated with these exceptions from doing the things you listed.

In that case, you'd better expect to see system freezes, memory
corruption and general instability.

Paul.
