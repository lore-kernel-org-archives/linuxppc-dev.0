Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spkh849mHzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 16:23:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/powerpc: Fix build break caused by EXPORT_SYMBOL
 changes
Date: Wed,  5 Oct 2016 16:22:57 +1100
Message-Id: <1475644977-24133-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The changes to make EXPORT_SYMBOL work in asm, specifically commit
9445aa1a3062 ("ppc: move exports to definitions"), in the kbuild tree,
breaks some of our selftests.

That is because we symlink the kernel code into the selftest, and shim
the required headers, and we are now missing asm/export.h

So create a minimal export.h to keep the tests building once powerpc and
the kbuild trees are merged.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/copyloops/asm/export.h   | 1 +
 tools/testing/selftests/powerpc/stringloops/asm/export.h | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/copyloops/asm/export.h
 create mode 100644 tools/testing/selftests/powerpc/stringloops/asm/export.h

diff --git a/tools/testing/selftests/powerpc/copyloops/asm/export.h b/tools/testing/selftests/powerpc/copyloops/asm/export.h
new file mode 100644
index 000000000000..2d14a9b4248c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/copyloops/asm/export.h
@@ -0,0 +1 @@
+#define EXPORT_SYMBOL(x)
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/export.h b/tools/testing/selftests/powerpc/stringloops/asm/export.h
new file mode 100644
index 000000000000..2d14a9b4248c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/asm/export.h
@@ -0,0 +1 @@
+#define EXPORT_SYMBOL(x)
-- 
2.7.4
