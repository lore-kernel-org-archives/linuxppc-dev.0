Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E9B01DDE18
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 10:49:45 +1100 (EST)
Date: Thu, 31 Jan 2008 17:50:02 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] pasemi: Fix thinko in dma_direct_ops setup
Message-ID: <20080131235002.GA16753@lixom.net>
References: <18337.8955.539106.868486@cargo.ozlabs.ibm.com>
	<20080131064130.GA32344@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080131064130.GA32344@lixom.net>
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC] pasemi: Fix thinko in dma_direct_ops setup

The first patch will just fall through and still set dma_data to a bad
value, make it return directly instead.

Signed-off-by: Olof Johansson <olof@lixom.net>

---

Linus, thanks for picking up the patch so quickly. Unfortunately I
messed it up. Please apply this on top.


Thanks,

Olof

diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index c5cfd4b..5803f11 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -184,7 +184,7 @@ static void pci_dma_dev_setup_pasemi(struct pci_dev *dev)
 	if (dev->vendor == 0x1959 && dev->device == 0xa007 &&
 	    !firmware_has_feature(FW_FEATURE_LPAR)) {
 		dev->dev.archdata.dma_ops = &dma_direct_ops;
-		dev->dev.archdata.dma_data = 0;
+		return;
 	}
 #endif
 
