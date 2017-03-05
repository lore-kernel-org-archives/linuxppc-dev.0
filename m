Return-Path: <srs0=r6wc=2o=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbz0805SwzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:00:08 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vbz0768k3z8tBy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:00:07 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vbz065qwVz9s78
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Mar 2017 10:00:06 +1100 (AEDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id v25MxwHF017843
 for <linuxppc-dev@ozlabs.org>; Sun, 5 Mar 2017 17:00:00 -0600
Message-ID: <1488754796.2870.112.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: sparsemem should be the default on powernv
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Mon, 06 Mar 2017 09:59:56 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is especially true of POWER9 where memory between chips is
discontiguous.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4940917..c4b4c55 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -580,7 +580,7 @@ config ARCH_SPARSEMEM_ENABLE
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
-	depends on (SMP && PPC_PSERIES) || PPC_PS3
+	depends on (SMP && PPC_PSERIES) || PPC_PS3 || PPC_POWERNV
 
 config SYS_SUPPORTS_HUGETLBFS
 	bool
