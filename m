Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler2.mail.xerox.com (wvmler2.mail.xerox.com [13.8.138.217])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "wvmler2.mail.xerox.com",
	Issuer "wvmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E1A52679E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 22:25:08 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 82xx_io UART BRG's vs BUS CLK
Date: Tue, 14 Feb 2006 11:23:51 -0000
Message-ID: <35786B99AB3FDC45A8215724617919736D9236@gbrwgceumf01.eu.xerox.net>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Russell McGuire" <rmcguire@uwbt.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I did some math on the BRG calculations and with 66Mhz the BRG divisor
is
> 17.8 I am assuming 17 gets written, and with 66.666Mhz then its 18.02
so
> thus 18 probably gets written. Should perhaps a constant minus 1 be
added to
> the code?

> Using:
> U-boot 1.1.2
> DENX Linux 2.4.25

> Is anyone aware of similar issues, or are there bug fixes past the
2.4.25
> Kernel for this?

> -Russ

Hi Russ

I am not familiar with your hardware, nor have I checked the code that
calculated the Baud rate divisor.

I would advise against "adding a constant -1", in favour of rounding
to the nearest integer. From your figures:

  divisor =3D clock / (baudrate * 32)

To get a rounded result using real numbers:

  divisor =3D integer_part_of((clock / (baudrate * 32)) + 1/2)

Using integer arithmetic, you can code this in C as:

  divisor =3D ((clock / baudrate /16) + 1) >> 1;

I would check whether or not the code is doing this, or the equivalent,
and if not, change it. If the code is doing this, the divisor should be
18 in both cases.

Clive
