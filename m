Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 63D7DDDFC7
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:46:10 +1100 (EST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id
	592E285712
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:46:09 -0500 (EST)
Received: from thinkcentre (unknown [67.9.156.46]) by
	a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPA id 0658D85711
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:46:08 -0500 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] convert sysfs cache code to of_find_next_cache_node()
Date: Wed, 10 Dec 2008 18:46:06 -0600
Message-Id: <1228956366-17593-3-git-send-email-ntl@pobox.com>
In-Reply-To: <1228956366-17593-1-git-send-email-ntl@pobox.com>
References: <1228956366-17593-1-git-send-email-ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Using the common code means that more complete cache information will
provided in sysfs on platforms that don't use the l2-cache property
convention.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/sysfs.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 20885a3..0c64f10 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -566,7 +566,6 @@ static bool cache_is_unified(struct device_node *np)
 
 static struct cache_desc * __cpuinit create_cache_index_info(struct device_node *np, struct kobject *parent, int index, int level)
 {
-	const phandle *next_cache_phandle;
 	struct device_node *next_cache;
 	struct cache_desc *new, **end;
 
@@ -591,11 +590,7 @@ static struct cache_desc * __cpuinit create_cache_index_info(struct device_node
 	while (*end)
 		end = &(*end)->next;
 
-	next_cache_phandle = of_get_property(np, "l2-cache", NULL);
-	if (!next_cache_phandle)
-		goto out;
-
-	next_cache = of_find_node_by_phandle(*next_cache_phandle);
+	next_cache = of_find_next_cache_node(np);
 	if (!next_cache)
 		goto out;
 
-- 
1.5.5
