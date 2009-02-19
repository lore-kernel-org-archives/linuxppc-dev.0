Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5550DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 07:49:44 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Subject: [PATCH 1/3] powerpc/pci: Default to dma_direct_ops for pci dma_ops
Date: Thu, 19 Feb 2009 14:49:15 -0600
Message-Id: <1235076557-24464-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This will allow us to remove the ppc32 specific checks in get_dma_ops()
that defaults to dma_direct_ops if the archdata is NULL.  We really
should always have archdata set to something going forward.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/pci-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 2ad1731..633e871 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -50,7 +50,7 @@ resource_size_t isa_mem_base;
 unsigned int ppc_pci_flags = 0;
 
 
-static struct dma_mapping_ops *pci_dma_ops;
+static struct dma_mapping_ops *pci_dma_ops = &dma_direct_ops;
 
 void set_pci_dma_ops(struct dma_mapping_ops *dma_ops)
 {
-- 
1.5.6.6
