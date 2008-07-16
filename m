Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id C8147DE1A0
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 07:08:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 82xx performance
Date: Wed, 16 Jul 2008 16:08:35 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04B3490E@ismail.innsys.innovsys.com>
In-Reply-To: <200807152150.35811.arnd@arndb.de>
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807142244.07450.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04AE6877@ismail.innsys.innovsys.com>
	<200807152150.35811.arnd@arndb.de>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Arnd Bergmann" <arnd@arndb.de>, "Milton Miller" <miltonm@bga.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Tuesday 15 July 2008, Rune Torgersen wrote:
>> Using arch/ppc I got a 2.6.25 kernel to boot, and the kernel compile
>> test I did is almost identical (within 1%) of what the arch/powerpc
>> 2.6.25 did, so it seems to be a difference between 2.6.18 and 2.6.25
>> (I'll see if I can find an exact version, as I think my ppc port can
>> be compiled for all versions from 2.6.18 to 25)
>=20
> You probably already know git-bisect, but if you don't, you should
> definitely give it a try. It's the best tool to find which patch
> exactly broke your performance.

Turns out the story is no so simple.
I redid the test wih all versions of arch/ppc from 2.6.18 to 2.6.26, and
also arch/powerpc (2.6.24 and 25, 26 doesn't compile because of binutil
issues)

This time I made very sure that the tests were performed the same way,
and I made a tabel showing relative performance:

kernel        compile time   rel   context switch  rel
v2.6.18         01:13:33.70  1.00       7.2        1.00
v2.6.19         01:13:29.21  1.00       7.1        0.99
v2.6.20         01:13:29.58  1.00       2.8        0.39
v2.6.21         01:13:24.91  1.00       8.1        1.13
v2.6.22         01:13:42.72  1.00       4.5        0.63
v2.6.23         01:15:16.43  1.02       17         2.36
v2.6.24         01:15:30.90  1.03       20         2.78
v2.6.25         01:14:51.21  1.02       21         2.92
v2.6.26         01:14:34.76  1.01       23.8       3.31
v2.6.24-powerpc 01:17:41.99  1.06       25.8       3.58
v2.6.25-powerpc 01:18:10.10  1.06       35.7       4.96

This shows that arch/ppc no matter versin is fairly consistent in speed.
Arch/powerpc is roughtly 6% worse.

The contect swith column is found running lat_ctx 2 from lmbench3, and
should be in microsecs.
