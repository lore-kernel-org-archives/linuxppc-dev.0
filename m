Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDDF91A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:28:05 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 19:28:04 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E655719D803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 19:19:11 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2RsnU52887638
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:28:02 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2RTmg020406
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:27:29 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 06/18] powerpc/powernv: move OPAL_DUMP_REGION defines in
 opal.h to same place as in firmware opal.h
Date: Tue, 10 Feb 2015 13:26:48 +1100
Message-Id: <1423535220-6322-7-git-send-email-stewart@linux.vnet.ibm.com>
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

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9ca5167..7075f57 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -733,6 +733,13 @@ struct opal_sg_list {
 	struct opal_sg_entry entry[];
 };
 
+/*
+ * Dump region ID range usable by the OS
+ */
+#define OPAL_DUMP_REGION_HOST_START		0x80
+#define OPAL_DUMP_REGION_LOG_BUF		0x80
+#define OPAL_DUMP_REGION_HOST_END		0xFF
+
 /* We calculate number of sg entries based on PAGE_SIZE */
 #define SG_ENTRIES_PER_NODE ((PAGE_SIZE - 16) / sizeof(struct opal_sg_entry))
 
@@ -979,13 +986,6 @@ struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
 					     unsigned long vmalloc_size);
 void opal_free_sg_list(struct opal_sg_list *sg);
 
-/*
- * Dump region ID range usable by the OS
- */
-#define OPAL_DUMP_REGION_HOST_START		0x80
-#define OPAL_DUMP_REGION_LOG_BUF		0x80
-#define OPAL_DUMP_REGION_HOST_END		0xFF
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_H */
-- 
1.7.10.4
