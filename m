Return-Path: <Martin.Leisner@xerox.com>
Received: from wvmler3.mail.xerox.com (wvmler3.mail.xerox.com [13.8.138.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler3.mail.xerox.com",
	Issuer "wvmler3.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 45ED7DDEF3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 May 2007 05:42:15 +1000 (EST)
Received: from wvmlir1.mail.xerox.com (wvmlir1.mail.xerox.com [13.147.8.221])
	by wvmler3.mail.xerox.com (8.13.8/8.13.6) with ESMTP id
	l4PJgCbd028546
	for <linuxppc-embedded@ozlabs.org>; Fri, 25 May 2007 12:42:13 -0700
Received: from wvmlir1.mail.xerox.com (localhost [127.0.0.1])
	by wvmlir1.mail.xerox.com (8.13.8/8.13.6) with ESMTP id l4PJfxCH016374
	for <linuxppc-embedded@ozlabs.org>; Fri, 25 May 2007 12:41:59 -0700
Received: from USA7061GW002.na.xerox.net (usa7061gw002.na.xerox.net
	[13.151.210.15])
	by wvmlir1.mail.xerox.com (8.13.8/8.13.6) with ESMTP id l4PJfxXM016359
	for <linuxppc-embedded@ozlabs.org>; Fri, 25 May 2007 12:41:59 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: taiga/7448 questions
Date: Fri, 25 May 2007 15:40:51 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C066B5A8E@usa0300ms03.na.xerox.net>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: "Lund, Nathan" <Nathan.Lund@xerox.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

OK, I built 2.6.20.11 and 2.6.21.1 for taiga...with the supplied config=20
(and I didn't know about the dtc for powerpc until I booted and nothing
happened).
I changed a few things (like /proc/config.gz)

A few issues I've seen:

1) after we start booting, the console turns off until the login message
appears:

taiga login: [    0.000000] Zone PFN ranges:
000000]   Normal     131072 ->   131072
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   131072
[    0.000000] Built 1 zonelists.  Total pages: 130048
[    0.000000] Kernel command line: root=3D/dev/sda2 =
console=3DttyS0,11520
[    0.000000] mpic: Setting up MPIC "Tsi108_PIC" version 1.2 at
c0007400, max 4 CPUs
[    0.000000] mpic: ISU size: 24, shift: 5, mask: 1f
[    0.000000] mpic: Initializing for 24 sources
[    0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)



Linux System
Kernel 2.6.21.1 on an ppc
Version: #2 Thu May 24 14:37:53 EDT 2007

This is consistent on 2.6.20.11 and 2.6.21.1...

2) Does "reboot" work?  Even when I do a <sysrq-magic-b> it doesn't want
to boot
until I do a hardware reset....

3) It seems 2.6.21.1 consistently works, 2.6.20.11 sometimes hangs (and
since I can't see the
console, I don't know what's hanging and why)


4) The dtb strategy seems to a little clumsy...is there a way to embed a
default dtc into a kernel
(so if you just tftp one file, something happens?)  I like the ability
to do fewer operations (i.e.
initramfs embedded in the image) -- I like reducing steps into of
increasing them...
Is there a way to tell the kernel "use a default dtb if you don't have
one better?"

marty
