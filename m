Return-Path: <dja@axtens.net>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F0521A0769
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:36:22 +1100 (AEDT)
Received: by pdnc3 with SMTP id c3so17183246pdn.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:36:20 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/27] powerpc/fsl_pci: Don't change ppc_swiotlb_enable after
 swiotlb_subsys_init
Date: Wed, 25 Mar 2015 16:35:38 +1100
Message-Id: <1427261761-22952-5-git-send-email-dja@axtens.net>
In-Reply-To: <1427261761-22952-1-git-send-email-dja@axtens.net>
References: <1427261761-22952-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only function that checks ppc_swiotlb_enable is swiotlb_subsys_init.
The code in fsl_pci.c is called well after that, so don't bother
changing it.

(ppc_swiotlb is usually set in swiotlb_detect_4g, which is called by
a number of arch initcalls.)

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/sysdev/fsl_pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4b74c27..7071feb 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -376,9 +376,7 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	}
 
 	if (hose->dma_window_size < mem) {
-#ifdef CONFIG_SWIOTLB
-		ppc_swiotlb_enable = 1;
-#else
+#ifndef CONFIG_SWIOTLB
 		pr_err("%s: ERROR: Memory size exceeds PCI ATMU ability to "
 			"map - enable CONFIG_SWIOTLB to avoid dma errors.\n",
 			 name);
-- 
2.1.4
