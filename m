Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3KY75hJBzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 09:16:11 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id a188so7494791pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 16:16:11 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: dja@axtens.net,
	linux-raid@vger.kernel.org
Subject: [v4 1/2] lib/raid6: Build proper files on corresponding arch
Date: Thu, 13 Apr 2017 09:15:45 +1000
Message-Id: <20170412231546.15715-1-matthew.brown.dev@gmail.com>
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
Changlog
v2 - v4
	- fixup whitespace
	- change versioning to match other patch
---
 lib/raid6/test/Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
index 9c333e9..b64a267 100644
--- a/lib/raid6/test/Makefile
+++ b/lib/raid6/test/Makefile
@@ -44,10 +44,12 @@ else ifeq ($(HAS_NEON),yes)
         CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
 else
         HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
-                         gcc -c -x c - >&/dev/null && \
-                         rm ./-.o && echo yes)
+                         gcc -c -x c - >/dev/null && rm ./-.o && echo yes)
         ifeq ($(HAS_ALTIVEC),yes)
-                OBJS += altivec1.o altivec2.o altivec4.o altivec8.o
+                CFLAGS += -I../../../arch/powerpc/include
+                CFLAGS += -DCONFIG_ALTIVEC
+                OBJS += altivec1.o altivec2.o altivec4.o altivec8.o \
+                        vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o
         endif
 endif
 ifeq ($(ARCH),tilegx)
-- 
2.9.3
