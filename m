Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68BA11A047A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 23:19:56 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: fsl_sai: Fix incorrect register writing in
 fsl_sai_isr()
Date: Thu, 17 Jul 2014 21:21:38 +0800
Message-ID: <25a59f4a687232e0dd90376d640fbfd0eae65e2a.1405603108.git.nicoleotsuka@gmail.com>
In-Reply-To: <cover.1405603108.git.nicoleotsuka@gmail.com>
References: <cover.1405603108.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, b42378@freescale.com, b02247@freescale.com,
 linux-kernel@vger.kernel.org, timur@tabi.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the rx irq handling part, we should clear the flags in RCSR not TCSR.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index b10dbd8..1b6ee2c 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -106,7 +106,7 @@ irq_rx:
 	xcsr &= ~FSL_SAI_CSR_xF_MASK;
 
 	if (flags)
-		regmap_write(sai->regmap, FSL_SAI_TCSR, flags | xcsr);
+		regmap_write(sai->regmap, FSL_SAI_RCSR, flags | xcsr);
 
 out:
 	if (irq_none)
-- 
1.8.4
