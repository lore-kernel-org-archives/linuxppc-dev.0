Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRYwN1fDxzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 22:43:16 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id t86so2952567pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Aug 2017 05:43:16 -0700 (PDT)
Date: Tue, 8 Aug 2017 22:42:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 10/13] powerpc/64s: idle simplify KVM idle on POWER9
Message-ID: <20170808224257.720e85d6@roar.ozlabs.ibm.com>
In-Reply-To: <20170808103643.GA9107@in.ibm.com>
References: <20170805170241.22966-1-npiggin@gmail.com>
 <20170805170241.22966-11-npiggin@gmail.com>
 <20170808103643.GA9107@in.ibm.com>
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

On Tue, 8 Aug 2017 16:06:43 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hi Nicholas,
> 
> On Sun, Aug 06, 2017 at 03:02:38AM +1000, Nicholas Piggin wrote:
> > POWER9 CPUs have independent MMU contexts per thread so KVM
> > does not have to bring sibling threads into real-mode when
> > switching MMU mode to guest. This can simplify POWER9 sleep/wake
> > paths and avoids hwsyncs.
> > 


> > @@ -444,6 +439,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
> >  	beq	1f
> >  	b	kvm_start_guest
> >  1:
> > +END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)  
> 
> This would be 7 nops on power9. Should we move this to a different
> function and do a bl to that?

Yes that's a good idea.

> > +static void kvmppc_release_hwthread_secondary(int cpu)
> > +{
> > +	struct paca_struct *tpaca;
> > +
> > +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> > +		WARN_ON(1);
> > +		return;
> > +	}
> > +
> > +	tpaca = &paca[cpu];
> > +	tpaca->kvm_hstate.hwthread_req = 0;
> > +	kvmppc_release_hwthread(cpu);
> > +}
> > +
> > +  
> 
> Extra blank line not needed.

Sure.

> > @@ -2858,11 +2883,13 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
> > 
> >  	/* Let secondaries go back to the offline loop */
> >  	for (i = 0; i < controlled_threads; ++i) {
> > -		kvmppc_release_hwthread(pcpu + i);
> >  		if (sip && sip->napped[i])
> >  			kvmppc_ipi_thread(pcpu + i);
> >  		cpumask_clear_cpu(pcpu + i, &vc->kvm->arch.cpu_in_guest);
> >  	}  
> 
> We are sending an IPI to the thread that has exited the guest and is
> currently napping. The IPI wakes it up so that it can executes
> offline loop. But we haven't released the hwthread yet, which means
> that hwthread_req for this thread is still set.
> 
> The thread wakes up from nap, executes the pnv_powersave_wakeup code
> where it can enter kvm_start_guest. Is this a legitimate race or am I
> missing something?

Oh I think it's just a silly mistake in my patch, good catch.
Would moving this loop below the one below solve it? I wasn't
completely happy with uglifying these loops by making the
primary release different than secondary... maybe I will just
move the difference into kvmppc_release_hwthread and which is
less intrusive to callers.

Thanks,
Nick
