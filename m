Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 34522DE7C4
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 07:45:49 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 82xx performance
Date: Wed, 16 Jul 2008 23:45:26 +0200
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807152150.35811.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04B3490E@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04B3490E@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807162345.26395.arnd@arndb.de>
Cc: Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 July 2008, Rune Torgersen wrote:
> Turns out the story is no so simple.
> I redid the test wih all versions of arch/ppc from 2.6.18 to 2.6.26, and
> also arch/powerpc (2.6.24 and 25, 26 doesn't compile because of binutil
> issues)
>=20
> This time I made very sure that the tests were performed the same way,
> and I made a tabel showing relative performance:
>=20
> kernel =A0 =A0 =A0 =A0compile time =A0 rel =A0 context switch =A0rel
> v2.6.18 =A0 =A0 =A0 =A0 01:13:33.70 =A01.00 =A0 =A0 =A0 7.2 =A0 =A0 =A0 =
=A01.00
> v2.6.19 =A0 =A0 =A0 =A0 01:13:29.21 =A01.00 =A0 =A0 =A0 7.1 =A0 =A0 =A0 =
=A00.99
> v2.6.20 =A0 =A0 =A0 =A0 01:13:29.58 =A01.00 =A0 =A0 =A0 2.8 =A0 =A0 =A0 =
=A00.39
> v2.6.21 =A0 =A0 =A0 =A0 01:13:24.91 =A01.00 =A0 =A0 =A0 8.1 =A0 =A0 =A0 =
=A01.13
> v2.6.22 =A0 =A0 =A0 =A0 01:13:42.72 =A01.00 =A0 =A0 =A0 4.5 =A0 =A0 =A0 =
=A00.63
> v2.6.23 =A0 =A0 =A0 =A0 01:15:16.43 =A01.02 =A0 =A0 =A0 17 =A0 =A0 =A0 =
=A0 2.36
> v2.6.24 =A0 =A0 =A0 =A0 01:15:30.90 =A01.03 =A0 =A0 =A0 20 =A0 =A0 =A0 =
=A0 2.78
> v2.6.25 =A0 =A0 =A0 =A0 01:14:51.21 =A01.02 =A0 =A0 =A0 21 =A0 =A0 =A0 =
=A0 2.92
> v2.6.26 =A0 =A0 =A0 =A0 01:14:34.76 =A01.01 =A0 =A0 =A0 23.8 =A0 =A0 =A0 =
3.31
> v2.6.24-powerpc 01:17:41.99 =A01.06 =A0 =A0 =A0 25.8 =A0 =A0 =A0 3.58
> v2.6.25-powerpc 01:18:10.10 =A01.06 =A0 =A0 =A0 35.7 =A0 =A0 =A0 4.96
>=20
> This shows that arch/ppc no matter versin is fairly consistent in speed.
> Arch/powerpc is roughtly 6% worse.
>=20
> The contect swith column is found running lat_ctx 2 from lmbench3, and
> should be in microsecs.

Ok, I think this could be related mostly to two changes:

* In 2.6.23, the process scheduler was replaced, the new one is the CFS,
the 'completely fair scheduler'. This has changed a lot of data.
To verify this, you could check out a git version just before and just
after CFS went in.

* Obviously, the 6 percent change between ppc and powerpc should not
be there. You can still try to use 'readprofile', or oprofile in
timer based mode (i.e. without HW performance counters) to get some
more data about where the time is spent on an identical kernel version.

	Arnd <><
