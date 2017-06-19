Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrlvx1yBxzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 19:26:05 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5J9OWQL077917
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 05:26:02 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b64u0s1j4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 05:26:02 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 19 Jun 2017 19:25:59 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5J9PvDh57802902
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 19:25:57 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5J9PtQo025102
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 19:25:56 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linux@roeck-us.net, clg@kaod.org, stewart@linux.vnet.ibm.com
Cc: jdelvare@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, linux-hwmon@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] hwmon: (ibmpowernv) Add current(A) sensors
Date: Mon, 19 Jun 2017 14:55:33 +0530
Message-Id: <1497864333-16969-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
 drivers/hwmon/ibmpowernv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 862b832..e0557f9 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -50,6 +50,7 @@ enum sensors {
 	TEMP,
 	POWER_SUPPLY,
 	POWER_INPUT,
+	CURRENT,
 	MAX_SENSOR_TYPE,
 };
 
@@ -65,7 +66,8 @@ enum sensors {
 	{"fan", "ibm,opal-sensor-cooling-fan"},
 	{"temp", "ibm,opal-sensor-amb-temp"},
 	{"in", "ibm,opal-sensor-power-supply"},
-	{"power", "ibm,opal-sensor-power"}
+	{"power", "ibm,opal-sensor-power"},
+	{"curr", "ibm,opal-sensor-current"},
 };
 
 struct sensor_data {
-- 
1.8.3.1
