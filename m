Date: Wed, 14 Nov 2001 11:08:42 +0100
From: Richard Zidlicky <rz@linux-m68k.org>
To: Jun Sun <jsun@mvista.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
Message-ID: <20011114110842.A473@linux-m68k.org>
References: <Pine.GSO.4.21.0111122055010.10720-100000@mullein.sonytel.be> <3BF0371F.8040575B@linux-m68k.org> <20011113144240.B669@linux-m68k.org> <3BF15F55.AABB383C@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BF15F55.AABB383C@mvista.com>; from jsun@mvista.com on Tue, Nov 13, 2001 at 09:58:45AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 13, 2001 at 09:58:45AM -0800, Jun Sun wrote:
> Richard Zidlicky wrote:
>
> > Btw the interrupt need not to be hardware, for the Q40 I test
> > a rtc register once per jiffie and generate a "soft interrupt".
> > It could be done generic at least for m68k.
> >
>
> I have written an experiemntal ptimer driver to do just this and potential
> more.  Such a device is useful for real-time programming (e.g., when you try
> to implement a periodic user task).
>
> See http://linux.junsun.net/realtime-linux/preemption-test
>
> The driver is architecture independent (i.e., linux-common code)
>
> Due to the different programming needs behind periodic timers (or user-level
> timer) and RTC operations, my vote for future work is to leave them as two
> separate drivers.  To me, RTC is really just to read/write RTC clock.

RTC_UIE is needed (or at least very useful) to set the clock, so it belongs
into a rtc driver if it can be implemented. General purpose timers are
different story, btw what is wrong with setitimer that you have chosen
to implement an additional driver for it?

Richard

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
