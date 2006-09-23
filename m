Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF0F667B8D
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 10:37:45 +1000 (EST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat
	Linux)) id 1GQvWX-0002e2-Pd
	for linuxppc-dev@ozlabs.org; Sat, 23 Sep 2006 01:37:41 +0100
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc math-emu needs -fno-builtin-fabs for math.c and fabs.c
Message-Id: <E1GQvWX-0002e2-Pd@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 23 Sep 2006 01:37:41 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


... since they deal with internal function with that name.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/math-emu/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
index 754143e..29bc912 100644
--- a/arch/powerpc/math-emu/Makefile
+++ b/arch/powerpc/math-emu/Makefile
@@ -11,3 +11,6 @@ obj-$(CONFIG_MATH_EMULATION)	+= fabs.o f
 					mcrfs.o mffs.o mtfsb0.o mtfsb1.o \
 					mtfsf.o mtfsfi.o stfiwx.o stfs.o \
 					udivmodti4.o
+
+CFLAGS_fabs.o = -fno-builtin-fabs
+CFLAGS_math.o = -fno-builtin-fabs
-- 
1.4.2.GIT
