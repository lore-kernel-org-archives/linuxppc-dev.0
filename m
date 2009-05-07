Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5B35DDDF84
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 06:21:00 +1000 (EST)
To: Damien Dusha <d.dusha@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC5121 new board constantly resetting after u-boot passes
	control to Linux
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <c788c1220905070143t5271ebe1ra12df43f8f53e491@mail.gmail.com>
References: <c788c1220905070143t5271ebe1ra12df43f8f53e491@mail.gmail.com>
Date: Thu, 07 May 2009 22:20:55 +0200
Message-Id: <20090507202055.D86FA832C2FB@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Damien,

in message <c788c1220905070143t5271ebe1ra12df43f8f53e491@mail.gmail.com> you wrote:
> 
> We are attempting to bring up a new MPC5121e board, somewhat based on the
> Silicon Turnkey's ADS5121 development board.  We are using a kernel and
> u-boot based on Freescale/STx's board support package.

I recommend to use current code - tip of tree in U-Boot (although I
have a long stack of patches in the queue - wait for the weekend) and
Linux (use mainline aka kernel.org plus the patches I just posted for
a start).

> We have successfully modified u-boot for the 64MB of DDR2 RAM, and we can
> use u-boot's (and the BDI's) memory test facility to check that the RAM is
> working.

Let's say, it is *basicly* working. Note that these memory tests
don't stress-test the bus; for example, they do not stress-test any
burst-mode accesses.

See the FAQ: http://www.denx.de/wiki/view/DULG/UBootCrashAfterRelocation

My bet is you got a memory initialization error.

> At this point, the board immediately resets.  There is no hint of life from
> the kernel from the console, although setting a breakpoint on the BDI at
> 0x0000000 and tracing through appears as though some code (although we don't
> know what) is being executed.

Why don't you know which code this is? GDB will tell you.

Did you try the standard methods, like post-mortem dump of the log
buffer area, etc.?  See the FAQ for details.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I think there's a world market for about five computers.
         -- attr. Thomas J. Watson (Chairman of the Board, IBM), 1943
