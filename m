Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1649F1A0976
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 19:23:04 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 23 Jul 2014 14:53:00 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 0005FE004C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 14:54:35 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6N9OjlE3539200
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 14:54:46 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6N9MsGN016161
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 14:52:54 +0530
Received: from hegdevasant.in.ibm.com (hegdevasant.in.ibm.com [9.124.35.88]
 (may be forged))
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s6N9MsBj016124
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 14:52:54 +0530
Subject: [PATCH 2/2] powerpc/powernv: Improve error message
To: linuxppc-dev@lists.ozlabs.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Wed, 23 Jul 2014 14:52:53 +0530
Message-ID: <20140723092246.4740.47235.stgit@hegdevasant.in.ibm.com>
In-Reply-To: <20140723092236.4740.33763.stgit@hegdevasant.in.ibm.com>
References: <20140723092236.4740.33763.stgit@hegdevasant.in.ibm.com>
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
