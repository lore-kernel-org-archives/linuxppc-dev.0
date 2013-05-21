Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7FB92C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 22:05:52 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init functions
 for corenet ds board
Date: Tue, 21 May 2013 20:04:58 +0800
Message-ID: <1369137900-5748-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
References: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function pci_devs_phb_init is invoked more earlier than we really
probe the pci controller, so it does nothing at all. And we also don't
need the pci_dn stuff for the fsl powerpc64 boards, just remove it.

It also seems that we don't support ISA on all the current corenet ds
boards. So picking a primary bus seems useless, remove that function
too.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/platforms/85xx/corenet_ds.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index c59c617..aa3690b 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -53,12 +53,6 @@ void __init corenet_ds_setup_arch(void)
 {
 	mpc85xx_smp_init();
 
-#if defined(CONFIG_PCI) && defined(CONFIG_PPC64)
-	pci_devs_phb_init();
-#endif
-
-	fsl_pci_assign_primary();
-
 	swiotlb_detect_4g();
 
 	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
-- 
1.8.1.4
