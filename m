Return-Path: <dmitchell@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9DCABDDE0F
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 02:42:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: of_serial.c: adding UPF_FIXED_TYPE flag
Date: Wed, 3 Jun 2009 09:26:49 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C0772AF40@SDCEXCHANGE01.ad.amcc.com>
From: "David Mitchell" <dmitchell@amcc.com>
To: <linuxppc-dev@ozlabs.org>
Cc: arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

Are there any objections or concerns on adding UPF_FIXED_TYPE to the
port flags for the of_serial driver? Or maybe - are there any
implementations using of_serial that rely on the 8250's probing to
determine type? Based on the configs it looks like just the 4xx and 6xx
variants are using this driver.

The UPF_FIXED_TYPE is a flag added earlier this year to bypass the
8250's autoconfig probing to determine type ("Serial: Allow port type to
be specified when calling serial8250_register_port").

On our 16750 capable parts, the 8250's autoconfig probing is identifying
the UARTs as a 16550a. Adding this flag to of_serial's would let us
drive the type directly from the device tree. Thus we could avoid
polluting the 8250 driver with processor-specific tests.

Thoughts or other suggestions?

Thanks,

Dave Mitchell
AppliedMicro
