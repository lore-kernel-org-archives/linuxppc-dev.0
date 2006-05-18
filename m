Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx009.isp.belgacom.be (outmx009.isp.belgacom.be
	[195.238.5.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57EBE67B32
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 May 2006 00:10:55 +1000 (EST)
Received: from outmx009.isp.belgacom.be (localhost [127.0.0.1])
	by outmx009.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4IEAcPX003752
	for <linuxppc-embedded@ozlabs.org>; Thu, 18 May 2006 16:10:39 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: About BDI2000 and mpc8247
Date: Thu, 18 May 2006 16:12:06 +0200
References: <ee10e9f40605180640g12a2671bo530c3ccbba8b3829@mail.gmail.com>
	<ee10e9f40605180656q58f989bcg562b48d765afdba5@mail.gmail.com>
In-Reply-To: <ee10e9f40605180656q58f989bcg562b48d765afdba5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605181612.06314.laurent.pinchart@tbox.biz>
Cc: Gosiuua <gosiuua@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>  i have a develop board based on mpc8247. It has no eeprom to restore
> hareware configure word and i have to use default config word
> 0x00000000.
>  my bdi config file:
[...]

You should tell the BDI to initialize the SYPCR register, otherwise the 
internal watchdog timer will keep resetting the CPU.

[INIT]
; *** Initialize the core internal registers
; Program the SYPCR - Disable the watchdog timer
WM32    0xf0010004      0xffff2081

You will need to initiliaze other internal registers as well (BCR, SIUMCR, 
BRx, ORx, ...).

I'm not sure if this will be enough to solve your problem, but it should at 
least be a start.

Laurent Pinchart
