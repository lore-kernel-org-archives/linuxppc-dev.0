Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CB5D1A0757
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 00:53:53 +1000 (AEST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 7 Apr 2015 08:53:51 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BFCBD3E4004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 08:53:47 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t37ErouB36896974
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 07:53:50 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t37Erlwq003683
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 08:53:47 -0600
Message-ID: <5523EF7A.8030604@linux.vnet.ibm.com>
Date: Tue, 07 Apr 2015 09:53:46 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] Correct memory hotplug locking
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory dlpar handling can return from dlpar_memory() without releasing the
device_hotplug lock. Correct this routine to ensure the lock is released.

This patch applies on top of my previous updates to memory hotplug:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-February/124804.html

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 742ef88..5cefcad 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -562,13 +562,15 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 	lock_device_hotplug();
 
 	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (!dn)
-		return -EINVAL;
+	if (!dn) {
+		rc = -EINVAL;
+		goto dlpar_memory_out;
+	}
 
 	prop = dlpar_clone_drconf_property(dn);
 	if (!prop) {
-		of_node_put(dn);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto dlpar_memory_out;
 	}
 
 	switch (hp_elog->action) {
@@ -599,6 +601,7 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 	else
 		dlpar_update_drconf_property(dn, prop);
 
+dlpar_memory_out:
 	of_node_put(dn);
 	unlock_device_hotplug();
 	return rc;
