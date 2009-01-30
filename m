Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9CFEFDDFAB
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 14:08:00 +1100 (EST)
Date: Fri, 30 Jan 2009 06:07:58 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.28-rt on PowerPC
Message-ID: <20090130030758.GA7004@oksana.dev.rtsoft.ru>
References: <20090129213429.GA29014@oksana.dev.rtsoft.ru>
	<1233281510.18767.17.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1233281510.18767.17.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 30, 2009 at 01:11:50PM +1100, Benjamin Herrenschmidt wrote:
> 
> > This is trivially solved by converting arch/powerpc/sysdev/ipic.c
> > back to spinlocks (ipic_lock).
> > 
> > Assuming that converting-back is automatic, there are few other
> > chained interrupt controllers you might want to convert-back:
> > 
> > arch/powerpc/sysdev/i8259.c (i8259_lock)
> > arch/powerpc/sysdev/mpic.c (mpic_lock)
> > arch/powerpc/sysdev/qe_lib/qe_ic.c (qe_ic_lock)
> 
> Except that a bunch of those can be both primary and chained...

Yeah, thanks for correcting.

> It's
> simply not a solution to have to "convert" interrupt controller code to
> use a different locking scheme depending on whether they are chained or
> primary...

Actually, it doesn't matter whether a controller is a root IC or
cascaded. Just as primary handlers, chained handlers don't run in
threads, thus spinlocks should be used, not sleeping locks.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
