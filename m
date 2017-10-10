Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yB2kz2cz9zDr57
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 14:33:30 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9A3TDec112017
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 23:33:28 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dgcac3th3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 23:33:28 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 10 Oct 2017 04:33:26 +0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9A3XNjV9502776
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 03:33:24 GMT
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9A3XQge031581
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 14:33:27 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
 boris.brezillon@free-electrons.com, sjitindarsingh@gmail.com
Subject: [PATCH v4 07/10] powernv/opal-sensor: remove not needed lock
Date: Tue, 10 Oct 2017 14:32:59 +1100
In-Reply-To: <20171010033302.20854-1-cyrilbur@gmail.com>
References: <20171010033302.20854-1-cyrilbur@gmail.com>
Message-Id: <20171010033302.20854-8-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stewart Smith <stewart@linux.vnet.ibm.com>

Parallel sensor reads could run out of async tokens due to
opal_get_sensor_data grabbing tokens but then doing the sensor
read behind a mutex, essentially serializing the (possibly
asynchronous and relatively slow) sensor read.

It turns out that the mutex isn't needed at all, not only
should the OPAL interface allow concurrent reads, the implementation
is certainly safe for that, and if any sensor we were reading
from somewhere isn't, doing the mutual exclusion in the kernel
is the wrong place to do it, OPAL should be doing it for the kernel.

So, remove the mutex.

Additionally, we shouldn't be printing out an error when we don't
get a token as the only way this should happen is if we've been
interrupted in down_interruptible() on the semaphore.

Reported-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-sensor.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
index aa267f120033..0a7074bb91dc 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -19,13 +19,10 @@
  */
 
 #include <linux/delay.h>
-#include <linux/mutex.h>
 #include <linux/of_platform.h>
 #include <asm/opal.h>
 #include <asm/machdep.h>
 
-static DEFINE_MUTEX(opal_sensor_mutex);
-
 /*
  * This will return sensor information to driver based on the requested sensor
  * handle. A handle is an opaque id for the powernv, read by the driver from the
@@ -38,13 +35,9 @@ int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data)
 	__be32 data;
 
 	token = opal_async_get_token_interruptible();
-	if (token < 0) {
-		pr_err("%s: Couldn't get the token, returning\n", __func__);
-		ret = token;
-		goto out;
-	}
+	if (token < 0)
+		return token;
 
-	mutex_lock(&opal_sensor_mutex);
 	ret = opal_sensor_read(sensor_hndl, token, &data);
 	switch (ret) {
 	case OPAL_ASYNC_COMPLETION:
@@ -52,7 +45,7 @@ int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data)
 		if (ret) {
 			pr_err("%s: Failed to wait for the async response, %d\n",
 			       __func__, ret);
-			goto out_token;
+			goto out;
 		}
 
 		ret = opal_error_code(opal_get_async_rc(msg));
@@ -73,10 +66,8 @@ int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data)
 		break;
 	}
 
-out_token:
-	mutex_unlock(&opal_sensor_mutex);
-	opal_async_release_token(token);
 out:
+	opal_async_release_token(token);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(opal_get_sensor_data);
-- 
2.14.2
