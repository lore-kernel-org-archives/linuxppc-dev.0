Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF1BF1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 13:09:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 23 Sep 2015 13:09:01 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 90E222BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 13:08:57 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8N38ngx35913852
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 13:08:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8N38Ofq009559
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 13:08:24 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Ian Munsie <imunsie@au1.ibm.com>, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>, Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: [PATCH] cxl: Fix lockdep warning while creating afu_err_buff attribute
Date: Wed, 23 Sep 2015 08:37:59 +0530
Message-Id: <1442977679-4468-1-git-send-email-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Presently a lockdep warning is reported during creation of afu_err_buff
bin_attribute for the afu. This is caused due to the variable attr.key
not pointing to a static class key, hence the function lockdep_init_map
reports this warning:

 BUG: key <some-address> not in .data!

The patch fixes this issue by calling sysfs_attr_init on the
attr_eb.attr structure before populating it with the afu_err_buff file
details. This will populate the attr.key variable with a static class
key so that lockdep_init_map stops complaining about the lockdep key not
being static.

Reported-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 25868c2..02006f7 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -592,6 +592,8 @@ int cxl_sysfs_afu_add(struct cxl_afu *afu)
 
 	/* conditionally create the add the binary file for error info buffer */
 	if (afu->eb_len) {
+		sysfs_attr_init(&afu->attr_eb.attr);
+
 		afu->attr_eb.attr.name = "afu_err_buff";
 		afu->attr_eb.attr.mode = S_IRUGO;
 		afu->attr_eb.size = afu->eb_len;
-- 
2.2.1
