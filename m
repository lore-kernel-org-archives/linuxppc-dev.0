Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1FE4E2C013C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 04:48:04 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 14:48:02 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B7C92C9002A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 14:47:59 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MIlw3V255944
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 14:47:59 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MIluj3022566
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:47:56 -0300
Received: from [9.41.105.123] ([9.41.105.123])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3MIltKp022430
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:47:55 -0300
Message-ID: <517585DB.9040603@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 13:47:55 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 12/12]  Add /proc interface to control topology updates
References: <51757951.2080007@linux.vnet.ibm.com>
In-Reply-To: <51757951.2080007@linux.vnet.ibm.com>
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
 arch/powerpc/kernel/rtasd.c         |    7 ++--
 arch/powerpc/mm/numa.c              |   62 +++++++++++++++++++++++++++++++++++-
 3 files changed, 71 insertions(+), 3 deletions(-)

Index: powerpc/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-04-22 09:46:13.000000000 -0500
+++ powerpc/arch/powerpc/mm/numa.c	2013-04-22 09:51:10.000000000 -0500
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
@@ -1585,7 +1588,6 @@
 
 	return rc;
 }
-__initcall(start_topology_update);
 
 /*
  * Disable polling for VPHN associativity changes.
@@ -1604,4 +1606,62 @@
 
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
--- powerpc.orig/arch/powerpc/include/asm/topology.h	2013-04-18 09:09:21.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/topology.h	2013-04-22 09:51:10.000000000 -0500
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
--- powerpc.orig/arch/powerpc/kernel/rtasd.c	2013-04-18 09:09:21.000000000 -0500
+++ powerpc/arch/powerpc/kernel/rtasd.c	2013-04-22 09:51:10.000000000 -0500
@@ -29,6 +29,7 @@
 #include <asm/nvram.h>
 #include <linux/atomic.h>
 #include <asm/machdep.h>
+#include <asm/topology.h>
 
 
 static DEFINE_SPINLOCK(rtasd_log_lock);
@@ -294,11 +295,13 @@
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
