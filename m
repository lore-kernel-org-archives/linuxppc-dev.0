Return-Path: <clg@fr.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC1F61A025F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 03:04:57 +1100 (AEDT)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 26 Mar 2015 16:04:54 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: =?UTF-8?q?=5BPATCH=20v2=201/3=5D=20powerpc/powernv=3A=20convert=20codes=20returned=20by=20OPAL=20calls?=
Date: Thu, 26 Mar 2015 17:04:45 +0100
Message-Id: <1427385887-25403-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <5514027D.8010501@fr.ibm.com>
References: <5514027D.8010501@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 skiboot@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL has its own list of return codes. The patch provides a translation
of such codes in errnos for the opal_sensor_read call.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-sensor.c |   37 ++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

Index: linux.git/arch/powerpc/platforms/powernv/opal-sensor.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/powernv/opal-sensor.c
+++ linux.git/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -26,6 +26,38 @@
 
 static DEFINE_MUTEX(opal_sensor_mutex);
 
+
+/*
+ * opal_sensor_read() return codes
+ *
+ * OPAL_PARAMETER - invalid sensor handler
+ * OPAL_UNSUPPORTED - plateform does not support reading sensors.
+ *
+ *     in case of communication with the FSP on IBM systems
+ *
+ * OPAL_ASYNC_COMPLETION - a request was sent and an async completion will
+ *	be triggered with the @token argument
+ * OPAL_PARTIAL - the request completed but the data returned is invalid
+ * OPAL_BUSY_EVENT - a previous request is still pending
+ * OPAL_NO_MEM - allocation failed
+ * OPAL_INTERNAL_ERROR - communication failure with the FSP
+ * OPAL_HARDWARE - FSP is not available
+ */
+static int convert_opal_code(int ret)
+{
+	switch (ret) {
+	case OPAL_SUCCESS:		return 0;
+	case OPAL_PARAMETER:		return -EINVAL;
+	case OPAL_UNSUPPORTED:		return -ENOSYS;
+	case OPAL_ASYNC_COMPLETION:	return -EAGAIN;
+	case OPAL_BUSY_EVENT:		return -EBUSY;
+	case OPAL_NO_MEM:		return -ENOMEM;
+	case OPAL_HARDWARE:		return -ENOENT;
+	case OPAL_INTERNAL_ERROR:	return -EIO;
+	default:			return -EIO;
+	}
+}
+
 /*
  * This will return sensor information to driver based on the requested sensor
  * handle. A handle is an opaque id for the powernv, read by the driver from the
@@ -46,8 +78,10 @@ int opal_get_sensor_data(u32 sensor_hndl
 
 	mutex_lock(&opal_sensor_mutex);
 	ret = opal_sensor_read(sensor_hndl, token, &data);
-	if (ret != OPAL_ASYNC_COMPLETION)
+	if (ret != OPAL_ASYNC_COMPLETION) {
+		ret = convert_opal_code(ret);
 		goto out_token;
+	}
 
 	ret = opal_async_wait_response(token, &msg);
 	if (ret) {
@@ -58,6 +92,7 @@ int opal_get_sensor_data(u32 sensor_hndl
 
 	*sensor_data = be32_to_cpu(data);
 	ret = be64_to_cpu(msg.params[1]);
+	ret = convert_opal_code(ret);
 
 out_token:
 	mutex_unlock(&opal_sensor_mutex);
