Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com
 [209.85.216.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B05052C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 07:14:47 +1100 (EST)
Received: by mail-qc0-f176.google.com with SMTP id e16so3570657qcx.35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 12:14:43 -0800 (PST)
Date: Wed, 29 Jan 2014 15:14:40 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 5/6] X86: remove redundant cpuidle_idle_call()
In-Reply-To: <CAOesGMjvOkuxCopog91SAV1-gB9GaEYXpuXwhV1EJQor_pKjBA@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1401291434120.1652@knanqh.ubzr>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-6-git-send-email-nicolas.pitre@linaro.org>
 <CAOesGMjvOkuxCopog91SAV1-gB9GaEYXpuXwhV1EJQor_pKjBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
 Russell King <linux@arm.linux.org.uk>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mundt <lethal@linux-sh.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Jan 2014, Olof Johansson wrote:

> Hi,
> 
> On Wed, Jan 29, 2014 at 9:45 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > The core idle loop now takes care of it.
> >
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  arch/x86/kernel/process.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index 3fb8d95ab8..4505e2a950 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -298,10 +298,7 @@ void arch_cpu_idle_dead(void)
> >   */
> >  void arch_cpu_idle(void)
> >  {
> > -       if (cpuidle_idle_call())
> > -               x86_idle();
> > -       else
> > -               local_irq_enable();
> > +       x86_idle();
> 
> You're taking out the local_irq_enable() here but I don't see the
> equivalent of adding it back in the 1/6 patch that moves the
> cpuidle_idle_call() up to common code. It seems that one of the call
> paths through cpuidle_idle_call() don't re-enable it on its own.

When cpuidle_idle_call() returns non-zero, IRQs are left disabled.  When 
it returns zero then IRQs should be disabled.  Same goes for cpuidle 
drivers.  That's the theory at least.

Looking into some cpuidle drivers for x86 I found at least one that 
doesn't respect this convention.  Damn.

> Even if this is the right thing to do, why it's OK to do so should
> probably be documented in the patch description.

Better yet, I'm going to amend patch 1/6 with the below to make things 
more reliable while still identifying misbehaving drivers.

diff --git a/kernel/cpu/idle.c b/kernel/cpu/idle.c
index ffcd3ee9af..14ca43430a 100644
--- a/kernel/cpu/idle.c
+++ b/kernel/cpu/idle.c
@@ -98,7 +98,8 @@ static void cpu_idle_loop(void)
 					rcu_idle_enter();
 					if (cpuidle_idle_call())
 						arch_cpu_idle();
-					WARN_ON_ONCE(irqs_disabled());
+					if (WARN_ON_ONCE(irqs_disabled()))
+						local_irq_enable();
 					rcu_idle_exit();
 					start_critical_timings();
 				} else {
