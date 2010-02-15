Return-Path: <anton@ozlabs.org>
Date: Mon, 15 Feb 2010 15:06:57 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Don't clear larx reservation on system call exit
Message-ID: <20100215040657.GA24270@kryten>
References: <20100215014028.GB13355@kryten>
	<1266200687.16346.110.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1266200687.16346.110.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi Ben,

> Well, the main issue here is leaking kernel reservations into userspace,
> and thus the question of whether it is a big deal or not. There's also
> an issue I can see with signals.
> 
> The risk with kernel reservations leaking into userspace is a problem on
> some processors that do not compare the reservation address locally
> (only for snoops), thus userspace code doing lwarx/syscall/stwcx. might
> end up with a suceeding stwcx. despite the fact that the original
> reservation was long lost. 

Yeah that was my primary concern. Right now these things fail 100%, so
no one is relying on it. The worry is if people start writing their own
crazy low level system call + locking stubs that might work most of the
time (if we remove the stwcx in syscall exit).

> At this stage it becomes an ABI problem, ie, whether we define the
> behaviour of a lwarx/stwcx. accross a syscall as defined or not.
> 
> The other problem I see is that signal handlers would have to be made
> very careful not to leave dangling reservations since the return from
> the syscall is a syscall, unless we add code specifically to this (and
> set_context too I'd say) to clear reservations.
> 
> IE. You could have something like:
> 
> lwarx, <interrupt>, signal handler, sigreturn, stwcx.
> 
> In the above case, the reservation would be cleared by the return from
> the interrupt, but the signal handler might leave a dangling one, which
> sigreturn might fail to clear (in practice, our current implementation
> of sys_sigreturn() will probably clear any reservation as a side effect
> of restore_sigmask() spinlock or set_thread_flag() but it sounds a bit
> fragile to rely on unless it's well documented). 

Good point, I hadn't thought of signals and I agree we'd need to clear the
reservation in the sigreturn path.

Anton
