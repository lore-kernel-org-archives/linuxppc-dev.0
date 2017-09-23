Return-Path: <clg@kaod.org>
Received: from 7.mo179.mail-out.ovh.net (7.mo179.mail-out.ovh.net
 [46.105.61.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzkVQ0SBKzDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Sep 2017 18:46:52 +1000 (AEST)
Received: from player794.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 44C6064397
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Sep 2017 10:27:42 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 1/2] powerpc/xive: fix IPI reset
Date: Sat, 23 Sep 2017 10:26:55 +0200
Message-Id: <20170923082656.27219-2-clg@kaod.org>
In-Reply-To: <20170923082656.27219-1-clg@kaod.org>
References: <20170923082656.27219-1-clg@kaod.org>
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
