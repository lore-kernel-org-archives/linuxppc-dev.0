Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A2071A0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 14:48:04 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/4] powerpc/powernv: Add OPAL check token call
Date: Tue, 19 Aug 2014 14:47:59 +1000
Message-Id: <1408423682-14297-1-git-send-email-mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently there is no way to generically check if an OPAL call exists or not
from the host kernel.

This adds an OPAL call opal_check_token() which tells you if the given token is
present in OPAL or not.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/opal.h                | 7 +++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 86055e5..4593a93 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -135,6 +135,7 @@ struct opal_sg_list {
 #define OPAL_FLASH_MANAGE			77
 #define OPAL_FLASH_UPDATE			78
 #define OPAL_RESYNC_TIMEBASE			79
+#define OPAL_CHECK_TOKEN			80
 #define OPAL_DUMP_INIT				81
 #define OPAL_DUMP_INFO				82
 #define OPAL_DUMP_READ				83
@@ -417,6 +418,11 @@ struct opal_msg {
 	__be64 params[8];
 };
 
+enum OpalCheckTokenStatus {
+       OPAL_TOKEN_ABSENT = 0,
+       OPAL_TOKEN_PRESENT = 1
+};
+
 struct opal_machine_check_event {
 	enum OpalMCE_Version	version:8;	/* 0x00 */
 	uint8_t			in_use;		/* 0x01 */
@@ -887,6 +893,7 @@ int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
 			    __be16 *pci_error_type, __be16 *severity);
 int64_t opal_pci_poll(uint64_t phb_id);
 int64_t opal_return_cpu(void);
+int64_t opal_check_token(uint64_t token);
 int64_t opal_reinit_cpus(uint64_t flags);
 
 int64_t opal_xscom_read(uint32_t gcid, uint64_t pcb_addr, __be64 *val);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 2e6ce1b..5718855 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -232,6 +232,7 @@ OPAL_CALL(opal_validate_flash,			OPAL_FLASH_VALIDATE);
 OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
 OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
 OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEBASE);
+OPAL_CALL(opal_check_token,			OPAL_CHECK_TOKEN);
 OPAL_CALL(opal_dump_init,			OPAL_DUMP_INIT);
 OPAL_CALL(opal_dump_info,			OPAL_DUMP_INFO);
 OPAL_CALL(opal_dump_info2,			OPAL_DUMP_INFO2);
-- 
1.9.1
