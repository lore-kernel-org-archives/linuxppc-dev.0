Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s156s2PJ1zDrPj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 20:48:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: wei.guo.simon@gmail.com,
	khandual@linux.vnet.ibm.com
Subject: [PATCH] selftests/powerpc: Specify we expect to build with std=gnu99
Date: Fri, 29 Jul 2016 20:48:09 +1000
Message-Id: <1469789289-2693-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have some tests that assume we're using std=gnu99, which is fine on
most compilers, but some old compilers use a different default.

So make it explicit that we want to use std=gnu99.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index c6e1745b2a74..f9d311bc4130 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -8,7 +8,7 @@ ifeq ($(ARCH),powerpc)
 
 GIT_VERSION = $(shell git describe --always --long --dirty || echo "unknown")
 
-CFLAGS := -Wall -O2 -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CURDIR) $(CFLAGS)
+CFLAGS := -std=gnu99 -Wall -O2 -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CURDIR) $(CFLAGS)
 
 export CFLAGS
 
-- 
2.7.4
