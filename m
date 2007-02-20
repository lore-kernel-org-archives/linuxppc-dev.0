Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 11C0CDDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 01:16:40 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [0/14] Ebony support, 2nd spin
Date: Tue, 20 Feb 2007 15:16:24 +0100
References: <20070220020837.GF17818@localhost.localdomain>
	<1171980307.24204.66.camel@zod.rchland.ibm.com>
In-Reply-To: <1171980307.24204.66.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702201516.25160.arnd@arndb.de>
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 20 February 2007 15:05, Josh Boyer wrote:
> Which probably has something to do with the of_serial driver being used
> now. =A0Just an FYI.

If you want to use of_serial together with serial console, you need
to make sure that the detection logic in arch/powerpc/kernel/legacy_serial.c
finds the port. It currently finds the serial port on axon, but that
requires that the bus it's on is of type "opb" and the device itself
is listed as "stdout" and has type "serial" and is compatible with
"ns16750" (note: the others look for "ns16550" here).

	Arnd <><
