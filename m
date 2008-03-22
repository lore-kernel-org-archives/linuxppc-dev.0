Return-Path: <SRS0+6740c57f952c672cdc2a+1672+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A3F1DDF12
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 10:31:35 +1100 (EST)
Subject: Re: [PATCH] windfarm: add PowerMac 12,1 support
From: David Woodhouse <dwmw2@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080323102502.e0754062.sfr@canb.auug.org.au>
References: <1201348525.6859.1.camel@thilivren>
	<1206214508.9540.89.camel@pmac.infradead.org>
	<1206223998.7197.13.camel@pasglop>
	<1206226966.9540.104.camel@pmac.infradead.org>
	<20080323102502.e0754062.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Sat, 22 Mar 2008 23:31:13 +0000
Message-Id: <1206228673.9540.115.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: =?ISO-8859-1?Q?=C9tienne?= Bersac <bersace03@gmail.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-03-23 at 10:25 +1100, Stephen Rothwell wrote:
> Why would you expect otherwise (from the C standard):
> 
> "Unlike the bitwise binary & operator, the && operator guarantees
> left-to-right evaluation; there is a sequence point after the evaluation
> of the first operand. If the first operand compares equal to 0, the
> second operand is not evaluated."

Because it's Saturday night, I wasn't expecting that construct there
(because it seems to require that the sensors/controls are detected in
the precise order that they're checked for, otherwise it'll never match
the ones which are found out of order), and mostly because I'm stupid.

This seems to fix it (note the change of the control names too):

--- drivers/macintosh/windfarm_pm121.c~	2008-03-22 19:13:22.000000000 +0000
+++ drivers/macintosh/windfarm_pm121.c	2008-03-22 23:23:44.000000000 +0000
@@ -867,7 +867,7 @@ static struct wf_control* pm121_register
 {
 	if (controls[id] == NULL && !strcmp(ct->name, match)) {
 		if (wf_get_control(ct) == 0)
-			controls[FAN_OD] = ct;
+			controls[id] = ct;
 	}
 	return controls[id];
 }
@@ -879,10 +879,10 @@ static void pm121_new_control(struct wf_
 	if (pm121_all_controls_ok)
 		return;
 
-	all = all && pm121_register_control(ct, "optical-driver-fan", FAN_OD);
-	all = all && pm121_register_control(ct, "hard-driver-fan", FAN_HD);
-	all = all && pm121_register_control(ct, "cpu-driver-fan", FAN_CPU);
-	all = all && pm121_register_control(ct, "cpufreq-clamp", CPUFREQ);
+	all = pm121_register_control(ct, "optical-drive-fan", FAN_OD) && all;
+	all = pm121_register_control(ct, "hard-drive-fan", FAN_HD) && all;
+	all = pm121_register_control(ct, "cpu-fan", FAN_CPU) && all;
+	all = pm121_register_control(ct, "cpufreq-clamp", CPUFREQ) && all;
 
 	if (all)
 		pm121_all_controls_ok = 1;
@@ -909,24 +909,24 @@ static void pm121_new_sensor(struct wf_s
 	if (pm121_all_sensors_ok)
 		return;
 
-	all = all && pm121_register_sensor(sr, "cpu-temp",
-					   &sensor_cpu_temp);
-	all = all && pm121_register_sensor(sr, "cpu-current",
-					   &sensor_cpu_current);
-	all = all && pm121_register_sensor(sr, "cpu-voltage",
-					   &sensor_cpu_voltage);
-	all = all && pm121_register_sensor(sr, "cpu-power",
-					   &sensor_cpu_power);
-	all = all && pm121_register_sensor(sr, "hard-drive-temp",
-					   &sensor_hard_drive_temp);
-	all = all && pm121_register_sensor(sr, "optical-drive-temp",
-					   &sensor_optical_drive_temp);
-	all = all && pm121_register_sensor(sr, "incoming-air-temp",
-					   &sensor_incoming_air_temp);
-	all = all && pm121_register_sensor(sr, "north-bridge-temp",
-					   &sensor_north_bridge_temp);
-	all = all && pm121_register_sensor(sr, "gpu-temp",
-					   &sensor_gpu_temp);
+	all = pm121_register_sensor(sr, "cpu-temp",
+				    &sensor_cpu_temp) && all;
+	all = pm121_register_sensor(sr, "cpu-current",
+				    &sensor_cpu_current) && all;
+	all = pm121_register_sensor(sr, "cpu-voltage",
+				    &sensor_cpu_voltage) && all;
+	all = pm121_register_sensor(sr, "cpu-power",
+				    &sensor_cpu_power) && all;
+	all = pm121_register_sensor(sr, "hard-drive-temp",
+				    &sensor_hard_drive_temp) && all;
+	all = pm121_register_sensor(sr, "optical-drive-temp",
+				    &sensor_optical_drive_temp) && all;
+	all = pm121_register_sensor(sr, "incoming-air-temp",
+				    &sensor_incoming_air_temp) && all;
+	all = pm121_register_sensor(sr, "north-bridge-temp",
+				    &sensor_north_bridge_temp) && all;
+	all = pm121_register_sensor(sr, "gpu-temp",
+				    &sensor_gpu_temp) && all;
 
 	if (all)
 		pm121_all_sensors_ok = 1;


-- 
dwmw2
