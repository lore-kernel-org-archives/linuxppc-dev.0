Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22d.google.com (mail-yk0-x22d.google.com
 [IPv6:2607:f8b0:4002:c07::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E974E1A0226
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 22:14:57 +1000 (AEST)
Received: by ykll84 with SMTP id l84so35020910ykl.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 05:14:55 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/8] jump_label: no need to acquire the jump_label_mutex in
 jump_lable_init()
Date: Thu, 20 Aug 2015 20:14:29 +0800
Message-Id: <1440072876-8321-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
References: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The jump_label_init() run in a very early stage, even before the
sched_init(). So there is no chance for concurrent access of the
jump label table.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 kernel/jump_label.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index f7dd15d537f9..df1a7fbe7cd5 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -205,7 +205,6 @@ void __init jump_label_init(void)
 	struct static_key *key = NULL;
 	struct jump_entry *iter;
 
-	jump_label_lock();
 	jump_label_sort_entries(iter_start, iter_stop);
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
@@ -229,7 +228,6 @@ void __init jump_label_init(void)
 #endif
 	}
 	static_key_initialized = true;
-	jump_label_unlock();
 }
 
 #ifdef CONFIG_MODULES
-- 
2.1.0
