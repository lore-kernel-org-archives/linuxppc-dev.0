Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyr4t1kD2zDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 16:54:54 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5T6sgIi046960
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 02:54:52 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bctaams6f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 02:54:51 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Thu, 29 Jun 2017 16:54:48 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5T6sjh23735992
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 16:54:45 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5T6siMJ008398
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 16:54:45 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Cc: dwmw2@infradead.org, stewart@linux.vnet.ibm.com
Subject: [PATCH 5/5] mtd: powernv_flash: Use
 opal_async_wait_response_interruptible()
Date: Thu, 29 Jun 2017 16:54:13 +1000
In-Reply-To: <20170629065413.19845-1-cyrilbur@gmail.com>
References: <20170629065413.19845-1-cyrilbur@gmail.com>
Message-Id: <20170629065413.19845-6-cyrilbur@gmail.com>
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
also prevents timely signal delivery which is also undesirable.

This patch also attempts to quieten down the use of dev_err() when
errors haven't actually occurred and also to return better information up
the stack rather than always -EIO.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 drivers/mtd/devices/powernv_flash.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index 7b41af06f4fe..a7c5ae2b2898 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -88,19 +88,23 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 	}
 
 	if (rc != OPAL_ASYNC_COMPLETION) {
-		dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
-				op, rc);
+		if (rc != OPAL_BUSY)
+			dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
+					op, rc);
 		opal_async_release_token(token);
-		rc = -EIO;
+		rc = opal_error_code(rc);
 		goto out;
 	}
 
-	rc = opal_async_wait_response(token, &msg);
+	rc = opal_async_wait_response_interruptible(token, &msg);
 	opal_async_release_token(token);
 	mutex_unlock(&info->lock);
 	if (rc) {
-		dev_err(dev, "opal async wait failed (rc %d)\n", rc);
-		return -EIO;
+		if (rc == -ERESTARTSYS)
+			rc = -EINTR;
+		else
+			dev_err(dev, "opal async wait failed (rc %d)\n", rc);
+		return rc;
 	}
 
 	rc = opal_get_async_rc(msg);
@@ -109,7 +113,7 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 		if (retlen)
 			*retlen = len;
 	} else {
-		rc = -EIO;
+		rc = opal_error_code(rc);
 	}
 
 	return rc;
-- 
2.13.2
