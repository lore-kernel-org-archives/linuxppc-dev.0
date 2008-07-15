Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id F15E1DE1CA
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 04:11:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 82xx performance
Date: Tue, 15 Jul 2008 13:12:05 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04AE685A@ismail.innsys.innovsys.com>
In-Reply-To: <9dc3e1e709ad1aa47ae4c73f18c4d5e0@bga.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<9dc3e1e709ad1aa47ae4c73f18c4d5e0@bga.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Milton Miller" <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 9919_unit  Linux 2.6.25       powerpc-linux-gnu  434    32    32 =20
> > 1.0000 1
> > 9919_unit  Linux 2.6.18       powerpc-linux-gnu  445    32    32 =20
> > 1.0100 1
>=20
> Hmm, processor MHz is off by 11/445

I noticed that.

> And memory latency is off 13/500.
>=20
> That sounds like it will be 16/666.
>=20
> Are you using the same board and the same firmware?

Yes. Same board, same firmware, same filesystem, just booted with
different kernels.

>=20
> If so, look at /proc/cpuinfo and/or the boot log to see what
> frequency linux thinks the processor is running at.  It sounds
> like someone introduced or fixed a rounding error error calculating
> the timebase frequency for your board.

2.6.18 /proc/cpuinfo
processor       : 0
cpu             : G2_LE
revision        : 1.4 (pvr 8082 2014)
bogomips        : 296.96
chipset         : 8250
vendor          : Innovative Systems LLC
machine         : AP Gold

mem size                : 0x40000000
console baud            : 115200

core clock      : 447 MHz
CPM  clock      : 298 MHz
bus  clock      : 99 MHz


2.6.25 /proc/cpuinfo
processor       : 0
cpu             : G2_LE
clock           : 447.897600MHz
revision        : 1.4 (pvr 8082 2014)
bogomips        : 49.53
timebase        : 24883200
platform        : Innovative Systems ApMax


> Please try the sleep test: sleep for 100 seconds, and time with
> either a stopwatch or another system.  I think you will find they
> take different amounts of time, and all the results need to be scaled.
> You might be able to see it reading the hardware clock.

Sleep 100 takes excactly 100 seconds on both kernels (verified with
stopwatch and external ntp server)
