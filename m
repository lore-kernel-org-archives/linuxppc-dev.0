Return-Path: <clg@kaod.org>
Received: from 6.mo3.mail-out.ovh.net (6.mo3.mail-out.ovh.net [188.165.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRTGy25pXzDqpQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 19:14:02 +1000 (AEST)
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 9045312AF1D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 10:57:02 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 05/10] powerpc/xive: add the HW IRQ number under xive_irq_data
Date: Tue,  8 Aug 2017 10:56:15 +0200
Message-Id: <1502182579-990-6-git-send-email-clg@kaod.org>
In-Reply-To: <1502182579-990-1-git-send-email-clg@kaod.org>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
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
index 1deb10032d61..6d097a18d3ae 100644
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
index 0f95476b01f6..3417fb0ce1ff 100644
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
index a3668815d5c1..9a0fd9f7e38a 100644
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
2.7.5
