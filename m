Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0130.outbound.protection.outlook.com [207.46.100.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A9251A084B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 10:12:11 +1100 (AEDT)
Message-ID: <1428016310.22867.289.camel@freescale.com>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
From: Scott Wood <scottwood@freescale.com>
To: Purcareata Bogdan <b43198@freescale.com>
Date: Thu, 2 Apr 2015 18:11:50 -0500
In-Reply-To: <55158E6D.40304@freescale.com>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>
 <54E74A8C.30802@linutronix.de> <1424734051.4698.17.camel@freescale.com>
 <54EF196E.4090805@redhat.com> <54EF2025.80404@linutronix.de>
 <1424999159.4698.78.camel@freescale.com> <55158E6D.40304@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-rt-users@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 mihai.caraman@freescale.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-27 at 19:07 +0200, Purcareata Bogdan wrote:
> On 27.02.2015 03:05, Scott Wood wrote:
> > On Thu, 2015-02-26 at 14:31 +0100, Sebastian Andrzej Siewior wrote:
> >> On 02/26/2015 02:02 PM, Paolo Bonzini wrote:
> >>>
> >>>
> >>> On 24/02/2015 00:27, Scott Wood wrote:
> >>>> This isn't a host PIC driver.  It's guest PIC emulation, some of which
> >>>> is indeed not suitable for a rawlock (in particular, openpic_update_irq
> >>>> which loops on the number of vcpus, with a loop body that calls
> >>>> IRQ_check() which loops over all pending IRQs).
> >>>
> >>> The question is what behavior is wanted of code that isn't quite
> >>> RT-ready.  What is preferred, bugs or bad latency?
> >>>
> >>> If the answer is bad latency (which can be avoided simply by not running
> >>> KVM on a RT kernel in production), patch 1 can be applied.  If the
> >> can be applied *but* makes no difference if applied or not.
> >>
> >>> answer is bugs, patch 1 is not upstream material.
> >>>
> >>> I myself prefer to have bad latency; if something takes a spinlock in
> >>> atomic context, that spinlock should be raw.  If it hurts (latency),
> >>> don't do it (use the affected code).
> >>
> >> The problem, that is fixed by this s/spin_lock/raw_spin_lock/, exists
> >> only in -RT. There is no change upstream. In general we fix such things
> >> in -RT first and forward the patches upstream if possible. This convert
> >> thingy would be possible.
> >> Bug fixing comes before latency no matter if RT or not. Converting
> >> every lock into a rawlock is not always the answer.
> >> Last thing I read from Scott is that he is not entirely sure if this is
> >> the right approach or not and patch #1 was not acked-by him either.
> >>
> >> So for now I wait for Scott's feedback and maybe a backtrace :)
> >
> > Obviously leaving it in a buggy state is not what we want -- but I lean
> > towards a short term "fix" of putting "depends on !PREEMPT_RT" on the
> > in-kernel MPIC emulation (which is itself just an optimization -- you
> > can still use KVM without it).  This way people don't enable it with RT
> > without being aware of the issue, and there's more of an incentive to
> > fix it properly.
> >
> > I'll let Bogdan supply the backtrace.
> 
> So about the backtrace. Wasn't really sure how to "catch" this, so what 
> I did was to start a 24 VCPUs guest on a 24 CPU board, and in the guest 
> run 24 netperf flows with an external back to back board of the same 
> kind. I assumed this would provide the sufficient VCPUs and external 
> interrupt to expose an alleged culprit.
> 
> With regards to measuring the latency, I thought of using ftrace, 
> specifically the preemptirqsoff latency histogram. Unfortunately, I 
> wasn't able to capture any major differences between running a guest 
> with in-kernel MPIC emulation (with the openpic raw_spinlock_conversion 
> applied) vs. no in-kernel MPIC emulation. Function profiling 
> (trace_stat) shows that in the second case there's a far greater time 
> spent in kvm_handle_exit (100x), but overall, the maximum latencies for 
> preemptirqsoff don't look that much different.
> 
> Here are the max numbers (preemptirqsoff) for the 24 CPUs, on the host 
> RT Linux, sorted in descending order, expressed in microseconds:
> 
> In-kernel MPIC		QEMU MPIC
> 3975			5105

What are you measuring?  Latency in the host, or in the guest?

-Scott
