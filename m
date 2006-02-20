Return-Path: <Bjorn.Ostby@combitech.se>
Received: from ms-101.aerotechtelub.se (ms-101.aerotechtelub.se
	[192.176.33.163]) by ozlabs.org (Postfix) with ESMTP id 9575267A3A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Feb 2006 00:47:30 +1100 (EST)
Received: from ratatosk.combitechsystems.com (unverified) by
	ms-101.aerotechtelub.se (Clearswift SMTPRS 5.2.3) with ESMTP id
	<T76944d7320c0b021a3824@ms-101.aerotechtelub.se> for
	<linuxppc-embedded@ozlabs.org>; Mon, 20 Feb 2006 14:37:24 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: SCCx UART status on 8xx
Date: Mon, 20 Feb 2006 14:37:23 +0100
Message-ID: <004B1D7A5257174C9044A1B7BD0E60ED0178CC4F@ratatosk.combitechsystems.com>
From: =?iso-8859-1?B?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitech.se>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
I'm messing with a mpc823e based board trying to enable the SCC3 UART. =
I'm using the 2.4.25 denx linux_ppc kernel and I've got SMC1 for console =
and SMC2 up and running but I'm in desperate need of another rs232 port =
(which is on SCC3 on my board).=20
Reading quite a lot of old posts on this mailing list got me confused =
whether the SCCx UART support in the kernel is ready to be used on 8xx =
or if there will take a large amount of hacking to get things going =
(reading the header of 8xx_io/uart.c got me wondering even more).
Current situation is that I have enabled the SCC3 UART in the kernel, =
set the correct CTS, RTS and CD signal options and finally disabled the =
SPI which (on my board at least) can override the UART on the third SCC =
port. During boot up I get the standard output:

>ttyS0 at 0x0280 is on SMC1 using BRG1
>ttyS1 at 0x0380 is on SMC2 using BRG2
>ttyS2 at 0x0200 is on SCC3 using BRG3

Writing to ttyS0 and ttyS1 works fine (the result pop up in the =
receiving terminal) but when trying ttyS2 nothing happens. I've checked =
the Tx signal and it appears as if data is sent (the signal gets noisy =
when starting the write procedure). I may also add that restaring the =
write application causes the kernel to hang (for ttyS2 only of course).

I've read some posts saying that Linux don't init other uart ports than =
the console port and that is the potential problem here, but it is =
unclear if this statement is true or not. I can also add to the problem =
description that my SMC2 port works fine for writing, but reading just =
hangs in the read() call. So, can anyone confirm any status on the SMCx =
and SCCx UART drivers for 2.4?

Best regards,
Bjorn ostby
