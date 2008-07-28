Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2B41DDE08
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 13:49:21 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m6S3nGDE004841
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 22:49:17 -0500
Subject: powerpc/powermac: Fixup default serial port device for pmac_zilog
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 13:49:15 +1000
Message-Id: <1217216955.11188.163.camel@pasglop>
Mime-Version: 1.0
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This removes the non-working code in legacy_serial that tried to handle
the powermac SCC ports, and instead add a (now working) function to the
powermac platform code to find the default serial console if any.
    
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 4d96e1d..bd8c838 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -493,18 +493,18 @@ static int __init serial_dev_init(void)
 device_initcall(serial_dev_init);
 
 
+#ifdef CONFIG_SERIAL_8250_CONSOLE
 /*
  * This is called very early, as part of console_init() (typically just after
  * time_init()). This function is respondible for trying to find a good
  * default console on serial ports. It tries to match the open firmware
- * default output with one of the available serial console drivers, either
- * one of the platform serial ports that have been probed earlier by
- * find_legacy_serial_ports() or some more platform specific ones.
+ * default output with one of the available serial console drivers that have
+ * been probed earlier by find_legacy_serial_ports()
  */
 static int __init check_legacy_serial_console(void)
 {
 	struct device_node *prom_stdout = NULL;
-	int speed = 0, offset = 0;
+	int i, speed = 0, offset = 0;
 	const char *name;
 	const u32 *spd;
 
@@ -548,33 +548,22 @@ static int __init check_legacy_serial_console(void)
 	if (spd)
 		speed = *spd;
 
-	if (0)
-		;
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	else if (strcmp(name, "serial") == 0) {
-		int i;
-		/* Look for it in probed array */
-		for (i = 0; i < legacy_serial_count; i++) {
-			if (prom_stdout != legacy_serial_infos[i].np)
-				continue;
-			offset = i;
-			speed = legacy_serial_infos[i].speed;
-			break;
-		}
-		if (i >= legacy_serial_count)
-			goto not_found;
+	if (strcmp(name, "serial") != 0)
+		goto not_found;
+
+	/* Look for it in probed array */
+	for (i = 0; i < legacy_serial_count; i++) {
+		if (prom_stdout != legacy_serial_infos[i].np)
+			continue;
+		offset = i;
+		speed = legacy_serial_infos[i].speed;
+		break;
 	}
-#endif /* CONFIG_SERIAL_8250_CONSOLE */
-#ifdef CONFIG_SERIAL_PMACZILOG_CONSOLE
-	else if (strcmp(name, "ch-a") == 0)
-		offset = 0;
-	else if (strcmp(name, "ch-b") == 0)
-		offset = 1;
-#endif /* CONFIG_SERIAL_PMACZILOG_CONSOLE */
-	else
+	if (i >= legacy_serial_count)
 		goto not_found;
-	of_node_put(prom_stdout);
 
+	of_node_put(prom_stdout);
+	
 	DBG("Found serial console at ttyS%d\n", offset);
 
 	if (speed) {
@@ -591,3 +580,4 @@ static int __init check_legacy_serial_console(void)
 }
 console_initcall(check_legacy_serial_console);
 
+#endif /* CONFIG_SERIAL_8250_CONSOLE */
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 3163544..88ccf3a 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -541,6 +541,78 @@ static int __init pmac_declare_of_platform_devices(void)
 }
 machine_device_initcall(powermac, pmac_declare_of_platform_devices);
 
+#ifdef CONFIG_SERIAL_PMACZILOG_CONSOLE
+/*
+ * This is called very early, as part of console_init() (typically just after
+ * time_init()). This function is respondible for trying to find a good
+ * default console on serial ports. It tries to match the open firmware
+ * default output with one of the available serial console drivers.
+ */
+static int __init check_pmac_serial_console(void)
+{
+	struct device_node *prom_stdout = NULL;
+	int offset = 0;
+	const char *name;
+#ifdef CONFIG_SERIAL_PMACZILOG_TTYS
+	char *devname = "ttyS";
+#else
+	char *devname = "ttyPZ";
+#endif
+
+	pr_debug(" -> check_pmac_serial_console()\n");
+
+	/* The user has requested a console so this is already set up. */
+	if (strstr(boot_command_line, "console=")) {
+		pr_debug(" console was specified !\n");
+		return -EBUSY;
+	}
+
+	if (!of_chosen) {
+		pr_debug(" of_chosen is NULL !\n");
+		return -ENODEV;
+	}
+
+	/* We are getting a weird phandle from OF ... */
+	/* ... So use the full path instead */
+	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
+	if (name == NULL) {
+		pr_debug(" no linux,stdout-path !\n");
+		return -ENODEV;
+	}
+	prom_stdout = of_find_node_by_path(name);
+	if (!prom_stdout) {
+		pr_debug(" can't find stdout package %s !\n", name);
+		return -ENODEV;
+	}
+	pr_debug("stdout is %s\n", prom_stdout->full_name);
+
+	name = of_get_property(prom_stdout, "name", NULL);
+	if (!name) {
+		pr_debug(" stdout package has no name !\n");
+		goto not_found;
+	}
+
+	if (strcmp(name, "ch-a") == 0)
+		offset = 0;
+	else if (strcmp(name, "ch-b") == 0)
+		offset = 1;
+	else
+		goto not_found;
+	of_node_put(prom_stdout);
+
+	pr_debug("Found serial console at %s%d\n", devname, offset);
+
+	return add_preferred_console(devname, offset, NULL);
+
+ not_found:
+	pr_debug("No preferred console found !\n");
+	of_node_put(prom_stdout);
+	return -ENODEV;
+}
+console_initcall(check_pmac_serial_console);
+
+#endif /* CONFIG_SERIAL_PMACZILOG_CONSOLE */
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
