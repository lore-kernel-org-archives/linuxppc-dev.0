Return-Path: <bunk@kernel.org>
Received: from mailhub.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with ESMTP id 2CF02DDDFC
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Sep 2007 04:21:14 +1000 (EST)
Date: Sun, 9 Sep 2007 20:21:17 +0200
From: Adrian Bunk <bunk@kernel.org>
To: paulus@samba.org
Subject: [2.6 patch] powerpc: proper defconfig for crosscompiles
Message-ID: <20070909182117.GJ3563@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The trick for finding the right defconfig is neat, but you forgot to 
provide an i686_defconfig.  ;-)

More seriously, cross compiling the defconfig is often useful, e.g. for 
testing the compilation of patches that touch multiple architectures, 
and this patch therefore chooses g5_defconfig if $(CROSS_COMPILE) is 
non-empty.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
0b0e6e0e3a16f48348cb9c40ef1bb55ef42f92eb 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 2065138..a39bac4 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -35,7 +35,11 @@ endif
 
 export CROSS32CC CROSS32AS CROSS32LD CROSS32AR CROSS32OBJCOPY
 
+ifeq ($(CROSS_COMPILE),)
 KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
+else
+KBUILD_DEFCONFIG := g5_defconfig
+endif
 
 ifeq ($(CONFIG_PPC64),y)
 OLDARCH	:= ppc64
