Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 3426967BB6
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 12:49:00 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 23 Nov 2006 02:48:48 +0100
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: NTP time sync
Message-ID: <20061123014848.GA8675@iram.es>
References: <20061122203633.611acaa8@inspiron>
	<200611221155.26686.david-b@pacbell.net>
	<20061122212355.046de470@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20061122212355.046de470@inspiron>
Cc: akpm@osdl.org, Kim@ozlabs.org, linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ralf@linux-mips.org, David Brownell <david-b@pacbell.net>,
	Andi Kleen <ak@muc.de>, lethal@linux-sh.org, paulus@samba.org,
	kkojima@rr.iij4u.or.jp, hackers@lists.ntp.isc.org,
	davem@davemloft.net, rmk@arm.linux.org.uk, mills@udel.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 22, 2006 at 09:23:55PM +0100, Alessandro Zummo wrote:
> On Wed, 22 Nov 2006 11:55:23 -0800
> David Brownell <david-b@pacbell.net> wrote:
>=20
> > >=20
> > >  So, if the arch maintainers agree,=20
> > >  I would suggest to schedule it for removal.
> > >=20
> > > [1] http://lkml.org/lkml/2006/3/28/358
> >=20
> > Suggested time of removal: one year after two relevant software
> > package releases get updated:
> >=20
> >   - NTPD, to call hwclock specifying the relevant RTC;
>=20
>  This might introduce delays. ntpd might open the device
>  and update the time itself.
>=20

Indeed, the update should be at least _triggered_ by ntp.

In the end it will be the kernel that accesses the hardware,
the fundamental problem is that with RTC chips with very slow=20
access like I2C it cannot be done from an interrupt.

But it nevertheless has to be done as close as possible
to the half-second or second boundary (depending on the chip)=20
boundary if we want to keep some precision. You can't expect=20
miracles from RTC chips in this respect, since the crystal
period is about 30=B5s to boot and from some tests I did a long
time ago it seems that most do not reset the first bits of
the divider when written to, so the precision is much worse
(something like 30ms IIRC). It is still much better than 1
second in any case.

How can ntp know if the RTC chip has to be updated at the=20
half-second or second boundary? That is the kind of knowledge
that is better left to the driver.

	Regards,
	Gabriel
