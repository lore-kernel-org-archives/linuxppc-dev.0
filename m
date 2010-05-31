Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0BED7B7D47
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 May 2010 11:50:34 +1000 (EST)
Subject: [PATCH] powerpc: Don't export cvt_fd & _df when CONFIG_PPC_FPU is
	not set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 May 2010 11:50:28 +1000
Message-ID: <1275270628.1931.540.camel@pasglop>
Mime-Version: 1.0
Cc: Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/ppc_ksyms.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index bc9f39d..3b4dcc8 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -101,7 +101,7 @@ EXPORT_SYMBOL(pci_dram_offset);
 EXPORT_SYMBOL(start_thread);
 EXPORT_SYMBOL(kernel_thread);
 
-#ifndef CONFIG_BOOKE
+#ifdef CONFIG_PPC_FPU
 EXPORT_SYMBOL_GPL(cvt_df);
 EXPORT_SYMBOL_GPL(cvt_fd);
 #endif
