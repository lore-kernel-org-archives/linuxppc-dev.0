Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C37BA1A018F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:27:40 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 21:27:38 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id BC7E938C8039
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 21:27:36 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2RaNK20971612
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 02:27:36 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2RY2W007877
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 21:27:36 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 16/18] powerpc/powernv: move SG_ENTRIES_PER_NODE to
 linux-specific opal-api.h
Date: Tue, 10 Feb 2015 13:26:58 +1100
Message-Id: <1423535220-6322-17-git-send-email-stewart@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/opal-api.h |    4 ++++
 arch/powerpc/include/asm/opal.h     |    4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index c4009dd..172d08e 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -237,4 +237,8 @@ extern void opal_lpc_init(void);
 struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
 					     unsigned long vmalloc_size);
 void opal_free_sg_list(struct opal_sg_list *sg);
+
+/* We calculate number of sg entries based on PAGE_SIZE */
+#define SG_ENTRIES_PER_NODE ((PAGE_SIZE - 16) / sizeof(struct opal_sg_entry))
+
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index b60a25a..2441f36 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -820,10 +820,6 @@ enum {
 #define OPAL_PHB_CAPI_FLAG_SNOOP_CONTROL	0x00000001
 #define OPAL_PHB_CAPI_FLAG_REVERT_TO_PCIE	0x00000002
 
-/* We calculate number of sg entries based on PAGE_SIZE */
-#define SG_ENTRIES_PER_NODE ((PAGE_SIZE - 16) / sizeof(struct opal_sg_entry))
-
-
 /* OPAL I2C request */
 struct opal_i2c_request {
 	uint8_t	type;
-- 
1.7.10.4
