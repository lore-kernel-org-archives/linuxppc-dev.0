Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D059DE031
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 06:20:24 +1100 (EST)
Message-ID: <47866FDE.5070307@freescale.com>
Date: Thu, 10 Jan 2008 13:19:58 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Help with device tree binding for SMC serial
References: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com>
	<4785246D.6090206@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BC9@ismail.innsys.innovsys.com>
	<47854AE1.7080802@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BEF@ismail.innsys.innovsys.com>
	<47854D6D.2010906@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58C20@ismail.innsys.innovsys.com>
	<20080110175348.GA4317@loki.buserror.net>
	<DCEAAC0833DD314AB0B58112AD99B93B03D99E60@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03D99E60@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Not sure what was wrong. We took a step back, and redid some stuff, and
> now we have serial output from the boot-wrapper.
> THe checkstop came from the wrapper grying to access the bcsr and doing
> the chip select fixup. We don';t have a bcsr on our board, and the cs
> layout is different.

There's no bcsr access in the upstream bootwrapper (the mention of bcsr 
in cuboot-pq2.c is just one reason why some boards require us to do the 
CS programming), and the CS programming is chip-level, not board-level 
(it just requires that the device tree have a correct localbus node for 
the board).

-Scott
