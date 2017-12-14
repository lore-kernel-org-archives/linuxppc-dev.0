Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxvC03gTdzDrnr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 11:12:28 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id q20so2217192pgv.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 16:12:28 -0800 (PST)
Date: Thu, 14 Dec 2017 11:12:13 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 2/2] powernv/kdump: Fix cases where the kdump kernel
 can get HMI's
Message-ID: <20171214111213.07ba99a4@gmail.com>
In-Reply-To: <20171213205101.2cc0c830@roar.ozlabs.ibm.com>
References: <20171213080828.2800-1-bsingharora@gmail.com>
 <20171213080828.2800-2-bsingharora@gmail.com>
 <20171213205101.2cc0c830@roar.ozlabs.ibm.com>
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

On Wed, 13 Dec 2017 20:51:01 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> This is looking pretty nice now...
> 
> On Wed, 13 Dec 2017 19:08:28 +1100
> Balbir Singh <bsingharora@gmail.com> wrote:
> 
> > @@ -543,7 +543,25 @@ void smp_send_debugger_break(void)
> >  #ifdef CONFIG_KEXEC_CORE
> >  void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
> >  {
> > +	int cpu;
> > +
> >  	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, crash_ipi_callback, 1000000);
> > +	if (kdump_in_progress() && crash_wake_offline) {
> > +		for_each_present_cpu(cpu) {
> > +			if (cpu_online(cpu))
> > +				continue;
> > +			/*
> > +			 * crash_ipi_callback will wait for
> > +			 * all cpus, including offline CPUs.
> > +			 * We don't care about nmi_ipi_function.
> > +			 * Offline cpus will jump straight into
> > +			 * crash_ipi_callback, we can skip the
> > +			 * entire NMI dance and waiting for
> > +			 * cpus to clear pending mask, etc.
> > +			 */
> > +			do_smp_send_nmi_ipi(cpu);  
> 
> Still a little bit concerned about using NMI IPI for this.
>

OK -- for offline CPUs you mean?

> If you take an NMI IPI from stop, the idle code should do the
> right thing and we would just return the system reset wakeup
> reason in SRR1 here (which does not need to be cleared).
> 
> If you take the system reset anywhere else in the loop, it's
> going to go out via system_reset_exception. I guess that
> would end up doing the right thing, it probably gets to
> crash_ipi_callback from crash_kexec_secondary?

You mean like if we are online at the time of NMI'ing? If so
the original loop will NMI us back into crash_ipi_callback
anyway. We don't expect this to occur for offline CPUs

> 
> It's just going to be a very untested code path :( What we
> gain I suppose is better ability to handle a CPU that's locked
> up somewhere in the cpu offline path. Assuming the uncommon
> case works...
> 
> Actually, if you *always* go via the system reset exception
> handler, then code paths will be shared. That might be the
> way to go. So I would check for system reset wakeup SRR1 reason
> and call replay_system_reset() for it. What do you think?
> 

We could do that, but that would call pnv_system_reset_exception
and try to call the NMI function, but we've not used that path
to initiate the NMI, so it should call the stale nmi_ipi_function
which is crash_ipi_callback and not go via the crash_kexec path.


I can't call smp_send_nmi_ipi due to the nmi_ipi_busy_count and
I'm worried about calling a stale nmi_ipi_function via the
system_reset_exception path, if we are OK with it, I can revisit
the code path

Thanks,
Balbir Singh.
