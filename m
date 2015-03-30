Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA31F1A0A2C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 21:06:54 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 30 Mar 2015 11:06:51 +0100
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 2/2] powerpc/powernv: handle OPAL_SUCCESS return in
 opal_sensor_read
Date: Mon, 30 Mar 2015 12:06:10 +0200
Message-Id: <1427709970-10207-2-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1427698456.28219.2.camel@ellerman.id.au>
References: <1427698456.28219.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, benh@au1.ibm.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, when a sensor value is read, the kernel calls OPAL, which in
turn builds a message for the FSP, and waits for a message back. 

The new device tree for OPAL sensors [1] adds new sensors that can be 
read synchronously (core temperatures for instance) and that don't need 
to wait for a response.

This patch modifies the opal call to accept an OPAL_SUCCESS return value
and cover the case above.

[1] https://lists.ozlabs.org/pipermail/skiboot/2015-March/000639.html

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---

 We still uselessly reserve a token (for the response) and take a
 lock, which might raise the need of a new 'opal_sensor_read_sync' 
 call.

 Changes since v2 :

 - merged the return code assignments in one call

 arch/powerpc/platforms/powernv/opal-sensor.c |   32 ++++++++++++++++-----------
 1 file changed, 20 insertions(+), 12 deletions(-)

Index: linux.git/arch/powerpc/platforms/powernv/opal-sensor.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/powernv/opal-sensor.c
+++ linux.git/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -46,20 +46,28 @@ int opal_get_sensor_data(u32 sensor_hndl
 
 	mutex_lock(&opal_sensor_mutex);
 	ret = opal_sensor_read(sensor_hndl, token, &data);
-	if (ret != OPAL_ASYNC_COMPLETION) {
-		ret = opal_error_code(ret);
-		goto out_token;
-	}
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
+		ret = opal_error_code(be64_to_cpu(msg.params[1]));
+		*sensor_data = be32_to_cpu(data);
+		break;
 
-	*sensor_data = be32_to_cpu(data);
-	ret = opal_error_code(be64_to_cpu(msg.params[1]));
+	case OPAL_SUCCESS:
+		ret = 0;
+		*sensor_data = be32_to_cpu(data);
+		break;
+
+	default:
+		ret = opal_error_code(ret);
+		break;
+	}
 
 out_token:
 	mutex_unlock(&opal_sensor_mutex);
