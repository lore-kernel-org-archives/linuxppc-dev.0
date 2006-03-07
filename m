Return-Path: <SRS0+dbec145124743c04f3c9+926+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87B24679E0
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Mar 2006 10:36:09 +1100 (EST)
Subject: Re: signal/syscall/swapcontext fixes
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17421.62535.805543.661898@cargo.ozlabs.ibm.com>
References: <17421.32092.442696.49291@cargo.ozlabs.ibm.com>
	<1141736951.4110.167.camel@pmac.infradead.org>
	<17421.62535.805543.661898@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 23:36:40 +0000
Message-Id: <1141774601.29552.31.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-03-08 at 07:59 +1100, Paul Mackerras wrote:
> David Woodhouse writes:
> 
> > The 64-bit version (bl .save_nvgprs) is prettier than the 32-bit version
> > (doing it longhand), and they're still gratuitously different. We should
> > probably fix that.
> 
> There's also the difference where ret_from_except in 32-bit does what
> ret_from_except_lite does in 64-bit, and the 32-bit
> ret_from_except_full is approximately the same as the 64-bit
> ret_from_except. :)

Oh yeah -- I remember that now :)

> > On a similar note, we should also do a ptrace stop when we deliver
> > signals, to ensure that the debugger gets a stop _on_ the first
> > instruction of the handler. Once upon a time there was a stop in
> > handle_rt_signal() and handle_signal(), but doing it that way gave a
> > _double_ stop when we ended up in a signal handler from sigsuspend(),
> > because the syscall stop you just fixed for ppc32 happened too.
> 
> Do we have a fix for this for 2.6.16, or will we leave it until
> 2.6.17?

It's hardly a showstopper -- I suspect we can happily leave it for now.
Adding the stops back where they were isn't perfect, and I thought I had
a better plan when I removed them. Buggered if I can remember it now
though.

> > On a purely cosmetic note I'm not sure about this though -- it was
> > slightly easier to follow when it was more explicit:
> > -       andi.   r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL|_TIF_SAVE_NVGPRS|_TIF_NOERROR|_TIF_RESTORE_SIGMASK)
> > +       andi.   r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
> 
> I did it that way because we are clearing _TIF_PERSYSCALL_MASK further
> down.  If we expand one we should expand both.

Yeah, I suppose you're right.

-- 
dwmw2
