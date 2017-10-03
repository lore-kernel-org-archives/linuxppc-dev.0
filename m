Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y605k09pfzDqlp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 00:20:41 +1100 (AEDT)
Date: Tue, 3 Oct 2017 15:20:21 +0200 (CEST)
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
In-Reply-To: <alpine.DEB.2.20.1710031411440.2281@nanos>
Message-ID: <alpine.DEB.2.20.1710031451590.2281@nanos>
References: <20170912193654.321505854@linutronix.de>
 <20170912194147.862865570@linutronix.de>
 <87d165dqew.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1710030848210.2281@nanos>
 <87o9pocvjq.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1710031411440.2281@nanos>
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

On Tue, 3 Oct 2017, Thomas Gleixner wrote:
> On Tue, 3 Oct 2017, Michael Ellerman wrote:
> > Hmm, I tried that patch, it makes the warning go away. But then I
> > triggered a deliberate hard lockup and got nothing.
> > 
> > Then I went back to the existing code (in linux-next), and I still get
> > no warning from a deliberate hard lockup.
> > 
> > So seems there may be some more gremlins. Will test more in the morning.
> 
> Hrm. That's weird. I'll have a look and send a proper patch series on top
> of next.

The major difference is that the reworked code utilizes
watchdog_nmi_reconfigure() for both init and the sysctl updates, but I
can't for my life figure out why that doesn't work.

Thanks,

	tglx
