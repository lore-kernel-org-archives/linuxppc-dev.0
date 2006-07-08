Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 499C3679E1
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 10:37:30 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH maple] Fix new interrupt code (MPIC endianness)
To: linuxppc-dev@ozlabs.org
Message-Id: <20060708003723.BC91A3BB9E0@schermpje.krocht>
Date: Sat,  8 Jul 2006 02:37:23 +0200 (CEST)
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All U3/U4 based systems are big-endian, not all express it in their
device trees.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Index: linux-powerpc/arch/powerpc/platforms/maple/setup.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/maple/setup.c	2006-07-03 19:56:28.469294976 +0200
+++ linux-powerpc/arch/powerpc/platforms/maple/setup.c	2006-07-03 20:05:01.121380920 +0200
@@ -259,6 +259,8 @@
 
 	/* XXX Maple specific bits */
 	flags |= MPIC_BROKEN_U3 | MPIC_WANTS_RESET;
+	/* All U3/U4 are big-endian, older SLOF firmware doesn't encode this */
+	flags |= MPIC_BIG_ENDIAN;
 
 	/* Setup the openpic driver. More device-tree junks, we hard code no
 	 * ISUs for now. I'll have to revisit some stuffs with the folks doing
