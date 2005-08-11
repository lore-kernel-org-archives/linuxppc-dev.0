Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 8C2D5680A8
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Aug 2005 02:19:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 11 Aug 2005 11:19:49 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859423@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
Subject: FW: CLOCK_TICK_RATE
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

CLOCK_TICK_RATE is the basis for TIME_NSEC which is used to update xtime
on every timer interrupt, so it is very relevant for PPC.

CLOCK_TICK_RATE is used for LATCH which is used for ACTHZ which in turn
is used for TIME_NSEC
=20

> -----Original Message-----
> From: Andreas Schwab [mailto:schwab@suse.de]=20
> Sent: Thursday, August 11, 2005 11:15
> To: Rune Torgersen
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: CLOCK_TICK_RATE
>=20
> "Rune Torgersen" <runet@innovsys.com> writes:
>=20
> > Hi
> >
> > I have found that I need to set CLOCK_TICK_RATE (currently=20
> defined in
> > include/asm-ppc/timex.h) to something else.
>=20
> I can't find any use of CLOCK_TICK_RATE in the kernel that is=20
> relevant for
> ppc.

>From a previous thread in linux-ppc-embedded (Wall clock accuracy)
> -----Original Message-----
> From: George Anzinger [mailto:george@mvista.com]=20
> Sent: Tuesday, August 09, 2005 19:07
>
> The problem here is that the CLOCK_TICK_RATE is not correctly=20
> defined.=20
> This should be the rate at which the decrementer is clocked in hertz.=20
> If this is properly defined the tick_nsec value will be what=20
> works to to=20
> be an integral number of these that gives an nsec value less than or=20
> equal to what LATCH says you should be using for the number of=20
> decrementer counts in a jiffie.  It is important that this be=20
> correctly=20
> defined so that a) LATCH is right and b) the jiffies to/from=20
> conversions=20
> are done right.  These conversions rely on TICK_NSEC to get the right=20
> answer.  (Also, so you don't step into a computing mess, it=20
> is important=20
> that these be defined at compile time so the compiler can do=20
> the heavy=20
> lifting.  If defined as variables the conversions will take a=20
> LOT longer=20
> (and use more code to boot).)
>=20
> If you are getting 999848, it would appear that you are using the x86=20
> value which, I assume, is NOT right for a PPC, but then the=20
> PPC is NOT=20
> my strong suit...
>
