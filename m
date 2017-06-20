Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsG8Z2xXSzDqjN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:08:46 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5K53p7F011585
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 01:08:44 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b6v07aqbc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 01:08:44 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 15:08:41 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5K58cAc64946298
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:08:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5K58Tut021502
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:08:30 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linux@roeck-us.net, clg@kaod.org, stewart@linux.vnet.ibm.com
Cc: jdelvare@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, linux-hwmon@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V2 2/2] hwmon: (ibmpowernv) Add current(A) sensor
Date: Tue, 20 Jun 2017 10:38:13 +0530
In-Reply-To: <1497935293-31618-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1497935293-31618-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1497935293-31618-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch exports current(A) sensors in inband sensors copied to
main memory by OCC.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from V1:
- Rebased on top of Cedric's patch to remove legay-compatible type for
  the current(A) sensor.

 drivers/hwmon/ibmpowernv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 6d8909c..9b11b13 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -50,6 +50,7 @@ enum sensors {
 	TEMP,
 	POWER_SUPPLY,
 	POWER_INPUT,
+	CURRENT,
 	MAX_SENSOR_TYPE,
 };
 
@@ -75,7 +76,8 @@ enum sensors {
 	{ "fan"   },
 	{ "temp"  },
 	{ "in"    },
-	{ "power" }
+	{ "power" },
+	{ "curr"  },
 };
 
 struct sensor_data {
-- 
1.8.3.1
