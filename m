Return-Path: <clg@kaod.org>
Received: from 9.mo4.mail-out.ovh.net (9.mo4.mail-out.ovh.net [46.105.40.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6Vn907sqzDqvQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 20:23:08 +1100 (AEDT)
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 4013DC45CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 11:15:22 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 1/2] powerpc/xive: fix IPI reset
Date: Wed,  4 Oct 2017 11:15:04 +0200
Message-Id: <20171004091505.16776-2-clg@kaod.org>
In-Reply-To: <20171004091505.16776-1-clg@kaod.org>
References: <20171004091505.16776-1-clg@kaod.org>
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

When resetting an IPI, hw_ipi should also be set to zero.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/sysdev/xive/spapr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index f24a70bc6855..d9c4c9366049 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -431,7 +431,11 @@ static int xive_spapr_get_ipi(unsigned int cpu, struct xive_cpu *xc)
 
 static void xive_spapr_put_ipi(unsigned int cpu, struct xive_cpu *xc)
 {
+	if (!xc->hw_ipi)
+		return;
+
 	xive_irq_bitmap_free(xc->hw_ipi);
+	xc->hw_ipi = 0;
 }
 #endif /* CONFIG_SMP */
 
-- 
2.13.5
