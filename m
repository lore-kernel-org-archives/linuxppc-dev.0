Date: Thu, 22 Jul 2004 16:55:36 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ralph Siemsen <rsiemsen@rossvideo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: early UART mapping in head_44x.S
Message-ID: <20040722165536.B20296@home.com>
References: <40F452D6.9020806@rossvideo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40F452D6.9020806@rossvideo.com>; from rsiemsen@rossvideo.com on Tue, Jul 13, 2004 at 05:23:34PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 13, 2004 at 05:23:34PM -0400, Ralph Siemsen wrote:
>
> I've been trying to boot a vanilla 2.6.7 kernel on a board similar to
> Ocotea (the board boots 2.4.x okay).  I wasn't getting any serial
> output, despite setting CONFIG_SERIAL_TEXT_DEBUG and doing early
> registration of a console (as per David Woodhouse's posts on this list).

That's a separate issue. I need to go through and early register
the console on 4xx when I get a moment.

> After much tracing and a lucky suggestion on IRC, I seem to have
> stumbled on the cause, although I don't fully understand what is going
> on.  In arch/ppc/kernel/head_44x.S (from 2.6.7 mainline) there is a
> block of code that sets up the "early UART mapping".  It does three
> tlbwe instructions, and then repeats the same a second time but in
> "Translation state 1".  This second set seems to cause my problems.
> When I comment out the 5 instructions before the isync, I magically
> start getting printk outputs.

Yeah, I fat-fingered the last patch to head_44x.S and left the
duplicate code fragment there. There's a patch submitted to fix
this in mainline.

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
