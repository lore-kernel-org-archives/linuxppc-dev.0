Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E472B7253
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 16:09:45 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p4K69gTd001156
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 01:09:42 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/14] powerpc/85xx: Add PCI support in 64-bit mode on P5020DS
Date: Fri, 20 May 2011 01:09:30 -0500
Message-Id: <1305871771-16334-13-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1305871771-16334-12-git-send-email-galak@kernel.crashing.org>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-3-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-4-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-6-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-7-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-8-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-9-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-10-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-11-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-12-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/corenet_ds.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index 10af3c7..338e6dc 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -22,6 +22,7 @@
 #include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
 #include <mm/mmu_decl.h>
 #include <asm/prom.h>
 #include <asm/udbg.h>
@@ -90,6 +91,10 @@ void __init corenet_ds_setup_arch(void)
 					hose->dma_window_size);
 		}
 	}
+
+#ifdef CONFIG_PPC64
+	pci_devs_phb_init();
+#endif
 #endif
 
 #ifdef CONFIG_SWIOTLB
-- 
1.7.3.4
