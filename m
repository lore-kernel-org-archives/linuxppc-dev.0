Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yB2kz2KnGzDr4W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 14:33:30 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9A3Vf4T093632
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 23:33:28 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dghrc3up3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 23:33:28 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 10 Oct 2017 04:33:26 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9A3XMLW21233900
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 03:33:24 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9A3XMxV021424
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 14:33:23 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
 boris.brezillon@free-electrons.com, sjitindarsingh@gmail.com
Subject: [PATCH v4 02/10] mtd: powernv_flash: Don't treat OPAL_SUCCESS as an
 error
Date: Tue, 10 Oct 2017 14:32:54 +1100
In-Reply-To: <20171010033302.20854-1-cyrilbur@gmail.com>
References: <20171010033302.20854-1-cyrilbur@gmail.com>
Message-Id: <20171010033302.20854-3-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While this driver expects to interact asynchronously, OPAL is well
within its rights to return OPAL_SUCCESS to indicate that the operation
completed without the need for a callback. We shouldn't treat
OPAL_SUCCESS as an error rather we should wrap up and return promptly to
the caller.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
I'll note here that currently no OPAL exists that will return
OPAL_SUCCESS so there isn't the possibility of a bug today.
---
 drivers/mtd/devices/powernv_flash.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index f9ec38281ff2..ca3ca6adf71e 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -63,7 +63,6 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 	if (token < 0) {
 		if (token != -ERESTARTSYS)
 			dev_err(dev, "Failed to get an async token\n");
-
 		return token;
 	}
 
@@ -83,21 +82,25 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 		return -EIO;
 	}
 
+	if (rc == OPAL_SUCCESS)
+		goto out_success;
+
 	if (rc != OPAL_ASYNC_COMPLETION) {
 		dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
 				op, rc);
-		opal_async_release_token(token);
-		return -EIO;
+		rc = -EIO;
+		goto out;
 	}
 
 	rc = opal_async_wait_response(token, &msg);
-	opal_async_release_token(token);
 	if (rc) {
 		dev_err(dev, "opal async wait failed (rc %d)\n", rc);
-		return -EIO;
+		rc = -EIO;
+		goto out;
 	}
 
 	rc = opal_get_async_rc(msg);
+out_success:
 	if (rc == OPAL_SUCCESS) {
 		rc = 0;
 		if (retlen)
@@ -106,6 +109,8 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 		rc = -EIO;
 	}
 
+out:
+	opal_async_release_token(token);
 	return rc;
 }
 
-- 
2.14.2
