Return-Path: <weiyj_lk@163.com>
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
 by lists.ozlabs.org (Postfix) with ESMTP id F16341A001D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 01:10:18 +1100 (AEDT)
From: weiyj_lk@163.com
To: Scott Wood <scottwood@freescale.com>,
 Zhao Qiang <qiang.zhao@freescale.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] QE: Use GFP_ATOMIC under spin lock
Date: Fri,  5 Feb 2016 21:52:23 +0800
Message-Id: <1454680343-18393-1-git-send-email-weiyj_lk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The function cpm_muram_alloc_common() is called from several
places, in some of which, such as cpm_muram_alloc(), a lock is
held here, so we should use GFP_ATOMIC when a lock is held.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/soc/fsl/qe/qe_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 419fa5b..d774e54 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -194,7 +194,7 @@ unsigned long cpm_muram_alloc_common(unsigned long size, genpool_algo_t algo,
 		goto out2;
 	start = start - GENPOOL_OFFSET;
 	memset_io(cpm_muram_addr(start), 0, size);
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
 		goto out1;
 	entry->start = start;
