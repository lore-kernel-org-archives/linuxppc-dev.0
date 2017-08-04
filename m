Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNt6v6YpgzDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 13:43:03 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id j68so615844pfc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Aug 2017 20:43:03 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: dja@axtens.net
Subject: [v6 2/2] lib/raid6: Build proper raid6test files on powerpc
Date: Fri,  4 Aug 2017 13:42:33 +1000
Message-Id: <20170804034233.13628-2-matthew.brown.dev@gmail.com>
In-Reply-To: <20170804034233.13628-1-matthew.brown.dev@gmail.com>
References: <20170804034233.13628-1-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously the raid6 test Makefile did not build the POWER specific files
(altivec and vpermxor).
This patch fixes the bug, so that all appropriate files for powerpc are built.

This patch also fixes the missing and mismatched ifdef statements to allow the
altivec.uc file to be built correctly.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
v6:
	- remove vpermxor objs from this patch
v5:
	- moved altivec.uc fix into this patch
---
 lib/raid6/altivec.uc    | 3 +++
 lib/raid6/test/Makefile | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/raid6/altivec.uc b/lib/raid6/altivec.uc
index 682aae8..d20ed0d 100644
--- a/lib/raid6/altivec.uc
+++ b/lib/raid6/altivec.uc
@@ -24,10 +24,13 @@
 
 #include <linux/raid/pq.h>
 
+#ifdef CONFIG_ALTIVEC
+
 #include <altivec.h>
 #ifdef __KERNEL__
 # include <asm/cputable.h>
 # include <asm/switch_to.h>
+#endif /* __KERNEL__ */
 
 /*
  * This is the C data type to use.  We use a vector of
diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
index a14be53..b64a267 100644
--- a/lib/raid6/test/Makefile
+++ b/lib/raid6/test/Makefile
@@ -44,9 +44,10 @@ else ifeq ($(HAS_NEON),yes)
         CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
 else
         HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
-                         gcc -c -x c - >&/dev/null && \
-                         rm ./-.o && echo yes)
+                         gcc -c -x c - >/dev/null && rm ./-.o && echo yes)
         ifeq ($(HAS_ALTIVEC),yes)
+                CFLAGS += -I../../../arch/powerpc/include
+                CFLAGS += -DCONFIG_ALTIVEC
                 OBJS += altivec1.o altivec2.o altivec4.o altivec8.o \
                         vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o
         endif
-- 
2.9.3
