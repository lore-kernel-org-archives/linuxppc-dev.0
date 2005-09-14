Return-Path: <JohnsonCheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id 33ACB68259
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Sep 2005 21:46:03 +1000 (EST)
From: "JohnsonCheng" <JohnsonCheng@qnap.com.tw>
To: "'Fillod Stephane'" <stephane.fillod@thomson.net>,
	"'linux-ppc-embedded'" <linuxppc-embedded@ozlabs.org>
Date: Wed, 14 Sep 2005 19:45:54 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0DD5@rennsmail02.eu.thmulti.com>
Message-Id: <20050914114603.33ACB68259@ozlabs.org>
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

Dear Stephane,

Great. It's work when I use %lld instead of %ld.

Thanks,
Johnson Cheng


-----Original Message-----
From: Fillod Stephane [mailto:stephane.fillod@thomson.net]=20
Sent: Wednesday, September 14, 2005 5:48 PM
To: linux-ppc-embedded
Cc: JohnsonCheng
Subject: RE: How to support LFS on ppc=20

>I have a problem about Large File System on ppc. The following is my
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
