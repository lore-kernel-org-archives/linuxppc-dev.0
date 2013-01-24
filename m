Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F8272C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 21:13:26 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Thu, 24 Jan 2013 20:08:26 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 65FB12BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 21:13:19 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0OA1Ulb11534612
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 21:01:31 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0OADHLv002565
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 21:13:18 +1100
Message-ID: <1359022384.2666.46.camel@ThinkPad-T5421.cn.ibm.com>
Subject: Re: [PATCH powerpc ] Avoid debug_smp_processor_id() check in
 arch_spin_unlock_wait()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 24 Jan 2013 18:13:04 +0800
In-Reply-To: <1358999231.29726.9.camel@pasglop>
References: <1353305799.3694.9.camel@ThinkPad-T5421.cn.ibm.com>
 <1357797726.4838.89.camel@pasglop>
 <1357808418.10378.16.camel@ThinkPad-T5421.cn.ibm.com>
 <1358999231.29726.9.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-01-24 at 14:47 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2013-01-10 at 17:00 +0800, Li Zhong wrote:
> > Use local_paca directly in arch_spin_unlock_wait(), as all processors have the
> > same value for the field shared_proc, so we don't need care racy here.
> 
> Of course that won't build if CONFIG_PPC_SPLPAR isn't defined...

...ah, I didn't notice that lppaca_ptr is only defined under
CONFIG_PPC_BOOK3S, and the whole paca is only defined under
CONFIG_PPC64; while the function changed seems could be used by any
configuration. Sorry about the carelessness. 

> 
> Maybe you could change the definition of the SHARED_PROCESSOR
> macro itself. The only possible "risk" would be a stale lppaca
> if we preempt & hot unplug the CPU at the wrong time (provided
> we no longer stop_machine either), I suppose if that's a real
> concern we could delay freeing of lppaca's via RCU or such.

I'm not very clear about the "risk" you mentioned above. It seems to me
that the freeing of lppaca only appeared in free_unused_pacas(), called
by early setup code, at which time hotplug seems impossible. 

I must missed something ...

I'll update the SHARED_PROCESSOR directly, it seems better to me now.
(wonder why I gave it up immediately when it first came into my mind
while I was doing the last update...)

Thanks, Zhong

> Ben.
> 
> > Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/lib/locks.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
> > index bb7cfec..850bea6 100644
> > --- a/arch/powerpc/lib/locks.c
> > +++ b/arch/powerpc/lib/locks.c
> > @@ -72,7 +72,7 @@ void arch_spin_unlock_wait(arch_spinlock_t *lock)
> >  {
> >  	while (lock->slock) {
> >  		HMT_low();
> > -		if (SHARED_PROCESSOR)
> > +		if (local_paca->lppaca_ptr->shared_proc)
> >  			__spin_yield(lock);
> >  	}
> >  	HMT_medium();
> 
> 
