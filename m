Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 711B967A8C
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 06:05:16 +1100 (EST)
Date: Tue, 18 Jan 2005 12:05:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20050118190514.GL28724@smtp.west.cox.net>
References: <41EC29A8.1040703@mvista.com>
	<20050118161515.GI28724@smtp.west.cox.net>
	<41ED5BBA.2090808@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41ED5BBA.2090808@mvista.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 18, 2005 at 11:55:54AM -0700, Mark A. Greer wrote:
> Tom Rini wrote:
[snip]
> >>Is there a better way to do this?
> >>   
> >>
> >
> >How about we try borrowing the MIPS abstraction and force todc_time,
> >pmac_time (any others?) to directly define (and EXPORT_SYMBOL)
> >get_rtc_time / set_rtc_time / etc.
> >
> 
> Yep, MIPS has a solution...and so does ARM...and so does PPC.  This is 
> sort of my point.

And my point was to use someone elses solution, 'cuz that's how we go
from N to N-1 to 1 :)

> If we really want to do it right then someone needs to architect a 
> generic solution.  What I have done is generic but does not handle the 
> case that Geert mentioned when you have one kernel binary and several 
> possible rtc chips.  In the meantime, what I have done works fine for 
> all but that case.

I guess there's two points:
- How does your solution differ from what MIPS does, and probably ARM
  does of saying the backend (todc_time, i2c-foo) provides
  get_rtc_time/set_rtc_time?
- I horribly briefly talked with rmk about this a long time ago, and I
  think he has the generic solution, siting in arch/arm/common/rtctime.c
  (sure it would need to be moved to drivers/char/something, but..).
- I lied, #3 how does ARM, which I think lets you select multiple
  boards, and thus probably end up with multiple rtc chip choices, deal
  with it.

-- 
Tom Rini
http://gate.crashing.org/~trini/
