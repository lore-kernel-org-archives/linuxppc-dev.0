Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsG8S0ZJfzDqjD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:08:39 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5K53sv8051861
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 01:08:37 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b6qen4k9h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 01:08:37 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 15:08:34 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5K58W2844564496
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:08:32 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5K58N27021350
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:08:24 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linux@roeck-us.net, clg@kaod.org, stewart@linux.vnet.ibm.com
Cc: jdelvare@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, linux-hwmon@vger.kernel.org
Subject: [PATCH V2 1/2] hwmon: (ibmpowernv) introduce a legacy_compatibles
 array
Date: Tue, 20 Jun 2017 10:38:12 +0530
In-Reply-To: <1497935293-31618-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1497935293-31618-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1497935293-31618-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cédric Le Goater <clg@kaod.org>

Today, the type of a PowerNV sensor system is determined with the
"compatible" property for legacy Firmwares and with the "sensor-type"
for newer ones. The same array of strings is used for both to do the
matching and this raises some issue to introduce new sensor types.

Let's introduce two different arrays (legacy and current) to make
things easier for new sensor types.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/hwmon/ibmpowernv.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 862b832..6d8909c 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -55,17 +55,27 @@ enum sensors {
 
 #define INVALID_INDEX (-1U)
 
+/*
+ * 'compatible' string properties for sensor types as defined in old
+ * PowerNV firmware (skiboot). These are ordered as 'enum sensors'.
+ */
+static const char * const legacy_compatibles[] = {
+	"ibm,opal-sensor-cooling-fan",
+	"ibm,opal-sensor-amb-temp",
+	"ibm,opal-sensor-power-supply",
+	"ibm,opal-sensor-power"
+};
+
 static struct sensor_group {
-	const char *name;
-	const char *compatible;
+	const char *name; /* matches property 'sensor-type' */
 	struct attribute_group group;
 	u32 attr_count;
 	u32 hwmon_index;
 } sensor_groups[] = {
-	{"fan", "ibm,opal-sensor-cooling-fan"},
-	{"temp", "ibm,opal-sensor-amb-temp"},
-	{"in", "ibm,opal-sensor-power-supply"},
-	{"power", "ibm,opal-sensor-power"}
+	{ "fan"   },
+	{ "temp"  },
+	{ "in"    },
+	{ "power" }
 };
 
 struct sensor_data {
@@ -239,8 +249,8 @@ static int get_sensor_type(struct device_node *np)
 	enum sensors type;
 	const char *str;
 
-	for (type = 0; type < MAX_SENSOR_TYPE; type++) {
-		if (of_device_is_compatible(np, sensor_groups[type].compatible))
+	for (type = 0; type < ARRAY_SIZE(legacy_compatibles); type++) {
+		if (of_device_is_compatible(np, legacy_compatibles[type]))
 			return type;
 	}
 
-- 
1.8.3.1
