Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 76A8667EB6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 03:04:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 9 Aug 2005 12:04:10 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859418@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Wall clock accuracy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sorry for double post...
=20

> -----Original Message-----
> From: Eugene Surovegin [mailto:ebs@ebshome.net]=20
> Sent: Tuesday, August 09, 2005 11:41
> It's not small drift (I usually have clock accuracy within +-50ppm),=20
> but still is much less than maximum 1024ppm NTPD can deal with.

My bigger problem with the walltime is that time_nsec should have been
1000000, not 999848 to begin with. If it had been, I would probably
never even have noticed it.

The thing is that that value is set based on a value I cannot find any
reference as how was chosen. Looks to be a leftover when porting PPC
fron i386 once upon a time.

time_nsec basically gets is value (via some macros) from
CLOCK_TICK_RATE, which is defined in asm-ppc/timex.h to be 1193180

In my opinion, time_nsec should have been calculated based on the actual
clock input rate to begin with (like in calibrate_decrementer()).
