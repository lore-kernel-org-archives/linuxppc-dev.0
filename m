Return-Path: <clg@fr.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B65771A11C2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 03:40:06 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 27 Mar 2015 16:40:03 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/3] powerpc/powernv: remove opal_sensor_mutex
Date: Fri, 27 Mar 2015 17:39:21 +0100
Message-Id: <1427474362-3903-3-git-send-email-clg@fr.ibm.com>
In-Reply-To: <20150327095936.50A921400A0@ozlabs.org>
References: <20150327095936.50A921400A0@ozlabs.org>
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

The opal sensor mutex protects the opal_sensor_read call which
can return a OPAL_BUSY code on IBM Power systems if a previous 
request is in progress.

This can be handled at user level with a retry.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---

 Changes since v2 :

 - removed a goto label

 arch/powerpc/platforms/powernv/opal-sensor.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Index: linux.git/arch/powerpc/platforms/powernv/opal-sensor.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/powernv/opal-sensor.c
+++ linux.git/arch/powerpc/platforms/powernv/opal-sensor.c
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
@@ -40,11 +37,9 @@ int opal_get_sensor_data(u32 sensor_hndl
 	token = opal_async_get_token_interruptible();
 	if (token < 0) {
 		pr_err("%s: Couldn't get the token, returning\n", __func__);
-		ret = token;
-		goto out;
+		return token;
 	}
 
-	mutex_lock(&opal_sensor_mutex);
 	ret = opal_sensor_read(sensor_hndl, token, &data);
 	switch (ret) {
 	case OPAL_ASYNC_COMPLETION:
@@ -70,9 +65,7 @@ int opal_get_sensor_data(u32 sensor_hndl
 	}
 
 out_token:
-	mutex_unlock(&opal_sensor_mutex);
 	opal_async_release_token(token);
-out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(opal_get_sensor_data);
