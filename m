Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BA011A0C73
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 17:03:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 14 Apr 2015 17:02:59 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E37902CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 17:02:55 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E72krT52625562
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 17:02:55 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E72LZa005862
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 17:02:21 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel] powerpc/pseries: Fix compile of memory hotplug without
 CONFIG_MEMORY_HOTREMOVE
Date: Tue, 14 Apr 2015 17:01:56 +1000
Message-Id: <1428994916-25779-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

51925fb3c5 "powerpc/pseries: Implement memory hotplug remove in the kernel"
broke compile when CONFIG_MEMORY_HOTREMOVE is not defined due to missing
symbols. This fixes the issue by adding the missing symbols.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is made against ad30cb99465 (mpe/next) and can be squashed into 51925fb3c5
if not too late.


---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 5cefcad..0ced387 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -369,6 +369,19 @@ static inline int dlpar_memory_remove(struct pseries_hp_errorlog *hp_elog)
 {
 	return -EOPNOTSUPP;
 }
+static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
+{
+	return -EOPNOTSUPP;
+}
+static int dlpar_memory_remove_by_count(u32 lmbs_to_remove,
+					struct property *prop)
+{
+	return -EOPNOTSUPP;
+}
+static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
+{
+	return -EOPNOTSUPP;
+}
 
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-- 
2.0.0
