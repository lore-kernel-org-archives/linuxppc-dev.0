Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MY9C15cKzDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 21:56:30 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w66BsB39076950
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jul 2018 07:56:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k23vr26m5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Jul 2018 07:56:27 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Fri, 6 Jul 2018 12:56:25 +0100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linux@roeck-us.net, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v4 3/3] hwmon: Document the sensor enable attribute
Date: Fri,  6 Jul 2018 17:26:06 +0530
In-Reply-To: <1530878166-12589-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1530878166-12589-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1530878166-12589-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 Documentation/hwmon/sysfs-interface | 62 +++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index fc337c3..f865dd7 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -171,6 +171,15 @@ in[0-*]_label	Suggested voltage channel label.
 		user-space.
 		RO
 
+in[0-*]_enable
+		Enable or disable the sensors.
+		When disabled the sensor read will return -ENODATA. This
+		attribute can be used as per-sensor or per-sub-group attribute
+		depending on what is supported by the hardware.
+		1: Enable
+		0: Disable
+		RW
+
 cpu[0-*]_vid	CPU core reference voltage.
 		Unit: millivolt
 		RO
@@ -236,6 +245,15 @@ fan[1-*]_label	Suggested fan channel label.
 		In all other cases, the label is provided by user-space.
 		RO
 
+fan[1-*]_enable
+		Enable or disable the sensors.
+		When disabled the sensor read will return -ENODATA. This
+		attribute can be used as per-sensor or per-sub-group attribute
+		depending on what is supported by the hardware.
+		1: Enable
+		0: Disable
+		RW
+
 Also see the Alarms section for status flags associated with fans.
 
 
@@ -409,6 +427,15 @@ temp_reset_history
 		Reset temp_lowest and temp_highest for all sensors
 		WO
 
+temp[1-*]_enable
+		Enable or disable the sensors.
+		When disabled the sensor read will return -ENODATA. This
+		attribute can be used as per-sensor or per-sub-group attribute
+		depending on what is supported by the hardware.
+		1: Enable
+		0: Disable
+		RW
+
 Some chips measure temperature using external thermistors and an ADC, and
 report the temperature measurement as a voltage. Converting this voltage
 back to a temperature (or the other way around for limits) requires
@@ -468,6 +495,15 @@ curr_reset_history
 		Reset currX_lowest and currX_highest for all sensors
 		WO
 
+curr[1-*]_enable
+		Enable or disable the sensors.
+		When disabled the sensor read will return -ENODATA. This
+		attribute can be used as per-sensor or per-sub-group attribute
+		depending on what is supported by the hardware.
+		1: Enable
+		0: Disable
+		RW
+
 Also see the Alarms section for status flags associated with currents.
 
 *********
@@ -566,6 +602,15 @@ power[1-*]_crit			Critical maximum power.
 				Unit: microWatt
 				RW
 
+power[1-*]_enable		Enable or disable the sensors.
+				When disabled the sensor read will return
+				-ENODATA. This attribute can be used as
+				per-sensor or per-sub-group attribute depending
+				on what is supported by the hardware.
+				1: Enable
+				0: Disable
+				RW
+
 Also see the Alarms section for status flags associated with power readings.
 
 **********
@@ -576,6 +621,14 @@ energy[1-*]_input		Cumulative energy use
 				Unit: microJoule
 				RO
 
+energy[1-*]_enable		Enable or disable the sensors.
+				When disabled the sensor read will return
+				-ENODATA. This attribute can be used as
+				per-sensor or per-sub-group attribute depending
+				on what is supported by the hardware.
+				1: Enable
+				0: Disable
+				RW
 
 ************
 * Humidity *
@@ -586,6 +639,15 @@ humidity[1-*]_input		Humidity
 				RO
 
 
+humidity[1-*]_enable		Enable or disable the sensors
+				When disabled the sensor read will return
+				-ENODATA. This attribute can be used as
+				per-sensor or per-sub-group attribute depending
+				on what is supported by the hardware.
+				1: Enable
+				0: Disable
+				RW
+
 **********
 * Alarms *
 **********
-- 
1.8.3.1
