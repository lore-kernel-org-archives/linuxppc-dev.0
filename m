Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 85551B70A7
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 19:04:55 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Thu, 19 Apr 2012 08:18:59 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3J8DCaj1544248
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:13:12 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3J8JnfN008356
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:49 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/15] powerpc/windfarm: Updates to lm75 and max6690 sensors
Date: Thu, 19 Apr 2012 18:16:54 +1000
Message-Id: <1334823416-9138-14-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
Cc: khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows those modules to load on PowerMac7,2 PowerMac7,3
and RackMac3,1 and add the sensor name conversion for those
machines.

This will be used by the corresponding new windfarm modules
for those machines.

Note that since therm_pm72 is linked first, it will still
take priority on those i2c devices if built-in. If using modules
it will depend which is loaded first, but you should avoid building
therm_pm72 if you are using the new windfarm drivers

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/windfarm_lm75_sensor.c    |   11 ++++++-----
 drivers/macintosh/windfarm_max6690_sensor.c |   11 +++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index 4cc3f93..b0c2d36 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -116,6 +116,12 @@ static int wf_lm75_probe(struct i2c_client *client,
 		name = "optical-drive-temp";
 	else if (!strcmp(loc, "HD Temp"))
 		name = "hard-drive-temp";
+	else if (!strcmp(loc, "PCI SLOTS"))
+		name = "slots-temp";
+	else if (!strcmp(loc, "CPU A INLET"))
+		name = "cpu-inlet-temp-0";
+	else if (!strcmp(loc, "CPU B INLET"))
+		name = "cpu-inlet-temp-1";
 	else
 		return -ENXIO;
  	
@@ -170,11 +176,6 @@ static struct i2c_driver wf_lm75_driver = {
 
 static int __init wf_lm75_sensor_init(void)
 {
-	/* Don't register on old machines that use therm_pm72 for now */
-	if (of_machine_is_compatible("PowerMac7,2") ||
-	    of_machine_is_compatible("PowerMac7,3") ||
-	    of_machine_is_compatible("RackMac3,1"))
-		return -ENODEV;
 	return i2c_add_driver(&wf_lm75_driver);
 }
 
diff --git a/drivers/macintosh/windfarm_max6690_sensor.c b/drivers/macintosh/windfarm_max6690_sensor.c
index f4902f4..371b058 100644
--- a/drivers/macintosh/windfarm_max6690_sensor.c
+++ b/drivers/macintosh/windfarm_max6690_sensor.c
@@ -74,7 +74,11 @@ static int wf_max6690_probe(struct i2c_client *client,
 		return -ENXIO;
 	}
 
-	if (!strcmp(loc, "BACKSIDE"))
+	/*
+	 * We only expose the external temperature register for
+	 * now as this is all we need for our control loops
+	 */
+	if (!strcmp(loc, "BACKSIDE") || !strcmp(loc, "SYS CTRLR AMBIENT"))
 		name = "backside-temp";
 	else if (!strcmp(loc, "NB Ambient"))
 		name = "north-bridge-temp";
@@ -128,11 +132,6 @@ static struct i2c_driver wf_max6690_driver = {
 
 static int __init wf_max6690_sensor_init(void)
 {
-	/* Don't register on old machines that use therm_pm72 for now */
-	if (of_machine_is_compatible("PowerMac7,2") ||
-	    of_machine_is_compatible("PowerMac7,3") ||
-	    of_machine_is_compatible("RackMac3,1"))
-		return -ENODEV;
 	return i2c_add_driver(&wf_max6690_driver);
 }
 
-- 
1.7.9.5
