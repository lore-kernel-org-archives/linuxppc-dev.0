Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECC6F1A0153
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 16:31:26 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B7F3114032E
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2015 16:31:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 18 Aug 2015 16:31:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3E3143578052
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2015 16:31:21 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7I6VCL165732616
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2015 16:31:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7I6UlkU009635
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2015 16:30:48 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: dja@axtens.net, mpe@ellerman.id.au, benh@kernel.crashing.org,
 mikey@neuling.org, imunsie@au1.ibm.com,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH] cxl: Allow release of contexts which have been OPENED but not
 STARTED
Date: Tue, 18 Aug 2015 16:30:15 +1000
Message-Id: <1439879415-9925-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we open a context but do not start it (either because we do not attempt
to start it, or because it fails to start for some reason), we are left
with a context in state OPENED. Previously, cxl_release_context() only
allowed releasing contexts in state CLOSED, so attempting to release an
OPENED context would fail.

In particular, this bug causes available contexts to run out after some EEH
failures, where drivers attempt to release contexts that have failed to
start.

Allow releasing contexts in any state other than STARTED, i.e. OPENED or
CLOSED (we can't release a STARTED context as it's currently using the
hardware).

Cc: stable@vger.kernel.org
Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 6a768a9..1c520b8 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -59,7 +59,7 @@ EXPORT_SYMBOL_GPL(cxl_get_phys_dev);
 
 int cxl_release_context(struct cxl_context *ctx)
 {
-	if (ctx->status != CLOSED)
+	if (ctx->status == STARTED)
 		return -EBUSY;
 
 	put_device(&ctx->afu->dev);
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
