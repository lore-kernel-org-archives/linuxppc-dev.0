Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A13081A0015
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 12:14:45 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 23 Jun 2014 12:14:45 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 65F5B3578048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 12:14:43 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5N2ERnd11600372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 12:14:27 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5N2EgYe000678
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 12:14:43 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 1/3] powerpc/powernv: Sync header with firmware
Date: Mon, 23 Jun 2014 12:14:40 +1000
Message-Id: <1403489682-14841-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, qiudayu@linux.vnet.ibm.com, agraf@suse.de,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch synchronizes firmware header file (opal.h) for PCI error
injection.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                | 65 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 2 files changed, 66 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 66ad7a7..d982bb8 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -175,6 +175,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_SET_PARAM				90
 #define OPAL_DUMP_RESEND			91
 #define OPAL_DUMP_INFO2				94
+#define OPAL_ERR_INJECT				96
 
 #ifndef __ASSEMBLY__
 
@@ -219,6 +220,69 @@ enum OpalPciErrorSeverity {
 	OPAL_EEH_SEV_INF	= 5
 };
 
+enum OpalErrinjctType {
+	OpalErrinjctTypeFirst			= 0,
+	OpalErrinjctTypeFatal			= 1,
+	OpalErrinjctTypeRecoverRandomEvent	= 2,
+	OpalErrinjctTypeRecoverSpecialEvent	= 3,
+	OpalErrinjctTypeCorruptedPage		= 4,
+	OpalErrinjctTypeCorruptedSlb		= 5,
+	OpalErrinjctTypeTranslatorFailure	= 6,
+	OpalErrinjctTypeIoaBusError		= 7,
+	OpalErrinjctTypeIoaBusError64		= 8,
+	OpalErrinjctTypePlatformSpecific	= 9,
+	OpalErrinjctTypeDcacheStart		= 10,
+	OpalErrinjctTypeDcacheEnd		= 11,
+	OpalErrinjctTypeIcacheStart		= 12,
+	OpalErrinjctTypeIcacheEnd		= 13,
+	OpalErrinjctTypeTlbStart		= 14,
+	OpalErrinjctTypeTlbEnd			= 15,
+	OpalErrinjctTypeUpstreamIoError		= 16,
+	OpalErrinjctTypeLast			= 17,
+
+	/* IoaBusError & IoaBusError64 */
+	OpalEitIoaLoadMemAddr			= 0,
+	OpalEitIoaLoadMemData			= 1,
+	OpalEitIoaLoadIoAddr			= 2,
+	OpalEitIoaLoadIoData			= 3,
+	OpalEitIoaLoadConfigAddr		= 4,
+	OpalEitIoaLoadConfigData		= 5,
+	OpalEitIoaStoreMemAddr			= 6,
+	OpalEitIoaStoreMemData			= 7,
+	OpalEitIoaStoreIoAddr			= 8,
+	OpalEitIoaStoreIoData			= 9,
+	OpalEitIoaStoreConfigAddr		= 10,
+	OpalEitIoaStoreConfigData		= 11,
+	OpalEitIoaDmaReadMemAddr		= 12,
+	OpalEitIoaDmaReadMemData		= 13,
+	OpalEitIoaDmaReadMemMaster		= 14,
+	OpalEitIoaDmaReadMemTarget		= 15,
+	OpalEitIoaDmaWriteMemAddr		= 16,
+	OpalEitIoaDmaWriteMemData		= 17,
+	OpalEitIoaDmaWriteMemMaster		= 18,
+	OpalEitIoaDmaWriteMemTarget		= 19,
+};
+
+struct OpalErrinjct {
+	int32_t type;
+	union {
+		struct {
+			uint32_t addr;
+			uint32_t mask;
+			uint64_t phb_id;
+			uint32_t pe;
+			uint32_t function;
+		} ioa;
+		struct {
+			uint64_t addr;
+			uint64_t mask;
+			uint64_t phb_id;
+			uint32_t pe;
+			uint32_t function;
+		} ioa64;
+	};
+};
+
 enum OpalShpcAction {
 	OPAL_SHPC_GET_LINK_STATE = 0,
 	OPAL_SHPC_GET_SLOT_STATE = 1
@@ -870,6 +934,7 @@ int64_t opal_update_flash(uint64_t blk_list);
 int64_t opal_dump_init(uint8_t dump_type);
 int64_t opal_dump_info(__be32 *dump_id, __be32 *dump_size);
 int64_t opal_dump_info2(__be32 *dump_id, __be32 *dump_size, __be32 *dump_type);
+int64_t opal_err_injct(struct OpalErrinjct *ei);
 int64_t opal_dump_read(uint32_t dump_id, uint64_t buffer);
 int64_t opal_dump_ack(uint32_t dump_id);
 int64_t opal_dump_resend_notification(void);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index f531ffe..44b3d81 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -136,6 +136,7 @@ OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEBASE);
 OPAL_CALL(opal_dump_init,			OPAL_DUMP_INIT);
 OPAL_CALL(opal_dump_info,			OPAL_DUMP_INFO);
 OPAL_CALL(opal_dump_info2,			OPAL_DUMP_INFO2);
+OPAL_CALL(opal_err_injct,			OPAL_ERR_INJECT);
 OPAL_CALL(opal_dump_read,			OPAL_DUMP_READ);
 OPAL_CALL(opal_dump_ack,			OPAL_DUMP_ACK);
 OPAL_CALL(opal_get_msg,				OPAL_GET_MSG);
-- 
1.8.3.2
