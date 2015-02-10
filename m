Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFCCF1A09D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:28:15 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 19:28:13 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B3BAE3E40030
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 19:28:11 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2SOEv33161350
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:28:32 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2RcOK020727
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:27:39 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 14/18] powerpc/powernv: sync comments and whitespace in opal.h
 with firmware
Date: Tue, 10 Feb 2015 13:26:56 +1100
Message-Id: <1423535220-6322-15-git-send-email-stewart@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/opal.h |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index c09cf66..2aaa861 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -346,6 +346,11 @@ enum OpalPciResetScope {
 };
 
 enum OpalPciReinitScope {
+	/*
+	 * Note: we chose values that do not overlap
+	 * OpalPciResetScope as OPAL v2 used the same
+	 * enum for both
+	 */
 	OPAL_REINIT_PCI_DEV = 1000
 };
 
@@ -423,10 +428,10 @@ enum {
 };
 
 struct opal_ipmi_msg {
-	uint8_t		version;
-	uint8_t		netfn;
-	uint8_t		cmd;
-	uint8_t		data[];
+	uint8_t version;
+	uint8_t netfn;
+	uint8_t cmd;
+	uint8_t data[];
 };
 
 /*
@@ -477,7 +482,6 @@ enum OpalMemErr_Version {
 enum OpalMemErrType {
 	OPAL_MEM_ERR_TYPE_RESILIENCE	= 0,
 	OPAL_MEM_ERR_TYPE_DYN_DALLOC,
-	OPAL_MEM_ERR_TYPE_SCRUB,
 };
 
 /* Memory Reilience error type */
@@ -731,11 +735,10 @@ struct OpalIoPhb3ErrorData {
 	__be64 errorClass;
 	__be64 correlator;
 
+	/* PHB3 MMIO Error Regs */
 	__be64 nFir;			/* 000 */
 	__be64 nFirMask;		/* 003 */
 	__be64 nFirWOF;		/* 008 */
-
-	/* PHB3 MMIO Error Regs */
 	__be64 phbPlssr;		/* 120 */
 	__be64 phbCsr;		/* 110 */
 	__be64 lemFir;		/* C00 */
@@ -772,7 +775,7 @@ typedef struct oppanel_line {
 } oppanel_line_t;
 
 /*
- * SG entry
+ * SG entries
  *
  * WARNING: The current implementation requires each entry
  * to represent a block that is 4k aligned *and* each block
@@ -783,7 +786,11 @@ struct opal_sg_entry {
 	__be64 length;
 };
 
-/* SG list */
+/*
+ * Candiate image SG list.
+ *
+ * length = VER | length
+ */
 struct opal_sg_list {
 	__be64 length;
 	__be64 next;
-- 
1.7.10.4
