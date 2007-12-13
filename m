Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFF4FDDDFC
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 07:32:20 +1100 (EST)
Subject: Re: apm_emulation regression
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1197546020.6558.247.camel@johannes.berg>
References: <1197427530.8385.59.camel@pasglop>
	<1197482587.6558.145.camel@johannes.berg>
	<1197546020.6558.247.camel@johannes.berg>
Content-Type: text/plain
Date: Fri, 14 Dec 2007 07:31:32 +1100
Message-Id: <1197577892.15741.143.camel@pasglop>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.osdl.org>, ralf <ralf@linux-mips.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-12-13 at 12:40 +0100, Johannes Berg wrote:
> > > That basically means X will break. That's why X broke on the latest
> > > ubuntu until I whacked some new scripts in them to force console
> > > switching, among other things. Possibly other apps that relied
> > > on /dev/apm_bios to be notified of system suspend/resume broke as well.
> > 
> > Ah. I guess I never noticed because I had the scripts to do console
> > switching all along.
> 
> Actually, it just occurred to me that the *kernel* does a console switch
> when we use /sys/power/state, so maybe that is why I never had a problem
> rather than userspace doing a console switch (which it only started
> doing very recently)

The kernel console switching can be disabled and -is- by some distros.
For example, the problem I was having was when testing Gutsy before it
was final, the script to console switch wasn't in the right place for
powermac and didn't work. X wouldn't be suspended properly and the
machine would lockup.

In general, we should try to fix that, as other things might rely
on /dev/apm_bios doing the right thing.

Ben.
