Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3XJX0K2CzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 17:21:00 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i5so9026576pfc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 00:20:59 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH] powerpc/configs: Enable THP and 64K for ppc64(le)_defconfig
Date: Thu, 13 Apr 2017 17:20:45 +1000
Message-Id: <20170413072045.17956-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable 64K page size and THP. I use ppc64le_defconfig when I need
a single config across guest and host, but having 4K page size
as default is not what I expect. I could move these over to
server.config and merge if ppc64_defconfig is meant for systems
that use 4k pages by default.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/configs/ppc64_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 17c6c12..775c8f4 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -53,6 +53,8 @@ CONFIG_CRASH_DUMP=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_PPC_64K_PAGES=y
 CONFIG_SCHED_SMT=y
 CONFIG_PCCARD=y
 CONFIG_ELECTRA_CF=y
-- 
2.9.3
