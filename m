Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6m8v0mtbzDqk0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 14:25:50 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6C4NoTV038709
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 00:25:48 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bncj4ram7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 00:25:48 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 12 Jul 2017 14:25:45 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6C4OJp022806608
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 14:24:27 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6C4Ntnf009199
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 14:23:55 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Cc: benh@kernel.crashing.org, stewart@linux.vnet.ibm.com, dwmw2@infradead.org,
 rlippert@google.com, alistair@popple.id.au
Subject: [PATCH v3 03/10] mtd: powernv_flash: Don't treat OPAL_SUCCESS as an
 error
Date: Wed, 12 Jul 2017 14:22:57 +1000
In-Reply-To: <20170712042304.19745-1-cyrilbur@gmail.com>
References: <20170712042304.19745-1-cyrilbur@gmail.com>
Message-Id: <20170712042304.19745-4-cyrilbur@gmail.com>
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

 drivers/mtd/devices/powernv_flash.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index 7b41af06f4fe..d50b5f200f73 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -66,9 +66,8 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 	if (token < 0) {
 		if (token != -ERESTARTSYS)
 			dev_err(dev, "Failed to get an async token\n");
-
-		rc = token;
-		goto out;
+		mutex_unlock(&info->lock);
+		return token;
 	}
 
 	switch (op) {
@@ -87,23 +86,25 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 		goto out;
 	}
 
+	if (rc == OPAL_SUCCESS)
+		goto out_success;
+
 	if (rc != OPAL_ASYNC_COMPLETION) {
 		dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
 				op, rc);
-		opal_async_release_token(token);
 		rc = -EIO;
 		goto out;
 	}
 
 	rc = opal_async_wait_response(token, &msg);
-	opal_async_release_token(token);
-	mutex_unlock(&info->lock);
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
@@ -112,8 +113,8 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 		rc = -EIO;
 	}
 
-	return rc;
 out:
+	opal_async_release_token(token);
 	mutex_unlock(&info->lock);
 	return rc;
 }
-- 
2.13.2
