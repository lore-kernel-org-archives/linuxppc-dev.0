Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zT0hK2GRzzF0Tb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 13:53:21 +1100 (AEDT)
Date: Sat, 27 Jan 2018 13:45:46 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH] powerpc/powernv: Provide a way to force a core into
 SMT4 mode
Message-ID: <20180127024546.GB5360@fergus.ozlabs.ibm.com>
References: <20180125050512.GA18744@fergus.ozlabs.ibm.com>
 <20180127102735.5075a560@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180127102735.5075a560@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 27, 2018 at 10:27:35AM +1000, Nicholas Piggin wrote:
> On Thu, 25 Jan 2018 16:05:12 +1100
> Paul Mackerras <paulus@ozlabs.org> wrote:
> 
> > POWER9 processors up to and including "Nimbus" v2.2 have hardware
> > bugs relating to transactional memory and thread reconfiguration.
> > One of these bugs has a workaround which is to get the core into
> > SMT4 state temporarily.  This workaround is only needed when
> > running bare-metal.
> 
> How often will this be triggered, in practice? If it's infrequent,
> then would it be better to just do a smp_call_function on siblings
> and get them all spinning there? I'm looking sadly at the added
> sync...

We'll need to do this every time we exit a guest vcpu and the CPU is
in "fake suspend" state, which will be the next exit after entering
the vcpu when its MSR[TS] = 0b01 (suspend state).  If the vcpu does a
tresume or treclaim in fake suspend state, that causes a softpatch
interrupt; the CPU doesn't get out of fake suspend state because of
any guest instruction, only via hypervisor action.

So it could be very rare or it could be quite frequent, depending on
how much usage the guest makes of TM and how long it spends in suspend
state.

The smp_call_function on siblings wouldn't work in the case where some
threads are off-line, since it only works on online CPUs.  Also we
would need to spin in the function being called on the other CPUs
(otherwise you could get the situation where they wake up serially and
you never have 3 or 4 threads simultaneously active), which would make
me worry about deadlocks in the case where multiple threads are
concurrently trying to get the core into SMT4 mode.

If you can think of a way to eliminate the sync without introducing a
race, I'm all ears.  I haven't been able to.

Paul.
