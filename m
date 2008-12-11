Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 77194DDFCD
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 17:16:12 +1100 (EST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id
	58A2886E93
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 01:16:09 -0500 (EST)
Received: from thinkcentre (unknown [67.9.156.46]) by
	a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPA id ECA4486E91
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 01:16:07 -0500 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3 v2] convert cpu_to_l2cache() to of_find_next_cache_node()
Date: Thu, 11 Dec 2008 00:16:07 -0600
Message-Id: <1228976167-11236-1-git-send-email-ntl@pobox.com>
In-Reply-To: <1228956366-17593-2-git-send-email-ntl@pobox.com>
References: <1228956366-17593-2-git-send-email-ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The smp code uses cache information to populate cpu_core_map; change
it to use common code for cache lookup.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/smp.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

v2: Fix refcount imbalance, thanks to sfr.

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ff9f701..a112ba9 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -408,8 +408,7 @@ out:
 static struct device_node *cpu_to_l2cache(int cpu)
 {
 	struct device_node *np;
-	const phandle *php;
-	phandle ph;
+	struct device_node *cache;
 
 	if (!cpu_present(cpu))
 		return NULL;
@@ -418,13 +417,11 @@ static struct device_node *cpu_to_l2cache(int cpu)
 	if (np == NULL)
 		return NULL;
 
-	php = of_get_property(np, "l2-cache", NULL);
-	if (php == NULL)
-		return NULL;
-	ph = *php;
+	cache = of_find_next_cache_node(np);
+
 	of_node_put(np);
 
-	return of_find_node_by_phandle(ph);
+	return cache;
 }
 
 /* Activate a secondary processor. */
-- 
1.5.5
