Return-Path: <jkenisto@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E4D7CB70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 10:00:20 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p19Mrx0Z014463
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 15:53:59 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p19N0CRd114356
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 16:00:12 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p19N4jD0014078
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 16:04:45 -0700
Subject: Re: [PATCH 2/6] nvram: Capture oops/panic reports in ibm, oops-log
	partition
From: Jim Keniston <jkenisto@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1297054887.14982.55.camel@pasglop>
References: <20101114041510.9457.92921.stgit@localhost.localdomain>
	<20101114041521.9457.69485.stgit@localhost.localdomain>
	<1297054887.14982.55.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Feb 2011 15:00:09 -0800
Message-ID: <1297292409.3108.38.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-02-07 at 16:01 +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2010-11-13 at 20:15 -0800, Jim Keniston wrote:
> > Create the ibm,oops-log NVRAM partition, and capture the end of the printk
> > buffer in it when there's an oops or panic.  If we can't create the
> > ibm,oops-log partition, capture the oops/panic report in ibm,rtas-log.

I've appended an updated patch that addresses your comments and applies
to 2.6.38-rc4.

> 
> Won't the parsing tools choke on the oops log in the RTAS log
> partition ?

I don't think that that will be a problem, because pSeries_log_error()
doesn't log errors that aren't of type ERR_TYPE_RTAS_LOG.

However, I did add code to ensure that even if ibm,rtas-log is used for
both RTAS errors and oops reports, an oops report won't overwrite a
recently captured RTAS event that hasn't yet been read into the
filesystem (e.g., by rtas_errd).

> 
> Also, maybe remove the "ibm," prefix on the nvram partition, make it
> "lnx," instead.

Done.

> 
> Then, if you move the rest of the code out of pseries, you can move that
> out too, just make pseries platform code call the init code for it, that
> way other platforms can re-use that as-is.
> 
> But that later part can wait a separate patch series,

Agreed.

> just make sure you
> change the partition name now.

Still done.

> 
> Cheers,
> Ben.

Here's my revised patch.
Jim
=====
Capture oops/panic reports in lnx,oops-log partition

Create the lnx,oops-log NVRAM partition, and capture the end of the printk
buffer in it when there's an oops or panic.  If we can't create the
lnx,oops-log partition, capture the oops/panic report in ibm,rtas-log.

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
---

 arch/powerpc/platforms/pseries/nvram.c |  118 +++++++++++++++++++++++++++++++-
 1 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index befb41b..419707b 100644
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
@@ -39,7 +41,7 @@ struct nvram_os_partition {
 	const char *name;
 	int req_size;	/* desired size, in bytes */
 	int min_size;	/* minimum acceptable size (0 means req_size) */
-	long size;	/* size of data portion of partition */
+	long size;	/* size of data portion (excluding err_log_info) */
 	long index;	/* offset of data portion of partition */
 };
 
@@ -50,11 +52,35 @@ static struct nvram_os_partition rtas_log_partition = {
 	.index = -1
 };
 
+static struct nvram_os_partition oops_log_partition = {
+	.name = "lnx,oops-log",
+	.req_size = 4000,
+	.min_size = 2000,
+	.index = -1
+};
+
 static const char *pseries_nvram_os_partitions[] = {
 	"ibm,rtas-log",
+	"lnx,oops-log",
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
+/* See clobbering_unread_rtas_event() */
+#define NVRAM_RTAS_READ_TIMEOUT 5		/* seconds */
+static unsigned long last_unread_rtas_event;	/* timestamp */
+
+/* We preallocate oops_buf during init to avoid kmalloc during oops/panic. */
+static char *oops_buf;
+
 static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
 {
 	unsigned int i;
@@ -214,8 +240,11 @@ int nvram_write_os_partition(struct nvram_os_partition *part, char * buff,
 int nvram_write_error_log(char * buff, int length,
                           unsigned int err_type, unsigned int error_log_cnt)
 {
-	return nvram_write_os_partition(&rtas_log_partition, buff, length,
+	int rc = nvram_write_os_partition(&rtas_log_partition, buff, length,
 						err_type, error_log_cnt);
+	if (!rc)
+		last_unread_rtas_event = get_seconds();
+	return rc;
 }
 
 /* nvram_read_error_log
@@ -274,6 +303,7 @@ int nvram_clear_error_log(void)
 		printk(KERN_ERR "nvram_clear_error_log: Failed nvram_write (%d)\n", rc);
 		return rc;
 	}
+	last_unread_rtas_event = 0;
 
 	return 0;
 }
@@ -342,9 +372,35 @@ static int __init pseries_nvram_init_os_partition(struct nvram_os_partition
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
+	oops_buf = kmalloc(oops_log_partition.size, GFP_KERNEL);
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
 machine_arch_initcall(pseries, pseries_nvram_init_log_partitions);
@@ -378,3 +434,59 @@ int __init pSeries_nvram_init(void)
 
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
+/*
+ * Are we using the ibm,rtas-log for oops/panic reports?  And if so,
+ * would logging this oops/panic overwrite an RTAS event that rtas_errd
+ * hasn't had a chance to read and process?  Return 1 if so, else 0.
+ *
+ * We assume that if rtas_errd hasn't read the RTAS event in
+ * NVRAM_RTAS_READ_TIMEOUT seconds, it's probably not going to.
+ */
+static int clobbering_unread_rtas_event(void)
+{
+	return (oops_log_partition.index == rtas_log_partition.index
+		&& last_unread_rtas_event
+		&& get_seconds() - last_unread_rtas_event <=
+						NVRAM_RTAS_READ_TIMEOUT);
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
+	if (clobbering_unread_rtas_event())
+		return;
+
+	text_len = capture_last_msgs(old_msgs, old_len, new_msgs, new_len,
+					oops_buf, oops_log_partition.size);
+	(void) nvram_write_os_partition(&oops_log_partition, oops_buf,
+		(int) text_len, ERR_TYPE_KERNEL_PANIC, ++oops_count);
+}
