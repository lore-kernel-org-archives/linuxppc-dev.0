Return-Path: <ejohnson@acdstar.com>
Received: from mail.acdstar.com (mail.acdstar.com [209.98.244.9])
	by ozlabs.org (Postfix) with ESMTP id AD3A267A72
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 10:53:40 +1100 (EST)
Received: from zaphod.acdstar.com (zaphod.int.acdstar.com [192.168.2.100])
	by mail.acdstar.com (8.13.0/8.13.0) with ESMTP id j1FNuupr003815
	for <linuxppc-embedded@ozlabs.org>; Tue, 15 Feb 2005 17:56:56 -0600
Message-Id: <6.2.1.2.1.20050215174631.02dfbf28@mail.int.acdstar.com>
Date: Tue, 15 Feb 2005 17:55:21 -0600
To: linuxppc-embedded@ozlabs.org
From: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
In-Reply-To: <712A2DEC228C7448978CBD7A7AD5B090592CE2@fever.wardrobe.irob
	ot.com>
References: <712A2DEC228C7448978CBD7A7AD5B090592CE2@fever.wardrobe.irobot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: Re: How to set a custom baud rate using 2.6 linux distro on
 MPC5200 based board?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>I'm trying to set a custom baud rate (500KBaud, in case anyone cares) on 
>one of the PSCs on a MPC5200 board.
[snip]
>   serial_info.flags = ASYNC_SPD_CUST | ASYNC_LOW_LATENCY;
>    serial_info.custom_divisor = 48;  // clock on FTDI chip / 48 == 500KB
>
>    if ( ioctl(tty_fd, TIOCSSERIAL, &serial_info ) < 0) {
>      perror("config_serial_port: ioctl TIOCSSERIAL");
>      return(-1);
>    }
>
>This compiled fine under the ppc cross-dev tools we have but it fails with 
>an "invalid argument" error when run on the ppc board.

It looks like this code was written for an FTDI serial port.  The FTDI is a 
USB to Serial converter that handles baud rate generation very differently 
from a standard UART.

Eric
