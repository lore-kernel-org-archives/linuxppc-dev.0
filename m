Message-ID: <40F452D6.9020806@rossvideo.com>
Date: Tue, 13 Jul 2004 17:23:34 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: early UART mapping in head_44x.S
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been trying to boot a vanilla 2.6.7 kernel on a board similar to
Ocotea (the board boots 2.4.x okay).  I wasn't getting any serial
output, despite setting CONFIG_SERIAL_TEXT_DEBUG and doing early
registration of a console (as per David Woodhouse's posts on this list).

After much tracing and a lucky suggestion on IRC, I seem to have
stumbled on the cause, although I don't fully understand what is going
on.  In arch/ppc/kernel/head_44x.S (from 2.6.7 mainline) there is a
block of code that sets up the "early UART mapping".  It does three
tlbwe instructions, and then repeats the same a second time but in
"Translation state 1".  This second set seems to cause my problems.
When I comment out the 5 instructions before the isync, I magically
start getting printk outputs.

But as-written, the code causes an exception immediately upon the first
attempt to write to the mapped space.  Of course there are no exception
handlers in place at this point, so things grind to a halt very quickly.

Can anyone explain how this is meant to work?  Specifically, the
	ori	r3,r3,PPC44x_TLB_TS
would clear the other bits in this register, including the "valid" bit,
so how is this mapping supposed to work?

Thanks
-Ralph

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
