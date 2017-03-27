Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vs15L4zwrzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 15:19:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org, bamvor.zhangjian@linaro.org
Subject: [PATCH] selftests/powerpc: Fix standalone powerpc build
Date: Mon, 27 Mar 2017 15:19:47 +1100
Message-Id: <1490588387-18903-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The changes to enable building with a separate output directory, in
commit a8ba798bc8ec ("selftests: enable O and KBUILD_OUTPUT") broke
building the powerpc selftests on their own, eg:

 $ cd tools/testing/selftests/powerpc; make

It was partially fixed in commit e53aff45c490 ("selftests: lib.mk Fix
individual test builds"), which defined OUTPUT for standalone tests. But
that only defines OUTPUT within the Makefile, the value is not exported
so sub-shells can't see it. We could export OUTPUT, but it's actually
cleaner to just expand the value of OUTPUT before we invoke the shell.

Fixes: a8ba798bc8ec ("selftests: enable O and KBUILD_OUTPUT")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

I'll merge this via the powerpc tree.

cheers

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 1c5d0575802e..bf13fc2297aa 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -34,34 +34,34 @@ endif
 all: $(SUB_DIRS)
 
 $(SUB_DIRS):
-	BUILD_TARGET=$$OUTPUT/$@; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $@ all
+	BUILD_TARGET=$(OUTPUT)/$@; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $@ all
 
 include ../lib.mk
 
 override define RUN_TESTS
 	@for TARGET in $(SUB_DIRS); do \
-		BUILD_TARGET=$$OUTPUT/$$TARGET;	\
+		BUILD_TARGET=$(OUTPUT)/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests;\
 	done;
 endef
 
 override define INSTALL_RULE
 	@for TARGET in $(SUB_DIRS); do \
-		BUILD_TARGET=$$OUTPUT/$$TARGET;	\
+		BUILD_TARGET=$(OUTPUT)/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install;\
 	done;
 endef
 
 override define EMIT_TESTS
 	@for TARGET in $(SUB_DIRS); do \
-		BUILD_TARGET=$$OUTPUT/$$TARGET;	\
+		BUILD_TARGET=$(OUTPUT)/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests;\
 	done;
 endef
 
 clean:
 	@for TARGET in $(SUB_DIRS); do \
-		BUILD_TARGET=$$OUTPUT/$$TARGET;	\
+		BUILD_TARGET=$(OUTPUT)/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean; \
 	done;
 	rm -f tags
-- 
2.7.4
