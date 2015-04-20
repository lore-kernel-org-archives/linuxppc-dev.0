Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FEB71A1E65
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 17:59:47 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 20 Apr 2015 13:29:45 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 9C4D4E004C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 13:32:19 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3K7xfm162849168
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 13:29:41 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3K7xeld031380
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 13:29:41 +0530
Subject: [PATCH v3 1/3] powerpc/powernv: Add OPAL interfaces for accessing
 and modifying system LED states
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org
Date: Mon, 20 Apr 2015 13:29:40 +0530
Message-ID: <20150420075927.12371.59080.stgit@localhost.localdomain>
In-Reply-To: <20150420075558.12371.6697.stgit@localhost.localdomain>
References: <20150420075558.12371.6697.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: stewart@linux.vnet.ibm.com, cooloney@gmail.com, rpurdie@rpsys.net,
 j.anaszewski@samsung.com, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch registers the following two new OPAL interfaces calls
for the platform LED subsystem. With the help of these new OPAL calls,
the kernel will be able to get or set the state of various individual
LEDs on the system at any given location code which is passed through
the LED specific device tree nodes.

	(1) OPAL_LEDS_GET_INDICATOR     opal_leds_get_ind
	(2) OPAL_LEDS_SET_INDICATOR     opal_leds_set_ind

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Tested-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            |   29 +++++++++++++++++++++++-
 arch/powerpc/include/asm/opal.h                |    5 ++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 ++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0321a90..64508eb 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -153,7 +153,9 @@
 #define OPAL_FLASH_READ				110
 #define OPAL_FLASH_WRITE			111
 #define OPAL_FLASH_ERASE			112
-#define OPAL_LAST				112
+#define OPAL_LEDS_GET_INDICATOR			114
+#define OPAL_LEDS_SET_INDICATOR			115
+#define OPAL_LAST				115
 
 /* Device tree flags */
 
@@ -730,6 +732,31 @@ struct opal_i2c_request {
 	__be64 buffer_ra;		/* Buffer real address */
 };
 
+/* LED Mode */
+#define LED_MODE_LIGHT_PATH	"lightpath"
+#define LED_MODE_GUIDING_LIGHT	"guidinglight"
+
+/* LED type */
+#define LED_TYPE_IDENTIFY	"identify"
+#define LED_TYPE_FAULT		"fault"
+#define LED_TYPE_ATTENTION	"attention"
+
+/* LED location */
+#define LED_LOC_ENCLOSURE	"enclosure"
+#define LED_LOC_DESCENDENT	"descendent"
+
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
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 042af1a..e06dc7e 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -193,6 +193,11 @@ int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
 		uint64_t *msg_len);
 int64_t opal_i2c_request(uint64_t async_token, uint32_t bus_id,
 			 struct opal_i2c_request *oreq);
+int64_t opal_leds_get_ind(char *loc_code, u64 *led_mask,
+			  u64 *led_value, u64 *max_led_type);
+int64_t opal_leds_set_ind(uint64_t token, char *loc_code, const u64 led_mask,
+			  const u64 led_value, u64 *max_led_type);
+
 
 int64_t opal_flash_read(uint64_t id, uint64_t offset, uint64_t buf,
 		uint64_t size, uint64_t token);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 4e74037..20d4da4 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -295,3 +295,5 @@ OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
 OPAL_CALL(opal_flash_read,			OPAL_FLASH_READ);
 OPAL_CALL(opal_flash_write,			OPAL_FLASH_WRITE);
 OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
+OPAL_CALL(opal_leds_get_ind,			OPAL_LEDS_GET_INDICATOR);
+OPAL_CALL(opal_leds_set_ind,			OPAL_LEDS_SET_INDICATOR);
