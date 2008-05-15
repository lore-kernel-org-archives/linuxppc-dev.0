Return-Path: <garyj@denx.de>
Received: from mout1.freenet.de (mout1.freenet.de [195.4.92.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9DD06DE22C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 05:02:28 +1000 (EST)
Received: from [195.4.92.12] (helo=2.mx.freenet.de)
	by mout1.freenet.de.freenet.de with esmtpa (ID
	gary.jennejohn@freenet.de) (port 25) (Exim 4.69 #19)
	id 1Jwiic-00054C-GI
	for linuxppc-dev@ozlabs.org; Thu, 15 May 2008 21:02:22 +0200
Received: from mace2.m.pppool.de ([89.49.172.226]:56689
	helo=peedub.jennejohn.org)
	by 2.mx.freenet.de with esmtpa (ID gary.jennejohn@freenet.de) (port 25)
	(Exim 4.69 #12) id 1Jwiic-0008Pv-76
	for linuxppc-dev@ozlabs.org; Thu, 15 May 2008 21:02:22 +0200
Date: Thu, 15 May 2008 21:02:21 +0200
From: Gary Jennejohn <garyj@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: 440EPx - SPI and IIC1 conflict
Message-ID: <20080515210221.2cd19762@peedub.jennejohn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: gary.jennejohn@freenet.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I've developed a driver for the SPI controller in the 440EPx, which should
also work for e.g. the 460EX, and maybe other AMCC processors.

According to the UM bit 14 in SDR0_PFC1 controls whether certain signals
are for IIC1 or SPI.  My driver assures that this bit is set to 0.  Note
that I haven't been able to find any code in the Linux tree which
manipulates this register except for my driver, so IIC1 isn't actually
enabled for the 440EPx or the 460EX.

Anyway.  In order to guarantee that IIC1 doesn't interfere with the
operation of SPI I have this code snippet in i2c-ibm_of.c:

#if (defined(CONFIG_SPI_PPC4xx) || defined(CONFIG_SPI_PPC4xx_MODULE)) \
	&& defined(CONFIG_440EPX)
	/*
	 * Hack, but on the 440EPx we can have either IIC1 or SPI.
	 */
	if (dev->paddr == 0x1ef600800ULL)
		goto fail1;
#endif

which skips IIC1 if the SPI controller is being used.

However, this isn't very aesthetically pleasing.

A colleague suggested testing bit 14 in SDR0_PFC1 and bailing if it's
set.

The problem with this is that the test would depend on the order in which
the init routines are called.  Right now the SPI driver is initialized
before the i2c driver, but I'm not certain that this would be the case for
all time.

Basically I'm wondering whether anyone on this list has any brilliant
idea for handling this problem or whether my present solution is really
just OK.

---
Gary Jennejohn
*********************************************************************
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
*********************************************************************
