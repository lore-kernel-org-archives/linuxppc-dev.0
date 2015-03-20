Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 131261A2B38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 22:03:33 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 20 Mar 2015 16:33:31 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7A00FE0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 16:35:37 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2KB3OCl5046502
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 16:33:24 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2KB3NCD001306
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 16:33:23 +0530
Subject: [PATCH v2 1/2] powerpc/powernv: Add OPAL interfaces for accessing
 and modifying system LED states
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org
Date: Fri, 20 Mar 2015 16:33:23 +0530
Message-ID: <20150320110242.14866.94690.stgit@localhost.localdomain>
In-Reply-To: <20150320105921.14866.83209.stgit@localhost.localdomain>
References: <20150320105921.14866.83209.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: stewart@linux.vnet.ibm.com, cooloney@gmail.com, rpurdie@rpsys.net,
 khandual@linux.vnet.ibm.com
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
changes in v2:
  - Rebased on top of mpe's next branch.
  - Added macro for LED mode etc.

-Vasant

 arch/powerpc/include/asm/opal-api.h            |   29 +++++++++++++++++++++++-
 arch/powerpc/include/asm/opal.h                |    5 ++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 ++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index e8a6baf..81d2503 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -150,7 +150,9 @@
 #define OPAL_IPMI_SEND				107
 #define OPAL_IPMI_RECV				108
 #define OPAL_I2C_REQUEST			109
-#define OPAL_LAST				109
+#define OPAL_LEDS_GET_INDICATOR			114
+#define OPAL_LEDS_SET_INDICATOR			115
+#define OPAL_LAST				115
 
 /* Device tree flags */
 
@@ -727,6 +729,31 @@ struct opal_i2c_request {
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
index 0ef0fd6..3676a63 100644
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
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index b23fe7c..f946f54 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -292,3 +292,5 @@ OPAL_CALL(opal_tpo_read,			OPAL_READ_TPO);
 OPAL_CALL(opal_ipmi_send,			OPAL_IPMI_SEND);
 OPAL_CALL(opal_ipmi_recv,			OPAL_IPMI_RECV);
 OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
+OPAL_CALL(opal_leds_get_ind,			OPAL_LEDS_GET_INDICATOR);
+OPAL_CALL(opal_leds_set_ind,			OPAL_LEDS_SET_INDICATOR);
