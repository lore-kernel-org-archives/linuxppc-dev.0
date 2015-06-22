Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id D9CBF1A027B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 03:01:38 +1000 (AEST)
Message-Id: <0636b88c7d11acb6a4d638e39bfcbb98c1d86045.1434978970.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1434978970.git.christophe.leroy@c-s.fr>
References: <cover.1434978970.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/2] powerpc32: checksum_wrappers_64 becomes checksum_wrappers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 22 Jun 2015 19:01:07 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc64 checksum wrapper functions adds the csum_and_copy_to_user() which
otherwise is implemented in include/net/checksum.h by using csum_partial() then
copy_to_user()

Those two wrapper fonctions are also applicable to powerpc32 as it is based on
the use of csum_partial_copy_generic() which also exists on powerpc32

This patch renames arch/powerpc/lib/checksum_wrappers_64.c to
arch/powerpc/lib/checksum_wrappers.c and
makes it non-conditional to CONFIG_WORD_SIZE

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/checksum.h     |   9 ---
 arch/powerpc/lib/Makefile               |   3 +-
 arch/powerpc/lib/checksum_wrappers.c    | 102 ++++++++++++++++++++++++++++++++
 arch/powerpc/lib/checksum_wrappers_64.c | 102 --------------------------------
 4 files changed, 103 insertions(+), 113 deletions(-)
 create mode 100644 arch/powerpc/lib/checksum_wrappers.c
 delete mode 100644 arch/powerpc/lib/checksum_wrappers_64.c

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 8251a3b..0ffd793 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -56,21 +56,12 @@ extern __wsum csum_partial_copy_generic(const void *src, void *dst,
 					      int len, __wsum sum,
 					      int *src_err, int *dst_err);
 
-#ifdef __powerpc64__
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 				      int len, __wsum sum, int *err_ptr);
 #define HAVE_CSUM_COPY_USER
 extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
 				    int len, __wsum sum, int *err_ptr);
-#else
-/*
- * the same as csum_partial, but copies from src to dst while it
- * checksums.
- */
-#define csum_partial_copy_from_user(src, dst, len, sum, errp)   \
-        csum_partial_copy_generic((__force const void *)(src), (dst), (len), (sum), (errp), NULL)
-#endif
 
 #define csum_partial_copy_nocheck(src, dst, len, sum)   \
         csum_partial_copy_generic((src), (dst), (len), (sum), NULL, NULL)
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index a47e142..e46b068 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -22,8 +22,7 @@ obj64-$(CONFIG_SMP)	+= locks.o
 obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
 
 ifeq ($(CONFIG_GENERIC_CSUM),)
-obj-y			+= checksum_$(CONFIG_WORD_SIZE).o
-obj-$(CONFIG_PPC64)	+= checksum_wrappers_64.o
+obj-y			+= checksum_$(CONFIG_WORD_SIZE).o checksum_wrappers.o
 endif
 
 obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o
diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
new file mode 100644
index 0000000..08e3a33
--- /dev/null
+++ b/arch/powerpc/lib/checksum_wrappers.c
@@ -0,0 +1,102 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2010
+ *
+ * Author: Anton Blanchard <anton@au.ibm.com>
+ */
+#include <linux/export.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <asm/checksum.h>
+#include <asm/uaccess.h>
+
+__wsum csum_and_copy_from_user(const void __user *src, void *dst,
+			       int len, __wsum sum, int *err_ptr)
+{
+	unsigned int csum;
+
+	might_sleep();
+
+	*err_ptr = 0;
+
+	if (!len) {
+		csum = 0;
+		goto out;
+	}
+
+	if (unlikely((len < 0) || !access_ok(VERIFY_READ, src, len))) {
+		*err_ptr = -EFAULT;
+		csum = (__force unsigned int)sum;
+		goto out;
+	}
+
+	csum = csum_partial_copy_generic((void __force *)src, dst,
+					 len, sum, err_ptr, NULL);
+
+	if (unlikely(*err_ptr)) {
+		int missing = __copy_from_user(dst, src, len);
+
+		if (missing) {
+			memset(dst + len - missing, 0, missing);
+			*err_ptr = -EFAULT;
+		} else {
+			*err_ptr = 0;
+		}
+
+		csum = csum_partial(dst, len, sum);
+	}
+
+out:
+	return (__force __wsum)csum;
+}
+EXPORT_SYMBOL(csum_and_copy_from_user);
+
+__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
+			     __wsum sum, int *err_ptr)
+{
+	unsigned int csum;
+
+	might_sleep();
+
+	*err_ptr = 0;
+
+	if (!len) {
+		csum = 0;
+		goto out;
+	}
+
+	if (unlikely((len < 0) || !access_ok(VERIFY_WRITE, dst, len))) {
+		*err_ptr = -EFAULT;
+		csum = -1; /* invalid checksum */
+		goto out;
+	}
+
+	csum = csum_partial_copy_generic(src, (void __force *)dst,
+					 len, sum, NULL, err_ptr);
+
+	if (unlikely(*err_ptr)) {
+		csum = csum_partial(src, len, sum);
+
+		if (copy_to_user(dst, src, len)) {
+			*err_ptr = -EFAULT;
+			csum = -1; /* invalid checksum */
+		}
+	}
+
+out:
+	return (__force __wsum)csum;
+}
+EXPORT_SYMBOL(csum_and_copy_to_user);
diff --git a/arch/powerpc/lib/checksum_wrappers_64.c b/arch/powerpc/lib/checksum_wrappers_64.c
deleted file mode 100644
index 08e3a33..0000000
--- a/arch/powerpc/lib/checksum_wrappers_64.c
+++ /dev/null
@@ -1,102 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
- * Copyright (C) IBM Corporation, 2010
- *
- * Author: Anton Blanchard <anton@au.ibm.com>
- */
-#include <linux/export.h>
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <asm/checksum.h>
-#include <asm/uaccess.h>
-
-__wsum csum_and_copy_from_user(const void __user *src, void *dst,
-			       int len, __wsum sum, int *err_ptr)
-{
-	unsigned int csum;
-
-	might_sleep();
-
-	*err_ptr = 0;
-
-	if (!len) {
-		csum = 0;
-		goto out;
-	}
-
-	if (unlikely((len < 0) || !access_ok(VERIFY_READ, src, len))) {
-		*err_ptr = -EFAULT;
-		csum = (__force unsigned int)sum;
-		goto out;
-	}
-
-	csum = csum_partial_copy_generic((void __force *)src, dst,
-					 len, sum, err_ptr, NULL);
-
-	if (unlikely(*err_ptr)) {
-		int missing = __copy_from_user(dst, src, len);
-
-		if (missing) {
-			memset(dst + len - missing, 0, missing);
-			*err_ptr = -EFAULT;
-		} else {
-			*err_ptr = 0;
-		}
-
-		csum = csum_partial(dst, len, sum);
-	}
-
-out:
-	return (__force __wsum)csum;
-}
-EXPORT_SYMBOL(csum_and_copy_from_user);
-
-__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
-			     __wsum sum, int *err_ptr)
-{
-	unsigned int csum;
-
-	might_sleep();
-
-	*err_ptr = 0;
-
-	if (!len) {
-		csum = 0;
-		goto out;
-	}
-
-	if (unlikely((len < 0) || !access_ok(VERIFY_WRITE, dst, len))) {
-		*err_ptr = -EFAULT;
-		csum = -1; /* invalid checksum */
-		goto out;
-	}
-
-	csum = csum_partial_copy_generic(src, (void __force *)dst,
-					 len, sum, NULL, err_ptr);
-
-	if (unlikely(*err_ptr)) {
-		csum = csum_partial(src, len, sum);
-
-		if (copy_to_user(dst, src, len)) {
-			*err_ptr = -EFAULT;
-			csum = -1; /* invalid checksum */
-		}
-	}
-
-out:
-	return (__force __wsum)csum;
-}
-EXPORT_SYMBOL(csum_and_copy_to_user);
-- 
2.1.0
