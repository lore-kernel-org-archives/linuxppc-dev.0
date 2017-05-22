Return-Path: <dja@axtens.net>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWLl64LXvzDqZl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 11:33:06 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id k74so17231844qke.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 18:33:06 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: kernel-hardening@lists.openwall.com,
	linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>, Kees Cook <keescook@chromium.org>,
 Daniel Micay <danielmicay@gmail.com>
Subject: [PATCH 1/2] powerpc: Don't fortify prom_init
Date: Mon, 22 May 2017 11:32:32 +1000
Message-Id: <20170522013233.21780-2-dja@axtens.net>
In-Reply-To: <20170522013233.21780-1-dja@axtens.net>
References: <20170522013233.21780-1-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

prom_init is a bit special; in theory it should be able to be
linked separately to the kernel. To keep this from getting too
complex, the symbols that prom_init.c uses are checked.

Fortification adds symbols, and it gets quite messy as it includes
things like panic(). So just don't fortify prom_init.c for now.

Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

This will need to go in before the main fortify support, but it
doesn't make any sense in the absence of fortify. I think it would
make most sense for Kees to queue this up with the main fortify patch,
with an Ack from mpe?

---
 arch/powerpc/kernel/prom_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index dd8a04f3053a..613f79f03877 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -15,6 +15,9 @@
 
 #undef DEBUG_PROM
 
+/* we cannot use FORTIFY as it brings in new symbols */
+#define __NO_FORTIFY
+
 #include <stdarg.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
-- 
2.11.0
