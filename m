Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 932281A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 12:14:29 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6328B140297
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2016 12:14:29 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 18 Feb 2016 11:14:28 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C35052BB0055
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2016 12:14:25 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1I1EHhO1245568
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2016 12:14:25 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1I1DrkH014326
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2016 12:13:53 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1I1DrDW013583
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2016 12:13:53 +1100
Received: from ajd.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 by ozlabs.au.ibm.com (Postfix) with ESMTP id B6842A01B6
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2016 12:12:58 +1100 (AEDT)
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/powernv: don't create OPAL msglog sysfs entry if
 memcons init fails
Date: Thu, 18 Feb 2016 12:12:54 +1100
Message-Id: <1455757974-4315-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When initialising OPAL interfaces, there is a possibility that
opal_msglog_init() may fail to initialise the msglog/memory console.

Fix opal_msglog_sysfs_init() so it doesn't try to create sysfs entry for
the msglog if this occurs.

Suggested-by: Joel Stanley <joel@jms.id.au>
Fixes: 9b4fffa14906 ("powerpc/powernv: new function to access OPAL msglog")
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-msglog.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
index 59fa6e1..39d6ff9 100644
--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -128,6 +128,11 @@ void __init opal_msglog_init(void)
 
 void __init opal_msglog_sysfs_init(void)
 {
+	if (!opal_memcons) {
+		pr_warn("OPAL: message log initialisation failed, not creating sysfs entry\n");
+		return;
+	}
+
 	if (sysfs_create_bin_file(opal_kobj, &opal_msglog_attr) != 0)
 		pr_warn("OPAL: sysfs file creation failed\n");
 }
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
