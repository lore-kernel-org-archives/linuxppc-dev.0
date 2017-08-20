Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp11.smtpout.orange.fr
 [80.12.242.133])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xb1ZR56VgzDqgk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 01:53:35 +1000 (AEST)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: qiang.zhao@nxp.com,
	leoyang.li@nxp.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] soc/fsl/qe: Slighly simplify code
Date: Sun, 20 Aug 2017 17:53:28 +0200
Message-Id: <20170820155328.882-1-christophe.jaillet@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Return 0 instead of 'ret' (which is 0 at this point) to make the code more
explicit.
Also avoid a useless initialization of 'ret'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/soc/fsl/qe/qe_tdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index 6b9647fee512..c90c72ca9e3e 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -42,7 +42,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 		     struct ucc_tdm_info *ut_info)
 {
 	const char *sprop;
-	int ret = 0;
+	int ret;
 	u32 val;
 	struct resource *res;
 	struct device_node *np2;
@@ -171,7 +171,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 		siram_init_flag = 1;
 	}
 
-	return ret;
+	return 0;
 
 err_miss_siram_property:
 	return ret;
-- 
2.11.0
