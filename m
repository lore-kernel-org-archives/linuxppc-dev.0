Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22c.google.com (mail-yk0-x22c.google.com
 [IPv6:2607:f8b0:4002:c07::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 237EB1A1D75
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 22:15:05 +1000 (AEST)
Received: by ykll84 with SMTP id l84so35024141ykl.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 05:15:03 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/8] jump_label: introduce DEFINE_STATIC_KEY_{TRUE,
 FALSE}_ARRAY macros
Date: Thu, 20 Aug 2015 20:14:31 +0800
Message-Id: <1440072876-8321-4-git-send-email-haokexin@gmail.com>
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

These are used to define a static_key_{true,false} array.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 include/linux/jump_label.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 7f653e8f6690..5c1d6a49dd6b 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -267,6 +267,12 @@ struct static_key_false {
 #define DEFINE_STATIC_KEY_FALSE(name)	\
 	struct static_key_false name = STATIC_KEY_FALSE_INIT
 
+#define DEFINE_STATIC_KEY_TRUE_ARRAY(name, n)	\
+	struct static_key_true name[n] = { [0 ... n - 1] = STATIC_KEY_TRUE_INIT }
+
+#define DEFINE_STATIC_KEY_FALSE_ARRAY(name, n)	\
+	struct static_key_false name[n] = { [0 ... n - 1] = STATIC_KEY_FALSE_INIT }
+
 #ifdef HAVE_JUMP_LABEL
 
 /*
-- 
2.1.0
