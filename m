Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5wwB1173zDqy4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 21:57:14 +1100 (AEDT)
Date: Tue, 3 Oct 2017 12:56:50 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Nicholas Piggin <npiggin@gmail.com>
cc: Michael Ellerman <mpe@ellerman.id.au>, LKML <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Siewior <bigeasy@linutronix.de>, Don Zickus <dzickus@redhat.com>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Ulrich Obergfell <uobergfe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch V2 22/29] lockup_detector: Make watchdog_nmi_reconfigure()
 two stage
In-Reply-To: <20171003200126.358155b7@roar.ozlabs.ibm.com>
Message-ID: <alpine.DEB.2.20.1710031248490.2281@nanos>
References: <20170912193654.321505854@linutronix.de>
 <20170912194147.862865570@linutronix.de>
 <87d165dqew.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1710030848210.2281@nanos>
 <alpine.DEB.2.20.1710030902310.2281@nanos>
 <20171003200126.358155b7@roar.ozlabs.ibm.com>
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

On Tue, 3 Oct 2017, Nicholas Piggin wrote:
> On Tue, 3 Oct 2017 09:04:03 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Tue, 3 Oct 2017, Thomas Gleixner wrote:
> > > On Tue, 3 Oct 2017, Michael Ellerman wrote:  
> > > > Hi Thomas,
> > > > Unfortunately this is hitting the WARN_ON in start_wd_cpu() on powerpc
> > > > because we're calling it multiple times for the boot CPU.
> > > > 
> > > > The first call is via:
> > > > 
> > > >   start_wd_on_cpu+0x80/0x2f0
> > > >   watchdog_nmi_reconfigure+0x124/0x170
> > > >   softlockup_reconfigure_threads+0x110/0x130
> > > >   lockup_detector_init+0xbc/0xe0
> > > >   kernel_init_freeable+0x18c/0x37c
> > > >   kernel_init+0x2c/0x160
> > > >   ret_from_kernel_thread+0x5c/0xbc
> > > > 
> > > > And then again via the CPU hotplug registration:
> > > > 
> > > >   start_wd_on_cpu+0x80/0x2f0
> > > >   cpuhp_invoke_callback+0x194/0x620
> > > >   cpuhp_thread_fun+0x7c/0x1b0
> > > >   smpboot_thread_fn+0x290/0x2a0
> > > >   kthread+0x168/0x1b0
> > > >   ret_from_kernel_thread+0x5c/0xbc
> > > > 
> > > > 
> > > > The first call is new because previously watchdog_nmi_reconfigure()
> > > > wasn't called from softlockup_reconfigure_threads().  
> > > 
> > > Hmm, don't you have the same problem with CPU hotplug or do you just get
> > > lucky because the hotplug callback in your code is ordered vs. the
> > > softlockup thread hotplug callback in a way that this does not hit?
> 
> I had the idea that it watchdog_nmi_reconfigure() being only called
> with get_online_cpus held would prevent hotplug callbacks running.
>   
> > 
> > Which leads me to the question why you need the hotplug state at all if the
> > softlockup detector is enabled. Wouldn't it make more sense to only
> > register the state if softlockup detector is turned off in Kconfig and
> > actually move it to the core code?
> 
> I don't understand what you mean exactly, but it was done to avoid
> relying on the softlockup detector at all, because it wasn't needed
> for anything else (unlike the perf lockup detector).

If the softlockup detector is enabled along with your hardlockup detector
then the current code in mainline invokes watchdog_nmi_enable(cpu), which
is a weak function and as I just noticed not implemented by powerpc. So
it's a non issue because it's not implemented.

Thanks,

	tglx
