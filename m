Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3FB80DDFE4
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 06:56:14 +1000 (EST)
Date: Wed, 13 May 2009 22:55:38 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: question about softirqs
In-Reply-To: <20090513195340.GC19296@one.firstfloor.org>
Message-ID: <alpine.LFD.2.00.0905132252570.3561@localhost.localdomain>
References: <874ovpmmdq.fsf@basil.nowhere.org> <4A0AC9EC.6070908@nortel.com>
	<20090513141532.GT19296@one.firstfloor.org>
	<alpine.LFD.2.00.0905131612180.3561@localhost.localdomain>
	<87my9hkrmw.fsf@basil.nowhere.org> <4A0AE19D.9040509@nortel.com>
	<20090513170122.GZ19296@one.firstfloor.org>
	<4A0B19A9.1090206@nortel.com>
	<20090513191354.GB19296@one.firstfloor.org>
	<4A0B233B.8010105@nortel.com>
	<20090513195340.GC19296@one.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, netdev@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Ingo Molnar <mingo@elte.hu>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 13 May 2009, Andi Kleen wrote:
> On Wed, May 13, 2009 at 01:44:59PM -0600, Chris Friesen wrote:
> > Andi Kleen wrote:
> > > On Wed, May 13, 2009 at 01:04:09PM -0600, Chris Friesen wrote:
> > >> Andi Kleen wrote:
> > >>
> > >>> network packets are normally processed by the network packet interrupt's
> > >>> softirq or alternatively in the NAPI poll loop.
> > >> If we have a high priority task, ksoftirqd may not get a chance to run.
> > > 
> > > In this case the next interrupt will also process them. It will just
> > > go more slowly because interrupts limit the work compared to ksoftirqd.
> > 
> > I realize that they will eventually get processed.  My point is that the
> > documentation (in-kernel, online, and in various books) says that
> > softirqs will be processed _on the return from a syscall_. 
> 
> They are. The documentation is correct. 

No, the documentation is wrong for the case that the task, which
raised the softirq and therefor woke up ksoftirqd, has a higher
priority than ksoftirqd. In that case the kernel does _NOT_ schedule
ksoftirqd in the return from syscall path.

And that's all what Chris is pointing out.

Thanks,

	tglx
