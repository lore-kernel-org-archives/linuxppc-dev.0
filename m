Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 0BF96DDE0E
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 06:39:06 +1100 (EST)
Date: Fri, 20 Mar 2009 22:39:04 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] tracing: Fix TRACING_SUPPORT dependency
Message-ID: <20090320193904.GA13707@oksana.dev.rtsoft.ru>
References: <20090320150914.GA22769@oksana.dev.rtsoft.ru>
	<20090320190428.GD6224@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090320190428.GD6224@elte.hu>
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	linux-kernel@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 20, 2009 at 08:04:28PM +0100, Ingo Molnar wrote:
> 
> * Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > commit 40ada30f9621fbd831ac2437b9a2a399aad34b00 ("tracing: clean 
> > up menu"), despite the "clean up" in its purpose, introduced 
> > behavioural change for Kconfig symbols: we no longer able to 
> > select tracing support on PPC32 (because IRQFLAGS_SUPPORT isn't 
> > yet implemented).
> 
> Could you please solve this by implementing proper irqflag-tracing 
> support? It's been available upstream for almost three years. It's 
> needed for lockdep support as well, etc.

Breaking things via clean up patches is an interesting method of
encouraging something to implement. ;-)

Surely I'll look into implementing irqflags tracing, but considering
that no one ever needed this for almost three years, and that we
explicitly have the code to deal with tracing-w/o-irqflags, can we
please restore the old behaviour?

At least for 2.6.30, because I don't think I'll have enough time to
implement/test/push irqflags tracing support in time for 2.6.30-rc1.

Thanks,

p.s.
It would make more sense if 40ada30f's commit message would state
that tracing w/o irqflags is now obsolete, or better, if it was
discussed on some mailinglist, so that we'd have some time to
adapt the architecture-specific code.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
