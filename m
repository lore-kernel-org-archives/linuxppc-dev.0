Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp11.smtpout.orange.fr
 [80.12.242.133])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xb1ZG52SgzDqb5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 01:53:25 +1000 (AEST)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: qiang.zhao@nxp.com,
	leoyang.li@nxp.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] soc/fsl/qe: Fix a potential NULL pointer dereference in
 an error handling path
Date: Sun, 20 Aug 2017 17:53:12 +0200
Message-Id: <20170820155312.831-1-christophe.jaillet@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If 'of_find_device_by_node()' fails at line 153, a NULL pointer
dereference (pdev) will occur in the error handling path.

Just remove the 'devm_iounmap()' call from the error handling path. The
corresponding is managed, there is no need to release explicitly here.

Fixes: 35ef1c20fdb2 ("fsl/qe: Add QE TDM lib")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is only a guess that sounds logical to me.

I propose to remove this 'devm_iounmap' mainly because of its name (if it
is managed, why should be manually handle it here ?)
---
 drivers/soc/fsl/qe/qe_tdm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index f744c214f680..6b9647fee512 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -174,7 +174,6 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	return ret;
 
 err_miss_siram_property:
-	devm_iounmap(&pdev->dev, utdm->si_regs);
 	return ret;
 }
 EXPORT_SYMBOL(ucc_of_parse_tdm);
-- 
2.11.0
