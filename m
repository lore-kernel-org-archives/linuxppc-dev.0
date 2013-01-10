Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C4DD2C031E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 18:50:41 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Thu, 10 Jan 2013 13:19:09 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1E891125804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 13:20:48 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0A7oWT740173782
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 13:20:32 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0A7oWSu024456
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 18:50:33 +1100
Message-ID: <1357804229.10378.9.camel@ThinkPad-T5421.cn.ibm.com>
Subject: Re: [RFC PATCH powerpc ] Protect smp_processor_id() in
 arch_spin_unlock_wait()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 10 Jan 2013 15:50:29 +0800
In-Reply-To: <1357797726.4838.89.camel@pasglop>
References: <1353305799.3694.9.camel@ThinkPad-T5421.cn.ibm.com>
 <1357797726.4838.89.camel@pasglop>
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

On Thu, 2013-01-10 at 17:02 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2012-11-19 at 14:16 +0800, Li Zhong wrote:
> > This patch tries to disable preemption for using smp_processor_id() in arch_spin_unlock_wait(), 
> > to avoid following report:
> 
>  .../...
> 
> > diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
> > index bb7cfec..7a7c31b 100644
> > --- a/arch/powerpc/lib/locks.c
> > +++ b/arch/powerpc/lib/locks.c
> > @@ -72,8 +72,10 @@ void arch_spin_unlock_wait(arch_spinlock_t *lock)
> >  {
> >  	while (lock->slock) {
> >  		HMT_low();
> > +		preempt_disable();
> >  		if (SHARED_PROCESSOR)
> >  			__spin_yield(lock);
> > +		preempt_enable();
> >  	}
> 
> I assume what you are protecting is the PACA access in SHARED_PROCESSOR
> or is there more ?

Yes, only the one in SHARED_PROCESSOR.

> 
> In that case I'd say just make it use local_paca-> directly or something
> like that. It doesn't matter if the access is racy, all processors will
> have the same value for that field as far as I can tell.

It also seemed to me that all processors have the same value :). I'll
send an updated version based on your suggestion soon.

Thanks, Zhong

> 
> Cheers,
> Ben.
> 
> 
