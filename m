Return-Path: <ahuja@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 464C467BBC
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 08:15:36 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB1LFWVb015133
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Dec 2006 16:15:32 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB1LFWKT173882
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Dec 2006 16:15:32 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB1LFWnP006678
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Dec 2006 16:15:32 -0500
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	kB1LDWOK000422
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Dec 2006 16:15:32 -0500
Received: from [127.0.0.1] (IBM-E113D5807BA.austin.ibm.com [9.53.40.199])
	by austin.ibm.com (8.12.10/8.12.10) with ESMTP id kB1IT0Z6253682
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Dec 2006 12:29:00 -0600
Message-ID: <45707469.9060604@austin.ibm.com>
Date: Fri, 01 Dec 2006 12:28:57 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH]Enabling Auto poweron after power is restored.
Content-Type: multipart/mixed; boundary="------------090708020007060306080000"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090708020007060306080000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

During power outages, the ups notifies the system for a shutdown. In the 
current setup, it isn't possible to poweron when power is restored. This 
patch fixes the issue by calling the right ibm,power-off-ups token 
during such events. It also adds a proc interface so that rc.powerfail 
can parse the epow events and modify the power-off behavior accordingly 
to enable the right token to be called.

Signed-off-by: Manish Ahuja <ahuja@austin.ibm.com>

Resending this email as earlier attempts failed.



--------------090708020007060306080000
Content-Type: text/plain;
 name="power-off-ups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="power-off-ups.patch"

Index: 2.6-git2/arch/powerpc/kernel/rtas.c
===================================================================
--- 2.6-git2.orig/arch/powerpc/kernel/rtas.c	2006-11-29 12:00:26.000000000 -0800
+++ 2.6-git2/arch/powerpc/kernel/rtas.c	2006-11-30 10:56:12.000000000 -0800
@@ -603,11 +603,30 @@
 
 void rtas_power_off(void)
 {
+	int rc = 0;
+	int rtas_poweron_auto_token;
+
 	if (rtas_flash_term_hook)
 		rtas_flash_term_hook(SYS_POWER_OFF);
-	/* allow power on only with power button press */
-	printk("RTAS power-off returned %d\n",
-	       rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1));
+
+	if (rtas_poweron_auto == 0) {
+		/* allow power on only with power button press */
+		printk(KERN_INFO "RTAS power-off returned %d\n",
+			rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1));
+	} else {
+		rtas_poweron_auto_token = rtas_token("ibm,power-off-ups");
+
+		if (rtas_poweron_auto_token == RTAS_UNKNOWN_SERVICE) {
+			/* ibm,power-off-ups failed or token does not exist */
+			rc = rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1);
+	 		printk(KERN_EMERG "Power-off called instead %d\n", rc );
+		} else {
+			/* Enable the system to reboot if power comes back on */
+			rc = rtas_call(rtas_token("ibm,power-off-ups"), 0, 1, NULL);
+			printk(KERN_INFO "RTAS ibm,power-off-ups returned %d\n", rc);
+		}
+
+	}
 	for (;;);
 }
 
Index: 2.6-git2/arch/powerpc/kernel/rtas-proc.c
===================================================================
--- 2.6-git2.orig/arch/powerpc/kernel/rtas-proc.c	2006-11-29 11:51:49.000000000 -0800
+++ 2.6-git2/arch/powerpc/kernel/rtas-proc.c	2006-11-30 11:01:55.000000000 -0800
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
+	if (ups_restart != 0)
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

--------------090708020007060306080000--
