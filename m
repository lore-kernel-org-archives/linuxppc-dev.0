Return-Path: <bharat.bhushan@nxp.com>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60056.outbound.protection.outlook.com [40.107.6.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HCYP03rLzF1LP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 20:28:53 +1000 (AEST)
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 robh@kernel.org, geoff@infradead.org, tyreld@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [PATCH] powerpc/mpic: Cleanup irq vector accounting
Date: Fri, 29 Jun 2018 15:54:32 +0530
Message-Id: <1530267872-31244-1-git-send-email-Bharat.Bhushan@nxp.com>
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

Available vector space accounts ipis and timer interrupts
while spurious vector was not accounted. Also later
mpic_setup_error_int() escape one more vector, seemingly it
assumes one spurious vector.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 arch/powerpc/sysdev/fsl_mpic_err.c | 2 +-
 arch/powerpc/sysdev/mpic.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c b/arch/powerpc/sysdev/fsl_mpic_err.c
index 488ec45..2a98837 100644
--- a/arch/powerpc/sysdev/fsl_mpic_err.c
+++ b/arch/powerpc/sysdev/fsl_mpic_err.c
@@ -76,7 +76,7 @@ int mpic_setup_error_int(struct mpic *mpic, int intvec)
 	mpic->flags |= MPIC_FSL_HAS_EIMR;
 	/* allocate interrupt vectors for error interrupts */
 	for (i = MPIC_MAX_ERR - 1; i >= 0; i--)
-		mpic->err_int_vecs[i] = --intvec;
+		mpic->err_int_vecs[i] = intvec--;
 
 	return 0;
 }
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 1d4e0ef6..e098d1e 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1380,12 +1380,12 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 		 * global vector number space, as in case of ipis
 		 * and timer interrupts.
 		 *
-		 * Available vector space = intvec_top - 12, where 12
+		 * Available vector space = intvec_top - 13, where 13
 		 * is the number of vectors which have been consumed by
-		 * ipis and timer interrupts.
+		 * ipis, timer interrupts and spurious.
 		 */
 		if (fsl_version >= 0x401) {
-			ret = mpic_setup_error_int(mpic, intvec_top - 12);
+			ret = mpic_setup_error_int(mpic, intvec_top - 13);
 			if (ret)
 				return NULL;
 		}
-- 
1.9.3
