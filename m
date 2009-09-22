Return-Path: <Bernhard.Weirich@riedel.net>
Received: from dhuumrelay0.dtm.ops.eu.uu.net (dhuumrelay0.dtm.ops.eu.uu.net
	[194.139.33.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 172CAB7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 19:29:32 +1000 (EST)
Received: from mail.riedel.net (mail.riedel.net [213.70.193.150])
	by dhuumrelay0.dtm.ops.eu.uu.net (8.14.1/8.14.1) with ESMTP id
	n8M9TQd7008359
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 09:29:27 GMT
From: "Weirich, Bernhard" <Bernhard.Weirich@riedel.net>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 22 Sep 2009 11:29:24 +0200
Subject: [PATCH] Re: [405EX] Bad page map in process ...
Message-ID: <CE92B8B581B4584FB8CA86B51EDE8AC5243C568B04@wupexchange.riedel.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I found the cause of the problem.
My architecture does not define the _PAGE_SPECIAL macro, thus in pte-common=
.h line 32, it is defined as 0
And then in line 180, since _PAGE_SPECIAL is defined, the macro __HAVE_ARCH=
_PTE_SPECIAL is erroneously defined.
This makes any ppc architecture to act as if it has a pte special bit!
I suggest the following simple patch to fix this.

Bernhard WEIRICH
Software Development


Signed-off-by: Bernhard Weirich <bernhard.weirich@riedel.net>
--- linux/arch/powerpc/include/asm/pte-common.h	2009-09-16 11:23:44.0000000=
00 +0200
+++ linux/arch/powerpc/include/asm/pte-common.h	2009-09-22 11:13:08.0000000=
00 +0200
@@ -176,7 +176,7 @@
 #define HAVE_PAGE_AGP
=20
 /* Advertise support for _PAGE_SPECIAL */
-#ifdef _PAGE_SPECIAL
+#if _PAGE_SPECIAL !=3D 0
 #define __HAVE_ARCH_PTE_SPECIAL
 #endif
=20
