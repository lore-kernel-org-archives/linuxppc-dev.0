Return-Path: <DaveLiu@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E45CEB71A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 14:42:51 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9DB3ADDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 14:42:49 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n5J4gk7X015270
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 21:42:46 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n5J4giLB001093
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 23:42:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Problem with memcpy on ppc8536
Date: Fri, 19 Jun 2009 12:42:44 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB120893EB700@zch01exm21.fsl.freescale.net>
In-Reply-To: <71DEA556544D7A4F9C6848402D8184340C4A13@usi01.ultsol.local>
References: <71DEA556544D7A4F9C6848402D8184340C4A13@usi01.ultsol.local>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Fahd Abidi" <fabidi@ultsol.com>, <linuxppc-dev@ozlabs.org>
Cc: u-boot@lists.denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I believe the question should be sent to u-boot@lists.denx.de,
not linuxppc-dev list.

What is the TLB settings for NAND FCM buffer? Pay attention
to set the TLB as cache inhibited and guarded attribute.

If not set the guarded bit, it is possible to cause the speculate
load from FCM buffer below the cmplwi and blt inst.

IIRC, the FCM buffer only has the 4KB. So if it has one speculated
Load above the 4KB, it will run into problem.

The 0x700 is not alignment exception, it is program exception.

If you can dump the exception error information from console
to us, maybe we can give better help.

Thanks, Dave

________________________________

	From:
linuxppc-dev-bounces+daveliu=3Dfreescale.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+daveliu=3Dfreescale.com@lists.ozlabs.org] =
On
Behalf Of Fahd Abidi
	Sent: Friday, June 19, 2009 4:34 AM
	To: linuxppc-dev@ozlabs.org
	Subject: Problem with memcpy on ppc8536
=09
=09
	Hello,=20
=09
	I am trying to debug a crash during memcpy while copying data
from the FCM buffer of an mpc8536 to the ddr ram. I debugged memcpy
enough through my BDI3000 to see that the entire contents of the fcm
buffer I want moved are actually moved off to memory location I specify.
The crash comes after it memcpy finishes copying and performs the
instruction "2: cmplwi 0,r5,4":=20
=09
	memcpy:=20
	rlwinm. r7,r5,32-3,3,31 /* r0 =3D r5 >> 3 */=20
	addi r6,r3,-4=20
	addi r4,r4,-4=20
	beq 2f /* if less than 8 bytes to do */=20
	andi. r0,r6,3 /* get dest word aligned */=20
	mtctr r7=20
	bne 5f=20
	1: lwz r7,4(r4)=20
	lwzu r8,8(r4)=20
	stw r7,4(r6)=20
	stwu r8,8(r6)=20
	bdnz 1b=20
	andi. r5,r5,7=20
	2: cmplwi 0,r5,4=20
=09
	contents of r5 are 0x0 showing that the entire 0x1000 size
transfer I specified correctly finished. At this point I can check the
memory contents through my BDI and verify all the data is in the ddr as
I expect. Now the strange thing happens, if I execute the "cmplwi
0,r5,4" the program takes an exception and eventually gets struck at
exception vector 0x700 which I saw from start.S is an "Alignment"
exception. I am not sure what this exception means, can someone help me
understand what is happening?=20
=09
	Does this exception somehow mean that memcpy did not move all
the data? Does memcpy expect contents of r5 to be 4 and not 0 when it
hits the cmplwi instruction?=20
=09

	Fahd Abidi
	Product Manager - Technical Tools and Development
	Ultimate Solutions, Inc.
	=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	Your Single Source for Professional Development Tools and
Embedded Solutions
	Ph: 978-455-3383 x255
	Fx: 978-926-3091
	Email: fabidi@ultsol.com
	Visit: http://www.ultsol.com <http://www.ultsol.com/> =20
