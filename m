Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id E8A4567A80
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 09:53:22 +1100 (EST)
Date: Thu, 20 Jan 2005 15:53:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20050120225321.GB2626@smtp.west.cox.net>
References: <41EC29A8.1040703@mvista.com>
	<20050118161515.GI28724@smtp.west.cox.net>
	<93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
	<20050118181330.GJ28724@smtp.west.cox.net>
	<41ED5C51.8020809@mvista.com>
	<20050118190848.GM28724@smtp.west.cox.net>
	<41ED66D0.2090506@mvista.com>
	<20050119180841.GP28724@smtp.west.cox.net>
	<41F01A23.2090907@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41F01A23.2090907@mvista.com>
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

On Thu, Jan 20, 2005 at 01:52:51PM -0700, Mark A. Greer wrote:
> Tom Rini wrote:
> 
> >
> >I guess the problem I have is you're not providing a generic solution
> >(it won't work on PPC_MULTIPLATFORM), you're providing a different hook
> >for your board(s) :)
> 
> Tom, again, [I think that] you are thinking the patch I submitted is 
> trying to solve something that it isn't.  I think we both agree that the 
> current rtc architecture (or lack thereof) needs to be improved.  And 
> maybe the ARM way is the way to go.  That's fine but that's not what the 
> patch I submitted is trying to do.

So you're saying that using the hook directly isn't a different hook?  I
suppose we can agree to disagree, since it's not relevant really :)

> The patch I submittted is only trying to be the most generic it can be 
> with the rtc architecture that is there today.  The patch will work on 
> any architecture, even on PPC/MULTIPLATFORM.  It is not only for my 

It can't work on PPC/MULTIPLATFORM as that's a kernel with multiple rtc
chips in one binary (pmac, todc for prep, chrp?).

> >So until we get around to stealing arch/arm/common/rtctime.c, I'd rather
> >you used something like:
> >- arch/ppc/Kconfig (or where ever you add the board bits)
> > config PPC_DIFFERENT_GENRTC_HOOKS
> > default y if BOARD_A || BOARD_B
> 
> Why?  There is no reason do add in the 'if BOARD_A' stuff.  I've added a 
> simple option, if you want to use the m41t00 rtc--this is what I'm doing 
> this for--select i2c and the correct i2c algo/adapter, select the m41t00 
> i2c client, and [if on ppc] select the option to turn off 
> include/asm-ppc/rtc.h.  If its too hard to remember, it can be easily 
> captured in a arch/ppc/configs/xxx_defconfig file.  :)

Why ask the user for something you know he wants?  If they've selected
GENRTC and are using the board, they'll probably want GENRTC to work.
It's exactly what you described except the user won't have to know about
anything going on.

-- 
Tom Rini
http://gate.crashing.org/~trini/
