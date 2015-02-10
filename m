Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 723CD1A047E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:28:14 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 21:28:12 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A94CB38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 21:28:10 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2S2hi27918344
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 02:28:10 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2RbXr006732
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 21:27:38 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 12/18] powerpc/powernv: add CAPI and EPOW parts to opal.h
Date: Tue, 10 Feb 2015 13:26:54 +1100
Message-Id: <1423535220-6322-13-git-send-email-stewart@linux.vnet.ibm.com>
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

this adds CAPI and EPOW parts to opal.h that previously were only
in firmware opal.h

Currently unused, but gets us really close to being able to share
opal.h between firmware and linux.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h |   52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 240ee1c..214a106 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -414,6 +414,46 @@ struct opal_ipmi_msg {
 	uint8_t		data[];
 };
 
+/*
+ * EPOW status sharing (OPAL and the host)
+ *
+ * The host will pass on OPAL, a buffer of length OPAL_SYSEPOW_MAX
+ * with individual elements being 16 bits wide to fetch the system
+ * wide EPOW status. Each element in the buffer will contain the
+ * EPOW status in it's bit representation for a particular EPOW sub
+ * class as defiend here. So multiple detailed EPOW status bits
+ * specific for any sub class can be represented in a single buffer
+ * element as it's bit representation.
+ */
+
+/* System EPOW type */
+enum OpalSysEpow {
+	OPAL_SYSEPOW_POWER	= 0,	/* Power EPOW */
+	OPAL_SYSEPOW_TEMP	= 1,	/* Temperature EPOW */
+	OPAL_SYSEPOW_COOLING	= 2,	/* Cooling EPOW */
+	OPAL_SYSEPOW_MAX	= 3,	/* Max EPOW categories */
+};
+
+/* Power EPOW */
+enum OpalSysPower {
+	OPAL_SYSPOWER_UPS	= 0x0001, /* System on UPS power */
+	OPAL_SYSPOWER_CHNG	= 0x0002, /* System power configuration change */
+	OPAL_SYSPOWER_FAIL	= 0x0004, /* System impending power failure */
+	OPAL_SYSPOWER_INCL	= 0x0008, /* System incomplete power */
+};
+
+/* Temperature EPOW */
+enum OpalSysTemp {
+	OPAL_SYSTEMP_AMB	= 0x0001, /* System over ambient temperature */
+	OPAL_SYSTEMP_INT	= 0x0002, /* System over internal temperature */
+	OPAL_SYSTEMP_HMD	= 0x0004, /* System over ambient humidity */
+};
+
+/* Cooling EPOW */
+enum OpalSysCooling {
+	OPAL_SYSCOOL_INSF	= 0x0001, /* System insufficient cooling */
+};
+
 /* FSP memory errors handling */
 enum OpalMemErr_Version {
 	OpalMemErr_V1 = 1,
@@ -741,6 +781,18 @@ struct opal_sg_list {
 #define OPAL_DUMP_REGION_LOG_BUF		0x80
 #define OPAL_DUMP_REGION_HOST_END		0xFF
 
+/* CAPI modes for PHB */
+enum {
+	OPAL_PHB_CAPI_MODE_PCIE		= 0,
+	OPAL_PHB_CAPI_MODE_CAPI		= 1,
+	OPAL_PHB_CAPI_MODE_SNOOP_OFF    = 2,
+	OPAL_PHB_CAPI_MODE_SNOOP_ON	= 3,
+};
+
+/* CAPI feature flags (in device-tree) */
+#define OPAL_PHB_CAPI_FLAG_SNOOP_CONTROL	0x00000001
+#define OPAL_PHB_CAPI_FLAG_REVERT_TO_PCIE	0x00000002
+
 /* We calculate number of sg entries based on PAGE_SIZE */
 #define SG_ENTRIES_PER_NODE ((PAGE_SIZE - 16) / sizeof(struct opal_sg_entry))
 
-- 
1.7.10.4
