Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BC811A0D7D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 09:06:13 +1000 (AEST)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 793CC1402BF
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2015 09:06:12 +1000 (AEST)
Received: by pactm7 with SMTP id tm7so157656059pac.2
 for <linuxppc-dev@ozlabs.org>; Thu, 09 Jul 2015 16:06:09 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH] cxl: Check if afu is not null in cxl_slbia
Date: Fri, 10 Jul 2015 09:04:25 +1000
Message-Id: <1436483065-9202-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pointer to an AFU in the adapter's list of AFUs can be null
if we're in the process of removing AFUs. The afu_list_lock
doesn't guard against this.

Say we have 2 slices, and we're in the process of removing cxl.
 - We remove the AFUs in order (see cxl_remove). In cxl_remove_afu
   for AFU 0, we take the lock, set adapter->afu[0] = NULL, and
   release the lock.
 - Then we get an slbia. In cxl_slbia we take the lock, and set
   afu = adapter->afu[0], which is NULL.
 - Therefore our attempt to check afu->enabled will blow up.

Therefore, check if afu is a null pointer before dereferencing it.

cc: STABLE
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index 11a2044d6b0f..5bcd676bfd59 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -86,7 +86,7 @@ static inline void cxl_slbia_core(struct mm_struct *mm)
 		spin_lock(&adapter->afu_list_lock);
 		for (slice = 0; slice < adapter->slices; slice++) {
 			afu = adapter->afu[slice];
-			if (!afu->enabled)
+			if (!afu || !afu->enabled)
 				continue;
 			rcu_read_lock();
 			idr_for_each_entry(&afu->contexts_idr, ctx, id)
-- 
2.1.4
