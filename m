Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C09F0679E7
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Aug 2006 02:38:09 +1000 (EST)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k74GfpiH005375
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Aug 2006 11:41:51 -0500
Received: (from mporter@localhost)
	by gate.crashing.org (8.12.8/8.12.8/Submit) id k74GfpER005374
	for linuxppc-dev@ozlabs.org; Fri, 4 Aug 2006 11:41:51 -0500
Date: Fri, 4 Aug 2006 11:41:51 -0500
From: Matt Porter <mporter@embeddedalley.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Remove flush_dcache_all export
Message-ID: <20060804164151.GA4959@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removes the flush_dcache_all export for non coherent platforms.
We removed the last in-kernel user of this years ago in arch/ppc
so it no longer serves a purpose. Plus, it breaks the build
at the moment.

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 4b052ae..0e18342 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -127,10 +127,6 @@ EXPORT_SYMBOL(pci_bus_mem_base_phys);
 EXPORT_SYMBOL(pci_bus_to_hose);
 #endif /* CONFIG_PCI */
 
-#ifdef CONFIG_NOT_COHERENT_CACHE
-EXPORT_SYMBOL(flush_dcache_all);
-#endif
-
 EXPORT_SYMBOL(start_thread);
 EXPORT_SYMBOL(kernel_thread);
 
