Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C45042C017E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 00:21:14 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 00:11:58 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0BAEE357804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 00:21:10 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3NE7RUu9830724
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 00:07:27 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3NEL9wi012871
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 00:21:09 +1000
Subject: [PATCH v2 1/2] powerpc/rtas_flash: Update return token comments
To: linuxppc-dev@lists.ozlabs.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Tue, 23 Apr 2013 19:50:48 +0530
Message-ID: <20130423141958.25932.5791.stgit@hegdevasant>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add proper comment to ibm,validate-flash-image RTAS call
update result tokens.

Note: Only comment section is modified, no code change.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/kernel/rtas_flash.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index a7020d2..bc97a21 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -57,13 +57,26 @@
 #define VALIDATE_READY	       -1001 /* Firmware image ready for validation */
 #define VALIDATE_PARAM_ERR     -3    /* RTAS Parameter Error */
 #define VALIDATE_HW_ERR        -1    /* RTAS Hardware Error */
-#define VALIDATE_TMP_UPDATE    0     /* Validate Return Status */
-#define VALIDATE_FLASH_AUTH    1     /* Validate Return Status */
-#define VALIDATE_INVALID_IMG   2     /* Validate Return Status */
-#define VALIDATE_CUR_UNKNOWN   3     /* Validate Return Status */
-#define VALIDATE_TMP_COMMIT_DL 4     /* Validate Return Status */
-#define VALIDATE_TMP_COMMIT    5     /* Validate Return Status */
-#define VALIDATE_TMP_UPDATE_DL 6     /* Validate Return Status */
+
+/* ibm,validate-flash-image update result tokens */
+#define VALIDATE_TMP_UPDATE    0     /* T side will be updated */
+#define VALIDATE_FLASH_AUTH    1     /* Partition does not have authority */
+#define VALIDATE_INVALID_IMG   2     /* Candidate image is not valid */
+#define VALIDATE_CUR_UNKNOWN   3     /* Current fixpack level is unknown */
+/*
+ * Current T side will be committed to P side before being replace with new
+ * image, and the new image is downlevel from current image
+ */
+#define VALIDATE_TMP_COMMIT_DL 4
+/*
+ * Current T side will be committed to P side before being replaced with new
+ * image
+ */
+#define VALIDATE_TMP_COMMIT    5
+/*
+ * T side will be updated with a downlevel image
+ */
+#define VALIDATE_TMP_UPDATE_DL 6
 
 /* ibm,manage-flash-image operation tokens */
 #define RTAS_REJECT_TMP_IMG   0
