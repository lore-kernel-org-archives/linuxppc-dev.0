Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B6581A082E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 16:15:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v3] selftests/powerpc: Fix build failure of
 load_unaligned_zeropad test
Date: Tue, 13 Oct 2015 16:15:14 +1100
Message-Id: <1444713314-13596-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 7a5692e6e533 ("arch/powerpc: provide zero_bytemask() for
big-endian") added a call to __fls() in our word-at-a-time.h. That was
fine for the kernel build but missed the fact that we also use
word-at-a-time.h in a userspace test.

Pulling in the kernel version of __fls() gets messy, so just define our
own, it's unlikely to change often.

Fixes: 7a5692e6e533 ("arch/powerpc: provide zero_bytemask() for big-endian")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../selftests/powerpc/primitives/load_unaligned_zeropad.c        | 9 +++++++++
 1 file changed, 9 insertions(+)

v3: FFS, we still need the forward declaration for some compiler verions.

v2: Use a static inline, otherwise the little endian build fails because
    __fls() is unused >:(

diff --git a/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c b/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
index d1b647509596..6cae06117b55 100644
--- a/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
+++ b/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
@@ -25,10 +25,19 @@
 
 #define FIXUP_SECTION ".ex_fixup"
 
+static inline unsigned long __fls(unsigned long x);
+
 #include "word-at-a-time.h"
 
 #include "utils.h"
 
+static inline unsigned long __fls(unsigned long x)
+{
+	int lz;
+
+	asm (PPC_CNTLZL "%0,%1" : "=r" (lz) : "r" (x));
+	return sizeof(unsigned long) - 1 - lz;
+}
 
 static int page_size;
 static char *mem_region;
-- 
2.1.4
