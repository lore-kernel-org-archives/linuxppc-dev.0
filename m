Return-Path: <Martin.Leisner@xerox.com>
Received: from wvmler2.mail.xerox.com (wvmler2.mail.xerox.com [13.8.138.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler2.mail.xerox.com",
	Issuer "wvmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D6D62DDFC0
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 08:04:04 +1000 (EST)
Received: from wvmlir3.mail.xerox.com (wvmlir3.mail.xerox.com [13.147.8.223])
	by wvmler2.mail.xerox.com (8.14.2/8.13.8) with ESMTP id
	m3FLmL3g014188
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 14:48:21 -0700
Received: from wvmlir3.mail.xerox.com (localhost.localdomain [127.0.0.1])
	by wvmlir3.mail.xerox.com (8.13.8/8.13.6) with ESMTP id m3FLmFCX014089
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 14:48:15 -0700
Received: from USA0300GW002.na.xerox.net (usa0300gw002.na.xerox.net
	[13.135.210.15])
	by wvmlir3.mail.xerox.com (8.13.8/8.13.6) with ESMTP id m3FLm9Ds014035
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 14:48:15 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RFC:  adding post build comments to kernels
Date: Tue, 15 Apr 2008 17:47:23 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C08790522@USA0300MS03.na.xerox.net>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm a big proponent of marking kernels with their characteristics during
development -- instead of trying to  coordinate multiple pieces of
information and hope you get it right (I don't like to try)
I've been lobbying for /proc/config for a decade (that's one of the
first
things I enable when I'm doing kernel hacking).

I have a strategy to put "patch comments" into a kernel which you can
easily=20
extract at runtime (I use a separate elf section for now, is there a
subsystem which already had the capability -- I have a macro

PATCH_ENTRY(string)

which puts this string wherever you want in the source(marging it with
the file/line,date). =20

What I wanted is something so I can "add text" to a kernel (i.e. the
results of my patches).  It would be nice to extract at runtime, but not
necessary.

What I did was just:

cat >>uImage
some comments
<control-D>

and I can easily extract it with this script:

#! /bin/bash

image=3D$1
args=3D$(mkimage -l $1 2>/dev/null | grep 'Data Size')

set - $args

size=3D$3

size=3D$((size + 64))


dd if=3D$image skip=3D$size bs=3D1 2>/dev/null

This works fine:
%uboot-comments ./uImage 2.6.22.19-vanilla
this is a test
lovely kernel

but mkimage -l complains a little:

%mkimage -l uImage-2.6.22.19-vanilla
*** Warning: "uImage-2.6.22.19-vanilla" has corrupted data!
Image Name:   Linux-2.6.22.19
Created:      Mon Apr 14 13:04:02 2008
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    1578239 Bytes =3D 1541.25 kB =3D 1.51 MB
Load Address: 0x00000000
Entry Point:  0x00000000


I suppose a tool could be build with compresses the kernel, puts in a
special elf section with a comment, recompresses the kernel, and builds
a new image -- but this is pretty easy...

This seems to boot with no problems...

marty
