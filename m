Return-Path: <SRS0+5a975b97460a6157554b+1319+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B3F3DDE34
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 23:04:36 +1000 (EST)
Subject: Re: [PATCH 1/5 v2] adb: replace sleep notifier with class
	suspend/resume hooks
From: David Woodhouse <dwmw2@infradead.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1175676113.3556.2.camel@johannes.berg>
References: <20070319181800.149901000@sipsolutions.net>
	<20070319183619.051498000@sipsolutions.net>
	<1174349717.3660.7.camel@johannes.berg>
	<1175676113.3556.2.camel@johannes.berg>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 09:03:58 -0400
Message-Id: <1175691839.2774.11.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-04 at 10:41 +0200, Johannes Berg wrote:
> 
> So class suspend/resume hooks are apparently not called unless you do
> some more magic juju.
> 
> I'll work more sysfs foo to fix it. You can probably
> make /sys/power/state work and have adb still work by just applying all
> the patches up to "remove dead code in via-pmu86k".
> 
> Then again, which patches do you have applied now? Do you even have this
> one? I only sent you the other ones, and if you only have those applied
> then the problem must be elsewhere... 

I didn't have this set of patches applied. I have these:

Subject: [PATCH 1/3] rework pm_ops pm_disk_mode, kill misuse
Subject: [PATCH 2/3] power management: remove firmware disk mode
Subject: [PATCH 3/3] power management: implement pm_ops.valid for everybody

Subject: [PATCH 1/5] powerpc: generic time suspend/resume code
Subject: [PATCH 2/5] powerpc: fix suspend states again
Subject: [PATCH 3/5] powermac: disallow pmu sleep notifiers from aborting
Subject: [PATCH 4/5 v2] powermac: proper sleep management

It does re-probe ADB on resume, and it finds the keyboard every time
(thankfully). It just doesn't find the mouse more than about 1 in 10
times. Could it just be a timing thing? Resume seems to be a lot faster
with the patches applied.

-- 
dwmw2
