Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C9721A00BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 18:38:06 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 68750140B8C
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 18:38:06 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 11 Feb 2016 17:38:06 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BAF612CE8054
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 18:38:04 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1B7bqWx43843586
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 18:38:00 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1B7bV91012840
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 18:37:32 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Cc: stewart@linux.vnet.ibm.com, joel@jms.id.au
Subject: [PATCH V3 1/2] powerpc/powernv: new function to access OPAL msglog
Date: Thu, 11 Feb 2016 18:36:19 +1100
Message-Id: <1455176180-19670-1-git-send-email-andrew.donnellan@au1.ibm.com>
In-Reply-To: <1455002269-26543-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1455002269-26543-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the OPAL msglog/console buffer is exposed as a sysfs file, with
the sysfs read handler responsible for retrieving the log from the OPAL
buffer. We'd like to be able to use it in xmon as well.

Refactor the OPAL msglog code to create a new function, opal_msglog_copy(),
that copies to an arbitrary buffer. Separate the initialisation code into
generic memcons init and sysfs file creation.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Changes V2->V3:
- incorporate comments from Joel Stanley
- opal_msglog_sysfs_init() now bails out if opal_memcons isn't set

Changes V1->V2:
- Incorporate comments from mpe
- Move the memcons pointer out of the bin_attribute struct
- Decouple memcons init from sysfs init
---
 arch/powerpc/include/asm/opal.h              |  3 +++
 arch/powerpc/platforms/powernv/opal-msglog.c | 34 ++++++++++++++++++++--------
 arch/powerpc/platforms/powernv/opal.c        |  7 ++++--
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 07a99e6..9d86c66 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -248,6 +248,7 @@ extern int opal_elog_init(void);
 extern void opal_platform_dump_init(void);
 extern void opal_sys_param_init(void);
 extern void opal_msglog_init(void);
+extern void opal_msglog_sysfs_init(void);
 extern int opal_async_comp_init(void);
 extern int opal_sensor_init(void);
 extern int opal_hmi_handler_init(void);
@@ -273,6 +274,8 @@ void opal_free_sg_list(struct opal_sg_list *sg);
 
 extern int opal_error_code(int rc);
 
+ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_OPAL_H */
diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
index 44ed78a..c7a8f72 100644
--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -31,26 +31,25 @@ struct memcons {
 	__be32 in_cons;
 };
 
-static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
-				struct bin_attribute *bin_attr, char *to,
-				loff_t pos, size_t count)
+static struct memcons *opal_memcons = NULL;
+
+ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count)
 {
-	struct memcons *mc = bin_attr->private;
 	const char *conbuf;
 	ssize_t ret;
 	size_t first_read = 0;
 	uint32_t out_pos, avail;
 
-	if (!mc)
+	if (!opal_memcons)
 		return -ENODEV;
 
-	out_pos = be32_to_cpu(ACCESS_ONCE(mc->out_pos));
+	out_pos = be32_to_cpu(ACCESS_ONCE(opal_memcons->out_pos));
 
 	/* Now we've read out_pos, put a barrier in before reading the new
 	 * data it points to in conbuf. */
 	smp_rmb();
 
-	conbuf = phys_to_virt(be64_to_cpu(mc->obuf_phys));
+	conbuf = phys_to_virt(be64_to_cpu(opal_memcons->obuf_phys));
 
 	/* When the buffer has wrapped, read from the out_pos marker to the end
 	 * of the buffer, and then read the remaining data as in the un-wrapped
@@ -58,7 +57,7 @@ static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
 	if (out_pos & MEMCONS_OUT_POS_WRAP) {
 
 		out_pos &= MEMCONS_OUT_POS_MASK;
-		avail = be32_to_cpu(mc->obuf_size) - out_pos;
+		avail = be32_to_cpu(opal_memcons->obuf_size) - out_pos;
 
 		ret = memory_read_from_buffer(to, count, &pos,
 				conbuf + out_pos, avail);
@@ -76,7 +75,7 @@ static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
 	}
 
 	/* Sanity check. The firmware should not do this to us. */
-	if (out_pos > be32_to_cpu(mc->obuf_size)) {
+	if (out_pos > be32_to_cpu(opal_memcons->obuf_size)) {
 		pr_err("OPAL: memory console corruption. Aborting read.\n");
 		return -EINVAL;
 	}
@@ -91,6 +90,13 @@ out:
 	return ret;
 }
 
+static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
+				struct bin_attribute *bin_attr, char *to,
+				loff_t pos, size_t count)
+{
+	return opal_msglog_copy(to, pos, count);
+}
+
 static struct bin_attribute opal_msglog_attr = {
 	.attr = {.name = "msglog", .mode = 0444},
 	.read = opal_msglog_read
@@ -117,8 +123,16 @@ void __init opal_msglog_init(void)
 		return;
 	}
 
-	opal_msglog_attr.private = mc;
+	opal_memcons = mc;
+}
 
+void __init opal_msglog_sysfs_init(void)
+{
+	if (!opal_memcons) {
+		pr_warn("OPAL: message log initialisation failed, not creating sysfs entry\n");
+		return;
+	}
+	
 	if (sysfs_create_bin_file(opal_kobj, &opal_msglog_attr) != 0)
 		pr_warn("OPAL: sysfs file creation failed\n");
 }
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 4e0da5a..0256d07 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -724,6 +724,9 @@ static int __init opal_init(void)
 		of_node_put(leds);
 	}
 
+	/* Initialise OPAL message log interface */
+	opal_msglog_init();
+
 	/* Create "opal" kobject under /sys/firmware */
 	rc = opal_sysfs_init();
 	if (rc == 0) {
@@ -739,8 +742,8 @@ static int __init opal_init(void)
 		opal_platform_dump_init();
 		/* Setup system parameters interface */
 		opal_sys_param_init();
-		/* Setup message log interface. */
-		opal_msglog_init();
+		/* Setup message log sysfs interface. */
+		opal_msglog_sysfs_init();
 	}
 
 	/* Initialize platform devices: IPMI backend, PRD & flash interface */
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
