Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 2396568423
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Oct 2005 05:22:31 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 4 Oct 2005 14:22:29 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85947A@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <george@mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: RE: clock skew on B/W G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> From: George Anzinger [mailto:george@mvista.com]=20
> But this is defined in include/asm/???.h  so you should be=20
> able to set something more to your liking=20
> (or rather to your archs liking).  It is true that it SHOULD=20
> be defined as it is used to define=20
> TICK_NSEC which is used to define the=20
> jiffies<-->timeval/timespec conversions which would be VERY=20
> slow it it were a variable.

Just make them variables, and compute them ONCE during boot.
ppc calls calibrate_decr() before enabling the timer interrupt anyways.

time_nsec is easy.=20
in a platfrom specific file do (very simplified):

extern unsigned long time_nsec;

void platform_specific_calibrate_decr()
{
	time_nsec =3D REAL_TIME_NSEC;
}

This (of course) will do nothing about LATCH and ACTHZ that might be
used other places.
