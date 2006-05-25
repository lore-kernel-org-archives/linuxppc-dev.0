Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62B5667A6D
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 15:45:11 +1000 (EST)
Subject: Re: [Fwd: Re: via-pmu runs device_power_down in atomic context]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <1148534398.13249.246.camel@localhost.localdomain>
References: <1148531830.13249.237.camel@localhost.localdomain>
	<20060524215917.230af218.akpm@osdl.org>
	<1148534398.13249.246.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 25 May 2006 15:44:49 +1000
Message-Id: <1148535890.13249.250.camel@localhost.localdomain>
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


> No. If we call device_power_down with interrupts enabled, very bad
> things will happen. This powermac code is very carefully crafted to do
> things in a strict order and it's along those lines that the callbacks
> in the device model were initially defined. Now, people who don't
> understand shit about how to make power management reliable may have
> broken things around, but the powermac implementation is right there.

To be more precise, sysdev suspend is supposed to happen with irq offs
(it's specifically designed to handle legacy things, interrupt
controllers, ec...). Thus cpufreq suspend/resume need to assume that
it's being called in that context or be made something else than a
sysdev...

Regarding the possible down() if we walk through the irq_off device
list, well, that's indeed annoying, we probably need to pass a "no_lock"
argument. Never hit that one since as I told you, there are really few
if not no drivers using this facility of deferring suspend to after
interrupts are disabled. Also, the down there is harmless as in no
normal circumstances should it ever turn into a schedule() (there should
be no contention possible that late in the suspend process).

Ben.
