Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 13 May 2003 12:21:45 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfgang Denk <wd@denx.de>, Richard Zidlicky <rz@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: set_rtc_time() cleanup / normalization
Message-ID: <20030513102145.GA3997@iram.es>
References: <20030513081817.A25655@mrt-lx1.iram.es> <Pine.GSO.4.21.0305131051420.20323-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0305131051420.20323-100000@vervain.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, May 13, 2003 at 10:53:28AM +0200, Geert Uytterhoeven wrote:
>
> On Tue, 13 May 2003, Gabriel Paubert wrote:
> > On Tue, May 13, 2003 at 09:52:22AM +0200, Geert Uytterhoeven wrote:
> > > On Mon, 12 May 2003, Wolfgang Denk wrote:
> > > > I would like to find out if there is some consensus about the use  of
> > > > set_rtc_time() in the timer interrupt handler.
> > >
> > > On m68k, we removed that part because it confused NTP. Richard Zidlicky can
> > > probably tell more about that.
> >
> > I certainly would like to know the details of this. I believe it may
> > be fixing the symptom rather than the cause (an NTP bug).
>
> As far as I remember, NTP estimates the error of your RTC and uses that
> estimation to correct your time if no NTP server is available, but the
> estimation step fails if the kernel messes with the RTC behind NTP's back.

In this case NTP should never clear the STA_UNSYNC flag shen it
synchronized to the local clock (driver 127.127.0.0 IIRC) . The state
change from 0x41 to 0x01 should never happen for the kernel side of
the status flags, this would avoid creating the loop.

	Regards,
	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
