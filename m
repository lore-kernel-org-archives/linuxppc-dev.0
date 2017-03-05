Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbdV900y2zDqWC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 20:51:28 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v259mbmN006349
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 04:51:27 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28ytkg5d60-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 04:51:26 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Sun, 5 Mar 2017 15:21:24 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id F40983940033
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 15:21:20 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v259oD7R10027136
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 15:20:13 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v259pK40003949
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 15:21:20 +0530
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: [PATCH v3] powernv/sensor: Handle OPAL_WRONG_STATE error return
Date: Sun,  5 Mar 2017 15:21:08 +0530
Message-Id: <1488707468-16643-1-git-send-email-vipin@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL returns OPAL_WRONG_STATE upon failing to provide
sensor data due to core sleeping/offline. Added check
for OPAL_WRONG_STATE rerurn code with sensor read failure.
Also added a log message indicating sensor data being
queried for sleeping/offline core.

Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
---
Changes in v3:
 - Added a new case for OPAL_WRONG_STATE in sensor read
   along with a log message indicating sleeping/offline core
   causing read fail.

 arch/powerpc/platforms/powernv/opal-sensor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
index 308efd1..fb6d6bb 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -64,6 +64,12 @@ int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data)
 		*sensor_data = be32_to_cpu(data);
 		break;
 
+	case OPAL_WRONG_STATE:
+		pr_notice("%s: Sensor data read failure due to "
+				"core sleeping/offline\n", __func__);
+		ret = -EIO;
+		break;
+
 	default:
 		ret = opal_error_code(ret);
 		break;
-- 
2.7.4
