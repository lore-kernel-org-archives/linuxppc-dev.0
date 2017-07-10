Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5SNm4J25zDq88
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 11:31:36 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6A1SZXD120576
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Jul 2017 21:31:34 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bjujyh3xa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Jul 2017 21:31:34 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Mon, 10 Jul 2017 11:31:31 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6A1VSMe5046384
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 11:31:28 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6A1VQB1006346
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 11:31:27 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Cc: benh@kernel.crashing.org, stewart@linux.vnet.ibm.com, dwmw2@infradead.org,
 rlippert@google.com, alistair@popple.id.au
Subject: [PATCH v2 10/10] mtd: powernv_flash: Use
 opal_async_wait_response_interruptible()
Date: Mon, 10 Jul 2017 11:31:06 +1000
In-Reply-To: <20170710013106.27276-1-cyrilbur@gmail.com>
References: <20170710013106.27276-1-cyrilbur@gmail.com>
Message-Id: <20170710013106.27276-11-cyrilbur@gmail.com>
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
