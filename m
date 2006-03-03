Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7B6F67A33
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 17:13:36 +1100 (EST)
Subject: [PATCH] powerpc: Fix windfarm_pm112 not starting all control loops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 17:13:30 +1100
Message-Id: <1141366411.3888.50.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a couple of printk's to windfarm_pm112 to display which
control loops are actually starting and fixes a bug where it would not
start all loops.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Index: linux-work/drivers/macintosh/windfarm_pm112.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_pm112.c	2006-03-03 16:24:44.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_pm112.c	2006-03-03 17:04:53.000000000 +1100
@@ -358,6 +358,7 @@ static void backside_fan_tick(void)
 		return;
 	if (!backside_tick) {
 		/* first time; initialize things */
+		printk(KERN_INFO "windfarm: Backside control loop started.\n");
 		backside_param.min = backside_fan->ops->get_min(backside_fan);
 		backside_param.max = backside_fan->ops->get_max(backside_fan);
 		wf_pid_init(&backside_pid, &backside_param);
@@ -407,6 +408,7 @@ static void drive_bay_fan_tick(void)
 		return;
 	if (!drive_bay_tick) {
 		/* first time; initialize things */
+		printk(KERN_INFO "windfarm: Drive bay control loop started.\n");
 		drive_bay_prm.min = drive_bay_fan->ops->get_min(drive_bay_fan);
 		drive_bay_prm.max = drive_bay_fan->ops->get_max(drive_bay_fan);
 		wf_pid_init(&drive_bay_pid, &drive_bay_prm);
@@ -458,6 +460,7 @@ static void slots_fan_tick(void)
 		return;
 	if (!slots_started) {
 		/* first time; initialize things */
+		printk(KERN_INFO "windfarm: Slots control loop started.\n");
 		wf_pid_init(&slots_pid, &slots_param);
 		slots_started = 1;
 	}
@@ -504,6 +507,7 @@ static void pm112_tick(void)
 
 	if (!started) {
 		started = 1;
+		printk(KERN_INFO "windfarm: CPUs control loops started.\n");
 		for (i = 0; i < nr_cores; ++i) {
 			if (create_cpu_loop(i) < 0) {
 				failure_state = FAILURE_PERM;
@@ -594,8 +598,6 @@ static void pm112_new_sensor(struct wf_s
 {
 	unsigned int i;
 
-	if (have_all_sensors)
-		return;
 	if (!strncmp(sr->name, "cpu-temp-", 9)) {
 		i = sr->name[9] - '0';
 		if (sr->name[10] == 0 && i < NR_CORES &&
