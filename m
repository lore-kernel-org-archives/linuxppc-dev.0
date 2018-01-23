Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQmNd28fWzDqxT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 22:32:01 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0NBVGVS045278
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:31:58 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fp2r9v65y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:31:58 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 23 Jan 2018 11:31:55 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH v2 03/13] powerpc/powernv: Add opal calls for opencapi
Date: Tue, 23 Jan 2018 12:31:38 +0100
In-Reply-To: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
References: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20180123113148.6024-4-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add opal calls to interact with the NPU:

OPAL_NPU_SPA_SETUP: set the Shared Process Area (SPA)
The SPA is a table containing one entry (Process Element) per memory
context which can be accessed by the opencapi device.

OPAL_NPU_SPA_CLEAR_CACHE: clear the context cache
The NPU keeps a cache of recently accessed memory contexts. When a
Process Element is removed from the SPA, the cache for the link must
be cleared.

OPAL_NPU_TL_SET: configure the Transaction Layer
The Transaction Layer specification defines several templates for
messages to be exchanged on the link. During link setup, the host and
device must negotiate what templates are supported on both sides and
at what rates those messages can be sent.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            | 5 ++++-
 arch/powerpc/include/asm/opal.h                | 6 ++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S | 3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 233c7504b1f2..24c73f5575ee 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -201,7 +201,10 @@
 #define OPAL_SET_POWER_SHIFT_RATIO		155
 #define OPAL_SENSOR_GROUP_CLEAR			156
 #define OPAL_PCI_SET_P2P			157
-#define OPAL_LAST				157
+#define OPAL_NPU_SPA_SETUP			159
+#define OPAL_NPU_SPA_CLEAR_CACHE		160
+#define OPAL_NPU_TL_SET				161
+#define OPAL_LAST				161
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 0c545f7fc77b..12e70fb58700 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -34,6 +34,12 @@ int64_t opal_npu_init_context(uint64_t phb_id, int pasid, uint64_t msr,
 			uint64_t bdf);
 int64_t opal_npu_map_lpar(uint64_t phb_id, uint64_t bdf, uint64_t lparid,
 			uint64_t lpcr);
+int64_t opal_npu_spa_setup(uint64_t phb_id, uint32_t bdfn,
+			uint64_t addr, uint64_t PE_mask);
+int64_t opal_npu_spa_clear_cache(uint64_t phb_id, uint32_t bdfn,
+				uint64_t PE_handle);
+int64_t opal_npu_tl_set(uint64_t phb_id, uint32_t bdfn, long cap,
+			uint64_t rate_phys, uint32_t size);
 int64_t opal_console_write(int64_t term_number, __be64 *length,
 			   const uint8_t *buffer);
 int64_t opal_console_read(int64_t term_number, __be64 *length,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 6f4b00a2ac46..1b2936ba6040 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -320,3 +320,6 @@ OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
 OPAL_CALL(opal_get_power_shift_ratio,		OPAL_GET_POWER_SHIFT_RATIO);
 OPAL_CALL(opal_set_power_shift_ratio,		OPAL_SET_POWER_SHIFT_RATIO);
 OPAL_CALL(opal_sensor_group_clear,		OPAL_SENSOR_GROUP_CLEAR);
+OPAL_CALL(opal_npu_spa_setup,			OPAL_NPU_SPA_SETUP);
+OPAL_CALL(opal_npu_spa_clear_cache,		OPAL_NPU_SPA_CLEAR_CACHE);
+OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
-- 
2.14.1
