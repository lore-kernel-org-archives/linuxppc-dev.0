Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id D4AC867A64
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 07:53:00 +1100 (EST)
Message-ID: <41F01A23.2090907@mvista.com>
Date: Thu, 20 Jan 2005 13:52:51 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <41EC29A8.1040703@mvista.com>
	<20050118161515.GI28724@smtp.west.cox.net>
	<93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
	<20050118181330.GJ28724@smtp.west.cox.net>
	<41ED5C51.8020809@mvista.com>
	<20050118190848.GM28724@smtp.west.cox.net>
	<41ED66D0.2090506@mvista.com>
	<20050119180841.GP28724@smtp.west.cox.net>
In-Reply-To: <20050119180841.GP28724@smtp.west.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Tom Rini wrote:

>
>I guess the problem I have is you're not providing a generic solution
>(it won't work on PPC_MULTIPLATFORM), you're providing a different hook
>for your board(s) :)
>

Tom, again, [I think that] you are thinking the patch I submitted is 
trying to solve something that it isn't.  I think we both agree that the 
current rtc architecture (or lack thereof) needs to be improved.  And 
maybe the ARM way is the way to go.  That's fine but that's not what the 
patch I submitted is trying to do.

The patch I submittted is only trying to be the most generic it can be 
with the rtc architecture that is there today.  The patch will work on 
any architecture, even on PPC/MULTIPLATFORM.  It is not only for my 
boards, its for any board on any architecture.  Also, it isn't a 
different hook, its the same hook asm-ppc/rtc.c uses.  The only thing it 
doesn't work for is one kernel binary supporting more than one rtc 
chip.  So its about as generic as you can get given the rtc architecture 
that is there today.

Also, this is not without precedent.  drivers/char/ds1302.c, for 
example, is a complete parallel as what I'm doing.  The only difference 
is that it [essentially] duplicated the code in genrtc and its not an 
i2c device.

>
>Taking a look at arch/arm/common/rtctime.c again finally, it solves this
>problem rather elegantly.  The board registers with the driver the
>rtc_ops to get at the chip.
>

That's nice...  :)

>
>So until we get around to stealing arch/arm/common/rtctime.c, I'd rather
>you used something like:
>- arch/ppc/Kconfig (or where ever you add the board bits)
>  config PPC_DIFFERENT_GENRTC_HOOKS
>  default y if BOARD_A || BOARD_B
>

Why?  There is no reason do add in the 'if BOARD_A' stuff.  I've added a 
simple option, if you want to use the m41t00 rtc--this is what I'm doing 
this for--select i2c and the correct i2c algo/adapter, select the m41t00 
i2c client, and [if on ppc] select the option to turn off 
include/asm-ppc/rtc.h.  If its too hard to remember, it can be easily 
captured in a arch/ppc/configs/xxx_defconfig file.  :)

>- include/asm-ppc/rtc.h : what you had, basically.
>
>  
>

Mark
