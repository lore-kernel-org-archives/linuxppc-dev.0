Return-Path: <danielhb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLnkZ1pBTzDsPt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 04:18:14 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6VIDuoj038619
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 14:18:11 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c26xegkp5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 14:18:10 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <danielhb@linux.vnet.ibm.com>;
 Mon, 31 Jul 2017 15:18:09 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6VII6kD23330862
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 15:18:06 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6VII684010823
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 15:18:07 -0300
Received: from localhost.localdomain ([9.80.223.205])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v6VII4YA010737
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 15:18:05 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH] powerpc: Disabling MEMORY_HOTPLUG_DEFAULT_ONLINE option
 for PPC64 arch
Date: Mon, 31 Jul 2017 15:17:59 -0300
Message-Id: <20170731181759.13839-1-danielhb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 943db62c316c ("powerpc/pseries: Revert 'Auto-online
hotplugged memory'") reverted the auto-online feature for pseries due
to problems with LMB removals not updating the device struct properly.
Among other things, this commit made the following change in
arch/powerpc/configs/pseries_defconfig:

@@ -58,7 +58,6 @@ CONFIG_KEXEC_FILE=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
-CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
 CONFIG_KSM=y

The intent was to disable the option in the defconfig of pseries, since
after that the code doesn't have this support anymore. However, this change
alone isn't enough to prevent situations such as [1], where
distros can enable the option unaware of the consequences of
doing it (e.g. breaking LMB hotplug altogether).

Instead of relying on all distros knowing that pseries can't handle
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y after 943db62c316c, this patch
changes mm/Kconfig to make the MEMORY_HOTPLUG_DEFAULT_ONLINE config
unavailable for the PPC64 arch.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1476380

Fixes: 943db62c316c ("powerpc/pseries: Revert 'Auto-online hotplugged memory'")
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 48b1af4..a342c77 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -169,7 +169,7 @@ config MEMORY_HOTPLUG_SPARSE
 config MEMORY_HOTPLUG_DEFAULT_ONLINE
         bool "Online the newly added memory blocks by default"
         default n
-        depends on MEMORY_HOTPLUG
+        depends on MEMORY_HOTPLUG && !PPC64
         help
 	  This option sets the default policy setting for memory hotplug
 	  onlining policy (/sys/devices/system/memory/auto_online_blocks) which
-- 
2.9.4
