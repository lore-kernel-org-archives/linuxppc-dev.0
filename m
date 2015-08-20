Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22a.google.com (mail-yk0-x22a.google.com
 [IPv6:2607:f8b0:4002:c07::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F3DB1A0175
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 22:15:01 +1000 (AEST)
Received: by ykdt205 with SMTP id t205so35180964ykd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 05:14:59 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/8] jump_label: make it possible for the archs to invoke
 jump_label_init() much earlier
Date: Thu, 20 Aug 2015 20:14:30 +0800
Message-Id: <1440072876-8321-3-git-send-email-haokexin@gmail.com>
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

For some archs (such as powerpc) would want to invoke jump_label_init()
in a much earlier stage. So check static_key_initialized in order to
make sure this function run only once.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 kernel/jump_label.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index df1a7fbe7cd5..fcae370f8794 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -205,6 +205,9 @@ void __init jump_label_init(void)
 	struct static_key *key = NULL;
 	struct jump_entry *iter;
 
+	if (static_key_initialized)
+		return;
+
 	jump_label_sort_entries(iter_start, iter_stop);
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
-- 
2.1.0
