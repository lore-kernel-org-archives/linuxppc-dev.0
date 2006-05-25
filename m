Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7ED367A42
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 15:20:17 +1000 (EST)
Subject: Re: [Fwd: Re: via-pmu runs device_power_down in atomic context]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060524215917.230af218.akpm@osdl.org>
References: <1148531830.13249.237.camel@localhost.localdomain>
	<20060524215917.230af218.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 25 May 2006 15:19:58 +1000
Message-Id: <1148534398.13249.246.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	Alan Stern <stern@rowland.harvard.edu>, cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Here, pmac has gone and unilaterally decided that device_power_down() is
> atomic, even though device_power_down() _already_ calls suspend_device(),
> which does down().  So I'd say you've gone and found a via-pmu bug here.

No. Look at the implementation (and the comment) in device_power_down().
It's designed to be called with irqs off...  Of course, somebody changed
the locking in there and it's indeed ending up calling suspend_device()
for devices on the irq_off list which calls down ... bad bad... that's
another bug in the drivers/power/* to add to an already long list.
Fortunately, very few (if any) devics rely on this irq_off list. But
sysdev's do. 

> A way of shutting up the warning would be to use an atomic notifier, but
> it'll still be buggy.  Better would be to teach pmac_suspend_devices() not
> to assume things which aren't true ;)

No. If we call device_power_down with interrupts enabled, very bad
things will happen. This powermac code is very carefully crafted to do
things in a strict order and it's along those lines that the callbacks
in the device model were initially defined. Now, people who don't
understand shit about how to make power management reliable may have
broken things around, but the powermac implementation is right there.

Ben.
