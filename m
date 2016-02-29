Return-Path: <sjitindarsingh@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7EC0B1A005D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 17:30:27 +1100 (AEDT)
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 00945140307
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:30:26 +1100 (AEDT)
Received: by mail-pf0-x22d.google.com with SMTP id w128so41620844pfb.2
 for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2016 22:30:26 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH] selftests/powerpc: Remove -flto from common CFLAGS
Date: Mon, 29 Feb 2016 17:29:55 +1100
Message-Id: <1456727395-27386-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

LTO can cause GCC to inline some functions which have attributes set. The
act of inlining the functions can lead to GCC forgetting about the
attributes which leads to incorrect tests.
Notable example being: __attribute__((__target__("no-vsx")))
LTO can also interact strangely with custom assembly functions and cause
tests to intermittently fail.

Both these cases are hard to detect and require manual inspection of
binaries which is unlikely to happen for all tests. Furthermore, LTO
optimisations are not necessary for selftests and correctness is paramount
and as such it is best to disable LTO.

LTO can be enabled on a per test basis.

A pseries_le_defconfig kernel on a POWER8 was used to determine that the
same subset of selftests pass and fail with and without -flto in the
common Makefile.

These tests always fail:
selftests: per_event_excludes [FAIL]
selftests: event_attributes_test [FAIL]
selftests: ebb_vs_cpu_event_test [FAIL]
selftests: cpu_event_vs_ebb_test [FAIL]
selftests: cpu_event_pinned_vs_ebb_test [FAIL]
selftests: ipc_unmuxed [FAIL]
And the remaining tests PASS.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 tools/testing/selftests/powerpc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 0c2706b..7925a96 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -8,7 +8,7 @@ ifeq ($(ARCH),powerpc)
 
 GIT_VERSION = $(shell git describe --always --long --dirty || echo "unknown")
 
-CFLAGS := -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CURDIR) $(CFLAGS)
+CFLAGS := -Wall -O2 -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CURDIR) $(CFLAGS)
 
 export CFLAGS
 
-- 
2.5.0
