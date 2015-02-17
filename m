Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 16B191A0F43
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 20:02:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [RFC PATCH 3/3] powerpc/powernv: Remove unused definitions in
 opal-api.h
Date: Tue, 17 Feb 2015 20:01:55 +1100
Message-Id: <1424163715-10370-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1424163715-10370-1-git-send-email-mpe@ellerman.id.au>
References: <1424163715-10370-1-git-send-email-mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, skiboot@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes definitions in opal-api.h that are completely unused in
Linux.

For each of these I see three possibilities, 1) we *should* be using
them in Linux and patches will arrive to do that, 2) they are not used
but should stay in the header to document the API for some important
reason, 3) they are not used and needn't be part of the API.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/opal-api.h | 47 -------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 2984f486f3ba..e8a6baf55e82 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -165,10 +165,6 @@
 #ifndef __ASSEMBLY__
 
 /* Other enums */
-enum OpalVendorApiTokens {
-	OPAL_START_VENDOR_API_RANGE = 1000, OPAL_END_VENDOR_API_RANGE = 1999
-};
-
 enum OpalFreezeState {
 	OPAL_EEH_STOPPED_NOT_FROZEN = 0,
 	OPAL_EEH_STOPPED_MMIO_FREEZE = 1,
@@ -236,27 +232,12 @@ enum OpalErrinjectFunc {
 	OPAL_ERR_INJECT_FUNC_IOA_DMA_WR_TARGET	= 19,
 };
 
-enum OpalShpcAction {
-	OPAL_SHPC_GET_LINK_STATE = 0,
-	OPAL_SHPC_GET_SLOT_STATE = 1
-};
-
-enum OpalShpcLinkState {
-	OPAL_SHPC_LINK_DOWN = 0,
-	OPAL_SHPC_LINK_UP = 1
-};
-
 enum OpalMmioWindowType {
 	OPAL_M32_WINDOW_TYPE = 1,
 	OPAL_M64_WINDOW_TYPE = 2,
 	OPAL_IO_WINDOW_TYPE  = 3
 };
 
-enum OpalShpcSlotState {
-	OPAL_SHPC_DEV_NOT_PRESENT = 0,
-	OPAL_SHPC_DEV_PRESENT = 1
-};
-
 enum OpalExceptionHandler {
 	OPAL_MACHINE_CHECK_HANDLER	    = 1,
 	OPAL_HYPERVISOR_MAINTENANCE_HANDLER = 2,
@@ -348,29 +329,6 @@ enum OpalPciResetState {
 	OPAL_ASSERT_RESET   = 1
 };
 
-enum OpalPciMaskAction {
-	OPAL_UNMASK_ERROR_TYPE = 0,
-	OPAL_MASK_ERROR_TYPE = 1
-};
-
-enum OpalSlotLedType {
-	OPAL_SLOT_LED_ID_TYPE = 0,
-	OPAL_SLOT_LED_FAULT_TYPE = 1
-};
-
-enum OpalLedAction {
-	OPAL_TURN_OFF_LED = 0,
-	OPAL_TURN_ON_LED = 1,
-	OPAL_QUERY_LED_STATE_AFTER_BUSY = 2
-};
-
-enum OpalEpowStatus {
-	OPAL_EPOW_NONE = 0,
-	OPAL_EPOW_UPS = 1,
-	OPAL_EPOW_OVER_AMBIENT_TEMP = 2,
-	OPAL_EPOW_OVER_INTERNAL_TEMP = 3
-};
-
 /*
  * Address cycle types for LPC accesses. These also correspond
  * to the content of the first cell of the "reg" property for
@@ -440,11 +398,6 @@ enum OpalMemErr_DynErrType {
 	OPAL_MEM_DYNAMIC_DEALLOC	= 0,
 };
 
-/* OpalMemoryErrorData->flags */
-#define OPAL_MEM_CORRECTED_ERROR	0x0001
-#define OPAL_MEM_THRESHOLD_EXCEEDED	0x0002
-#define OPAL_MEM_ACK_REQUIRED		0x8000
-
 struct OpalMemoryErrorData {
 	enum OpalMemErr_Version	version:8;	/* 0x00 */
 	enum OpalMemErrType	type:8;		/* 0x01 */
-- 
2.1.0
