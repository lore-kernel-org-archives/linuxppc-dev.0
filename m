Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5yd93qYWzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 23:14:21 +1100 (AEDT)
Date: Tue, 3 Oct 2017 14:13:54 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Nicholas Piggin <npiggin@gmail.com>, Don Zickus <dzickus@redhat.com>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Ulrich Obergfell <uobergfe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch V2 22/29] lockup_detector: Make watchdog_nmi_reconfigure()
 two stage
In-Reply-To: <87o9pocvjq.fsf@concordia.ellerman.id.au>
Message-ID: <alpine.DEB.2.20.1710031411440.2281@nanos>
References: <20170912193654.321505854@linutronix.de>
 <20170912194147.862865570@linutronix.de>
 <87d165dqew.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1710030848210.2281@nanos>
 <87o9pocvjq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 3 Oct 2017, Michael Ellerman wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> >> The first call is new because previously watchdog_nmi_reconfigure()
> >> wasn't called from softlockup_reconfigure_threads().
> >
> > Hmm, don't you have the same problem with CPU hotplug or do you just get
> > lucky because the hotplug callback in your code is ordered vs. the
> > softlockup thread hotplug callback in a way that this does not hit?
> 
> I don't see it with CPU hotplug.
> 
> AFAICS that's because softlockup_reconfigure_threads() isn't called for
> CPU hotplug. Unless there's a path I'm missing?

As I said in the other reply, I assumed that its called via
watchdog_nmi_enable(cpu), but that's a weak function which is not
implemented on power. So no issue.

> >> I'm not sure what the easiest fix is. One option would be to just drop
> >> the WARN_ON, it's just there for paranoia AFAICS.
> >
> > The straight forward way is to make use of the new probe function. Patch
> > below.
> 
> Hmm, I tried that patch, it makes the warning go away. But then I
> triggered a deliberate hard lockup and got nothing.
> 
> Then I went back to the existing code (in linux-next), and I still get
> no warning from a deliberate hard lockup.
> 
> So seems there may be some more gremlins. Will test more in the morning.

Hrm. That's weird. I'll have a look and send a proper patch series on top
of next.

Thanks,

	tglx
