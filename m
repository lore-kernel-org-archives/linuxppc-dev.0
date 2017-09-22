Return-Path: <srs0=myp6=ax=flex--wak.bounces.google.com=3i6pfwqmkdlwycmiqqing.eqonkpwzrre-fgxq1ncdu.qti@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzVmH6yQLzDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Sep 2017 09:58:07 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xzVmH6Pksz8vpg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Sep 2017 09:58:07 +1000 (AEST)
Received: from mail-oi0-x249.google.com (mail-oi0-x249.google.com
 [IPv6:2607:f8b0:4003:c06::249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xzVmG6JnRz9sNw
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2017 09:58:06 +1000 (AEST)
Received: by mail-oi0-x249.google.com with SMTP id t11so222590oib.22
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2017 16:58:05 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 22 Sep 2017 16:58:00 -0700
Message-Id: <20170922235800.19348-1-wak@google.com>
Subject: [PATCH] powerpc/opal: Fix EBUSY bug in acquiring tokens
From: "William A. Kennington III" <wak@google.com>
To: linuxppc-dev@ozlabs.org
Cc: rlippert@google.com, wak@google.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current code checks the completion map to look for the first token
that is complete. In some cases, a completion can come in but the token
can still be on lease to the caller processing the completion. If this
completed but unreleased token is the first token found in the bitmap by
another tasks trying to acquire a token, then the __test_and_set_bit
call will fail since the token will still be on lease. The acquisition
will then fail with an EBUSY.

This patch reorganizes the acquisition code to look at the
opal_async_token_map for an unleased token. If the token has no lease it
must have no outstanding completions so we should never see an EBUSY,
unless we have leased out too many tokens. Since
opal_async_get_token_inrerruptible is protected by a semaphore, we will
practically never see EBUSY anymore.

Signed-off-by: William A. Kennington III <wak@google.com>
---
 arch/powerpc/platforms/powernv/opal-async.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
index cf33769a7b72..45b3feb8aa2f 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -39,18 +39,18 @@ int __opal_async_get_token(void)
 	int token;
 
 	spin_lock_irqsave(&opal_async_comp_lock, flags);
-	token = find_first_bit(opal_async_complete_map, opal_max_async_tokens);
+	token = find_first_zero_bit(opal_async_token_map, opal_max_async_tokens);
 	if (token >= opal_max_async_tokens) {
 		token = -EBUSY;
 		goto out;
 	}
 
-	if (__test_and_set_bit(token, opal_async_token_map)) {
+	if (!__test_and_clear_bit(token, opal_async_complete_map)) {
 		token = -EBUSY;
 		goto out;
 	}
 
-	__clear_bit(token, opal_async_complete_map);
+	__set_bit(token, opal_async_token_map);
 
 out:
 	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
-- 
2.14.1.821.g8fa685d3b7-goog
