Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2mjK3RzhzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 11:36:21 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id c198so2327085pfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 18:36:21 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-raid@vger.kernel.org,
	dja@axtens.net
Subject: [PATCH 1/2] lib/raid6: Build proper files on corresponding arch
Date: Wed, 12 Apr 2017 11:35:51 +1000
Message-Id: <20170412013552.21650-1-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously the raid6 test Makefile did not correctly build the files for
testing on PowerPC. This patch fixes the bug, so that all appropriate files
for PowerPC are built.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
 lib/raid6/test/Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
index 9c333e9..62b26d1 100644
--- a/lib/raid6/test/Makefile
+++ b/lib/raid6/test/Makefile
@@ -44,10 +44,12 @@ else ifeq ($(HAS_NEON),yes)
         CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
 else
         HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
-                         gcc -c -x c - >&/dev/null && \
-                         rm ./-.o && echo yes)
+			 gcc -c -x c - >/dev/null && rm ./-.o && echo yes)
         ifeq ($(HAS_ALTIVEC),yes)
-                OBJS += altivec1.o altivec2.o altivec4.o altivec8.o
+		CFLAGS += -I../../../arch/powerpc/include
+		CFLAGS += -DCONFIG_ALTIVEC
+		OBJS += altivec1.o altivec2.o altivec4.o altivec8.o \
+			vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o
         endif
 endif
 ifeq ($(ARCH),tilegx)
-- 
2.9.3
