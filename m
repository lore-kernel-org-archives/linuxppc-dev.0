Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Lzms0BDpzF1lm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 23:51:56 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w65DnEFQ034051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jul 2018 09:51:55 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k1k6fc2xp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jul 2018 09:51:54 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 5 Jul 2018 14:51:51 +0100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linux@roeck-us.net, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 ego@linux.vnet.ibm.com
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 3/3] hwmon: Document the sensor enable attribute and update
 ibmpowernv
Date: Thu,  5 Jul 2018 19:21:29 +0530
In-Reply-To: <1530798689-27742-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1530798689-27742-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1530798689-27742-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
 Documentation/hwmon/ibmpowernv      | 35 +++++++++++++++-
 Documentation/hwmon/sysfs-interface | 82 +++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpowernv
index 8826ba2..77ddba7 100644
--- a/Documentation/hwmon/ibmpowernv
+++ b/Documentation/hwmon/ibmpowernv
@@ -33,9 +33,40 @@ fanX_input		Measured RPM value.
 fanX_min		Threshold RPM for alert generation.
 fanX_fault		0: No fail condition
 			1: Failing fan
+
 tempX_input		Measured ambient temperature.
 tempX_max		Threshold ambient temperature for alert generation.
-inX_input		Measured power supply voltage
+tempX_highest		Historical maximum temperature
+tempX_lowest		Historical minimum temperature
+temp1_enable		Enable/disable all temperature sensors
+			1: Enable
+			0: Disable
+temp[2-N]_enable	State of the sensor (enabled/disabled)
+
+inX_input		Measured power supply voltage (millivolt)
 inX_fault		0: No fail condition.
 			1: Failing power supply.
-power1_input		System power consumption (microWatt)
+inX_highest		Historical maximum voltage
+inX_lowest		Historical minimum voltage
+in1_enable		Enable/disable all voltage sensors
+			1: Enable
+			0: Disable
+in[2-N]_enable		State of the sensor (enabled/disabled)
+
+powerX_input		Power consumption (microWatt)
+powerX_input_highest	Historical maximum power
+powerX_input_lowest	Historical minimum power
+power1_enable		Enable/disable all power sensors
+			1: Enable
+			0: Disable
+power[2-N]_enable	State of the sensor (enabled/disabled)
+
+currX_input		Measured current (milliampere)
+currX_highest		Historical maximum current
+currX_lowest		Historical minimum current
+curr1_enable		Enable/disable all current sensors
+			1: Enable
+			0: Disable
+curr[2-N]_enable	State of the sensor (enabled/disabled)
+
+energyX_input		Cumulative energy (microJoule)
diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index fc337c3..d81109c 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -171,6 +171,17 @@ in[0-*]_label	Suggested voltage channel label.
 		user-space.
 		RO
 
+in[0-*]_enable
+		Enable or disable the sensor.
+		When disabled the sensor read will return -ENODATA. For chips
+		which do not have the capability to disable/enable single sensor
+		but have support for sensor-group disable/enable, will only have
+		the first attribute with write permission. In such cases write
+		to the first attribute will affect all the sensors of this type.
+		1: Enable
+		0: Disable
+		RW/RO
+
 cpu[0-*]_vid	CPU core reference voltage.
 		Unit: millivolt
 		RO
@@ -236,6 +247,17 @@ fan[1-*]_label	Suggested fan channel label.
 		In all other cases, the label is provided by user-space.
 		RO
 
+fan[1-*]_enable
+		Enable or disable the sensor.
+		When disabled the sensor read will return -ENODATA. For chips
+		which do not have the capability to disable/enable single sensor
+		but have support for sensor-group disable/enable, will only have
+		the first attribute with write permission. In such cases write
+		to the first attribute will affect all the sensors of this type.
+		1: Enable
+		0: Disable
+		RW/RO
+
 Also see the Alarms section for status flags associated with fans.
 
 
@@ -409,6 +431,17 @@ temp_reset_history
 		Reset temp_lowest and temp_highest for all sensors
 		WO
 
+temp[1-*]_enable
+		Enable or disable the sensor.
+		When disabled the sensor read will return -ENODATA. For chips
+		which do not have the capability to disable/enable single sensor
+		but have support for sensor-group disable/enable, will only have
+		the first attribute with write permission. In such cases write
+		to the first attribute will affect all the sensors of this type.
+		1: Enable
+		0: Disable
+		RW/RO
+
 Some chips measure temperature using external thermistors and an ADC, and
 report the temperature measurement as a voltage. Converting this voltage
 back to a temperature (or the other way around for limits) requires
@@ -468,6 +501,17 @@ curr_reset_history
 		Reset currX_lowest and currX_highest for all sensors
 		WO
 
+curr[1-*]_enable
+		Enable or disable the sensor.
+		When disabled the sensor read will return -ENODATA. For chips
+		which do not have the capability to disable/enable single sensor
+		but have support for sensor-group disable/enable, will only have
+		the first attribute with write permission. In such cases write
+		to the first attribute will affect all the sensors of this type.
+		1: Enable
+		0: Disable
+		RW/RO
+
 Also see the Alarms section for status flags associated with currents.
 
 *********
@@ -566,6 +610,19 @@ power[1-*]_crit			Critical maximum power.
 				Unit: microWatt
 				RW
 
+power[1-*]_enable		Enable or disable the sensor.
+				When disabled the sensor read will return
+				-ENODATA. For chips which do not have the
+				capability to disable/enable single sensor but
+				have support for sensor-group disable/enable,
+				will only have the first attribute with write
+				permission. In such cases write	to the first
+				attribute will affect all the sensors of this
+				type.
+				1: Enable
+				0: Disable
+				RW/RO
+
 Also see the Alarms section for status flags associated with power readings.
 
 **********
@@ -576,6 +633,18 @@ energy[1-*]_input		Cumulative energy use
 				Unit: microJoule
 				RO
 
+energy[1-*]_enable		Enable or disable the sensor.
+				When disabled the sensor read will return
+				-ENODATA. For chips which do not have the
+				capability to disable/enable single sensor but
+				have support for sensor-group disable/enable,
+				will only have the first attribute with write
+				permission. In such cases write	to the first
+				attribute will affect all the sensors of this
+				type.
+				1: Enable
+				0: Disable
+				RW/RO
 
 ************
 * Humidity *
@@ -586,6 +655,19 @@ humidity[1-*]_input		Humidity
 				RO
 
 
+humidity[1-*]_enable		Enable or disable the sensor.
+				When disabled the sensor read will return
+				-ENODATA. For chips which do not have the
+				capability to disable/enable single sensor but
+				have support for sensor-group disable/enable,
+				will only have the first attribute with write
+				permission. In such cases write	to the first
+				attribute will affect all the sensors of this
+				type.
+				1: Enable
+				0: Disable
+				RW/RO
+
 **********
 * Alarms *
 **********
-- 
1.8.3.1
