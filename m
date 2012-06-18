Return-Path: <yong.zhang0@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A7A1CB72B4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2012 12:52:14 +1000 (EST)
Received: by obbeh20 with SMTP id eh20so5531632obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2012 19:52:11 -0700 (PDT)
Date: Mon, 18 Jun 2012 10:51:59 +0800
From: Yong Zhang <yong.zhang0@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 09/10] POWERPC: smp: remove call to
 ipi_call_lock()/ipi_call_unlock()
Message-ID: <20120618025159.GA24420@zhy>
References: <1338275765-3217-1-git-send-email-yong.zhang0@gmail.com>
 <1338275765-3217-10-git-send-email-yong.zhang0@gmail.com>
 <20120616163219.GI2420@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120616163219.GI2420@linux.vnet.ibm.com>
Cc: axboe@kernel.dk, nikunj@linux.vnet.ibm.com, sshtylyov@mvista.com,
 david.daney@cavium.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, akpm@linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, srivatsa.bhat@linux.vnet.ibm.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 16, 2012 at 09:32:19AM -0700, Paul E. McKenney wrote:
> On Tue, May 29, 2012 at 03:16:04PM +0800, Yong Zhang wrote:
> > From: Yong Zhang <yong.zhang@windriver.com>
> > 
> > 1) call_function.lock used in smp_call_function_many() is just to protect
> >    call_function.queue and &data->refs, cpu_online_mask is outside of the
> >    lock. And it's not necessary to protect cpu_online_mask,
> >    because data->cpumask is pre-calculate and even if a cpu is brougt up
> >    when calling arch_send_call_function_ipi_mask(), it's harmless because
> >    validation test in generic_smp_call_function_interrupt() will take care
> >    of it.
> > 
> > 2) For cpu down issue, stop_machine() will guarantee that no concurrent
> >    smp_call_fuction() is processing.
> 
> However, there is an effort to get rid of stop_machine() from the
> CPU-down path...  So something else will be needed.

Yeah. So Thomas changed the commit log like below:
[
    ipi_call_lock/unlock() lock resp. unlock call_function.lock. This lock
    protects only the call_function data structure itself, but it's
    completely unrelated to cpu_online_mask. The mask to which the IPIs
    are sent is calculated before call_function.lock is taken in
    smp_call_function_many(), so the locking around set_cpu_online() is
    pointless and can be removed.
    
    [ tglx: Massaged changelog ]
]

in tip/smp/hotplug.

Thanks,
Yong

> 
> 							Thanx, Paul
> 
> > Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > ---
> >  arch/powerpc/kernel/smp.c |    2 --
> >  1 files changed, 0 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index e4cb343..e1417c4 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -571,7 +571,6 @@ void __devinit start_secondary(void *unused)
> >  	if (system_state == SYSTEM_RUNNING)
> >  		vdso_data->processorCount++;
> >  #endif
> > -	ipi_call_lock();
> >  	notify_cpu_starting(cpu);
> >  	set_cpu_online(cpu, true);
> >  	/* Update sibling maps */
> > @@ -601,7 +600,6 @@ void __devinit start_secondary(void *unused)
> >  		of_node_put(np);
> >  	}
> >  	of_node_put(l2_cache);
> > -	ipi_call_unlock();
> > 
> >  	local_irq_enable();
> > 
> > -- 
> > 1.7.5.4
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Only stand for myself
