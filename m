Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22D571A1958
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 17:51:55 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DD4E1140BB3
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2016 17:51:54 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 20 Jan 2016 16:51:54 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E4EE63578056
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2016 17:51:50 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0K6pKXk45678708
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2016 17:51:28 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0K6pIxF032160
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2016 17:51:18 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u0K6pI3u031345
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2016 17:51:18 +1100
Received: from ajd.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 by ozlabs.au.ibm.com (Postfix) with ESMTP id 1008AA01A1
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2016 17:50:24 +1100 (AEDT)
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/powernv: new function to access OPAL msglog
Date: Wed, 20 Jan 2016 17:50:17 +1100
Message-Id: <1453272618-1083-1-git-send-email-andrew.donnellan@au1.ibm.com>
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
that copies to an arbitrary buffer.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/include/asm/opal.h              |  2 ++
 arch/powerpc/platforms/powernv/opal-msglog.c | 15 +++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 07a99e6..3f6cb85 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -273,6 +273,8 @@ void opal_free_sg_list(struct opal_sg_list *sg);
 
 extern int opal_error_code(int rc);
 
+ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_OPAL_H */
diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
index 44ed78a..a06191c 100644
--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -31,11 +31,11 @@ struct memcons {
 	__be32 in_cons;
 };
 
-static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
-				struct bin_attribute *bin_attr, char *to,
-				loff_t pos, size_t count)
+static struct bin_attribute opal_msglog_attr;
+
+ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count)
 {
-	struct memcons *mc = bin_attr->private;
+	struct memcons *mc = opal_msglog_attr.private;
 	const char *conbuf;
 	ssize_t ret;
 	size_t first_read = 0;
@@ -91,6 +91,13 @@ out:
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
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
