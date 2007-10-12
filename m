Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F333DDE11
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 06:19:15 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9CKJAZv018931
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:19:11 -0700 (MST)
Received: from loki ([10.82.17.119])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9CKJAA6009578
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 15:19:10 -0500 (CDT)
Received: from scott by loki with local (Exim 4.68)
	(envelope-from <scottwood@freescale.com>) id 1IgQyV-0002LB-3I
	for linuxppc-dev@ozlabs.org; Fri, 12 Oct 2007 15:19:11 -0500
Date: Fri, 12 Oct 2007 15:19:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] cpm: Fix a couple minor issues in cpm_common.c.
Message-ID: <20071012201910.GA8988@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A debugging printk is removed, and a comment is fixed to match
the code.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/cpm_common.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 66c8ad4..165981c 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -77,8 +77,6 @@ int __init cpm_muram_init(void)
 	int i = 0;
 	int ret = 0;
 
-	printk("cpm_muram_init\n");
-
 	spin_lock_init(&cpm_muram_lock);
 	/* initialize the info header */
 	rh_init(&cpm_muram_info, 1,
@@ -193,7 +191,7 @@ void __iomem *cpm_muram_addr(unsigned long offset)
 EXPORT_SYMBOL(cpm_muram_addr);
 
 /**
- * cpm_muram_phys - turn a muram virtual address into a DMA address
+ * cpm_muram_dma - turn a muram virtual address into a DMA address
  * @offset: virtual address from cpm_muram_addr() to convert
  */
 dma_addr_t cpm_muram_dma(void __iomem *addr)
-- 
1.5.3.4
