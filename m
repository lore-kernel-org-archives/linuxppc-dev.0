Return-Path: <horms@verge.net.au>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by ozlabs.org (Postfix) with ESMTP id 048FDDDEF8
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 15:00:49 +1000 (EST)
From: Simon Horman <horms@verge.net.au>
To: linuxppc-dev@ozlabs.org
Subject: [Patch] [POWERPC] allow make defconfig to work on non-power machines
Date: Tue, 15 May 2007 13:21:18 +0900
Message-Id: <1179202878.13166@tabatha.lab.ultramonkey.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm wondering if there is any interest in a patch along the lines
of this to allow make defconfig to do something sensible when
uname isn't sensible - I noticed this when doing cross-compile builds.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 
 arch/powerpc/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/powerpc/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/Makefile	2007-05-15 11:23:14.000000000 +0900
+++ linux-2.6/arch/powerpc/Makefile	2007-05-15 13:28:36.000000000 +0900
@@ -35,7 +35,7 @@ endif
 
 export CROSS32CC CROSS32AS CROSS32LD CROSS32AR CROSS32OBJCOPY
 
-KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
+KBUILD_DEFCONFIG := $(shell c=`uname -m`_defconfig; if [ ! -f arch/powerpc/configs/$$c ]; then c=ppc64_defconfig; fi; echo -n $$c)
 
 ifeq ($(CONFIG_PPC64),y)
 OLDARCH	:= ppc64
