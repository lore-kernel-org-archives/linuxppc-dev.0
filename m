Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C1F6D1A0179
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2015 09:42:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, khandual@linux.vnet.ibm.com,
 stewart@linux.vnet.ibm.com, hegdevasant@linux.vnet.ibm.com
Subject: [PATCH] powerpc/powernv: Fix mis-merge of OPAL support for LEDS driver
Date: Sat, 22 Aug 2015 09:42:05 +1000
Message-Id: <1440200525-22360-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When I merged the OPAL support for the powernv LEDS driver I missed a
hunk.

This is slightly modified from the original patch, as the original added
code to opal-api.h which is not in the skiboot version, which is
discouraged.

Instead those values are moved into the driver, which is the only place
they are used.

Fixes: 8a8d91817aec ("powerpc/powernv: Add OPAL interfaces for accessing and modifying system LED states")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/opal-api.h | 12 ++++++++++++
 drivers/leds/leds-powernv.c         |  6 +++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index b516ec1d3b4c..9784c9241c70 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -343,6 +343,18 @@ enum OpalPciResetState {
 	OPAL_ASSERT_RESET   = 1
 };
 
+enum OpalSlotLedType {
+	OPAL_SLOT_LED_TYPE_ID = 0,	/* IDENTIFY LED */
+	OPAL_SLOT_LED_TYPE_FAULT = 1,	/* FAULT LED */
+	OPAL_SLOT_LED_TYPE_ATTN = 2,	/* System Attention LED */
+	OPAL_SLOT_LED_TYPE_MAX = 3
+};
+
+enum OpalSlotLedState {
+	OPAL_SLOT_LED_STATE_OFF = 0,	/* LED is OFF */
+	OPAL_SLOT_LED_STATE_ON = 1	/* LED is ON */
+};
+
 /*
  * Address cycle types for LPC accesses. These also correspond
  * to the content of the first cell of the "reg" property for
diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
index a2fea192573b..2c5c5b12ab64 100644
--- a/drivers/leds/leds-powernv.c
+++ b/drivers/leds/leds-powernv.c
@@ -27,9 +27,9 @@ struct led_type_map {
 	const char	*desc;
 };
 static const struct led_type_map led_type_map[] = {
-	{OPAL_SLOT_LED_TYPE_ID,		POWERNV_LED_TYPE_IDENTIFY},
-	{OPAL_SLOT_LED_TYPE_FAULT,	POWERNV_LED_TYPE_FAULT},
-	{OPAL_SLOT_LED_TYPE_ATTN,	POWERNV_LED_TYPE_ATTENTION},
+	{OPAL_SLOT_LED_TYPE_ID,		"identify"},
+	{OPAL_SLOT_LED_TYPE_FAULT,	"fault"},
+	{OPAL_SLOT_LED_TYPE_ATTN,	"attention"},
 	{-1,				NULL},
 };
 
-- 
2.1.4
