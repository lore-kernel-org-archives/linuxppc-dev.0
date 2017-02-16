Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP1Bp4HqwzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 14:01:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: jallen@linux.vnet.ibm.com,
	nfont@linux.vnet.ibm.com
Subject: [PATCH] powerpc/pseries: Fix build break when MEMORY_HOTREMOVE=n
Date: Thu, 16 Feb 2017 14:01:18 +1100
Message-Id: <1487214078-3893-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We broke the build when CONFIG_MEMORY_HOTREMOVE=n:

  arch/powerpc/platforms/pseries/hotplug-memory.c:821:8: error: implicit
  declaration of function 'dlpar_memory_readd_by_index'

Add a dummy to fix it.

Fixes: e70d59700fc3 ("powerpc/pseries: Introduce memory hotplug READD operation")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 3381c20edbc0..b3b92814ce87 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -628,7 +628,10 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
 {
 	return -EOPNOTSUPP;
 }
-
+static int dlpar_memory_readd_by_index(u32 drc_index, struct property *prop)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 static int dlpar_add_lmb(struct of_drconf_cell *lmb)
-- 
2.7.4
