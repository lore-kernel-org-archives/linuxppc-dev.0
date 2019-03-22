Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299C4C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 14:08:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC1E21874
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 14:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TVD3t75R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC1E21874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QlrH3vwnzDqWp
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 01:08:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="TVD3t75R"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QlfM4hFZzDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 01:00:10 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44QlfD5myfz9tydW;
 Fri, 22 Mar 2019 15:00:04 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=TVD3t75R; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id xPLK5FWV0xo7; Fri, 22 Mar 2019 15:00:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44QlfD4bHHz9tydV;
 Fri, 22 Mar 2019 15:00:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553263204; bh=l///YPAie6uypUB1yNuBRWNf9RJugCs+/QmoUcS6Zx0=;
 h=From:Subject:To:Cc:Date:From;
 b=TVD3t75RzjncfGO+RukbpauQg6uI80vUDWLYyiU0cmGK2tADoEKMnA9EDqo4mH7SC
 xEU6OVubJ5ndZubeSwVVggp5Y2lHFaYTtoKgyA1BwNTPPi1ru6okwUD3vrIJJ4of9n
 NfTVntuDHQPZS/lEcJGozAj7O42qvByZ7/R2CgKI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F0388BB1B;
 Fri, 22 Mar 2019 15:00:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 4Uyy-m5EOo7f; Fri, 22 Mar 2019 15:00:05 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D1A368B848;
 Fri, 22 Mar 2019 15:00:05 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id ACA3C6CE54; Fri, 22 Mar 2019 14:00:05 +0000 (UTC)
Message-Id: <45a5e13683694fc8d4574b52c4851ffb7f5e5fbd.1553263058.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 1/3] kasan: move memset/memmove/memcpy interceptors in
 a dedicated file
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Date: Fri, 22 Mar 2019 14:00:05 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation of the addition of interceptors for other string functions,
this patch moves memset/memmove/memcpy interceptions in string.c

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 mm/kasan/Makefile |  5 ++++-
 mm/kasan/common.c | 26 --------------------------
 mm/kasan/string.c | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 27 deletions(-)
 create mode 100644 mm/kasan/string.c

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 5d1065efbd47..85e91e301404 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -1,11 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 KASAN_SANITIZE := n
 UBSAN_SANITIZE_common.o := n
+UBSAN_SANITIZE_string.o := n
 UBSAN_SANITIZE_generic.o := n
 UBSAN_SANITIZE_tags.o := n
 KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_common.o = -pg
+CFLAGS_REMOVE_string.o = -pg
 CFLAGS_REMOVE_generic.o = -pg
 CFLAGS_REMOVE_tags.o = -pg
 
@@ -13,9 +15,10 @@ CFLAGS_REMOVE_tags.o = -pg
 # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
 
 CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_string.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
-obj-$(CONFIG_KASAN) := common.o init.o report.o
+obj-$(CONFIG_KASAN) := common.o init.o report.o string.o
 obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
 obj-$(CONFIG_KASAN_SW_TAGS) += tags.o tags_report.o
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 80bbe62b16cd..3b94f484bf78 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -109,32 +109,6 @@ void kasan_check_write(const volatile void *p, unsigned int size)
 }
 EXPORT_SYMBOL(kasan_check_write);
 
-#undef memset
-void *memset(void *addr, int c, size_t len)
-{
-	check_memory_region((unsigned long)addr, len, true, _RET_IP_);
-
-	return __memset(addr, c, len);
-}
-
-#undef memmove
-void *memmove(void *dest, const void *src, size_t len)
-{
-	check_memory_region((unsigned long)src, len, false, _RET_IP_);
-	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
-
-	return __memmove(dest, src, len);
-}
-
-#undef memcpy
-void *memcpy(void *dest, const void *src, size_t len)
-{
-	check_memory_region((unsigned long)src, len, false, _RET_IP_);
-	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
-
-	return __memcpy(dest, src, len);
-}
-
 /*
  * Poisons the shadow memory for 'size' bytes starting from 'addr'.
  * Memory addresses should be aligned to KASAN_SHADOW_SCALE_SIZE.
diff --git a/mm/kasan/string.c b/mm/kasan/string.c
new file mode 100644
index 000000000000..f23a740ff985
--- /dev/null
+++ b/mm/kasan/string.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains strings functions for KASAN
+ *
+ */
+
+#include <linux/string.h>
+
+#include "kasan.h"
+
+#undef memset
+void *memset(void *addr, int c, size_t len)
+{
+	check_memory_region((unsigned long)addr, len, true, _RET_IP_);
+
+	return __memset(addr, c, len);
+}
+
+#undef memmove
+void *memmove(void *dest, const void *src, size_t len)
+{
+	check_memory_region((unsigned long)src, len, false, _RET_IP_);
+	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
+
+	return __memmove(dest, src, len);
+}
+
+#undef memcpy
+void *memcpy(void *dest, const void *src, size_t len)
+{
+	check_memory_region((unsigned long)src, len, false, _RET_IP_);
+	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
+
+	return __memcpy(dest, src, len);
+}
-- 
2.13.3

