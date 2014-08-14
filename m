Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 151D01A0209
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 16:46:46 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 14 Aug 2014 12:16:43 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 89EA4394001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 12:16:41 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7E6l25861931752
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 12:17:03 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7E6keH7010218
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 12:16:40 +0530
Subject: [PATCH] powerpc/powernv: Improve error message
To: linuxppc-dev@lists.ozlabs.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Thu, 14 Aug 2014 12:16:39 +0530
Message-ID: <20140814064607.26449.16899.stgit@hegdevasant.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Presently we only support initiating Service Processor dump from host.
Hence update sysfs message. Also update couple of other error/info
messages.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
Ben,
  This patch applies cleanly on top of powerpc next branch.

Vasant

 arch/powerpc/platforms/powernv/opal-dump.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 788a197..3e33e28 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -112,7 +112,7 @@ static ssize_t init_dump_show(struct dump_obj *dump_obj,
 			      struct dump_attribute *attr,
 			      char *buf)
 {
-	return sprintf(buf, "1 - initiate dump\n");
+	return sprintf(buf, "1 - initiate Service Processor(FSP) dump\n");
 }
 
 static int64_t dump_fips_init(uint8_t type)
@@ -121,7 +121,7 @@ static int64_t dump_fips_init(uint8_t type)
 
 	rc = opal_dump_init(type);
 	if (rc)
-		pr_warn("%s: Failed to initiate FipS dump (%d)\n",
+		pr_warn("%s: Failed to initiate FSP dump (%d)\n",
 			__func__, rc);
 	return rc;
 }
@@ -131,8 +131,12 @@ static ssize_t init_dump_store(struct dump_obj *dump_obj,
 			       const char *buf,
 			       size_t count)
 {
-	dump_fips_init(DUMP_TYPE_FSP);
-	pr_info("%s: Initiated FSP dump\n", __func__);
+	int rc;
+
+	rc = dump_fips_init(DUMP_TYPE_FSP);
+	if (rc == OPAL_SUCCESS)
+		pr_info("%s: Initiated FSP dump\n", __func__);
+
 	return count;
 }
 
@@ -297,7 +301,7 @@ static ssize_t dump_attr_read(struct file *filep, struct kobject *kobj,
 			 * and rely on userspace to ask us to try
 			 * again.
 			 */
-			pr_info("%s: Platform dump partially read.ID = 0x%x\n",
+			pr_info("%s: Platform dump partially read. ID = 0x%x\n",
 				__func__, dump->id);
 			return -EIO;
 		}
