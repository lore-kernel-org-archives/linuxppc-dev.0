Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 722AEDDE0F
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 23:17:15 +1000 (EST)
Message-Id: <2DF41779-732B-4477-9DAC-147CDC5C9885@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18457.32297.485053.356477@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
Date: Thu, 1 May 2008 08:17:07 -0500
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<18457.1279.401197.763726@cargo.ozlabs.ibm.com>
	<A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
	<18457.32297.485053.356477@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2008, at 3:24 AM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>>> It depends on whether a critical or machine check handler can ever  
>>> do
>>> anything to generate a signal or a reschedule.  If they can't, then
>>> there is no problem.
>>
>> They can if the come from user space.  I'm question what it means to
>> send a signal based on receiving an async exception.
>
> The most common cases are (a) something that ultimately generates
> input on a tty (e.g. a character arriving on a serial port) and that
> input turns out to be a ^C or similar, or (b) something that signals
> I/O completion and the program doing the I/O has requested
> notification by a SIGIO.  But in general any driver code can send a
> signal to userspace if it wants.

ok.  Was just wondering how the async exception know that the signal  
it wanted to send belonged to the particular process that is running.   
But I guess there are cases that the signal is really intended for who  
ever is currently running?

>>> If they can, then we have to be very careful.  If a critical or
>>> machine check happens at a point where normal interrupts are  
>>> disabled
>>> then we have to be extremely careful not to do anything that the  
>>> code
>>> we've interrupted assumes can't happen - so we'd better not try to
>>> take any spinlocks, for example.  That severely limits what the
>>> handler can do.  It probably shouldn't even call printk, for
>>> instance, or wake any process up, and definitely shouldn't call
>>> schedule (or schedule_preempt) on the way out.

Do we ensure that synchronous exceptions will not occur in these cases  
that kernel code things interrupts are disabled in?

>> how do we provide someone stick a kprobe on such code today?
>
> -ENOPARSE

I was asking how we prevent the cases you were describing working w/ 
kprobes today.  Since it ends up single stepping in kernel codes its  
possible that someone sets a kprobe in code that shouldn't be  
interrupted, yet we'd cause a SingleStep Exception.

>> So I'm not if there is any good way to preclude the handlers
>> associated with these exceptions from doing the things you listed.
>
> In that case, you'd better expect to see system freezes, memory
> corruption and general instability.

So the case I'm trying to make work is debug and kprobes.  This case  
seems like we have pretty good control over what the "handler" does.   
Are there checks we can add to BUG_ON() so we are at least aware of  
the code attempts to do something it shouldnt?

- k
