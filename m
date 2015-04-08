Return-Path: <khlebnikov@yandex-team.ru>
Received: from forward-corp1g.mail.yandex.net (forward-corp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B0EB1A09F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 03:04:38 +1000 (AEST)
Subject: [PATCH] of: return NUMA_NO_NODE from fallback of_node_to_nid()
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Date: Wed, 08 Apr 2015 19:59:20 +0300
Message-ID: <20150408165920.25007.6869.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Node 0 might be offline as well as any other numa node,
in this case kernel cannot handle memory allocation and crashes.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: 0c3f061c195c ("of: implement of_node_to_nid as a weak function")
---
 drivers/of/base.c  |    2 +-
 include/linux/of.h |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8f165b112e03..51f4bd16e613 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -89,7 +89,7 @@ EXPORT_SYMBOL(of_n_size_cells);
 #ifdef CONFIG_NUMA
 int __weak of_node_to_nid(struct device_node *np)
 {
-	return numa_node_id();
+	return NUMA_NO_NODE;
 }
 #endif
 
diff --git a/include/linux/of.h b/include/linux/of.h
index dfde07e77a63..78a04ee85a9c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -623,7 +623,10 @@ static inline const char *of_prop_next_string(struct property *prop,
 #if defined(CONFIG_OF) && defined(CONFIG_NUMA)
 extern int of_node_to_nid(struct device_node *np);
 #else
-static inline int of_node_to_nid(struct device_node *device) { return 0; }
+static inline int of_node_to_nid(struct device_node *device)
+{
+	return NUMA_NO_NODE;
+}
 #endif
 
 static inline struct device_node *of_find_matching_node(
