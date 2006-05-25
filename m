Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C869F67A41
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 00:44:53 +1000 (EST)
Date: Thu, 25 May 2006 07:44:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Fwd: Re: via-pmu runs device_power_down in atomic context]
Message-Id: <20060525074412.19a03c22.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0605251005450.6990-100000@iolanthe.rowland.org>
References: <20060524215917.230af218.akpm@osdl.org>
	<Pine.LNX.4.44L0.0605251005450.6990-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: cpufreq@lists.linux.org.uk, johannes@sipsolutions.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, 24 May 2006, Andrew Morton wrote:
> 
> > > device_power_down should be called with interrupts off, thus the PMU
> > > driver is fine. It's a misnamed function, it calls the sysdev's suspend
> > > and those should be called with irq off. I think the problem is more due
> > > to some cpufreq or notifier change that somebody done to recent kernels
> > > and that added some might_sleep.... I wonder why. 
> > > 
> > > Andrew, what's up there ? What is this new
> > > "blocking_notifier_call_chain" thing ? notifiers use to not use
> > > semaphores and not be blocking... at least powermac implementation of
> > > cpufreq relies on that.
> > 
> > notifiers used to be racy too - we just waddled across them without any
> > locking.
> > 
> > Alan made a best-effort conversion of callers, and there have been a few
> > problems.
> > 
> > Here, pmac has gone and unilaterally decided that device_power_down() is
> > atomic, even though device_power_down() _already_ calls suspend_device(),
> > which does down().  So I'd say you've gone and found a via-pmu bug here.
> > 
> > A way of shutting up the warning would be to use an atomic notifier, but
> > it'll still be buggy.  Better would be to teach pmac_suspend_devices() not
> > to assume things which aren't true ;)
> 
> Someone else had a problem with the cpufreq conversion earlier.  I posted 
> a message on the cpufreq mailing list but nobody ever responded to it.  
> This may or may not be related to that earlier problem.
> 
> In essence, the problem seemed to be that the cpufreq notifier chain is
> sometimes expected to be blocking and sometimes expected to be atomic,
> based on the "val" code passed to notifier_call_chain.  The cleanest
> solution would be to split the single notifier chain into two chains,
> one always blocking and the other always atomic.
> 
> Somebody who knows more about cpufreq than I do will have to make that
> change.
> 

I wouldn't describe the cpufreq project as a teeming hive of frenetic
activity, and we need something pronto.

We could go back to a raw_notifier and be as buggy as we used to be.
