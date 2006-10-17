Return-Path: <nd@bplan-gmbh.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id 1D96267BDC
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 22:00:15 +1000 (EST)
Message-ID: <4534BE9D.7030908@bplan-gmbh.de>
Date: Tue, 17 Oct 2006 13:29:33 +0200
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, akpm@osdl.org, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de
Subject: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Content-Type: multipart/mixed; boundary="------------020208050801000105080002"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020208050801000105080002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch enables RTAS /proc support for PowerPC 32bits / CHRP platform.

A new entry is created (/proc/ppc/rtas/) which contains the RTAS nodes. 
Theses nodes and the code are the exact same than with the ppc64 
architecture.

This patch has been succefully applied on the kernel 2.6.18.1 and tested 
on bPlan's OpenFirmware.

Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>

--------------020208050801000105080002
Content-Type: text/plain;
 name="rtas-proc_ppc32.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtas-proc_ppc32.patch"

--- a/arch/powerpc/kernel/rtas-proc.c	2006-10-14 05:34:03.000000000 +0200
+++ b/arch/powerpc/kernel/rtas-proc.c	2006-10-16 10:46:16.000000000 +0200
@@ -253,43 +253,70 @@ static void get_location_code(struct seq
 static void check_location_string(struct seq_file *m, char *c);
 static void check_location(struct seq_file *m, char *c);
 
+#ifdef CONFIG_PPC64
+#define PROCRTAS_ROOT "ppc64"
+#else
+#define PROCRTAS_ROOT "ppc"
+static int __init proc_ppc32_create(void)
+{
+        struct proc_dir_entry *root;
+
+        root = proc_mkdir(PROCRTAS_ROOT , NULL);
+        if (!root)
+                return -1;
+
+        if (!proc_mkdir("rtas", root))
+                return -1;
+
+        if (!proc_symlink("rtas", NULL, PROCRTAS_ROOT "/rtas"))
+                return -1;
+
+        return 0;
+}
+#endif
+
 static int __init proc_rtas_init(void)
 {
 	struct proc_dir_entry *entry;
 
-	if (!machine_is(pseries))
+	if ( ! ( machine_is(pseries) || machine_is(chrp) ) )
 		return -ENODEV;
 
 	rtas_node = of_find_node_by_name(NULL, "rtas");
 	if (rtas_node == NULL)
 		return -ENODEV;
 
-	entry = create_proc_entry("ppc64/rtas/progress", S_IRUGO|S_IWUSR, NULL);
+#ifndef CONFIG_PPC64
+	if (proc_ppc32_create() != 0)
+		return -ENODEV;
+#endif
+
+	entry = create_proc_entry(PROCRTAS_ROOT "/rtas/progress", S_IRUGO|S_IWUSR, NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_progress_operations;
 
-	entry = create_proc_entry("ppc64/rtas/clock", S_IRUGO|S_IWUSR, NULL);
+	entry = create_proc_entry(PROCRTAS_ROOT "/rtas/clock", S_IRUGO|S_IWUSR, NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_clock_operations;
 
-	entry = create_proc_entry("ppc64/rtas/poweron", S_IWUSR|S_IRUGO, NULL);
+	entry = create_proc_entry(PROCRTAS_ROOT "/rtas/poweron", S_IWUSR|S_IRUGO, NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_poweron_operations;
 
-	entry = create_proc_entry("ppc64/rtas/sensors", S_IRUGO, NULL);
+	entry = create_proc_entry(PROCRTAS_ROOT "/rtas/sensors", S_IRUGO, NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_sensors_operations;
 
-	entry = create_proc_entry("ppc64/rtas/frequency", S_IWUSR|S_IRUGO,
+	entry = create_proc_entry(PROCRTAS_ROOT "/rtas/frequency", S_IWUSR|S_IRUGO,
 				  NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_tone_freq_operations;
 
-	entry = create_proc_entry("ppc64/rtas/volume", S_IWUSR|S_IRUGO, NULL);
+	entry = create_proc_entry(PROCRTAS_ROOT "/rtas/volume", S_IWUSR|S_IRUGO, NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_tone_volume_operations;
 
-	entry = create_proc_entry("ppc64/rtas/rmo_buffer", S_IRUSR, NULL);
+	entry = create_proc_entry(PROCRTAS_ROOT "/rtas/rmo_buffer", S_IRUSR, NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_rmo_buf_ops;
 

--------------020208050801000105080002
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------020208050801000105080002--
