Return-Path: <Fabien.Clement@thomson.net>
Received: from dmzraw5.extranet.tce.com (dmzraw5.extranet.tce.com
	[157.254.234.142]) by ozlabs.org (Postfix) with ESMTP id 8F9BD681BE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 23:52:25 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 24 Nov 2005 13:51:46 +0100
Message-ID: <9C1918067C3BC14C9C351C206D8A843701F7F876@rennsmail03.eu.thmulti.com>
From: "Clement Fabien" <Fabien.Clement@thomson.net>
To: "Clement Fabien" <Fabien.Clement@thomson.net>,
	"Pantelis Antoniou" <panto@intracom.gr>,
	"Kumar Gala" <kumar.gala@freescale.com>,
	"Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH] CPM2: Fix totally bogus alignment handing of dpalloc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Some results: alignments are now respected but it seems that the method
I took from linux 2.4 is more efficient in terms of memory consumption.
I will provide a complete patch today with the same mechanism for
rh_alloc_fixed.

Fabien



Allocation method with offset (patch from myself)
rh_alloc - Required size =3D 0040, align =3D 0008
rh_alloc - Block size =3D 3F80, start =3D 00000080 - Off =3D 0000
rh_alloc - Alloc size =3D 0040, start =3D 00000080

rh_alloc - Required size =3D 0008, align =3D 0010
rh_alloc - Block size =3D 3F40, start =3D 000000c0 - Off =3D 0000
rh_alloc - Alloc size =3D 0010, start =3D 000000c0

rh_alloc - Required size =3D 1800, align =3D 0020
rh_alloc - Block size =3D 3F30, start =3D 000000d0 - Off =3D 0010
rh_alloc - Alloc size =3D 1810, start =3D 000000e0

rh_alloc - Required size =3D 0108, align =3D 0040
rh_alloc - Block size =3D 2720, start =3D 000018e0 - Off =3D 0020
rh_alloc - Alloc size =3D 0160, start =3D 00001900

rh_alloc - Required size =3D 0040, align =3D 0010
rh_alloc - Block size =3D 25C0, start =3D 00001a40 - Off =3D 0000
rh_alloc - Alloc size =3D 0040, start =3D 00001a40

rh_alloc - Required size =3D 0020, align =3D 0020
rh_alloc - Block size =3D 2580, start =3D 00001a80 - Off =3D 0000
rh_alloc - Alloc size =3D 0020, start =3D 00001a80

rh_alloc - Required size =3D 0010, align =3D 0010
rh_alloc - Block size =3D 2560, start =3D 00001aa0 - Off =3D 0000
rh_alloc - Alloc size =3D 0010, start =3D 00001aa0

rh_alloc - Required size =3D 000C, align =3D 0040
rh_alloc - Block size =3D 2550, start =3D 00001ab0 - Off =3D 0010
rh_alloc - Alloc size =3D 0050, start =3D 00001ac0


Allocation method without offset (Patch from Pantelis)
rh_alloc - Required size =3D 0040, align =3D 0008
rh_alloc - Block size =3D 3F80, start =3D 00000080
rh_alloc - Alloc size =3D 0047, start =3D 00000080

rh_alloc - Required size =3D 0008, align =3D 0010
rh_alloc - Block size =3D 3F39, start =3D 000000c7
rh_alloc - Alloc size =3D 0017, start =3D 000000d0

rh_alloc - Required size =3D 1800, align =3D 0020
rh_alloc - Block size =3D 3F22, start =3D 000000de
rh_alloc - Alloc size =3D 181F, start =3D 000000e0

rh_alloc - Required size =3D 0108, align =3D 0040
rh_alloc - Block size =3D 2703, start =3D 000018fd
rh_alloc - Alloc size =3D 0147, start =3D 00001900

rh_alloc - Required size =3D 0040, align =3D 0010
rh_alloc - Block size =3D 25BC, start =3D 00001a44
rh_alloc - Alloc size =3D 004F, start =3D 00001a50

rh_alloc - Required size =3D 0020, align =3D 0020
rh_alloc - Block size =3D 256D, start =3D 00001a93
rh_alloc - Alloc size =3D 003F, start =3D 00001aa0

rh_alloc - Required size =3D 0010, align =3D 0010
rh_alloc - Block size =3D 252E, start =3D 00001ad2
rh_alloc - Alloc size =3D 001F, start =3D 00001ae0

rh_alloc - Required size =3D 000C, align =3D 0040
rh_alloc - Block size =3D 250F, start =3D 00001af1
rh_alloc - Alloc size =3D 004B, start =3D 00001b00

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Clement
Fabien
Sent: jeudi 24 novembre 2005 12:26
To: Pantelis Antoniou; Kumar Gala; Marcelo Tosatti; linuxppc-embedded
Subject: RE: [PATCH] CPM2: Fix totally bogus alignment handing of
dpalloc

Here is a patch that builds.


-----Original Message-----
From: Pantelis Antoniou [mailto:panto@intracom.gr]=20
Sent: jeudi 24 novembre 2005 12:04
To: Clement Fabien; Kumar Gala; Marcelo Tosatti; linuxppc-embedded
Subject: [PATCH] CPM2: Fix totally bogus alignment handing of dpalloc

Hi all.

Alignments are currently handled bogusly for cpm2.

Please test.

Regards

Pantelis
