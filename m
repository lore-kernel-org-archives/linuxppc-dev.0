Return-Path: <jkenisto@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1EE92B7106
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Nov 2010 15:15:43 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAE3wPSZ012989
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 22:58:25 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAE4FMMS157502
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 23:15:22 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAE4FMkH024820
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 23:15:22 -0500
Received: from localhost.localdomain (w-jimk.beaverton.ibm.com [9.47.28.66])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAE4FMjd024767
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 23:15:22 -0500
From: Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH 2/6] nvram: Capture oops/panic reports in ibm,
	oops-log partition
To: linuxppc-dev@lists.ozlabs.org
Date: Sat, 13 Nov 2010 20:15:21 -0800
Message-ID: <20101114041521.9457.69485.stgit@localhost.localdomain>
In-Reply-To: <20101114041510.9457.92921.stgit@localhost.localdomain>
References: <20101114041510.9457.92921.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create the ibm,oops-log NVRAM partition, and capture the end of the printk
buffer in it when there's an oops or panic.  If we can't create the
ibm,oops-log partition, capture the oops/panic report in ibm,rtas-log.

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
---

 arch/powerpc/platforms/pseries/nvram.c |   89 ++++++++++++++++++++++++++++++++
 1 files changed, 88 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 43d5c52..6c88cda 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -16,6 +16,8 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/kmsg_dump.h>
 #include <asm/uaccess.h>
 #include <asm/nvram.h>
 #include <asm/rtas.h>
@@ -50,11 +52,32 @@ static struct os_partition rtas_log_partition = {
 	.index = -1
 };
 
+static struct os_partition oops_log_partition = {
+	.name = "ibm,oops-log",
+	.req_size = 4000,
+	.min_size = 2000,
+	.index = -1
+};
+
 static const char *valid_os_partitions[] = {
 	"ibm,rtas-log",
+	"ibm,oops-log",
 	NULL
 };
 
+static void oops_to_nvram(struct kmsg_dumper *dumper,
+		enum kmsg_dump_reason reason,
+		const char *old_msgs, unsigned long old_len,
+		const char *new_msgs, unsigned long new_len);
+
+static struct kmsg_dumper nvram_kmsg_dumper = {
+	.dump = oops_to_nvram
+};
+
+/* We preallocate oops_buf during init to avoid kmalloc during oops/panic. */
+static size_t oops_buf_sz;
+static char *oops_buf;
+
 static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
 {
 	unsigned int i;
@@ -337,9 +360,36 @@ static int __init pseries_nvram_init_os_partition(struct os_partition *part)
 	return 0;
 }
 
+static void __init nvram_init_oops_partition(int rtas_partition_exists)
+{
+	int rc;
+
+	rc = pseries_nvram_init_os_partition(&oops_log_partition);
+	if (rc != 0) {
+		if (!rtas_partition_exists)
+			return;
+		pr_notice("nvram: Using %s partition to log both"
+			" RTAS errors and oops/panic reports\n",
+			rtas_log_partition.name);
+		memcpy(&oops_log_partition, &rtas_log_partition,
+						sizeof(rtas_log_partition));
+	}
+	oops_buf_sz = oops_log_partition.size - sizeof(struct err_log_info);
+	oops_buf = kmalloc(oops_buf_sz, GFP_KERNEL);
+	rc = kmsg_dump_register(&nvram_kmsg_dumper);
+	if (rc != 0) {
+		pr_err("nvram: kmsg_dump_register() failed; returned %d\n", rc);
+		kfree(oops_buf);
+		return;
+	}
+}
+
 static int __init pseries_nvram_init_log_partitions(void)
 {
-	(void) pseries_nvram_init_os_partition(&rtas_log_partition);
+	int rc;
+
+	rc = pseries_nvram_init_os_partition(&rtas_log_partition);
+	nvram_init_oops_partition(rc == 0);
 	return 0;
 }
 machine_late_initcall(pseries, pseries_nvram_init_log_partitions);
@@ -373,3 +423,40 @@ int __init pSeries_nvram_init(void)
 
 	return 0;
 }
+
+/*
+ * Try to capture the last capture_len bytes of the printk buffer.  Return
+ * the amount actually captured.
+ */
+static size_t capture_last_msgs(const char *old_msgs, size_t old_len,
+				const char *new_msgs, size_t new_len,
+				char *captured, size_t capture_len)
+{
+	if (new_len >= capture_len) {
+		memcpy(captured, new_msgs + (new_len - capture_len),
+								capture_len);
+		return capture_len;
+	} else {
+		/* Grab the end of old_msgs. */
+		size_t old_tail_len = min(old_len, capture_len - new_len);
+		memcpy(captured, old_msgs + (old_len - old_tail_len),
+								old_tail_len);
+		memcpy(captured + old_tail_len, new_msgs, new_len);
+		return old_tail_len + new_len;
+	}
+}
+
+/* our kmsg_dump callback */
+static void oops_to_nvram(struct kmsg_dumper *dumper,
+		enum kmsg_dump_reason reason,
+		const char *old_msgs, unsigned long old_len,
+		const char *new_msgs, unsigned long new_len)
+{
+	static unsigned int oops_count = 0;
+	size_t text_len;
+
+	text_len = capture_last_msgs(old_msgs, old_len, new_msgs, new_len,
+						oops_buf, oops_buf_sz);
+	(void) nvram_write_os_partition(&oops_log_partition, oops_buf,
+		(int) text_len, ERR_TYPE_KERNEL_PANIC, ++oops_count);
+}
