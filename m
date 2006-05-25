Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D131167A5D
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 15:37:33 +1000 (EST)
Date: Wed, 24 May 2006 22:36:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Fwd: Re: via-pmu runs device_power_down in atomic context]
Message-Id: <20060524223658.6fc797f5.akpm@osdl.org>
In-Reply-To: <1148534398.13249.246.camel@localhost.localdomain>
References: <1148531830.13249.237.camel@localhost.localdomain>
	<20060524215917.230af218.akpm@osdl.org>
	<1148534398.13249.246.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net,
	stern@rowland.harvard.edu, cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> 
> > Here, pmac has gone and unilaterally decided that device_power_down() is
> > atomic, even though device_power_down() _already_ calls suspend_device(),
> > which does down().  So I'd say you've gone and found a via-pmu bug here.
> 
> No. Look at the implementation (and the comment) in device_power_down().
> It's designed to be called with irqs off...  Of course, somebody changed
> the locking in there and it's indeed ending up calling suspend_device()
> for devices on the irq_off list which calls down ... bad bad... that's
> another bug in the drivers/power/* to add to an already long list.
> Fortunately, very few (if any) devics rely on this irq_off list. But
> sysdev's do. 

uh-huh.

> > A way of shutting up the warning would be to use an atomic notifier, but
> > it'll still be buggy.  Better would be to teach pmac_suspend_devices() not
> > to assume things which aren't true ;)
> 
> No. If we call device_power_down with interrupts enabled, very bad
> things will happen. This powermac code is very carefully crafted to do
> things in a strict order and it's along those lines that the callbacks
> in the device model were initially defined. Now, people who don't
> understand shit about how to make power management reliable may have
> broken things around, but the powermac implementation is right there.
> 

This requirement to keep interrupts off in there breaks things again and
again and again and again.  And this time: again.

It looks like we (again) have to live with it in which case conversion to
an atomic notifier is probably needed.  That may break other things though.
Alan would know.
