Return-Path: <clg@kaod.org>
Received: from 6.mo68.mail-out.ovh.net (6.mo68.mail-out.ovh.net
 [46.105.63.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjGjS2DdmzDqgD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 06:06:20 +1000 (AEST)
Received: from player776.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 735D87B1B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 21:47:04 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v3 5/8] powerpc/xive: add the HW IRQ number under xive_irq_data
Date: Wed, 30 Aug 2017 21:46:14 +0200
Message-Id: <20170830194617.26621-6-clg@kaod.org>
In-Reply-To: <20170830194617.26621-1-clg@kaod.org>
References: <20170830194617.26621-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It will be required later by the H_INT_ESB hcall.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/asm/xive.h   | 1 +
 arch/powerpc/sysdev/xive/native.c | 2 ++
 arch/powerpc/sysdev/xive/spapr.c  | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index 473f133a8555..64ec9bbcf03e 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -45,6 +45,7 @@ struct xive_irq_data {
 	void __iomem *trig_mmio;
 	u32 esb_shift;
 	int src_chip;
+	u32 hw_irq;
 
 	/* Setup/used by frontend */
 	int target;
diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index ef92a83090e1..f8bcff15b0f9 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -82,6 +82,8 @@ int xive_native_populate_irq_data(u32 hw_irq, struct xive_irq_data *data)
 		return -ENOMEM;
 	}
 
+	data->hw_irq = hw_irq;
+
 	if (!data->trig_page)
 		return 0;
 	if (data->trig_page == data->eoi_page) {
diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 797bb0636ab7..0fcae7504353 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -264,6 +264,8 @@ static int xive_spapr_populate_irq_data(u32 hw_irq, struct xive_irq_data *data)
 		return -ENOMEM;
 	}
 
+	data->hw_irq = hw_irq;
+
 	/* Full function page supports trigger */
 	if (flags & XIVE_SRC_TRIGGER) {
 		data->trig_mmio = data->eoi_mmio;
-- 
2.13.5
