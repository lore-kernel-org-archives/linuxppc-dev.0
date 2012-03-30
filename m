Return-Path: <kaffeemonster@googlemail.com>
Received: from uhura.skim.hs-owl.de (uhura.skim.hs-owl.de [193.174.118.81])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D5368B6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 04:12:56 +1100 (EST)
Message-ID: <4F75CC63.10405@googlemail.com>
Date: Fri, 30 Mar 2012 17:08:19 +0200
From: Jan Seiffert <kaffeemonster@googlemail.com>
MIME-Version: 1.0
To: <netdev@vger.kernel.org>
Subject: [REGRESSION][PATCH V4 1/3] bpf jit: Make the filter.c::__load_pointer
 helper non-static  for the jits
References: <4F75CA89.4010709@googlemail.com>
In-Reply-To: <4F75CA89.4010709@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Eric Dumazet <eric.dumazet@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Matt Evans <matt@ozlabs.org>, "David S.
 Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function is renamed to make it a little more clear what it does.
It is not added to any .h because it is not for general consumption, only for
bpf internal use (and so by the jits).

Signed-of-by: Jan Seiffert <kaffeemonster@googlemail.com>

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -40,8 +40,12 @@
 #include <linux/reciprocal_div.h>
 #include <linux/ratelimit.h>
 
-/* No hurry in this branch */
-static void *__load_pointer(const struct sk_buff *skb, int k, unsigned int size)
+/*
+ * No hurry in this branch
+ *
+ * Exported for the bpf jit load helper.
+ */
+void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, unsigned int size)
 {
 	u8 *ptr = NULL;
 
@@ -60,7 +64,7 @@ static inline void *load_pointer(const struct sk_buff *skb, int k,
 {
 	if (k >= 0)
 		return skb_header_pointer(skb, k, size, buffer);
-	return __load_pointer(skb, k, size);
+	return bpf_internal_load_pointer_neg_helper(skb, k, size);
 }
 
 /**
