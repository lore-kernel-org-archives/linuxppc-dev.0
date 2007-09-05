Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.mud.yahoo.com (smtp104.biz.mail.mud.yahoo.com
	[68.142.200.252]) by ozlabs.org (Postfix) with SMTP id 7DE90DDFF8
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 08:15:49 +1000 (EST)
In-Reply-To: <20070905205301.GA807@ld0162-tx32.am.freescale.net>
References: <20070905192727.GA32365@ld0162-tx32.am.freescale.net>
	<4F58F233-56E5-4910-9D33-28A44FCB393C@embeddedalley.com>
	<20070905205301.GA807@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CF1B6B97-44FA-4002-9030-3C1A20F2F2F4@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 1/9] 8xx: Fix CONFIG_PIN_TLB.
Date: Wed, 5 Sep 2007 15:08:28 -0700
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 5, 2007, at 1:53 PM, Scott Wood wrote:

> Where is the code that checks for pinned TLB entries on 8xx when doing
> ioremap?

I don't know.  I haven't been the maintainer for the 2.6
changes.

>   Why could this not be done with a 512K mapping?  How was this
> even tested, given the obvious wrong-register mistake in the other
> CONFIG_PIN_TLB section?  On what do you base the assumption that  
> flash is
> within 8MB of the IMMR base?

All of this worked in 2.4, many changes were part
of the evolution in 2.6...  configurable pinned entries,
large page sizes, variations, I didn't keep track of
all of this.  I just assumed I'd have to fix it all if I
ever needed to use it, which I haven't.  The original
version of 8xx could wire exactly three entries for
8M text, 8M data, and 8M IMMR plus upper device
addresses.  We would set the IMMR to ff800000,
cover the CPM, some other devices and the flash
at the top of memory.  If you have too much flash, this
had to be adjusted accordingly, but for small systems
this was a nice performance enhancement.

> I didn't change it on a whim, I changed it because ioremap() wasn't
> working the way it currently is.

This processor is severely resource limited.  It's
far better to fix ioremap and take advantage of this
performance enhancement than to further
cripple it.  Just like other processors test for
mapping by BATs or CAMs, the 8xx and
probably 4xx should test for wired mapping.

Unfortunately, lots of things got messed up on 2.6
for the 8xx.  I was not in the loop to approve changes,
and most of my advice was ignored. :-)

Thanks.

	-- Dan
