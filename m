Message-ID: <3BF013E3.52F45AE9@mvista.com>
Date: Mon, 12 Nov 2001 10:24:35 -0800
From: Jun Sun <jsun@mvista.com>
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
References: <Pine.GSO.3.96.1011112142501.24771K-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Maciej W. Rozycki" wrote:
>
> On Mon, 12 Nov 2001, Geert Uytterhoeven wrote:
>
> > >  Unless you use a non-MC146818 RTC, which you need to write a separate
> > > driver for anyway.
> >
> > Yep, so that's why both m68k and PPC have common routines to read/write the
> > RTC, with a /dev/rtc-compatible abstraction on top of it.
>
>  OK, then you need an RTC chipset-specific driver and not a CPU
> architecture-specific one.

You *can* write a chip specific driver in addition to this generic one if you
want.  Presumably the chip-specific one provides more operations than just
read/write date.

> Otherwise we'll end with a zillion of similar
> RTC drivers like we already have for LANCE and SCC chips.
>

Don't quite understand this statement.

If everybody uses the generic rtc driver, there will be only one copy of it.
It will prevent zillions copies of similar thing.

Note that hardware specifics are already abstracted by rtc_set_time() and
rtc_get_time() routines.  The generic RTC driver makes use of them and has no
RTC chip or machine dependent code.

Jun

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
