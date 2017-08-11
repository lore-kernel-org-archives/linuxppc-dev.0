Return-Path: <clg@kaod.org>
Received: from 3.mo4.mail-out.ovh.net (3.mo4.mail-out.ovh.net [46.105.57.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTS1y3yGKzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 00:24:38 +1000 (AEST)
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 5A4128C9B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 16:24:35 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 5/8] powerpc/xive: add the HW IRQ number under xive_irq_data
Date: Fri, 11 Aug 2017 16:23:38 +0200
Message-Id: <20170811142341.22715-6-clg@kaod.org>
In-Reply-To: <20170811142341.22715-1-clg@kaod.org>
References: <20170811142341.22715-1-clg@kaod.org>
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
index 89e5a57693db..7efcee928569 100644
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
2.13.4
