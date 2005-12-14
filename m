Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17312.38814.551675.906916@cargo.ozlabs.ibm.com>
Date: Thu, 15 Dec 2005 09:07:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1134569118.3875.9.camel@localhost>
References: <1134569118.3875.9.camel@localhost>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: illegal instructions / irqs disabled warning
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> So I run across this warning: 
> [ 2724.595549] Debug: sleeping function called from invalid context at arch/ppc/kernel/traps.c:528
> [ 2724.595563] in_atomic():0, irqs_disabled():1

Hmmm.  What kernel version is this?  I assume you are using ARCH=ppc,
is that right?

> But here's the actual question:
> static inline unsigned long __copy_from_user(void *to,
>                 const void __user *from, unsigned long size)
> 
>         might_sleep();
>         return __copy_from_user_inatomic(to, from, size);
> 
> 
> Does that mean __copy_from_user_inatomic isn't actually valid to call in
> atomic context?

No, it doesn't mean that.  However, if the page isn't in memory,
__copy_from_user_inatomic won't try to bring it in if it has been
called from an atomic context (i.e. preempt or interrupts disabled).

The real question is why we have interrupts disabled in the illegal
instruction handler.  There was a reason why I wanted interrupts
disabled on entry to program_check_exception which I don't recall
clearly at the moment, but I think program_check_exception should be
doing a local_irq_enable() at some point (and it also shouldn't be
trying to emulate instructions for the kernel).

Paul.
