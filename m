Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvwP206v4zF0dw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 20:59:33 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id u5so6981042pfh.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 01:59:33 -0800 (PST)
Date: Mon, 5 Mar 2018 19:59:11 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] powerpc/64s/idle: POWER9 ESL=0 stop avoid
 save/restore overhead
Message-ID: <20180305195911.60381c76@roar.ozlabs.ibm.com>
In-Reply-To: <20180304230101.GC14569@fergus.ozlabs.ibm.com>
References: <20171117140807.22105-1-npiggin@gmail.com>
 <20171117140807.22105-4-npiggin@gmail.com>
 <20180228183439.GC20168@drishya.in.ibm.com>
 <20180301215734.6602315e@roar.ozlabs.ibm.com>
 <20180304230101.GC14569@fergus.ozlabs.ibm.com>
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

On Mon, 5 Mar 2018 10:01:01 +1100
Paul Mackerras <paulus@ozlabs.org> wrote:

> On Thu, Mar 01, 2018 at 09:57:34PM +1000, Nicholas Piggin wrote:
> > On Thu, 1 Mar 2018 00:04:39 +0530
> > Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:
> >   
> > > * Nicholas Piggin <npiggin@gmail.com> [2017-11-18 00:08:07]:  
> [snip]
> > > > diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> > > > index a921d5428d76..610b1637c16f 100644
> > > > --- a/arch/powerpc/platforms/powernv/idle.c
> > > > +++ b/arch/powerpc/platforms/powernv/idle.c
> > > > @@ -621,7 +621,12 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
> > > >  			continue;
> > > >  		}
> > > > 
> > > > -		if (max_residency_ns < residency_ns[i]) {
> > > > +		/*
> > > > +		 * Deepest stop for unplug must be PSSCR[EC]=1 (wakeup at
> > > > +		 * 0x100.
> > > > +		 */
> > > > +		if ((max_residency_ns < residency_ns[i])&&
> > > > +				(psscr_val[i] & PSSCR_EC)) {
> > > >  			max_residency_ns = residency_ns[i];
> > > >  			pnv_deepest_stop_psscr_val = psscr_val[i];
> > > >  			pnv_deepest_stop_psscr_mask = psscr_mask[i];    
> > > 
> > > If firmware did not provide any ESL=EC=1 state, we can still leave
> > > threads in stop ESL=0 state.  This is just a corner case or random
> > > test scenario.  Why do we want to enforce that offline cpus really use
> > > a ESL=0 state or just spin?   
> > 
> > It's because power9_offline_stop only has cases for EC=ESL=1
> > states now.
> > 
> > It actually looks like EC=ESL=0 unplug today is broken KVM, because
> > the wakeup side does not check HWTHREAD_REQ, and yet they do set
> > HWTHREAD_IN_IDLE. That would probably hang in KVM if we run with
> > dependent threads, wouldn't it?  
> 
> Right.  KVM with indep_threads_mode=N is broken at the moment if you
> run with powersave=off or if firmware provides no stop states with
> EC=ESL=1.  I'm not sure what's the best way to fix that.

For EC=ESL=1, would it be enough to do a test and branch right
after the stop instruction?

> > I think banning it for now should be okay.  
> 
> Banning what exactly?

power9 CPU unplug using a EC=ESL=0 stop state.

Thanks,
Nick
