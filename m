Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id DCC5ADDE41
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 11:07:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Help with device tree binding for SMC serial
Date: Thu, 10 Jan 2008 18:07:34 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03D9A042@ismail.innsys.innovsys.com>
In-Reply-To: <47866FDE.5070307@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com>
	<4785246D.6090206@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BC9@ismail.innsys.innovsys.com>
	<47854AE1.7080802@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BEF@ismail.innsys.innovsys.com>
	<47854D6D.2010906@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58C20@ismail.innsys.innovsys.com>
	<20080110175348.GA4317@loki.buserror.net>
	<DCEAAC0833DD314AB0B58112AD99B93B03D99E60@ismail.innsys.innovsys.com>
	<47866FDE.5070307@freescale.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Scott Wood [
> Rune Torgersen wrote:
> > Not sure what was wrong. We took a step back, and redid=20
> some stuff, and
> > now we have serial output from the boot-wrapper.
> > THe checkstop came from the wrapper grying to access the=20
> bcsr and doing
> > the chip select fixup. We don';t have a bcsr on our board,=20
> and the cs
> > layout is different.
>=20
> There's no bcsr access in the upstream bootwrapper (the=20
> mention of bcsr=20
> in cuboot-pq2.c is just one reason why some boards require us=20
> to do the=20
> CS programming), and the CS programming is chip-level, not=20
> board-level=20
> (it just requires that the device tree have a correct=20
> localbus node for=20
> the board).

Finally got it (sort-of) working.
Turned out that for some reason the console init is setting the baudrate
to 9600
the options string passed in to the console init fuunction is NULL.

Any idea oon how this should be passed in from u-boot?
