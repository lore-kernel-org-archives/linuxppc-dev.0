Return-Path: <roy.pledge@nxp.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0087.outbound.protection.outlook.com [104.47.42.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdbhv1BvPzDrK0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 06:38:07 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <leoyang.li@nxp.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <oss@buserror.net>, <madalin.bucur@nxp.com>, <catalin.marinas@arm.com>,
 <linux@armlinux.org.uk>, <arnd@arndb.de>, <mark.rutland@arm.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [v4 04/11] soc/fsl/qbman: Drop set/clear_bits usage
Date: Thu, 24 Aug 2017 16:37:48 -0400
Message-ID: <1503607075-28970-5-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
Reply-To: <roy.pledge@nxp.com>
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

From: Madalin Bucur <madalin.bucur@nxp.com>

Replace PPC specific set/clear_bits API with standard
bit twiddling so driver is portalable outside PPC.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/bman.c | 2 +-
 drivers/soc/fsl/qbman/qman.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index 604e45c..ff8998f 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -616,7 +616,7 @@ int bman_p_irqsource_add(struct bman_portal *p, u32 bits)
 	unsigned long irqflags;
 
 	local_irq_save(irqflags);
-	set_bits(bits & BM_PIRQ_VISIBLE, &p->irq_sources);
+	p->irq_sources |= bits & BM_PIRQ_VISIBLE;
 	bm_out(&p->p, BM_REG_IER, p->irq_sources);
 	local_irq_restore(irqflags);
 	return 0;
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 1bcfc51..25419e1 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -908,12 +908,12 @@ static inline int qm_mc_result_timeout(struct qm_portal *portal,
 
 static inline void fq_set(struct qman_fq *fq, u32 mask)
 {
-	set_bits(mask, &fq->flags);
+	fq->flags |= mask;
 }
 
 static inline void fq_clear(struct qman_fq *fq, u32 mask)
 {
-	clear_bits(mask, &fq->flags);
+	fq->flags &= ~mask;
 }
 
 static inline int fq_isset(struct qman_fq *fq, u32 mask)
@@ -1574,7 +1574,7 @@ void qman_p_irqsource_add(struct qman_portal *p, u32 bits)
 	unsigned long irqflags;
 
 	local_irq_save(irqflags);
-	set_bits(bits & QM_PIRQ_VISIBLE, &p->irq_sources);
+	p->irq_sources |= bits & QM_PIRQ_VISIBLE;
 	qm_out(&p->p, QM_REG_IER, p->irq_sources);
 	local_irq_restore(irqflags);
 }
@@ -1597,7 +1597,7 @@ void qman_p_irqsource_remove(struct qman_portal *p, u32 bits)
 	 */
 	local_irq_save(irqflags);
 	bits &= QM_PIRQ_VISIBLE;
-	clear_bits(bits, &p->irq_sources);
+	p->irq_sources &= ~bits;
 	qm_out(&p->p, QM_REG_IER, p->irq_sources);
 	ier = qm_in(&p->p, QM_REG_IER);
 	/*
-- 
2.7.4
