Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id A8A6A67A7E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Mar 2005 21:36:10 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 23 Mar 2005 11:36:03 +0100
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D19@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Vijay Padiyar" <vijay_padiyar@hotmail.com>,
	"LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
Subject: RE: question about writing to memory directly from user space in
	Linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vijay Padiyar wrote:
>I am running Linux 2.6.10 on an MPC8260 target. We have an I2C
controller
>that is part of our application code. In VxWorks, we could address the
>MPC8260 I2C memory registers directly from application space and so
this was
>not a problem.

The I2C abstraction layer of Linux is very good, and user-land support
quite comfortable. Why bother port/develop a new driver? Besides,=20
interrupt handling in user-space can be troublesome..

>Can you suggest some kind of a "synchronization" function which I can
call
>from *user space* which will ensure that all values written to mmaped
memory
>locations from user space are actually flushed to their physical
locations?
>I think this might be a potential problem with my code.

Please have a look at Denx's FAQ for accessing memory bus:

=20
http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acce
ssingPeripheralsFromUserSpace
or shorter: http://tinyurl.com/6c7th

Depending on the O_SYNC flag passed to open, the mmap'ed memory will be
accessed through non guarded cache or not. See linux/drivers/char/mem.c.
The ppc instruction "eieio" deals with I/O ordering.


Regards,
--=20
Stephane
