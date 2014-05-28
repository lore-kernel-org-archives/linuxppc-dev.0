Return-Path: <dev@codyps.com>
Received: from mail-yk0-x22a.google.com (mail-yk0-x22a.google.com
 [IPv6:2607:f8b0:4002:c07::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D17BE1A05A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 10:27:52 +1000 (EST)
Received: by mail-yk0-f170.google.com with SMTP id 10so7734407ykt.15
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 17:27:49 -0700 (PDT)
From: Cody P Schafer <dev@codyps.com>
To: LKML <linux-kernel@vger.kernel.org>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, Cody P Schafer <dev@codyps.com>
Subject: [PATCH 11/16] byteorder: provide a linux/byteorder.h with {be,
 le}_to_cpu() and cpu_to_{be, le}() macros
Date: Tue, 27 May 2014 17:22:06 -0700
Message-Id: <1401236684-10579-12-git-send-email-dev@codyps.com>
In-Reply-To: <1401236684-10579-1-git-send-email-dev@codyps.com>
References: <1401236684-10579-1-git-send-email-dev@codyps.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rather manually specifying the size of the integer to be converted, key
off of the type size. Reduces duplicate size info and the occurance of
certain types of bugs (using the wrong sized conversion).

CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Cody P Schafer <dev@codyps.com>
---
 include/linux/byteorder.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 include/linux/byteorder.h

diff --git a/include/linux/byteorder.h b/include/linux/byteorder.h
new file mode 100644
index 0000000..c7ab8da
--- /dev/null
+++ b/include/linux/byteorder.h
@@ -0,0 +1,34 @@
+#ifndef LINUX_BYTEORDER_H_
+#define LINUX_BYTEORDER_H_
+
+#include <asm/byteorder.h>
+
+#define be_to_cpu(v) \
+	__builtin_choose_expr(sizeof(v) == sizeof(uint8_t) , v,	\
+	__builtin_choose_expr(sizeof(v) == sizeof(uint16_t), be16_to_cpu(v), \
+	__builtin_choose_expr(sizeof(v) == sizeof(uint32_t), be32_to_cpu(v), \
+	__builtin_choose_expr(sizeof(v) == sizeof(uint64_t), be64_to_cpu(v), \
+		(void)0))))
+
+#define le_to_cpu(v) \
+	__builtin_choose_expr(sizeof(v) == sizeof(uint8_t) , v,	\
+	__builtin_choose_expr(sizeof(v) == sizeof(uint16_t), le16_to_cpu(v), \
+	__builtin_choose_expr(sizeof(v) == sizeof(uint32_t), le32_to_cpu(v), \
+	__builtin_choose_expr(sizeof(v) == sizeof(uint64_t), le64_to_cpu(v), \
+		(void)0))))
+
+#define cpu_to_le(v) \
+	__builtin_choose_expr(sizeof(v) == sizeof(uint8_t) , v,	\
+	__builtin_choose_expr(sizeof(v) == sizeof(uint16_t), cpu_to_le16(v), \
+	__builtin_choose_expr(sizeof(v) == sizeof(uint32_t), cpu_to_le32(v), \
+	__builtin_choose_expr(sizeof(v) == sizeof(uint64_t), cpu_to_le64(v), \
+		(void)0))))
+
+#define cpu_to_be(v) \
+	__builtin_choose_expr(sizeof(v) == sizeof(uint8_t) , v,	\
+	__builtin_choose_expr(sizeof(v) == sizeof(uint16_t), cpu_to_be16(v), \
+	__builtin_choose_expr(sizeof(v) == sizeof(uint32_t), cpu_to_be32(v), \
+	__builtin_choose_expr(sizeof(v) == sizeof(uint64_t), cpu_to_be64(v), \
+		(void)0))))
+
+#endif
-- 
1.9.3
