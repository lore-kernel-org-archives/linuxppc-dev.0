Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id EE7D967A6E
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 05:08:43 +1100 (EST)
Date: Wed, 19 Jan 2005 11:08:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20050119180841.GP28724@smtp.west.cox.net>
References: <41EC29A8.1040703@mvista.com>
	<20050118161515.GI28724@smtp.west.cox.net>
	<93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
	<20050118181330.GJ28724@smtp.west.cox.net>
	<41ED5C51.8020809@mvista.com>
	<20050118190848.GM28724@smtp.west.cox.net>
	<41ED66D0.2090506@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41ED66D0.2090506@mvista.com>
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

On Tue, Jan 18, 2005 at 12:43:12PM -0700, Mark A. Greer wrote:
> Tom Rini wrote:
> 
> >On Tue, Jan 18, 2005 at 11:58:25AM -0700, Mark A. Greer wrote:
> > 
> >
> >>Tom Rini wrote:
> >>
> >>   
> >>
> >>>I think one of us wasn't clear.  I'm not arguing for nuking
> >>>ppc_md.{get,set}_rtc_time(), I'm arguing for nuking
> >>>get_rtc_time()/set_rtc_time() inlines from <asm-ppc/rtc.h> (which are
> >>>used by drivers/char/genrtc.c) in favor of todc_time et al providing the
> >>>functions for genrtc.  So all of the other places we use
> >>>ppc_md.{get,set}_rtc_time() are unchanged.
> >>>     
> >>>
> >>Ahh.  Okay, that's good but it should be done in drivers/rtc or 
> >>something like and not just another arch specific solution.
> >>   
> >>
> >
> >It's not an arch specific solution today.
> >
> 
> Okay, I see what you mean and yes moving that up (or something 
> equivalent) would be a good idea.
> 
> That's not what my patch is about though.  My patch is just so I can 
> provide a generic solution with what is there today.  Its not 
> redesigning anything, its just getting asm-ppc/rtc.h out of the way so I 
> can make my own, generic get_rtc_time(), etc.

I guess the problem I have is you're not providing a generic solution
(it won't work on PPC_MULTIPLATFORM), you're providing a different hook
for your board(s) :)

Taking a look at arch/arm/common/rtctime.c again finally, it solves this
problem rather elegantly.  The board registers with the driver the
rtc_ops to get at the chip.

So until we get around to stealing arch/arm/common/rtctime.c, I'd rather
you used something like:
- arch/ppc/Kconfig (or where ever you add the board bits)
  config PPC_DIFFERENT_GENRTC_HOOKS
  default y if BOARD_A || BOARD_B
- include/asm-ppc/rtc.h : what you had, basically.

-- 
Tom Rini
http://gate.crashing.org/~trini/
