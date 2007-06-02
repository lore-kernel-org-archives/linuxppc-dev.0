Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C8B09DDE1A
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 09:59:35 +1000 (EST)
Subject: Re: [PATCH 3/3] consolidate do_signal
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070602102143.GA21707@lst.de>
References: <20070602102143.GA21707@lst.de>
Content-Type: text/plain
Date: Sun, 03 Jun 2007 09:59:25 +1000
Message-Id: <1180828765.14025.34.camel@localhost.localdomain>
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

On Sat, 2007-06-02 at 12:21 +0200, Christoph Hellwig wrote:
> do_signal has exactly the same behaviour on 32bit and 64bit and 32bit
> compat on 64bit for handling 32bit signals.  Consolidate all these
> into one common function in signal.c.  The oly odd left over is
> the try_to_free in the 32bit version that no other architecture has
> in mainline (only in i386 for some odd SuSE release).  We should
> probably get rid of it in a separate patch.

Excellent, that's something I was planning to do too, nice that you beat
me to it :-)

Some comments after a quick look (I haven't gone deep into comparing
old/new implementation, I'll do that later from work).

> +
> +#ifdef CONFIG_PPC32
> +no_signal:
> +#endif

That really need to go (the freeze stuff)

> +	/* Is there any syscall restart business here ? */
> +	check_syscall_restart(regs, &ka, signr > 0);
> +
> +	if (signr <= 0) {
> +		/* No signal to deliver -- put the saved sigmask back */
> +		if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
> +			clear_thread_flag(TIF_RESTORE_SIGMASK);
> +			sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
> +		}
> +		return 0;               /* no signals delivered */
> +	}
> +
> +#ifdef CONFIG_PPC64
> +        /*
> +	 * Reenable the DABR before delivering the signal to
> +	 * user space. The DABR will have been cleared if it
> +	 * triggered inside the kernel.
> +	 */
> +	if (current->thread.dabr)
> +		set_dabr(current->thread.dabr);
> +#endif

One of my patches is extending DABR to 32 bits, though I might have
missed that bit. I think if you apply yours on top of mines, then that
ifdef can go. (Note that I need to respin mines due to small changes, so
we might decide to shuffle things and put yours first, just on top of
the one of mine making the check restart common, and have the rest of my
changes moved on top of those).

> +	if (is32) {
> +		unsigned int newsp;
> +
> +		if ((ka.sa.sa_flags & SA_ONSTACK) &&
> +		    current->sas_ss_size && !on_sig_stack(regs->gpr[1]))
> +			newsp = current->sas_ss_sp + current->sas_ss_size;
> +		else
> +			newsp = regs->gpr[1];

Hrm... some gratuituous differences in the signal stack handling.. I
wonder if that hides a bug in one of the implementations...

> +        	if (ka.sa.sa_flags & SA_SIGINFO)
> +			ret = handle_rt_signal32(signr, &ka, &info, oldset,
> +					regs, newsp);
> +		else
> +			ret = handle_signal32(signr, &ka, &info, oldset,
> +					regs, newsp);
> +#ifdef CONFIG_PPC64
> +	} else {
> +		ret = handle_rt_signal64(signr, &ka, &info, oldset, regs);
> +#endif
> +	}

I'd rather have handle_rt_signal64() itself be defined as an empty
inline function than having an ifdef in here, don't you agree ?


Cheers,
Ben.
