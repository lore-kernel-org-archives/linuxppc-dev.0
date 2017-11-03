Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySmSW276wzDr9Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 13:42:02 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA32d1vK146606
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Nov 2017 22:42:00 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e0cdf915e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Nov 2017 22:41:59 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 3 Nov 2017 02:41:58 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
 boris.brezillon@free-electrons.com, sjitindarsingh@gmail.com
Subject: [PATCH v5 10/10] mtd: powernv_flash: Use
 opal_async_wait_response_interruptible()
Date: Fri,  3 Nov 2017 13:41:46 +1100
In-Reply-To: <20171103024146.17086-1-cyrilbur@gmail.com>
References: <20171103024146.17086-1-cyrilbur@gmail.com>
Message-Id: <20171103024146.17086-11-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The OPAL calls performed in this driver shouldn't be using
opal_async_wait_response() as this performs a wait_event() which, on
long running OPAL calls could result in hung task warnings. wait_event()
prevents timely signal delivery which is also undesirable.

This patch also attempts to quieten down the use of dev_err() when
errors haven't actually occurred and also to return better information up
the stack rather than always -EIO.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/devices/powernv_flash.c | 57 +++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index 3343d4f5c4f3..26f9feaa5d17 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -89,33 +89,46 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 		return -EIO;
 	}
 
-	if (rc == OPAL_SUCCESS)
-		goto out_success;
+	if (rc == OPAL_ASYNC_COMPLETION) {
+		rc = opal_async_wait_response_interruptible(token, &msg);
+		if (rc) {
+			/*
+			 * If we return the mtd core will free the
+			 * buffer we've just passed to OPAL but OPAL
+			 * will continue to read or write from that
+			 * memory.
+			 * It may be tempting to ultimately return 0
+			 * if we're doing a read or a write since we
+			 * are going to end up waiting until OPAL is
+			 * done. However, because the MTD core sends
+			 * us the userspace request in chunks, we need
+			 * it to know we've been interrupted.
+			 */
+			rc = -EINTR;
+			if (opal_async_wait_response(token, &msg))
+				dev_err(dev, "opal_async_wait_response() failed\n");
+			goto out;
+		}
+		rc = opal_get_async_rc(msg);
+	}
 
-	if (rc != OPAL_ASYNC_COMPLETION) {
+	/*
+	 * OPAL does mutual exclusion on the flash, it will return
+	 * OPAL_BUSY.
+	 * During firmware updates by the service processor OPAL may
+	 * be (temporarily) prevented from accessing the flash, in
+	 * this case OPAL will also return OPAL_BUSY.
+	 * Both cases aren't errors exactly but the flash could have
+	 * changed, userspace should be informed.
+	 */
+	if (rc != OPAL_SUCCESS && rc != OPAL_BUSY)
 		dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
 				op, rc);
-		rc = -EIO;
-		goto out;
-	}
 
-	rc = opal_async_wait_response(token, &msg);
-	if (rc) {
-		dev_err(dev, "opal async wait failed (rc %d)\n", rc);
-		rc = -EIO;
-		goto out;
-	}
-
-	rc = opal_get_async_rc(msg);
-out_success:
-	if (rc == OPAL_SUCCESS) {
-		rc = 0;
-		if (retlen)
-			*retlen = len;
-	} else {
-		rc = -EIO;
-	}
+	if (rc == OPAL_SUCCESS && retlen)
+		*retlen = len;
 
+	rc = opal_error_code(rc);
 out:
 	opal_async_release_token(token);
 	return rc;
-- 
2.15.0
