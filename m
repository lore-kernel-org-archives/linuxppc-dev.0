Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2004DDFFF
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 05:48:21 +1000 (EST)
Date: Wed, 13 May 2009 21:53:40 +0200
From: Andi Kleen <andi@firstfloor.org>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: question about softirqs
Message-ID: <20090513195340.GC19296@one.firstfloor.org>
References: <874ovpmmdq.fsf@basil.nowhere.org> <4A0AC9EC.6070908@nortel.com>
	<20090513141532.GT19296@one.firstfloor.org>
	<alpine.LFD.2.00.0905131612180.3561@localhost.localdomain>
	<87my9hkrmw.fsf@basil.nowhere.org> <4A0AE19D.9040509@nortel.com>
	<20090513170122.GZ19296@one.firstfloor.org>
	<4A0B19A9.1090206@nortel.com>
	<20090513191354.GB19296@one.firstfloor.org>
	<4A0B233B.8010105@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A0B233B.8010105@nortel.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, netdev@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Andi Kleen <andi@firstfloor.org>, paulus@samba.org,
	Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 13, 2009 at 01:44:59PM -0600, Chris Friesen wrote:
> Andi Kleen wrote:
> > On Wed, May 13, 2009 at 01:04:09PM -0600, Chris Friesen wrote:
> >> Andi Kleen wrote:
> >>
> >>> network packets are normally processed by the network packet interrupt's
> >>> softirq or alternatively in the NAPI poll loop.
> >> If we have a high priority task, ksoftirqd may not get a chance to run.
> > 
> > In this case the next interrupt will also process them. It will just
> > go more slowly because interrupts limit the work compared to ksoftirqd.
> 
> I realize that they will eventually get processed.  My point is that the
> documentation (in-kernel, online, and in various books) says that
> softirqs will be processed _on the return from a syscall_. 

They are. The documentation is correct. 

What might not be all processed is all packets that are in the per CPU
backlog queue when the network softirq runs (for non NAPI, for NAPI that's 
obsolete anyways). That's because there are limits.

Or when new work comes in in parallel it doesn't process it all.

But that's always the case -- no queue is infinite, so you have
always situations where it can drop or delay items.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
