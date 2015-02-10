Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 885771A0475
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:27:59 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 21:27:57 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5376338C8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 21:27:54 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2Rko620381740
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 02:27:54 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2RLlp006098
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 21:27:21 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 04/18] powerpc/powernv: relocate struct opal_sg_entry in
 opal.h to same place it is in firmware
Date: Tue, 10 Feb 2015 13:26:46 +1100
Message-Id: <1423535220-6322-5-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For whatever reason these structures were in different places.

Now they are not.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h |   48 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index e8d9bfc..0f9f06d 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -12,31 +12,6 @@
 #ifndef __OPAL_H
 #define __OPAL_H
 
-#ifndef __ASSEMBLY__
-/*
- * SG entry
- *
- * WARNING: The current implementation requires each entry
- * to represent a block that is 4k aligned *and* each block
- * size except the last one in the list to be as well.
- */
-struct opal_sg_entry {
-	__be64 data;
-	__be64 length;
-};
-
-/* SG list */
-struct opal_sg_list {
-	__be64 length;
-	__be64 next;
-	struct opal_sg_entry entry[];
-};
-
-/* We calculate number of sg entries based on PAGE_SIZE */
-#define SG_ENTRIES_PER_NODE ((PAGE_SIZE - 16) / sizeof(struct opal_sg_entry))
-
-#endif /* __ASSEMBLY__ */
-
 /****** OPAL APIs ******/
 
 /* Return codes */
@@ -740,6 +715,29 @@ typedef struct oppanel_line {
 	uint64_t 	line_len;
 } oppanel_line_t;
 
+/*
+ * SG entry
+ *
+ * WARNING: The current implementation requires each entry
+ * to represent a block that is 4k aligned *and* each block
+ * size except the last one in the list to be as well.
+ */
+struct opal_sg_entry {
+	__be64 data;
+	__be64 length;
+};
+
+/* SG list */
+struct opal_sg_list {
+	__be64 length;
+	__be64 next;
+	struct opal_sg_entry entry[];
+};
+
+/* We calculate number of sg entries based on PAGE_SIZE */
+#define SG_ENTRIES_PER_NODE ((PAGE_SIZE - 16) / sizeof(struct opal_sg_entry))
+
+
 /* OPAL I2C request */
 struct opal_i2c_request {
 	uint8_t	type;
-- 
1.7.10.4
