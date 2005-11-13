Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17270.58406.370195.733887@cargo.ozlabs.ibm.com>
Date: Sun, 13 Nov 2005 17:58:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1131756526.27347.212.camel@baythorne.infradead.org>
References: <1131745047.21212.194.camel@hades.cambridge.redhat.com>
	<17269.14127.936147.778781@cargo.ozlabs.ibm.com>
	<1131756526.27347.212.camel@baythorne.infradead.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Attempt to clean up sigsuspend et al
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> I suppose I could make a TIF_xxx flag make entry.S do that. It's not
> massively pretty, but then it wasn't pretty beforehand either. At least
> I'd have made the ppc32 and ppc64 code match, removed the assembly
> wrappers for a bunch of syscalls, and shortened the syscall exit fast
> path on ppc64. 
> 
> I'd probably still be removing more lines of code than I add, but I'm
> not entirely convinced by the whole plan. What do you think?

Or have a mark in the syscall table (e.g. set the bottom bit of the
address) for the syscalls that need the full register set.  That does
mean an extra conditional branch in the syscall entry path for all
syscalls, though.

> Failing that, I'll just switch them both to do either what ppc32
> currently does with sigreturn_exit() or what ppc64 does with returning
> zero to take the ret_from_except path. Probably the former, since
> pselect() and ppoll() will sometimes want to return zero without
> invoking a signal handler.  And we can probably shorten the ppc64
> syscall exit path anyway, either way. 

I'll be upset if you can shorten it by a lot - I thought I had it
pretty tight already. :)

Paul.
