Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw5.extranet.tce.com (dmzraw5.extranet.tce.com
	[157.254.234.142]) by ozlabs.org (Postfix) with ESMTP id 5F6F36827B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Sep 2005 20:20:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 14 Sep 2005 11:47:30 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0DD5@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "linux-ppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: RE: How to support LFS on ppc 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>I have a problem about Large File System on ppc. The following is my =
example code:

Actually not problem with LFS, but with int types.

>#define _FILE_OFFSET_BITS 64
>#include <sys/stat.h>
>#include <unistd.h>
>Int main()
>{
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct stat buf;
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stat64("/3G",&buf);
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf("size of test =3D %ld =
\n",buf.st_size);
                                   ^^^
Try %lld instead. Or to be portable, #include <inttypes.h>
and printf("size of test =3D %" PRId64 "\n", buf.st_size);

--=20
Stephane
