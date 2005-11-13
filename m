Return-Path: <SRS0+0c11b2d6486fa6634c62+812+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D31768733
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 22:58:27 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17271.4290.486710.929502@cargo.ozlabs.ibm.com>
References: <1131745047.21212.194.camel@hades.cambridge.redhat.com>
	<17269.14127.936147.778781@cargo.ozlabs.ibm.com>
	<1131756526.27347.212.camel@baythorne.infradead.org>
	<17270.58406.370195.733887@cargo.ozlabs.ibm.com>
	<1131874887.27347.221.camel@baythorne.infradead.org>
	<17271.4290.486710.929502@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sun, 13 Nov 2005 11:58:21 +0000
Message-Id: <1131883101.27347.233.camel@baythorne.infradead.org>
Mime-Version: 1.0
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

On Sun, 2005-11-13 at 21:09 +1100, Paul Mackerras wrote:
> > We don't need to do it on entry; we can do it on exit. If do_signal()
> > sees that the nvgprs weren't saved in the pt_regs it's playing with,
> > then it can set a new TIF_SAVENVPGRS_TO_SIG_FRAME bit. I don't think we
> > even need to store a pointer saying where to put them -- the signal
> > frame will always be at the top of the userspace stack.
> 
> Two problems with that: (1) for *sigsuspend, if do_signal returns 0,
> then we need to go back and keep waiting, and (2) it doesn't handle
> the other syscalls that need the full register set, such as fork,
> clone etc.  Also, for the *sigsuspend case, we need to pass the saved
> signal set to do_signal, not NULL (as the call from the exception exit
> path does).

It doesn't address fork/vfork/clone; certainly. I haven't really looked
at that code path at all yet. It was the *suspend() functions which
offended me, mostly because I need similar behaviour for pselect() and
ppoll() and I didn't want to add to the mess.

But I think other things you mention are OK -- we'd still call
do_signal() from *sigsuspend() just as we do at the moment, with the
same loop. It's just that do_signal() would notice that the nvgprs
aren't saved, and would set the TIF_SAVENVPGRS_TO_SIG_FRAME bit. ..

	if (!regs->trap & 1)
		set_thread_flag(TIF_SAVENVGPRS_SIG);

We end up returning to userspace via entry.S, and the code there notices
the SAVENVGPRS bit and saves _just_ r14-r31 into the signal frame. It
doesn't have to call do_signal() again, so doesn't have to get the right
saved signal mask when doing so.

(Actually in the case of swapcontext() we don't know that the nvgprs
should be saved in a signal frame at the top of the userspace stack; the
context will be elsewhere. We probably do need to store a pointer in the
thread_info, but that's OK too)

-- 
dwmw2
