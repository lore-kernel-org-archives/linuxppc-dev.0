Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415511A0585
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 09:28:49 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EA85B1404A8
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 09:28:48 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 19 Aug 2015 09:28:48 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8E0D92CE8056
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 09:28:44 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7INSb1G4129270
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 09:28:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7INSANs026383
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 09:28:11 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: dja@axtens.net, mpe@ellerman.id.au, benh@kernel.crashing.org,
 mikey@neuling.org, imunsie@au1.ibm.com,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH V2] cxl: Allow release of contexts which have been OPENED but
 not STARTED
Date: Wed, 19 Aug 2015 09:27:18 +1000
Message-Id: <1439940438-3585-1-git-send-email-andrew.donnellan@au1.ibm.com>
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

Allow releasing contexts in any state with a value lower than STARTED, i.e.
OPENED or CLOSED (we can't release a STARTED context as it's currently
using the hardware, and we assume that contexts in any new states which may
be added in future with a value higher than STARTED are also unsafe to
release).

Cc: stable@vger.kernel.org
Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 6a768a9..f49e3e5 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -59,7 +59,7 @@ EXPORT_SYMBOL_GPL(cxl_get_phys_dev);
 
 int cxl_release_context(struct cxl_context *ctx)
 {
-	if (ctx->status != CLOSED)
+	if (ctx->status >= STARTED)
 		return -EBUSY;
 
 	put_device(&ctx->afu->dev);
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
