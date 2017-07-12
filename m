Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6m6Z4TzdzDqjh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 14:23:50 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6C4Nm1V038633
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 00:23:48 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bncj4r8tn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 00:23:48 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 12 Jul 2017 14:23:38 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6C4NWQt25755724
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 14:23:32 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6C4NVmo012053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 14:23:31 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Cc: benh@kernel.crashing.org, stewart@linux.vnet.ibm.com, dwmw2@infradead.org,
 rlippert@google.com, alistair@popple.id.au
Subject: [PATCH v3 10/10] mtd: powernv_flash: Use
 opal_async_wait_response_interruptible()
Date: Wed, 12 Jul 2017 14:23:04 +1000
In-Reply-To: <20170712042304.19745-1-cyrilbur@gmail.com>
References: <20170712042304.19745-1-cyrilbur@gmail.com>
Message-Id: <20170712042304.19745-11-cyrilbur@gmail.com>
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
 drivers/mtd/devices/powernv_flash.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index d7243b72ba6e..cfa274ba7e40 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -90,16 +90,34 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 		goto out_success;
 
 	if (rc != OPAL_ASYNC_COMPLETION) {
-		dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
+		if (rc != OPAL_BUSY)
+			dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
 				op, rc);
-		rc = -EIO;
+		rc = opal_error_code(rc);
 		goto out;
 	}
 
-	rc = opal_async_wait_response(token, &msg);
+	rc = opal_async_wait_response_interruptible(token, &msg);
 	if (rc) {
-		dev_err(dev, "opal async wait failed (rc %d)\n", rc);
-		rc = -EIO;
+		/*
+		 * Awkward, we've been interrupted but we cannot return. If we
+		 * do return the mtd core will free the buffer we've just
+		 * passed to OPAL but OPAL will continue to read or write from
+		 * that memory.
+		 * Future work will introduce a call to tell OPAL to stop
+		 * using the buffer.
+		 * It may be tempting to ultimately return 0 if we're doing a
+		 * read or a write since we are going to end up waiting until
+		 * OPAL is done. However, because the MTD core sends us the
+		 * userspace request in chunks, we must report EINTR so that
+		 * it doesn't just send us the next chunk, thus defeating the
+		 * point of the _interruptible wait.
+		 */
+		rc = -EINTR;
+		if (op == FLASH_OP_READ || op == FLASH_OP_WRITE) {
+			if (opal_async_wait_response(token, &msg))
+				dev_err(dev, "opal async wait failed (rc %d)\n", rc);
+		}
 		goto out;
 	}
 
-- 
2.13.2
