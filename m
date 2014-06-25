Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71EF01A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 15:18:46 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Wed, 25 Jun 2014 15:18:43 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 69D932CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 15:18:41 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5P4uNnE65994818
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 14:56:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5P5IeoL013736
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 15:18:40 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s5P5Iego013733
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 15:18:40 +1000
Received: from ocelot.ozlabs.ibm.com (haven.au.ibm.com [9.190.164.82])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id ADE02A0196
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 15:18:40 +1000 (EST)
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] selftests/powerpc: fix TARGETS in powerpc selftests
 makefile
Date: Wed, 25 Jun 2014 15:18:40 +1000
Message-Id: <cf202ebfe8a42e3f84646e7c2a4bfd6a7e6195bc.1403673509.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch changes the name of a make variable (TARGETS) to prevent it
from colliding with a value set by the user on the command line (as
they are recommended to do by tools/testing/selftests/README.txt).

Before this patch, "make -C tools/testing/selftests TARGETS=powerpc"
would fail.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 tools/testing/selftests/powerpc/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 54833a7..84795c0 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -13,22 +13,22 @@ CFLAGS := -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CUR
 
 export CC CFLAGS
 
-TARGETS = pmu copyloops mm tm
+SUB_TARGETS = pmu copyloops mm tm
 
 endif
 
 all:
-	@for TARGET in $(TARGETS); do \
+	@for TARGET in $(SUB_TARGETS); do \
 		$(MAKE) -C $$TARGET all; \
 	done;
 
 run_tests: all
-	@for TARGET in $(TARGETS); do \
+	@for TARGET in $(SUB_TARGETS); do \
 		$(MAKE) -C $$TARGET run_tests; \
 	done;
 
 clean:
-	@for TARGET in $(TARGETS); do \
+	@for TARGET in $(SUB_TARGETS); do \
 		$(MAKE) -C $$TARGET clean; \
 	done;
 	rm -f tags
-- 
1.9.0
