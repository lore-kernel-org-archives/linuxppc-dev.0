Return-Path: <clg@fr.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 94AF71A0EEB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 02:09:41 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 20 Feb 2015 15:09:38 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 2/3] powerpc/powernv: handle OPAL_SUCCESS return in
 opal_sensor_read
Date: Fri, 20 Feb 2015 16:07:36 +0100
Message-Id: <1424444857-13805-3-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, when a sensor value is read, the kernel calls OPAL, which in
turn builds a message for the FSP, and waits for a message back. However,
some sensors can be read synchronously (core temperatures for instance)
and don't need to wait for a response.

This patch modifies the opal call to accept an OPAL_SUCCESS return value
and not wait for a response if this is the case.

But, we still uselessly reserve a token (for the response) and take a
lock, which might raise the need of a new 'opal_sensor_read_sync' call.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-sensor.c |   29 +++++++++++++++++---------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
index 544292f2020f..a4ed83a7dfb4 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -46,18 +46,27 @@ int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data)
 
 	mutex_lock(&opal_sensor_mutex);
 	ret = opal_sensor_read(sensor_hndl, token, &data);
-	if (ret != OPAL_ASYNC_COMPLETION)
-		goto out_token;
+	switch (ret) {
+	case OPAL_ASYNC_COMPLETION:
+		ret = opal_async_wait_response(token, &msg);
+		if (ret) {
+			pr_err("%s: Failed to wait for the async response, %d\n",
+			       __func__, ret);
+			goto out_token;
+		}
 
-	ret = opal_async_wait_response(token, &msg);
-	if (ret) {
-		pr_err("%s: Failed to wait for the async response, %d\n",
-				__func__, ret);
-		goto out_token;
-	}
+		ret = be64_to_cpu(msg.params[1]);
+
+		*sensor_data = be32_to_cpu(data);
+		break;
 
-	*sensor_data = be32_to_cpu(data);
-	ret = be64_to_cpu(msg.params[1]);
+	case OPAL_SUCCESS:
+		*sensor_data = be32_to_cpu(data);
+		break;
+
+	default:
+		break;
+	}
 
 out_token:
 	mutex_unlock(&opal_sensor_mutex);
-- 
1.7.10.4
