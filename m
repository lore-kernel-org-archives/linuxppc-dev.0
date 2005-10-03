Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id B187368446
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Oct 2005 00:30:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 3 Oct 2005 09:18:14 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Marc" <marvin24@gmx.de>, <linuxppc-dev@ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: clock skew on B/W G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:  Marc
> Sent: Sunday, October 02, 2005 11:46
>=20
> Some additions to the previous mail: I was able to isolate=20
> the problem to the=20
> introduction of a user specificable value of HZ (in=20
> include/asm-ppc/parm.h).=20
> I used a value of 250 while the former default was 1000.=20
> Setting it back to=20
> 1000 makes the clock tick right again.
>=20
> Is the CONFIG_HZ known to be broken on PPC ?
>=20

CONFIG_HZ is not broken, but the whole clock configuration is.
(I poseded something about it for 8260 earlier this summer)

Basic problem is that CLOCK_TICK_RATE which is used for setting up the
variables used for advancing the clock, is hardcoded to a value that
only makes sence for an i386. (it is default set at 1193180Hz which
happens to be the timer clock for timer1 on an i386 machine)

Another problem here is that that value apparently hve to be #define'd
which means you cannot insert the decrementer frequency from the
boot-loader either.
