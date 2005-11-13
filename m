Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17271.4290.486710.929502@cargo.ozlabs.ibm.com>
Date: Sun, 13 Nov 2005 21:09:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1131874887.27347.221.camel@baythorne.infradead.org>
References: <1131745047.21212.194.camel@hades.cambridge.redhat.com>
	<17269.14127.936147.778781@cargo.ozlabs.ibm.com>
	<1131756526.27347.212.camel@baythorne.infradead.org>
	<17270.58406.370195.733887@cargo.ozlabs.ibm.com>
	<1131874887.27347.221.camel@baythorne.infradead.org>
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

> We don't need to do it on entry; we can do it on exit. If do_signal()
> sees that the nvgprs weren't saved in the pt_regs it's playing with,
> then it can set a new TIF_SAVENVPGRS_TO_SIG_FRAME bit. I don't think we
> even need to store a pointer saying where to put them -- the signal
> frame will always be at the top of the userspace stack.

Two problems with that: (1) for *sigsuspend, if do_signal returns 0,
then we need to go back and keep waiting, and (2) it doesn't handle
the other syscalls that need the full register set, such as fork,
clone etc.  Also, for the *sigsuspend case, we need to pass the saved
signal set to do_signal, not NULL (as the call from the exception exit
path does).

Paul.
