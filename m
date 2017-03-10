Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfm3q5hXFzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 22:57:59 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2ABrVgD014050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 06:57:49 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2937yc207y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 06:57:49 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Fri, 10 Mar 2017 17:27:46 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2ABvhK136962320
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 17:27:43 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2ABvgFF028537
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 17:27:42 +0530
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: [PATCH v4] powernv/sensor: Handle OPAL_WRONG_STATE error return
Date: Fri, 10 Mar 2017 17:27:32 +0530
Message-Id: <1489147052-9590-1-git-send-email-vipin@linux.vnet.ibm.com>
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
in opal_get_sensor_data() for sensor read failure with
OPAL_WRONG_STATE return code and returned -EIO.

Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
---
Changes in v4:
 - Removed sleeping core log message with KERN_NOTICE priority.

Changes in v3:
 - Added a new case for OPAL_WRONG_STATE in sensor read
   along with a log message indicating sleeping/offline core
   causing read fail.

 arch/powerpc/platforms/powernv/opal-sensor.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
index 308efd1..aa267f1 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -64,6 +64,10 @@ int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data)
 		*sensor_data = be32_to_cpu(data);
 		break;
 
+	case OPAL_WRONG_STATE:
+		ret = -EIO;
+		break;
+
 	default:
 		ret = opal_error_code(ret);
 		break;
-- 
2.7.4
