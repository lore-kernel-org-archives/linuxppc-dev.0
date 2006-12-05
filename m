Return-Path: <ahuja@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5356D67B8B
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 11:15:35 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB60FUwk011117
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Dec 2006 19:15:30 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB60FTaS551990
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Dec 2006 17:15:30 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB60FTiH007182
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Dec 2006 17:15:29 -0700
Message-ID: <4575E76C.7030300@austin.ibm.com>
Date: Tue, 05 Dec 2006 15:41:00 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
References: <45707469.9060604@austin.ibm.com>
In-Reply-To: <45707469.9060604@austin.ibm.com>
Content-Type: multipart/mixed; boundary="------------000102020101060408050508"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000102020101060408050508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

During power outages, the ups notifies the system for a shutdown. In the 
current setup, it isn't possible to power on when power is restored. 
This patch fixes the issue by calling the right ibm,power-off-ups token 
during such events. It also adds a proc interface so that rc.powerfail 
can parse the epow events and modify the power-off behavior accordingly 
to enable the right token to be called.

Signed-off-by: Manish Ahuja <ahuja@austin.ibm.com>

--------------000102020101060408050508
Content-Type: text/plain;
 name="power-off-ups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="power-off-ups.patch"

Index: 2.6-git2/arch/powerpc/kernel/rtas.c
===================================================================
--- 2.6-git2.orig/arch/powerpc/kernel/rtas.c	2006-11-29 12:00:26.000000000 -0800
+++ 2.6-git2/arch/powerpc/kernel/rtas.c	2006-12-05 13:35:22.000000000 -0800
@@ -601,14 +601,32 @@
 	for (;;);
 }
 
+/**
+ * rtas_power_off - tell firmware about how to power off the system.
+ *
+ * This function calls either the power-off rtas token in normal cases
+ * or the ibm,power-off-ups token (if present & requested) in case of
+ * a power failure. If power-off token is used, power on will only be
+ * possible with power button press. If ibm,power-off-ups token is used
+ * it will allow auto poweron after power is restored.
+ */
 void rtas_power_off(void)
 {
-	if (rtas_flash_term_hook)
-		rtas_flash_term_hook(SYS_POWER_OFF);
-	/* allow power on only with power button press */
-	printk("RTAS power-off returned %d\n",
-	       rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1));
-	for (;;);
+	int rc;
+	int rtas_poweroff_ups_token = rtas_token("ibm,power-off-ups");
+
+ 	if (rtas_flash_term_hook)
+ 		rtas_flash_term_hook(SYS_POWER_OFF);
+
+	if (rtas_poweron_auto == 0 ||
+		rtas_poweroff_ups_token == RTAS_UNKNOWN_SERVICE) {
+		rc = rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1);
+		printk(KERN_INFO "RTAS power-off returned %d\n", rc);
+	} else {
+		rc = rtas_call(rtas_poweroff_ups_token, 0, 1, NULL);
+		printk(KERN_INFO "RTAS ibm,power-off-ups returned %d\n", rc);
+	}
+ 	for (;;);
 }
 
 void rtas_halt(void)
Index: 2.6-git2/arch/powerpc/kernel/rtas-proc.c
===================================================================
--- 2.6-git2.orig/arch/powerpc/kernel/rtas-proc.c	2006-11-29 11:51:49.000000000 -0800
+++ 2.6-git2/arch/powerpc/kernel/rtas-proc.c	2006-12-05 12:00:47.000000000 -0800
@@ -122,6 +122,7 @@
 
 static unsigned long rtas_tone_frequency = 1000;
 static unsigned long rtas_tone_volume = 0;
+unsigned long rtas_poweron_auto; /* default and normal state is 0 */
 
 /* ****************STRUCTS******************************************* */
 struct individual_sensor {
@@ -154,6 +155,9 @@
 		const char __user *buf, size_t count, loff_t *ppos);
 static int ppc_rtas_tone_volume_show(struct seq_file *m, void *v);
 static int ppc_rtas_rmo_buf_show(struct seq_file *m, void *v);
+static int ppc_rtas_poweron_auto_show(struct seq_file *m, void *v);
+static ssize_t ppc_rtas_poweron_auto_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos);
 
 static int sensors_open(struct inode *inode, struct file *file)
 {
@@ -244,6 +248,18 @@
 	.release	= single_release,
 };
 
+static int poweron_auto_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ppc_rtas_poweron_auto_show, NULL);
+}
+
+struct file_operations ppc_rtas_poweron_auto_operations = {
+	.open		= poweron_auto_open,
+	.read		= seq_read,
+	.write		= ppc_rtas_poweron_auto_write,
+	.release	= single_release,
+};
+
 static int ppc_rtas_find_all_sensors(void);
 static void ppc_rtas_process_sensor(struct seq_file *m,
 	struct individual_sensor *s, int state, int error, const char *loc);
@@ -293,6 +309,10 @@
 	if (entry)
 		entry->proc_fops = &ppc_rtas_rmo_buf_ops;
 
+	entry = create_proc_entry("ppc64/rtas/poweron_auto", S_IRUGO|S_IWUSR, NULL);
+	if (entry)
+		entry->proc_fops = &ppc_rtas_poweron_auto_operations;
+
 	return 0;
 }
 
@@ -805,3 +825,24 @@
 	seq_printf(m, "%016lx %x\n", rtas_rmo_buf, RTAS_RMOBUF_MAX);
 	return 0;
 }
+
+static ssize_t ppc_rtas_poweron_auto_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	unsigned long ups_restart;
+	int error = parse_number(buf, count, &ups_restart);
+	if (error)
+		return error;
+
+	if (ups_restart)
+		rtas_poweron_auto = 1;
+
+	return count;
+}
+
+static int ppc_rtas_poweron_auto_show(struct seq_file *m, void *v)
+{
+        seq_printf(m, "%lu\n", rtas_poweron_auto);
+        return 0;
+
+}
Index: 2.6-git2/include/asm-powerpc/rtas.h
===================================================================
--- 2.6-git2.orig/include/asm-powerpc/rtas.h	2006-11-28 14:41:17.000000000 -0800
+++ 2.6-git2/include/asm-powerpc/rtas.h	2006-11-30 10:42:35.000000000 -0800
@@ -228,6 +228,9 @@
 /* RMO buffer reserved for user-space RTAS use */
 extern unsigned long rtas_rmo_buf;
 
+/* Poweron buffer used for enabling auto ups restart */
+extern unsigned long rtas_poweron_auto;
+
 #define GLOBAL_INTERRUPT_QUEUE 9005
 
 /**

--------------000102020101060408050508--
