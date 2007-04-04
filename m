Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6D7DDDE2B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 09:13:11 +1000 (EST)
Subject: Re: [PATCH 1/5 v2] adb: replace sleep notifier with class
	suspend/resume hooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1175691839.2774.11.camel@shinybook.infradead.org>
References: <20070319181800.149901000@sipsolutions.net>
	<20070319183619.051498000@sipsolutions.net>
	<1174349717.3660.7.camel@johannes.berg>
	<1175676113.3556.2.camel@johannes.berg>
	<1175691839.2774.11.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 09:12:11 +1000
Message-Id: <1175728331.30879.77.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-04 at 09:03 -0400, David Woodhouse wrote:
> On Wed, 2007-04-04 at 10:41 +0200, Johannes Berg wrote:
> > 
> > So class suspend/resume hooks are apparently not called unless you do
> > some more magic juju.
> > 
> > I'll work more sysfs foo to fix it. You can probably
> > make /sys/power/state work and have adb still work by just applying all
> > the patches up to "remove dead code in via-pmu86k".
> > 
> > Then again, which patches do you have applied now? Do you even have this
> > one? I only sent you the other ones, and if you only have those applied
> > then the problem must be elsewhere... 
> 
> I didn't have this set of patches applied. I have these:
> 
> Subject: [PATCH 1/3] rework pm_ops pm_disk_mode, kill misuse
> Subject: [PATCH 2/3] power management: remove firmware disk mode
> Subject: [PATCH 3/3] power management: implement pm_ops.valid for everybody
> 
> Subject: [PATCH 1/5] powerpc: generic time suspend/resume code
> Subject: [PATCH 2/5] powerpc: fix suspend states again
> Subject: [PATCH 3/5] powermac: disallow pmu sleep notifiers from aborting
> Subject: [PATCH 4/5 v2] powermac: proper sleep management
> 
> It does re-probe ADB on resume, and it finds the keyboard every time
> (thankfully). It just doesn't find the mouse more than about 1 in 10
> times. Could it just be a timing thing? Resume seems to be a lot faster
> with the patches applied.

Hrm... ADB resume is supposed to fire a thread and if you have a
trackpad, it's supposed to wait for some time for it to settle...

Ben.
