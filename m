Date: Wed, 18 Dec 2002 11:55:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: embedded list <linuxppc-embedded@lists.linuxppc.org>,
	Todd Poynor <tpoynor@mvista.com>
Subject: Re: 405LP RTC reset
Message-ID: <20021218005542.GC3666@zax.zax>
References: <1040150612.10740.111.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1040150612.10740.111.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 17, 2002 at 12:43:32PM -0600, Hollis Blanchard wrote:
> Here's the updated 405LP RTC reset diff (after David's move of the RTC
> functions to ibm405lp.c). This patch
> a) does a full RTC reset as specified in the docs
> b) sets the RTC clock speed in RTC "Register A" DV bits, i.e. it does
> not assume the firmware has done this correctly.
>
> Please apply to _2_4_devel.

Seems to work on my Arctic-2, and now applied.

One query though (I didn't think of this earlier) - is it such a great
idea to go setting the reference clock frequency?  Unlike most other
drivers, we can't just take over the RTC and do what we like with it
once the kernel boots, because it has to keep running at the same rate
even when the device is rebooting or (mostly) off.  So, unless I'm
mistaken, things will be bogus anyway if the divider isn't already
correct when the driver initializes - so it seems a bit misleading to
set it in the driver itself.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
