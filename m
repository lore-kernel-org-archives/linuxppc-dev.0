Return-Path: <codrin.ciubotariu@nxp.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com (unknown
 [65.55.169.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B55F1A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 02:49:44 +1100 (AEDT)
From: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
To: <iommu@lists.linux-foundation.org>
CC: <scottwood@freescale.com>, <Varun.Sethi@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, Codrin Ciubotariu
 <codrin.ciubotariu@nxp.com>
Subject: [PATCH 3/7] iommu/fsl: Enable OMT cache,
 before invalidating PAACT and SPAACT cache
Date: Mon, 7 Mar 2016 17:34:19 +0200
Message-ID: <1457364863-18004-4-git-send-email-codrin.ciubotariu@nxp.com>
In-Reply-To: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
References: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Varun Sethi <Varun.Sethi@freescale.com>

Enable OMT cache, before invalidating PAACT and SPAACT cache. This
is a PAMU hardware errata work around.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
---
 drivers/iommu/fsl_pamu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index a00c473..ce25084 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -731,6 +731,16 @@ static int setup_one_pamu(unsigned long pamu_reg_base,
 	pamu_regs = (struct pamu_mmap_regs *)
 		(pamu_reg_base + PAMU_MMAP_REGS_BASE);
 
+	/*
+	 * As per PAMU errata A-005982, writing the PAACT and SPAACT
+	 * base address registers wouldn't invalidate the corresponding
+	 * caches if the OMT cache is disabled. The workaround is to
+	 * enable the OMT cache before setting the base registers.
+	 * This can be done without actually enabling PAMU.
+	 */
+
+	out_be32(pc, PAMU_PC_OCE);
+
 	/* set up pointers to corenet control blocks */
 
 	out_be32(&pamu_regs->ppbah, upper_32_bits(ppaact_phys));
-- 
1.9.3
