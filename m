Date: Tue, 13 May 2003 09:52:22 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Wolfgang Denk <wd@denx.de>, Richard Zidlicky <rz@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: set_rtc_time() cleanup / normalization
In-Reply-To: <20030512211733.B489EC6092@atlas.denx.de>
Message-ID: <Pine.GSO.4.21.0305130951230.20323-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 12 May 2003, Wolfgang Denk wrote:
> I would like to find out if there is some consensus about the use  of
> set_rtc_time() in the timer interrupt handler.
>
>     Note: this question relates to a thread that was started by
>     Stephen Johnson on Tue, 22 Apr 2003; see message:
>     http://lists.linuxppc.org/linuxppc-embedded/200304/msg00233.html
>
> The problem: some systems use RTC chips which  are  attached  to  the
> system  using an I2C bus (or similar). To control the device you will
> have to setup one or more I2C transactions, which usually  result  in
> one or more interrupts which must be processed.
>
> Depending on which architecture and/or board you are using, there may
> or may not be a call to set_rtc_time()  be  performed  in  the  timer
> interrupt  handler.  This  call  will  happen  every  11 minutes (659
> seconds, to be precise) - see "arch/ppc/kernel/time.c".
>
>
> I would like to know if there is a rationale  in  putting  this  call
> into a general part of the source code.
>
> Other architectures handle this differently. For example, in the  ARM
> kernel   tree  the  timer  interrupt  implementation  is  essentially
> board-specific (located in a include/asm/arch-.../time.h file).  Some
> ARM  boards'  timer interrupt handlers do call set_rtc_time(), others
> don't.
>
> Shouldn't we do the same on PPC?
>
> Or maybe we should delete this code completely? If somebody wants  to
> sync the RTC against the system time a simple daemon or cron job (for
> example calling "hwclock --systohc" every 11 minutes) would result in
> more or less identical results.

On m68k, we removed that part because it confused NTP. Richard Zidlicky can
probably tell more about that.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
