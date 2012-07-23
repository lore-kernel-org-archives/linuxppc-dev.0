Return-Path: <R65777@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 453C32C0330
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 20:15:11 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <agraf@suse.de>, <scottwood@freescale.com>
Subject: [PATCH] using get/put_user64 apis on 64bit machine
Date: Mon, 23 Jul 2012 15:46:37 +0530
Message-ID: <1343038597-23859-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc64 machine get/put_user64() is same as get/put_user() while
on powerpc32 machine get_user64 is different. With this patch we can
use get_user64() and put_user64() on 32 and 64 bit machines.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 arch/powerpc/include/asm/uaccess.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 17bb40c..01743aa 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -114,10 +114,17 @@ struct exception_table_entry {
 #define __put_user(x, ptr) \
 	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
 
+/*
+ * On powerpc64 machine get/put_user64() is same as get/put_user() while
+ * on powerpc32 machine get_user64 is different.
+ */
 #ifndef __powerpc64__
 #define __get_user64(x, ptr) \
 	__get_user64_nocheck((x), (ptr), sizeof(*(ptr)))
 #define __put_user64(x, ptr) __put_user(x, ptr)
+#else
+#define __get_user64(x, ptr) __get_user(x, ptr) 
+#define __put_user64(x, ptr) __put_user(x, ptr)
 #endif
 
 #define __get_user_inatomic(x, ptr) \
-- 
1.7.0.4
