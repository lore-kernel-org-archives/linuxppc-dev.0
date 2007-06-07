Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C802ADDEE2
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 23:03:26 +1000 (EST)
In-Reply-To: <200706070039.51541.arnd@arndb.de>
References: <1181147415.5674.108.camel@rhino>
	<200706070039.51541.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <d58f68e0c42ba9c01b1bbbecabb03e1a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix the LPC47M192 SuperIO on the MPC8641 HPCN
Date: Thu, 7 Jun 2007 15:03:20 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +=A0=A0=A0=A0=A0=A0=A0/* LPC47M192 Super I/O configuration */
>> +=A0=A0=A0=A0=A0=A0=A0outb(0x55, 0x4e);=A0=A0=A0=A0=A0=A0=A0/* enter =
superio config mode */
>> +
>> +=A0=A0=A0=A0=A0=A0=A0/* Enable keyboard and mouse */
>> +=A0=A0=A0=A0=A0=A0=A0outb(0x07, 0x4e);=A0=A0=A0=A0=A0=A0=A0/* device =
selector register */
>> +=A0=A0=A0=A0=A0=A0=A0outb(0x07, 0x4f);=A0=A0=A0=A0=A0=A0=A0/* select =
keyboard registers (device=20
>> 7) */
>> +=A0=A0=A0=A0=A0=A0=A0outb(0x30, 0x4e);=A0=A0=A0=A0=A0=A0=A0/* =
keyboard activation register */
>> +=A0=A0=A0=A0=A0=A0=A0outb(0x01, 0x4f);=A0=A0=A0=A0=A0=A0=A0/* =
activate keyboard */
>
> Hardcoded I/O port numbers always worry me a little. I know that this=20=

> is
> supposed to work in general, but can't you read the I/O port range =
from
> a device tree property?

This code is writing hardcoded values into IRQ#
and address window registers, the superio configuration
address should be the least of your worries ;-)


Segher
