Message-ID: <391C3273.4BBF0884@motorola.com>
Date: Fri, 12 May 2000 11:33:55 -0500
From: "Richard Hendricks" <richard.hendricks@motorola.com>
MIME-Version: 1.0
To: "Dan A. Dickey" <ddickey@charter.net>
CC: "linuxppc-embedded@lists.linuxppc.org"  <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rom code to go on FADS?
References: <391B220F.9838E70F@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What do you mean, exactly?  How to get it to run stand-alone?  The
way I understand it, the 8xxROM code is designed to work stand-alone.

Do you mean running with the ADI&MPC8bug connected?  In that case,
you could try reseting the ADS board without letting MPC8bug run its
default configuration scripts (type "reset :ni" I believe).  This will
not initialize any of the on-chip registers.  You might have to turn
on the ADS board, start MPC8bug, shut off the ADS board, turn the
ADS board back on again, then run "reset :ni" in order for this to
work properly, since MPC8bug does a reset when it starts.  This will
make sure the registers are in their default state.  Once you do that,
you should be able to do a "go", and the CPU should start automatically
at 0x0100.  Remember though, MPC8bug doesn't do address translation, so
it will have problems displaying memory locations once the MMU's have
been enabled.

"Dan A. Dickey" wrote:
>
> Ok, so I have the 8xxrom code running on my fads board;
> and so far I've only been able to run it by using the
> ADI connected to the debug port.  I noticed the other
> day that it was actually running without the ADI connected.
> (Lights blinking, RS232 status LED coming on, etc...)
>
> However, I cannot seem to figure out how to cause this to
> happen at will.  Is there some configuration thing I need
> to set via the debug port?  (Using mpc8bug95 on a windows
> machine talking to the ADI board connected to the debug
> port).
>
> If anyone is familar with how this is done, I'd appreciate
> a reply.   Thanks again.
>         -Dan
>

--
MPC823 Applications Engineering Development
Get help from other MPC823 customers on the
comp.sys.powerpc.tech newsgroup!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
