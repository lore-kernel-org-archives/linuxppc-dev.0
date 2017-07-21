Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDYcw1pp7zDqv7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 00:51:44 +1000 (AEST)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] powerpc/pseries: Fix of_node_put() underflow during pseries
 remove
Date: Fri, 21 Jul 2017 16:51:39 +0200
Message-Id: <20170721145139.9384-1-lvivier@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As for commit 68baf692c435 ("powerpc/pseries: Fix of_node_put()
underflow during DLPAR remove"), the call to of_node_put()
must be removed from pSeries_reconfig_remove_node().

dlpar_detach_node() and pSeries_reconfig_remove_node() call
of_detach_node(), and thus the node should not be released
in this case too.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 arch/powerpc/platforms/pseries/reconfig.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index e5bf1e8..011ef21 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -82,7 +82,6 @@ static int pSeries_reconfig_remove_node(struct device_node *np)
 
 	of_detach_node(np);
 	of_node_put(parent);
-	of_node_put(np); /* Must decrement the refcount */
 	return 0;
 }
 
-- 
2.9.4
