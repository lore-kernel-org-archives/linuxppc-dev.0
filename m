Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 407A42BD81
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2004 09:54:30 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20041018232004.0a9e0d5e@jack.colino.net>
References: <20041018232004.0a9e0d5e@jack.colino.net>
Content-Type: text/plain
Message-Id: <1098143379.18687.44.camel@gaston>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 09:49:40 +1000
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: PMU questions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2004-10-19 at 07:20, Colin Leroy wrote:
> Hi everyone,
> 
> I'm at a loss with a PMU-related problem... Basically something happened
> and my iBook (G4 14") battery now thinks it can last only 30 minutes.
> It used to be 3+ hours. I don't really know what happened.

Happens all the time on Apple laptops lately. My tipb battery is now
half of it's capacity. Browse the archives on the web, you'll see that
it's a common disease with those.

> After having tried to recalibrate it using Apple's secret-code
> (shift-control-option-power) and cycling it, things only got worse. I
> suspect it's due to the fact Linux doesn't put the laptop to sleep
> when the battery empties, but I don't have an OS X partition nor can
> backup 40GB...

No, it has nothing to do with Linux. 

> So I'm about to buy a new battery, but I fear the stupidity of the PMU
> will make it work as bad as the current one. So, here are the questions
> I have, I think people there will be more apt to answer me than any
> hotliner I could get at Apple:
> - is the max_charge field displayed in /proc/pmu/battery_0 stored in the
> PMU itself, or in the battery ? If I get a new battery and can't
> calibrate it, I do hope it's stored in the battery, but I'm really not
> sure about that.

It's all coming from the battery itself.

> - Would there be any way to overwrite this value by using some hack in
> via-pmu.c, or is that PMU a real black-box ? If it's writable, does
> there exist code somewhere to do that, or some doc I could use to write
> it ?

Not that I know of.

> - If there are people on this list with an iBook g4 14", could you tell
> me what's your max_charge value is ? mine is now 507... :-/

You can try the following: disable pmud & pbbuttonsd, and let the machine
on & drain the battery until it shuts down by itself (empty battery). Do
_not_ let it go to sleep or whatever pmud does when it thinks your battery
is closed to exhausted. Drain the battery completely.

Then, do a full charge, and drain it again completely.

Do that a few times. If that doesn't help, then I'm afraid you have to
ask apple for a replacement battery.

Ben.
