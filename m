Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDA5167A6F
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 15:46:42 +1000 (EST)
Subject: Re: [Fwd: Re: via-pmu runs device_power_down in atomic context]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060524223658.6fc797f5.akpm@osdl.org>
References: <1148531830.13249.237.camel@localhost.localdomain>
	<20060524215917.230af218.akpm@osdl.org>
	<1148534398.13249.246.camel@localhost.localdomain>
	<20060524223658.6fc797f5.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 25 May 2006 15:46:24 +1000
Message-Id: <1148535984.13249.253.camel@localhost.localdomain>
Mime-Version: 1.0
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


> This requirement to keep interrupts off in there breaks things again and
> again and again and again.  And this time: again.

Where else ?

If you look at this function it's _designed_ for interrupts off ! the
driver suspend have the option of deferring their suspend() callback
until after irqs have been turned off (needed for legacy stuff afaik but
rarely used) and the sysdev's are very low level things whose suspend
and resume callbacks should be called after that point as well. 

Ben.
