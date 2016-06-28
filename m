Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdtRk02L6zDqnf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 14:41:21 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id av7so620648pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:41:21 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: arnd@arndb.de, robh@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 sjitindarsingh@gmail.com
Subject: [PATCH V4 2/3] powerpc/opal: Add #define to get rc from an ASYNC_COMP
 opal_msg
Date: Tue, 28 Jun 2016 14:40:56 +1000
Message-Id: <1467088857-14477-2-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1467088857-14477-1-git-send-email-sjitindarsingh@gmail.com>
References: <1467088857-14477-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An opal_msg of type OPAL_MSG_ASYNC_COMP contains the return code in the
params[1] struct member. However this isn't intuitive or obvious when
reading the code and requires that a user look at the skiboot
documentation or opal-api.h to verify this.

Add a #define to get the return code from an opal_msg and update call
sites accordingly.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---

Change Log:

-> V4:
	- Added Patch to Series
---
 arch/powerpc/include/asm/opal-api.h            | 4 ++++
 arch/powerpc/platforms/powernv/opal-sensor.c   | 2 +-
 arch/powerpc/platforms/powernv/opal-sysparam.c | 4 ++--
 drivers/i2c/busses/i2c-opal.c                  | 2 +-
 drivers/leds/leds-powernv.c                    | 2 +-
 drivers/mtd/devices/powernv_flash.c            | 2 +-
 drivers/rtc/rtc-opal.c                         | 4 ++--
 7 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 9bb8ddf..7433cf0 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -387,6 +387,10 @@ struct opal_msg {
 	__be64 params[8];
 };
 
+#define GET_OPAL_MSG_ASYNC_COMP_RC(msg)	(msg.msg_type == OPAL_MSG_ASYNC_COMP ? \
+					be64_to_cpu(msg.params[1]) : \
+					OPAL_PARAMETER)
+
 /* System parameter permission */
 enum OpalSysparamPerm {
 	OPAL_SYSPARAM_READ  = 0x1,
diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
index a06059d..f30fc35 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -55,7 +55,7 @@ int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data)
 			goto out_token;
 		}
 
-		ret = opal_error_code(be64_to_cpu(msg.params[1]));
+		ret = opal_error_code(GET_OPAL_MSG_ASYNC_COMP_RC(msg));
 		*sensor_data = be32_to_cpu(data);
 		break;
 
diff --git a/arch/powerpc/platforms/powernv/opal-sysparam.c b/arch/powerpc/platforms/powernv/opal-sysparam.c
index afe66c5..9488bf5 100644
--- a/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -67,7 +67,7 @@ static ssize_t opal_get_sys_param(u32 param_id, u32 length, void *buffer)
 		goto out_token;
 	}
 
-	ret = opal_error_code(be64_to_cpu(msg.params[1]));
+	ret = opal_error_code(GET_OPAL_MSG_ASYNC_COMP_RC(msg));
 
 out_token:
 	opal_async_release_token(token);
@@ -103,7 +103,7 @@ static int opal_set_sys_param(u32 param_id, u32 length, void *buffer)
 		goto out_token;
 	}
 
-	ret = opal_error_code(be64_to_cpu(msg.params[1]));
+	ret = opal_error_code(GET_OPAL_MSG_ASYNC_COMP_RC(msg));
 
 out_token:
 	opal_async_release_token(token);
diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
index 75dd6d0..7cd91b7 100644
--- a/drivers/i2c/busses/i2c-opal.c
+++ b/drivers/i2c/busses/i2c-opal.c
@@ -71,7 +71,7 @@ static int i2c_opal_send_request(u32 bus_id, struct opal_i2c_request *req)
 	if (rc)
 		goto exit;
 
-	rc = be64_to_cpu(msg.params[1]);
+	rc = GET_OPAL_MSG_ASYNC_COMP_RC(msg);
 	if (rc != OPAL_SUCCESS) {
 		rc = i2c_opal_translate_error(rc);
 		goto exit;
diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
index dfb8bd3..3b07a09 100644
--- a/drivers/leds/leds-powernv.c
+++ b/drivers/leds/leds-powernv.c
@@ -118,7 +118,7 @@ static int powernv_led_set(struct powernv_led_data *powernv_led,
 		goto out_token;
 	}
 
-	rc = be64_to_cpu(msg.params[1]);
+	rc = GET_OPAL_MSG_ASYNC_COMP_RC(msg);
 	if (rc != OPAL_SUCCESS)
 		dev_err(dev, "%s : OAPL async call returned failed [rc=%d]\n",
 			__func__, rc);
diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index d5b870b..803059a 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -95,7 +95,7 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 		return -EIO;
 	}
 
-	rc = be64_to_cpu(msg.params[1]);
+	rc = GET_OPAL_MSG_ASYNC_COMP_RC(msg);
 	if (rc == OPAL_SUCCESS) {
 		rc = 0;
 		if (retlen)
diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 9c18d6f..0b42645 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -134,7 +134,7 @@ static int opal_get_tpo_time(struct device *dev, struct rtc_wkalrm *alarm)
 		goto exit;
 	}
 
-	rc = be64_to_cpu(msg.params[1]);
+	rc = GET_OPAL_MSG_ASYNC_COMP_RC(msg);
 	if (rc != OPAL_SUCCESS) {
 		rc = -EIO;
 		goto exit;
@@ -181,7 +181,7 @@ static int opal_set_tpo_time(struct device *dev, struct rtc_wkalrm *alarm)
 		goto exit;
 	}
 
-	rc = be64_to_cpu(msg.params[1]);
+	rc = GET_OPAL_MSG_ASYNC_COMP_RC(msg);
 	if (rc != OPAL_SUCCESS)
 		rc = -EIO;
 
-- 
2.5.5
