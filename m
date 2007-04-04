Return-Path: <SRS0+5a975b97460a6157554b+1319+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF599DDE2C
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 07:21:33 +1000 (EST)
Subject: Re: [PATCH 1/5 v2] adb: replace sleep notifier with class
	suspend/resume hooks
From: David Woodhouse <dwmw2@infradead.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1175706447.7388.13.camel@johannes.berg>
References: <20070319181800.149901000@sipsolutions.net>
	<20070319183619.051498000@sipsolutions.net>
	<1174349717.3660.7.camel@johannes.berg>
	<1175676113.3556.2.camel@johannes.berg>
	<1175691839.2774.11.camel@shinybook.infradead.org>
	<1175706447.7388.13.camel@johannes.berg>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 17:20:56 -0400
Message-Id: <1175721656.4640.3.camel@shinybook.infradead.org>
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

On Wed, 2007-04-04 at 19:07 +0200, Johannes Berg wrote:
> Is that the version you have in the fedora CVS? Because that one seems
> to be an older one that has a bug with set_context.

Yes. I've updated the patch in CVS; thanks for pointing it out.

> > Subject: [PATCH 3/5] powermac: disallow pmu sleep notifiers from aborting
> > Subject: [PATCH 4/5 v2] powermac: proper sleep management
> > 
> > It does re-probe ADB on resume, and it finds the keyboard every time
> > (thankfully). 
> 
> Interesting.
> 
> > It just doesn't find the mouse more than about 1 in 10
> > times. Could it just be a timing thing? Resume seems to be a lot faster
> > with the patches applied.
> 
> I have to admit that I have no idea, I don't have a machine with ADB in
> it. I'll poke at the code a bit.

Not sure if the subsequent patch was expected to change anything or not,
but it doesn't...

 $ dmesg | grep -i adb
PM: Adding info for platform:adb.0
adb: starting probe task...
adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
Detected ADB keyboard, type ISO, swapping keys.
input: ADB keyboard as /class/input/input1
input: ADB Powerbook buttons as /class/input/input2
ADB mouse at 3, handler set to 4 (trackpad)
input: ADB mouse as /class/input/input3
adb: finished probe task...
adb adb.0: suspend
adb adb.0: LATE suspend
adb adb.0: EARLY resume
adb adb.0: resuming
adb: starting probe task...
adb devices: [2]: 2 c4 [7]: 7 1f
ADB keyboard at 2, handler 1
adb: finished probe task...

-- 
dwmw2
