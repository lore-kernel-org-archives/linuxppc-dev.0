Return-Path: <SRS0+84e6a3bce418fe673909+811+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FE0168704
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2005 11:48:54 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17269.14127.936147.778781@cargo.ozlabs.ibm.com>
References: <1131745047.21212.194.camel@hades.cambridge.redhat.com>
	<17269.14127.936147.778781@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sat, 12 Nov 2005 00:48:46 +0000
Message-Id: <1131756526.27347.212.camel@baythorne.infradead.org>
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

On Sat, 2005-11-12 at 11:28 +1100, Paul Mackerras wrote:
> Ummm, I don't see where you save the non-volatile GPRs to the
> exception frame _before_ do_signal (called from within *_sigsuspend)
> copies them to the user stack...

Hm, yeah.

I suppose I could make a TIF_xxx flag make entry.S do that. It's not
massively pretty, but then it wasn't pretty beforehand either. At least
I'd have made the ppc32 and ppc64 code match, removed the assembly
wrappers for a bunch of syscalls, and shortened the syscall exit fast
path on ppc64. 

I'd probably still be removing more lines of code than I add, but I'm
not entirely convinced by the whole plan. What do you think?

Failing that, I'll just switch them both to do either what ppc32
currently does with sigreturn_exit() or what ppc64 does with returning
zero to take the ret_from_except path. Probably the former, since
pselect() and ppoll() will sometimes want to return zero without
invoking a signal handler.  And we can probably shorten the ppc64
syscall exit path anyway, either way. 

-- 
dwmw2
