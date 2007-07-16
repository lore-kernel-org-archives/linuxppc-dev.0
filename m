Return-Path: <aris@ruivo.org>
Received: from lobo.ruivo.org (lobo.ruivo.org [66.92.68.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lobo.ruivo.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2174FDDDFD
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 06:26:57 +1000 (EST)
Received: from jake.ruivo.org (gw.qemu.cathedral [192.168.72.1])
	by lobo.ruivo.org (Postfix) with ESMTP id 7A58A527F4
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 13:53:52 -0400 (EDT)
Date: Mon, 16 Jul 2007 16:03:56 -0400
From: Aristeu Rozanski <aris@ruivo.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH] therm_adt746x: fix behaviour on !ADT7460
Message-ID: <20070716200356.GX20841@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
	this bug exists since I began using a powerbook 12". When the
system gets hot, therm_adt746x begins to oscillate between two fan
speeds every one or two seconds. The result is very annoying not
optimal: while switching between two speeds, the machine takes a long
time to get cold again. This powerbook doesn't has a ADT7460, so it
only has one fan for both CPU and GPU. The problem happens when one of
the sensors (CPU, GPU) gets hotter than the other:

[172] temp is: 52, limit is: 50, var is 2, new_speed is 91, last_var is 4
[173] temp is: 74, limit is: 70, var is 4, new_speed is 145, last_var is 2
[174] temp is: 52, limit is: 50, var is 2, new_speed is 91, last_var is 4
[175] temp is: 74, limit is: 70, var is 4, new_speed is 145, last_var is 2
[176] temp is: 52, limit is: 50, var is 2, new_speed is 91, last_var is 4

When update_fans_speed() is called, it first finds that the CPU
temperature is over the limit (52/50) and because the variation (2 F) is
different enough from the last (4 F) and sets the fan speed to 91. As it
changed the fan speed, "started" variable is set to 1 and the function
returns. In the next time update_fan_speed() is called, it'll find the
temperature as the same for the CPU (or close to the same) and will go
to the next sensor. On the GPU, the temperature is 74 (70 is the limit),
so the variation is 4 F, different enough from the previous (2 F) to
change the fan speed. The fan speed is changed to 145 and the variation
(4 F) is stored. Next time, CPU sensor is checked and the variation is
2 F, different enough from the previous one, 4 F, so it changes the fan
speed again. And this goes on...

The patch changes update_fans_speed() to first collect the highest
variation for each fan and updates their speed accordingly, instead of
setting the same speed for both fans.
I've been testing this on my powerbook with different loads and it fixes
the problem. I'd like to hear from people with bigger powerbooks (15",
17") if it makes any difference (it should be quieter, since fans will
have different speeds).

Comments?

--- linus-2.6.orig/drivers/macintosh/therm_adt746x.c	2007-07-16 12:56:25.000000000 -0400
+++ linus-2.6/drivers/macintosh/therm_adt746x.c	2007-07-16 14:08:08.000000000 -0400
@@ -278,26 +278,34 @@
 
 static void update_fans_speed (struct thermostat *th)
 {
-	int lastvar = 0; /* last variation, for iBook */
-	int i = 0;
+	int sensor, fan, adt7460, vars[2] = { -50, -50 };
+
+	adt7460 = (therm_type == ADT7460);
 
 	/* we don't care about local sensor, so we start at sensor 1 */
-	for (i = 1; i < 3; i++) {
-		int started = 0;
-		int fan_number = (therm_type == ADT7460 && i == 2);
-		int var = th->temps[i] - th->limits[i];
+	for (sensor = 1; sensor < 3; sensor++) {
+		int diff;
+		fan = (adt7460 && sensor == 2);
+		diff = th->temps[sensor] - th->limits[sensor];
+		if (diff > vars[fan])
+			vars[fan] = diff;
+	}
 
-		if (var > -1) {
+	/*
+	 * here we have the biggest variation for each fan (in cases where
+	 * a single fan is used for two sensors).
+	 */
+	for (fan = 0; fan < (1 + adt7460); fan++) {
+		if (vars[fan] > -1) {
 			int step = (255 - fan_speed) / 7;
 			int new_speed = 0;
 
 			/* hysteresis : change fan speed only if variation is
 			 * more than two degrees */
-			if (abs(var - th->last_var[fan_number]) < 2)
+			if (abs(vars[fan] - th->last_var[fan]) < 2)
 				continue;
 
-			started = 1;
-			new_speed = fan_speed + ((var-1)*step);
+			new_speed = fan_speed + ((vars[fan] - 1) * step);
 
 			if (new_speed < fan_speed)
 				new_speed = fan_speed;
@@ -305,29 +313,19 @@
 				new_speed = 255;
 
 			if (verbose)
-				printk(KERN_DEBUG "adt746x: Setting fans speed to %d "
-						 "(limit exceeded by %d on %s) \n",
-						new_speed, var,
-						sensor_location[fan_number+1]);
-			write_both_fan_speed(th, new_speed);
-			th->last_var[fan_number] = var;
-		} else if (var < -2) {
-			/* don't stop fan if sensor2 is cold and sensor1 is not
-			 * so cold (lastvar >= -1) */
-			if (i == 2 && lastvar < -1) {
-				if (th->last_speed[fan_number] != 0)
-					if (verbose)
-						printk(KERN_DEBUG "adt746x: Stopping "
-							"fans.\n");
-				write_both_fan_speed(th, 0);
+				printk(KERN_DEBUG "adt746x: Setting fan speed to %d "
+						 "(limit exceeded by %d)\n",
+						new_speed, vars[fan]);
+			write_fan_speed(th, new_speed, fan);
+			th->last_var[fan] = vars[fan];
+		} else if (vars[fan] < -2) {
+			if (th->last_speed[fan] != 0) {
+				if (verbose)
+					printk(KERN_DEBUG "adt746x: Stopping "
+						"fan %i.\n", fan);
+				write_fan_speed(th, 0, fan);
 			}
 		}
-
-		lastvar = var;
-
-		if (started)
-			return; /* we don't want to re-stop the fan
-				* if sensor1 is heating and sensor2 is not */
 	}
 }
 
