Return-Path: <nd@bplan-gmbh.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 4CB6067B9E
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 18:16:13 +1000 (EST)
Message-ID: <45388531.4090005@bplan-gmbh.de>
Date: Fri, 20 Oct 2006 10:13:37 +0200
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
References: <4534BE9D.7030908@bplan-gmbh.de> <20061017132243.GA6773@lst.de>
	<200610180022.24631.arnd@arndb.de>
In-Reply-To: <200610180022.24631.arnd@arndb.de>
Content-Type: multipart/mixed; boundary="------------050208020300040503000809"
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050208020300040503000809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Arnd Bergmann wrote:
 > On Tuesday 17 October 2006 15:22, Christoph Hellwig wrote:
 >>>       rtas_node = of_find_node_by_name(NULL, "rtas");
 >>>       if (rtas_node == NULL)
 >>>               return -ENODEV;
 >> And given this check I wonder why we need the platform check at all.  It
 >> should be safe to just remove it.
 >>

 > One difference would be that it triggers on machines running SLOF 
(QS20, some JS20/JS21) and maybe some older Macs, which is probably a good
 > thing.
 >
 > I wonder if it should be a little stricter though:
 >
 >>     rtas_node = of_find_node_by_path("/rtas");
 >>     if (!rtas_node)
 >>         return -ENODEV;
 >
 > In case there is a node called "rtas" somewhere else.
 >
 >     Arnd <><
 >

Maybe we could check for the RTAS revision. The CHRP manual define this 
properties 'rtas-version' in /rtas/. This should be 1 for current 
implementation.

You can find here a new patch. It does not create the /proc/rtas and the 
symlink /proc/ppc64/rtas in  arch/powerpc/kernel/proc_ppc64.c anymore 
but rather create the entry (/proc/rtas) in 
arch/powerpc/kernel/rtas-proc.c and only the ppc64/ratas link for 64bit 
machine.

This has been tested on our PowerPC 32bit machine. It would be nice if 
PowerPC64 developer could reveiw and test it.

I stay ready to test upcomming patch if required.

Regards


--------------050208020300040503000809
Content-Type: text/plain;
 name="rtas_proc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtas_proc.patch"

diff -uprN a/arch/powerpc/kernel/proc_ppc64.c b/arch/powerpc/kernel/proc_ppc64.c
--- a/arch/powerpc/kernel/proc_ppc64.c	2006-10-14 05:34:03.000000000 +0200
+++ b/arch/powerpc/kernel/proc_ppc64.c	2006-10-20 08:32:20.000000000 +0200
@@ -51,15 +51,6 @@ static int __init proc_ppc64_create(void
 	if (!root)
 		return 1;
 
-	if (!of_find_node_by_path("/rtas"))
-		return 0;
-
-	if (!proc_mkdir("rtas", root))
-		return 1;
-
-	if (!proc_symlink("rtas", NULL, "ppc64/rtas"))
-		return 1;
-
 	return 0;
 }
 core_initcall(proc_ppc64_create);
diff -uprN a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
--- a/arch/powerpc/kernel/rtas-proc.c	2006-10-14 05:34:03.000000000 +0200
+++ b/arch/powerpc/kernel/rtas-proc.c	2006-10-20 08:22:57.000000000 +0200
@@ -253,43 +253,60 @@ static void get_location_code(struct seq
 static void check_location_string(struct seq_file *m, char *c);
 static void check_location(struct seq_file *m, char *c);
 
+static int __init proc_rtas_create(void)
+{
+        struct proc_dir_entry *root;
+
+        root = proc_mkdir("rtas" , NULL);
+        if (!root)
+                return -1;
+
+
+#ifdef CONFIG_PPC64
+        if (!proc_symlink("rtas", NULL, "ppc64/rtas"))
+                return -1;
+#endif
+
+        return 0;
+}
+
 static int __init proc_rtas_init(void)
 {
 	struct proc_dir_entry *entry;
 
-	if (!machine_is(pseries))
-		return -ENODEV;
-
 	rtas_node = of_find_node_by_name(NULL, "rtas");
 	if (rtas_node == NULL)
 		return -ENODEV;
 
-	entry = create_proc_entry("ppc64/rtas/progress", S_IRUGO|S_IWUSR, NULL);
+	if (proc_rtas_create() != 0)
+		return -ENODEV;
+
+	entry = create_proc_entry("/rtas/progress", S_IRUGO|S_IWUSR, NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_progress_operations;
 
-	entry = create_proc_entry("ppc64/rtas/clock", S_IRUGO|S_IWUSR, NULL);
+	entry = create_proc_entry("/rtas/clock", S_IRUGO|S_IWUSR, NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_clock_operations;
 
-	entry = create_proc_entry("ppc64/rtas/poweron", S_IWUSR|S_IRUGO, NULL);
+	entry = create_proc_entry("/rtas/poweron", S_IWUSR|S_IRUGO, NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_poweron_operations;
 
-	entry = create_proc_entry("ppc64/rtas/sensors", S_IRUGO, NULL);
+	entry = create_proc_entry("/rtas/sensors", S_IRUGO, NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_sensors_operations;
 
-	entry = create_proc_entry("ppc64/rtas/frequency", S_IWUSR|S_IRUGO,
+	entry = create_proc_entry("/rtas/frequency", S_IWUSR|S_IRUGO,
 				  NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_tone_freq_operations;
 
-	entry = create_proc_entry("ppc64/rtas/volume", S_IWUSR|S_IRUGO, NULL);
+	entry = create_proc_entry("/rtas/volume", S_IWUSR|S_IRUGO, NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_tone_volume_operations;
 
-	entry = create_proc_entry("ppc64/rtas/rmo_buffer", S_IRUSR, NULL);
+	entry = create_proc_entry("/rtas/rmo_buffer", S_IRUSR, NULL);
 	if (entry)
 		entry->proc_fops = &ppc_rtas_rmo_buf_ops;
 

--------------050208020300040503000809
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


--------------050208020300040503000809--
