Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F3342C0126
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 12:26:57 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 7 Aug 2013 12:23:49 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BE18E2BB004F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 12:25:25 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r772PE3l64749646
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Aug 2013 12:25:15 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r772POBF029197
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Aug 2013 12:25:24 +1000
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: Add procfs entry for PowerNV
Date: Tue,  6 Aug 2013 22:25:14 -0400
Message-Id: <1375842314-26555-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: Mike Qiu <qiudayu@linux.vnet.ibm.com>, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The procfs entry for global statistics has been missed on PowerNV
platform and the patch is going to add that.

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 39954fe..0e12bb1 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1063,7 +1063,7 @@ static const struct file_operations proc_eeh_operations = {
 
 static int __init eeh_init_proc(void)
 {
-	if (machine_is(pseries))
+	if (machine_is(pseries) || machine_is(powernv))
 		proc_create("powerpc/eeh", 0, NULL, &proc_eeh_operations);
 	return 0;
 }
-- 
1.8.2.1
