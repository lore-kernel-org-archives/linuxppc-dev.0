Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A4181A032C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 18:19:31 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2714114031D
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2016 18:19:31 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 9 Feb 2016 17:19:29 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B08BC2BB004D
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2016 18:19:25 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u197JHj661276168
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Feb 2016 18:19:25 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u197Iruj012523
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Feb 2016 18:18:53 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, stewart@linux.vnet.ibm.com
Subject: [PATCH V2 1/2] powerpc/powernv: new function to access OPAL msglog
Date: Tue,  9 Feb 2016 18:17:48 +1100
Message-Id: <1455002269-26543-1-git-send-email-andrew.donnellan@au1.ibm.com>
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

Changes V1->V2:
- Incorporate comments from mpe
- Move the memcons pointer out of the bin_attribute struct
- Decouple memcons init from sysfs init
---
 arch/powerpc/include/asm/opal.h              |  3 +++
 arch/powerpc/platforms/powernv/opal-msglog.c | 29 ++++++++++++++++++----------
 arch/powerpc/platforms/powernv/opal.c        |  7 +++++--
 3 files changed, 27 insertions(+), 12 deletions(-)

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
index 44ed78a..59fa6e1 100644
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
@@ -117,8 +123,11 @@ void __init opal_msglog_init(void)
 		return;
 	}
 
-	opal_msglog_attr.private = mc;
+	opal_memcons = mc;
+}
 
+void __init opal_msglog_sysfs_init(void)
+{
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
