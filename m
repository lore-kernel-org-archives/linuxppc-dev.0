From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 15 May 2003 12:45:42 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Zidlicky <rz@linux-m68k.org>, Wolfgang Denk <wd@denx.de>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: set_rtc_time() cleanup / normalization
Message-ID: <20030515104542.GA19980@iram.es>
References: <20030514230638.GB1687@linux-m68k.org> <Pine.GSO.4.21.0305151031410.13683-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0305151031410.13683-100000@vervain.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, May 15, 2003 at 10:32:12AM +0200, Geert Uytterhoeven wrote:
> On Thu, 15 May 2003, Richard Zidlicky wrote:
> > On Wed, May 14, 2003 at 05:42:24PM +0200, Gabriel Paubert wrote:
> > > On Tue, May 13, 2003 at 02:03:51PM +0200, Richard Zidlicky wrote:
> >
> > > > - RTC should be accessed by proper rtc device driver only
> > >
> > > This model is already broken by the fact that you read the time
> > > early in boot to get reasonable initial values. So I don't buy
> > > at all this argument.
> >
> > reading it early during boot is a bit different, no worry about
> > interrupts, long delays etc. Also this could be actually done
> > by accessing /dev/rtc.
>
> Actually this breaks on machines where the RTC is on i2c, since i2c wasn't
> initialized yet.

Well, that's tough, it should at least be read before the first
userspace program is sorted. Could it be read and passed from a
bootloader with a botinfo record (repeatedly read the clock until
you cross a second boundary and get the timebase at this point).

Something like BI_CLOCK
struct bi_clock {
	unsigned long timebase;
	unsigned long tv_sec;
}


Reading the clock is easy under OF, don't know about others.

	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
