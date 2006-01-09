Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw5.extranet.tce.com (dmzraw5.extranet.tce.com
	[157.254.234.142]) by ozlabs.org (Postfix) with ESMTP id 4A84D68A35
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jan 2006 23:21:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 9 Jan 2006 13:16:33 +0100
Message-ID: <1CFEB358338412458B21FAA0D78FE86D042A2F4E@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: <linuxppc-embedded@ozlabs.org>, "Arnd Bergmann" <arnd@arndb.de>
Subject: RE: io.h question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
>On Thursday 05 January 2006 21:00, mcnernbm@notes.udayton.edu wrote:
>> I finally noticed out_8 and in_8 and what not are located in the
>> ppc io.h file in the kernel development download.=A0 But when I=20
>> tried to do a io.h with in my program I added #include <asm/io.h>=A0
>> and it seems to find it with not problems but it can not find the
>> functions with in that file.=A0 Am i missing a define I need to set
>> or something so I can see the right files with in io.h I am
>> compiling for a ppc405 on a xilinx virtex 4 board.     =20
>
>The definitions in that file are only usable from inside the kernel,
>you can not use them in a user space application.

You may not include the file directly from a user-land application
program, but you may copy/paste the in_*/out_* macros, with appropriate=20
care off course.

>The correct way to solve your problem (which you did not explain, so
>I can only guess) would be to write a kernel device driver for
>the peripherial you want to drive, at least if it does not exist yet.

Sometimes, user-land access can make things simpler. YMMV.

>For prototyping, you can play with mmap() on /dev/mem in a user
>application, but that is often not very reliable.

For sake of curiosity, what is not reliable in mmap'ed access
by user application?

Regards,
--=20
Stephane
