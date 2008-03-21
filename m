Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33E8BDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 01:38:00 +1100 (EST)
Date: Fri, 21 Mar 2008 14:50:01 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 6/8] ptrace: arch_ptrace -ENOSYS return
In-Reply-To: <20080320081658.0B23826F995@magilla.localdomain>
Message-ID: <alpine.LFD.1.00.0803211441180.3781@apollo.tec.linutronix.de>
References: <20080319211714.8B14226F995@magilla.localdomain>
	<20080319212024.EA03126F995@magilla.localdomain>
	<alpine.LFD.1.00.0803191935080.3020@woody.linux-foundation.org>
	<20080320081658.0B23826F995@magilla.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Mar 2008, Roland McGrath wrote:
> > Wouldn't it be nicer to just let "arch_ptrace()" return a flag saying 
> > whether it handled things or not?
> 
> It would certainly be nicer.  I would prefer:
> 
> extern int arch_ptrace(struct task_struct *child, long request,
>        	    	       long addr, long data, long *retval);
> 
> where it returns an error code or it returns 0 and *retval is the value
> or it returns 1 and it didn't do anything.
>
> So this ugliness seemed like a better bet than waiting for 20 more
> arch sign-offs before any of it could go in.  You are certainly in a
> position to just change the generic signature and make every arch do
> the update (or fix your typos if you just tweak them all blind), and
> let them grumble.  I did not presume to do so.

What about adding a CONFIG_ARCH_HAS_PTRACE2, which is set by the archs
which are converted. For those which are not you add a fallback
implementation:

#ifndef CONFIG_ARCH_HAS_PTRACE2
static int arch_ptrace2(whatever your favourite interface)
{
	ret = arch_ptrace();
	return do_ugly_fixups(ret);
}
#endif

That way you introduce the new interface and convert one or two archs
initialy without breaking the other 22.

At the same time you mark arch_ptrace() deprecated so it will get the
attention of the arch maintainers pretty fast. Once all archs are
converted we can remove the config flag and the fallback quirk.

Thanks,
	tglx
