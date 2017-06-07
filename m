Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjHbs39gLzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 15:46:17 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v575iJTC153684
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 01:46:14 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2awy7mm275-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jun 2017 01:46:14 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 7 Jun 2017 15:46:11 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v575k2XV13500528
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 15:46:10 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v575jaHx004913
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 15:45:36 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: dwmw2@infradead.org, computersforpeace@gmail.com, mpe@ellerman.id.au
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] mtd: powernv_flash: Use WARN_ON_ONCE() rather than
 BUG_ON()
Date: Wed,  7 Jun 2017 15:43:54 +1000
Message-Id: <20170607054355.10590-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BUG_ON() should be reserved in situations where we can not longer
guarantee the integrity of the system. In the case where
powernv_flash_async_op() receives an impossible op, we can still
guarantee the integrity of the system.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
I think patches to powernv_flash have gone through MPE in the past -
is this still correct?

 drivers/mtd/devices/powernv_flash.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index f5396f26ddb4..a9a20c00687c 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -78,7 +78,8 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 		rc = opal_flash_erase(info->id, offset, len, token);
 		break;
 	default:
-		BUG_ON(1);
+		WARN_ON_ONCE(1);
+		return -EIO;
 	}
 
 	if (rc != OPAL_ASYNC_COMPLETION) {
-- 
2.13.0
