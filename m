Return-Path: <jangiels@speakeasy.net>
Received: from mail1.speakeasy.net (mail1.speakeasy.net [216.254.0.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AAB9D2BDA5
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2004 05:12:34 +1000 (EST)
From: Jeff Angielski <jangiels@speakeasy.net>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <1098379749.8619.16.camel@nighteyes.localdomain>
References: <A3240F62EF3C2749B1A25D3BC9548F4148BCF1@ExchWENZ02.wenz.global.vpn>
	<721875C6-236D-11D9-9860-003065F9B7DC@embeddededge.com>
	<1098371711.3508.9.camel@nighteyes.localdomain>
	<B9C9EB8C-2378-11D9-9860-003065F9B7DC@embeddededge.com>
	<1098379749.8619.16.camel@nighteyes.localdomain>
Content-Type: text/plain
Message-Id: <1098385953.8619.38.camel@nighteyes.localdomain>
Mime-Version: 1.0
Date: Thu, 21 Oct 2004 15:12:33 -0400
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: SCC UART -"tx interrupt buffer pointer"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


When testing with 57600, the stall was slightly different.  I did not
see a problem with the TX_WAKEUP, rather something was inconsistent with
the SCC itself.  The "Tx interrupt buffer pointer" in the SCC parameter
ram was outside the range of valid buffer addresses.

There are 4 buffers starting at: 0x00194284, 0x001942a4, 0x001842c4, and
0x001842e4.  The "Tx interrupt buffer pointer" was 0x00194304 which is 1
byte passed the end of the last buffer.  The TBPTR was ok, just the
interrupt buffer pointer was "bad".

Is this a bug in the hardware or does the Tx internal pointer get
wrapped at some other time?

FWIW, here is the dump of the parameter ram at that point in time:

SCC parameter ram:
==================
bdi2000>md 0xf0008100
f0008100 : 01100130 30300020 30001000 0019425e  ...000. 0.....B^
f0008110 : 01280006 e50679e3 30000000 00194304  .(....y.0.....C.
                                      ^^^^^^^^ <- "Tx internal buf ptr"
f0008120 : 01300000 0000f2fd 8c1e5e6f f4b7b9ca  .0........^o....
           ^^^^^^^^ <- TBPTR
f0008130 : 1a744c5d 9f2da4bd 00200000 00010000  .tL].-... ......
f0008140 : 00000000 00001bfd 00000000 7ea50000  ............~...
f0008150 : 80008000 80008000 80008000 80008000  ................
f0008160 : c0ff726f b6ca6434 59a7fd75 bb0efefd  ..ro..d4Y..u....
 
SCC RX BDs:
==========
f0000110 : 91000020 00194204 91000020 00194224  ... ..B.... ..B$
f0000120 : 9100001a 00194244 b1000020 00194264  ......BD... ..Bd

SCC TX BDs:
==========
f0000130 : 10000020 00194284 10000020 001942a4  ... ..B.... ..B.
f0000140 : 10000020 001942c4 30000020 001942e4  ... ..B.0.. ..B.


TIA,
Jeff
