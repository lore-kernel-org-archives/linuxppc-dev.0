Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jGz1qP5zF0T6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:02:51 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id 139so2274162wmn.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:02:50 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 01/19] xmon: Use __printf markup to silence compiler
Date: Fri, 16 Mar 2018 12:02:06 +0100
Message-Id: <20180316110224.12260-2-malat@debian.org>
In-Reply-To: <20180316110224.12260-1-malat@debian.org>
References: <20180316110224.12260-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update also the other prototype declaration in asm/xmon.h.

Silence warnings (triggered at W=1) by adding relevant __printf attribute.
Move #define at bottom of the file to prevent conflict with gcc attribute.

  CC      arch/powerpc/xmon/nonstdio.o
arch/powerpc/xmon/nonstdio.c: In function ‘xmon_printf’:
arch/powerpc/xmon/nonstdio.c:178:2: error: function might be possible candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
  n = vsnprintf(xmon_outbuf, sizeof(xmon_outbuf), format, args);
  ^
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/xmon.h | 2 +-
 arch/powerpc/xmon/nonstdio.h    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/xmon.h b/arch/powerpc/include/asm/xmon.h
index eb42a0c6e1d9..30ff69bd8f43 100644
--- a/arch/powerpc/include/asm/xmon.h
+++ b/arch/powerpc/include/asm/xmon.h
@@ -29,7 +29,7 @@ static inline void xmon_register_spus(struct list_head *list) { };
 extern int cpus_are_in_xmon(void);
 #endif
 
-extern void xmon_printf(const char *format, ...);
+extern __printf(1, 2) void xmon_printf(const char *format, ...);
 
 #endif /* __KERNEL __ */
 #endif /* __ASM_POWERPC_XMON_H */
diff --git a/arch/powerpc/xmon/nonstdio.h b/arch/powerpc/xmon/nonstdio.h
index 2202ec61972c..e8deac6c84e2 100644
--- a/arch/powerpc/xmon/nonstdio.h
+++ b/arch/powerpc/xmon/nonstdio.h
@@ -1,13 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #define EOF	(-1)
 
-#define printf	xmon_printf
-#define putchar	xmon_putchar
-
 extern void xmon_set_pagination_lpp(unsigned long lpp);
 extern void xmon_start_pagination(void);
 extern void xmon_end_pagination(void);
 extern int xmon_putchar(int c);
 extern void xmon_puts(const char *);
 extern char *xmon_gets(char *, int);
-extern void xmon_printf(const char *, ...);
+extern __printf(1, 2) void xmon_printf(const char *fmt, ...);
+
+#define printf	xmon_printf
+#define putchar	xmon_putchar
-- 
2.11.0
