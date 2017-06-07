Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjHbv6Rf5zDqLV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 15:46:19 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v575j4nw108624
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 01:46:17 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ax6nyshr3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jun 2017 01:46:17 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 7 Jun 2017 15:46:15 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v575k4GT66846954
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 15:46:12 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v575jW11026296
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 15:45:32 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: dwmw2@infradead.org, computersforpeace@gmail.com, mpe@ellerman.id.au
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] mtd: powernv_flash: Lock around concurrent access to OPAL
Date: Wed,  7 Jun 2017 15:43:55 +1000
In-Reply-To: <20170607054355.10590-1-cyrilbur@gmail.com>
References: <20170607054355.10590-1-cyrilbur@gmail.com>
Message-Id: <20170607054355.10590-2-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL can only manage one flash access at a time and will return an
OPAL_BUSY error for each concurrent access to the flash. The simplest
way to prevent this from happening is with a mutex.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
This is to address https://github.com/open-power/skiboot/issues/80


 drivers/mtd/devices/powernv_flash.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index a9a20c00687c..7b41af06f4fe 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -38,6 +38,7 @@
 
 struct powernv_flash {
 	struct mtd_info	mtd;
+	struct mutex lock;
 	u32 id;
 };
 
@@ -59,12 +60,15 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 	dev_dbg(dev, "%s(op=%d, offset=0x%llx, len=%zu)\n",
 			__func__, op, offset, len);
 
+	mutex_lock(&info->lock);
+
 	token = opal_async_get_token_interruptible();
 	if (token < 0) {
 		if (token != -ERESTARTSYS)
 			dev_err(dev, "Failed to get an async token\n");
 
-		return token;
+		rc = token;
+		goto out;
 	}
 
 	switch (op) {
@@ -79,18 +83,21 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 		break;
 	default:
 		WARN_ON_ONCE(1);
-		return -EIO;
+		rc = -EIO;
+		goto out;
 	}
 
 	if (rc != OPAL_ASYNC_COMPLETION) {
 		dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
 				op, rc);
 		opal_async_release_token(token);
-		return -EIO;
+		rc = -EIO;
+		goto out;
 	}
 
 	rc = opal_async_wait_response(token, &msg);
 	opal_async_release_token(token);
+	mutex_unlock(&info->lock);
 	if (rc) {
 		dev_err(dev, "opal async wait failed (rc %d)\n", rc);
 		return -EIO;
@@ -106,6 +113,9 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 	}
 
 	return rc;
+out:
+	mutex_unlock(&info->lock);
+	return rc;
 }
 
 /**
@@ -237,6 +247,8 @@ static int powernv_flash_probe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
+	mutex_init(&data->lock);
+
 	dev_set_drvdata(dev, data);
 
 	/*
-- 
2.13.0
