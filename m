Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yB2l03kVXzDr4b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 14:33:32 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9A3VeCw056652
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 23:33:30 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dgg5d7w49-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 23:33:30 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 10 Oct 2017 04:33:28 +0100
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9A3XNVp25559142
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 03:33:25 GMT
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9A3XMnD004781
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 14:33:23 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
 boris.brezillon@free-electrons.com, sjitindarsingh@gmail.com
Subject: [PATCH v4 10/10] mtd: powernv_flash: Use
 opal_async_wait_response_interruptible()
Date: Tue, 10 Oct 2017 14:33:02 +1100
In-Reply-To: <20171010033302.20854-1-cyrilbur@gmail.com>
References: <20171010033302.20854-1-cyrilbur@gmail.com>
Message-Id: <20171010033302.20854-11-cyrilbur@gmail.com>
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
---
 drivers/mtd/devices/powernv_flash.c | 57 +++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index 3343d4f5c4f3..42383dbca5a6 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -1,7 +1,7 @@
 /*
  * OPAL PNOR flash MTD abstraction
  *
- * Copyright IBM 2015
+ * Copyright IBM 2015-2017
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
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
+			 * to it know we've been interrupted.
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
+	if (rc == OPAL_SUCCESS && retlen)
 			*retlen = len;
-	} else {
-		rc = -EIO;
-	}
 
+	rc = opal_error_code(rc);
 out:
 	opal_async_release_token(token);
 	return rc;
-- 
2.14.2
