From: "Steve Boorman" <steveb@baydel.com>
To: linuxppc-embedded@lists.linuxppc.org
Date: Fri, 16 Jul 2004 15:49:50 +0100
Subject: Re: PPC440 Kernel Stack overflow
Reply-To: Steve Boorman <steveb@baydel.com>
Message-ID: <40F7F91E.18124.2F5883@localhost>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark,

Thanks for your comments, you are basically confirming what I
suspected, that accessing regions of memory outside the allocated
stack area are not trapped. It looks like the Kernel stack pointer is
just compared when context switches occur, and only then reported if
out of range.

> I'm curious about your watchdog - a true watchdog should hard reset
> your board if not serviced.  So you've really got a high priority
> interrupt I guess, which is probably not much use, (as you're
> finding out).  If it were an NMI you could at least write some code
> that would jump to the reset vector or something like that.

The watch-dog we use is built into the PPC440GP. The first time it
expires it generates a critical interrupt, the second time, if still
enabled, will cause a hardware reset if that function is enabled.
Whilst tracking down our original bug we didn't want the hardware
reset to occur as it would definitely loose any debug information
that may still be left in memory, hence we run it with reset
disabled.

Regards,
Steve Boorman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
