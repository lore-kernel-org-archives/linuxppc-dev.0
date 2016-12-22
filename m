Return-Path: <john@phrozen.org>
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:131:30e2::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tkmWw4tWZzDwKk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 20:32:28 +1100 (AEDT)
From: John Crispin <john@phrozen.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Imre Kaloz <kaloz@openwrt.org>, John Crispin <john@phrozen.org>
Subject: [PATCH] arch: powerpc: ppc4xx compile flag optimizations
Date: Thu, 22 Dec 2016 09:06:08 +0100
Message-Id: <1482393968-60623-1-git-send-email-john@phrozen.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Imre Kaloz <kaloz@openwrt.org>

This patch splits up the compile flags between ppc40x and ppc44x.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/powerpc/Makefile      |    3 ++-
 arch/powerpc/boot/Makefile |    6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 617dece..d85bb82 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -217,7 +217,8 @@ ifeq ($(CONFIG_FUNCTION_TRACER),y)
 KBUILD_CFLAGS		+= -mno-sched-epilog
 endif
 
-cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
+cpu-as-$(CONFIG_40x)		+= -Wa,-m405
+cpu-as-$(CONFIG_44x)		+= -Wa,-m440
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 9d47f2e..5c2feaa 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -53,10 +53,10 @@ BOOTCFLAGS	+= -I$(objtree)/$(obj) -I$(srctree)/$(obj)
 DTC_FLAGS	?= -p 1024
 
 $(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
-$(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
+$(obj)/ebony.o: BOOTCFLAGS += -mcpu=440
 $(obj)/cuboot-hotfoot.o: BOOTCFLAGS += -mcpu=405
-$(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405
-$(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
+$(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=440
+$(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=440
 $(obj)/cuboot-acadia.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-iss4xx.o: BOOTCFLAGS += -mcpu=405
-- 
1.7.10.4
