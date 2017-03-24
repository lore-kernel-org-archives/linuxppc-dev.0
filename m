Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqT4V2mMFzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 03:13:46 +1100 (AEDT)
From: Matthew Wilcox <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH v3 6/7] sym53c8xx_2: Convert to use memset32
Date: Fri, 24 Mar 2017 09:13:17 -0700
Message-Id: <20170324161318.18718-7-willy@infradead.org>
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
References: <20170324161318.18718-1-willy@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Matthew Wilcox <mawilcox@microsoft.com>

memset32() can be used to initialise these three arrays.  Minor code
footprint reduction.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/scsi/sym53c8xx_2/sym_hipd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
index 6b349e301869..b886b10e3499 100644
--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c
@@ -4985,13 +4985,10 @@ struct sym_lcb *sym_alloc_lcb (struct sym_hcb *np, u_char tn, u_char ln)
 	 *  Compute the bus address of this table.
 	 */
 	if (ln && !tp->luntbl) {
-		int i;
-
 		tp->luntbl = sym_calloc_dma(256, "LUNTBL");
 		if (!tp->luntbl)
 			goto fail;
-		for (i = 0 ; i < 64 ; i++)
-			tp->luntbl[i] = cpu_to_scr(vtobus(&np->badlun_sa));
+		memset32(tp->luntbl, cpu_to_scr(vtobus(&np->badlun_sa)), 64);
 		tp->head.luntbl_sa = cpu_to_scr(vtobus(tp->luntbl));
 	}
 
@@ -5077,8 +5074,7 @@ static void sym_alloc_lcb_tags (struct sym_hcb *np, u_char tn, u_char ln)
 	/*
 	 *  Initialize the task table with invalid entries.
 	 */
-	for (i = 0 ; i < SYM_CONF_MAX_TASK ; i++)
-		lp->itlq_tbl[i] = cpu_to_scr(np->notask_ba);
+	memset32(lp->itlq_tbl, cpu_to_scr(np->notask_ba), SYM_CONF_MAX_TASK);
 
 	/*
 	 *  Fill up the tag buffer with tag numbers.
@@ -5764,8 +5760,7 @@ int sym_hcb_attach(struct Scsi_Host *shost, struct sym_fw *fw, struct sym_nvram
 		goto attach_failed;
 
 	np->badlun_sa = cpu_to_scr(SCRIPTB_BA(np, resel_bad_lun));
-	for (i = 0 ; i < 64 ; i++)	/* 64 luns/target, no less */
-		np->badluntbl[i] = cpu_to_scr(vtobus(&np->badlun_sa));
+	memset32(np->badluntbl, cpu_to_scr(vtobus(&np->badlun_sa)), 64);
 
 	/*
 	 *  Prepare the bus address array that contains the bus 
-- 
2.11.0
