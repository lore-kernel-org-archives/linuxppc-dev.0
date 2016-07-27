Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtg2GsdzDrLK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 13/21] jump_label: Make it possible for arches to invoke
 jump_label_init() earlier
Date: Thu, 28 Jul 2016 00:18:09 +1000
Message-Id: <1469629097-30859-13-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kevin Hao <haokexin@gmail.com>

Some arches (powerpc at least) would like to invoke jump_label_init()
much earlier in boot. So check static_key_initialized in order to make
sure this function runs only once.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 kernel/jump_label.c | 3 +++
 1 file changed, 3 insertions(+)

v3: Updated change log.

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 05254eeb4b4e..14d81315fd7e 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -205,6 +205,9 @@ void __init jump_label_init(void)
 	struct static_key *key = NULL;
 	struct jump_entry *iter;
 
+	if (static_key_initialized)
+		return;
+
 	jump_label_lock();
 	jump_label_sort_entries(iter_start, iter_stop);
 
-- 
2.7.4
