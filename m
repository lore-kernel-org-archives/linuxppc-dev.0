Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 29C9CDDD06
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 15:54:54 +1000 (EST)
Subject: MPC885 hang in a lwarx/stwcx insn crossing a page boundary
From: Heiko Schocher <hs@denx.de>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 24 Apr 2007 07:55:47 +0200
Message-Id: <1177394147.6353.30.camel@Zeus.EmbLux>
Mime-Version: 1.0
Reply-To: hs@denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have a MPC885 and a running 2.6.16 kernel on it. I use the CPU15
Errata Patch from
(http://ozlabs.org/pipermail/linuxppc-dev/2007-April/033789.html)

Now if a lwarx/stwcx insn crossing a page boundary, the CPU hangs in
an endless loop, because the reservation allocated from the lwarx gets
cleared in the case of a tlb miss. And the CPU15 workaround invalidates
the tlbs around the page we're faulting in, so we cause a nasty infinite
loop. I started a service request at Freescale, and they are searching
why a tlbie clears the reservation or under which circumstances this
appears.

Without the CPU15 Errata patch it runs fine, but i can reproduce the
CPU15 Bug, so I need the or some CPU15 Errata patch ...

I also have a running 2.4.24-pre2 Kernel on this board, with the same
CPU15 Errata patch, and there the hang doesnt occur!! Some ideas where
the differences between 2.4.24-pre2 and 2.6.16 are?

I also didnt get this hang in userspace with the 2.6.16er Kernel.

So I see at the moment the following possibilities:

a) patching the gcc, so that the CPU15 Errata is no more necessary
   My favorit.

b) upgrade the CPU15 Bug like in the MPC885 Errata Sheet from Freescale
   (I think this is to much code for in an Exceptionhandler ...)

c) I made before every lwarcx a ".align" so that the insn is on one
   page. This is actually running without seeing problems on the board.
   But it is a "errata" for the "errata" ...

d) ...

Some suggestions, ideas? Especially, why the hang doesnt occur with a
2.4.24-pre2 kernel?

thanks
Heiko
-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
