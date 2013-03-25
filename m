Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C3F242C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 06:02:28 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 25 Mar 2013 13:02:26 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 11B1619D8053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 13:02:18 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2PJ2DYD278078
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 13:02:13 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2PJ2Cpa014749
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 13:02:12 -0600
Received: from [9.41.105.123] ([9.41.105.123])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2PJ2CpG014696
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 13:02:12 -0600
Message-ID: <51509F31.8010300@linux.vnet.ibm.com>
Date: Mon, 25 Mar 2013 14:02:09 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 11/11] Add /proc interface to control topology updates
References: <51509AE8.8070803@linux.vnet.ibm.com>
In-Reply-To: <51509AE8.8070803@linux.vnet.ibm.com>
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
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-03-20 12:27:48.000000000 -0500
+++ powerpc/arch/powerpc/mm/numa.c	2013-03-20 12:27:52.000000000 -0500
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
--- powerpc.orig/arch/powerpc/include/asm/topology.h	2013-03-20 12:25:37.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/topology.h	2013-03-20 12:27:52.000000000 -0500
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
--- powerpc.orig/arch/powerpc/kernel/rtasd.c	2013-03-20 12:25:37.000000000 -0500
+++ powerpc/arch/powerpc/kernel/rtasd.c	2013-03-20 12:27:52.000000000 -0500
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
