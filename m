Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E5C152C0387
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Mar 2013 15:10:07 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 8 Mar 2013 21:10:05 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0A4703E40044
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 21:09:54 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r294A3l1384130
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:10:03 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r294A3F2030777
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:10:03 -0700
Received: from [9.76.31.13] (sig-9-76-31-13.mts.ibm.com [9.76.31.13])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r294A03w030632
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:10:01 -0700
Message-ID: <513AB618.2090401@linux.vnet.ibm.com>
Date: Fri, 08 Mar 2013 22:10:00 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/11] Add /proc interface to control topology updates
References: <513AB2E3.6090209@linux.vnet.ibm.com>
In-Reply-To: <513AB2E3.6090209@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are instances in which we do not want topology updates to occur.
In order to allow this a /proc interface (/proc/powerpc/topology_updates)
is introduced so that topology updates can be enabled and disabled.

This patch also adds a prrn_is_enabled() call so that PRRN events are
handled in the kernel only if topology updating is enabled.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h |    5 ++
 arch/powerpc/kernel/rtasd.c         |    6 ++-
 arch/powerpc/mm/numa.c              |   62 +++++++++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 3 deletions(-)

Index: powerpc/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-03-08 19:58:09.000000000 -0600
+++ powerpc/arch/powerpc/mm/numa.c	2013-03-08 19:58:37.000000000 -0600
@@ -23,6 +23,9 @@
 #include <linux/cpuset.h>
 #include <linux/node.h>
 #include <linux/stop_machine.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>
 #include <asm/sparsemem.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
@@ -1558,7 +1561,6 @@
 
 	return rc;
 }
-__initcall(start_topology_update);
 
 /*
  * Disable polling for VPHN associativity changes.
@@ -1577,4 +1579,62 @@
 
 	return rc;
 }
+
+inline int prrn_is_enabled(void)
+{
+	return prrn_enabled;
+}
+
+static int topology_read(struct seq_file *file, void *v)
+{
+	if (vphn_enabled || prrn_enabled)
+		seq_puts(file, "on\n");
+	else
+		seq_puts(file, "off\n");
+
+	return 0;
+}
+
+static int topology_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, topology_read, NULL);
+}
+
+static ssize_t topology_write(struct file *file, const char __user *buf,
+			      size_t count, loff_t *off)
+{
+	char kbuf[4]; /* "on" or "off" plus null. */
+	int read_len;
+
+	read_len = count < 3 ? count : 3;
+	if (copy_from_user(kbuf, buf, read_len))
+		return -EINVAL;
+
+	kbuf[read_len] = '\0';
+
+	if (!strncmp(kbuf, "on", 2))
+		start_topology_update();
+	else if (!strncmp(kbuf, "off", 3))
+		stop_topology_update();
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static const struct file_operations topology_ops = {
+	.read = seq_read,
+	.write = topology_write,
+	.open = topology_open,
+	.release = single_release
+};
+
+static int topology_update_init(void)
+{
+	start_topology_update();
+	proc_create("powerpc/topology_updates", 644, NULL, &topology_ops);
+
+	return 0;
+}
+device_initcall(topology_update_init);
 #endif /* CONFIG_PPC_SPLPAR */
Index: powerpc/arch/powerpc/include/asm/topology.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/topology.h	2013-03-08 19:23:06.000000000 -0600
+++ powerpc/arch/powerpc/include/asm/topology.h	2013-03-08 19:58:37.000000000 -0600
@@ -71,6 +71,7 @@
 #if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
 extern int start_topology_update(void);
 extern int stop_topology_update(void);
+extern inline int prrn_is_enabled(void);
 #else
 static inline int start_topology_update(void)
 {
@@ -80,6 +81,10 @@
 {
 	return 0;
 }
+static inline int prrn_is_enabled(void)
+{
+	return 0;
+}
 #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
 
 #include <asm-generic/topology.h>
Index: powerpc/arch/powerpc/kernel/rtasd.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/rtasd.c	2013-03-08 19:56:48.000000000 -0600
+++ powerpc/arch/powerpc/kernel/rtasd.c	2013-03-08 19:58:37.000000000 -0600
@@ -292,11 +292,13 @@
 {
 	pSeries_log_error((char *)log, ERR_TYPE_RTAS_LOG, 0);
 
-	if (log->type == RTAS_TYPE_PRRN)
+	if (log->type == RTAS_TYPE_PRRN) {
 		/* For PRRN Events the extended log length is used to denote
 		 * the scope for calling rtas update-nodes.
 		 */
-		prrn_schedule_update(log->extended_log_length);
+		if (prrn_is_enabled())
+			prrn_schedule_update(log->extended_log_length);
+	}
 
 	return;
 }
