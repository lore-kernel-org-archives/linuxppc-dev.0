Date: Tue, 13 May 2003 08:18:17 +0000
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfgang Denk <wd@denx.de>, Richard Zidlicky <rz@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: set_rtc_time() cleanup / normalization
Message-ID: <20030513081817.A25655@mrt-lx1.iram.es>
References: <20030512211733.B489EC6092@atlas.denx.de> <Pine.GSO.4.21.0305130951230.20323-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0305130951230.20323-100000@vervain.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, May 13, 2003 at 09:52:22AM +0200, Geert Uytterhoeven wrote:
>
> On Mon, 12 May 2003, Wolfgang Denk wrote:
> > I would like to find out if there is some consensus about the use  of
> > set_rtc_time() in the timer interrupt handler.
> >
> >     Note: this question relates to a thread that was started by
> >     Stephen Johnson on Tue, 22 Apr 2003; see message:
> >     http://lists.linuxppc.org/linuxppc-embedded/200304/msg00233.html
> >
> > The problem: some systems use RTC chips which  are  attached  to  the
> > system  using an I2C bus (or similar). To control the device you will
> > have to setup one or more I2C transactions, which usually  result  in
> > one or more interrupts which must be processed.
> >
> > Depending on which architecture and/or board you are using, there may
> > or may not be a call to set_rtc_time()  be  performed  in  the  timer
> > interrupt  handler.  This  call  will  happen  every  11 minutes (659
> > seconds, to be precise) - see "arch/ppc/kernel/time.c".
> >
> >
> > I would like to know if there is a rationale  in  putting  this  call
> > into a general part of the source code.
> >
> > Other architectures handle this differently. For example, in the  ARM
> > kernel   tree  the  timer  interrupt  implementation  is  essentially
> > board-specific (located in a include/asm/arch-.../time.h file).  Some
> > ARM  boards'  timer interrupt handlers do call set_rtc_time(), others
> > don't.
> >
> > Shouldn't we do the same on PPC?
> >
> > Or maybe we should delete this code completely? If somebody wants  to
> > sync the RTC against the system time a simple daemon or cron job (for
> > example calling "hwclock --systohc" every 11 minutes) would result in
> > more or less identical results.
>
> On m68k, we removed that part because it confused NTP. Richard Zidlicky can
> probably tell more about that.

I certainly would like to know the details of this. I believe it may
be fixing the symptom rather than the cause (an NTP bug).

	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
