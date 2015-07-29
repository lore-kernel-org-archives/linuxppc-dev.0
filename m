Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 895E51A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 14:09:33 +1000 (AEST)
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 357D8140D2E
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 14:09:31 +1000 (AEST)
Received: by pdbnt7 with SMTP id nt7so81758145pdb.0
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 21:09:30 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH] cxl: Don't ignore add_process_element result when attaching
 context
Date: Wed, 29 Jul 2015 14:07:22 +1000
Message-Id: <1438142842-31603-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously, when attaching a context in dedicated mode, we ignored
the result of add_process_element, which could potentially fail.

If add_process_element returns and error, pass it back to the caller.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

I'm not sure if this is worth sending to stable: it doesn't fix
any actual bug, it just lets us know earlier if we've failed.

However, if mpe, Mikey or Ian feel like it should go to stable I
have no objection to that either.
---
 drivers/misc/cxl/native.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index debd97147b58..22c06d91faa8 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -551,9 +551,7 @@ static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
 	if ((result = cxl_afu_check_and_enable(ctx->afu)))
 		return result;
 
-	add_process_element(ctx);
-
-	return 0;
+	return add_process_element(ctx);
 }
 
 static int deactivate_afu_directed(struct cxl_afu *afu)
-- 
2.1.4
