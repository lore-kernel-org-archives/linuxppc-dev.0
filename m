Return-Path: <R65777@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8FF852C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 20:24:07 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <benh@kernel.crashing.org>
Subject: [PATCH] Remove unused __get_user64() and __put_user64()
Date: Tue, 11 Sep 2012 15:49:45 +0530
Message-ID: <1347358785-4695-1-git-send-email-Bharat.Bhushan@freescale.com>
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

__get_user64()  and __put_user64() are not used.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 arch/powerpc/include/asm/uaccess.h |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 17bb40c..4db4959 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -98,11 +98,6 @@ struct exception_table_entry {
  * PowerPC, we can just do these as direct assignments.  (Of course, the
  * exception handling means that it's no longer "just"...)
  *
- * The "user64" versions of the user access functions are versions that
- * allow access of 64-bit data. The "get_user" functions do not
- * properly handle 64-bit data because the value gets down cast to a long.
- * The "put_user" functions already handle 64-bit data properly but we add
- * "user64" versions for completeness
  */
 #define get_user(x, ptr) \
 	__get_user_check((x), (ptr), sizeof(*(ptr)))
@@ -114,12 +109,6 @@ struct exception_table_entry {
 #define __put_user(x, ptr) \
 	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
 
-#ifndef __powerpc64__
-#define __get_user64(x, ptr) \
-	__get_user64_nocheck((x), (ptr), sizeof(*(ptr)))
-#define __put_user64(x, ptr) __put_user(x, ptr)
-#endif
-
 #define __get_user_inatomic(x, ptr) \
 	__get_user_nosleep((x), (ptr), sizeof(*(ptr)))
 #define __put_user_inatomic(x, ptr) \
-- 
1.7.0.4
