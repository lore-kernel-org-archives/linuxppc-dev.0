Return-Path: <gustavo@embeddedor.com>
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com
 [192.185.143.46])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41htS262X0zF12N
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2018 02:54:26 +1000 (AEST)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
 by gateway31.websitewelcome.com (Postfix) with ESMTP id 08F58A21409
 for <linuxppc-dev@lists.ozlabs.org>;
 Fri,  3 Aug 2018 11:29:56 -0500 (CDT)
Date: Fri, 3 Aug 2018 11:29:53 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 2/7] ASoC: fsl_esai: Mark expected switch fall-through
Message-ID: <b866336e8826ed65e2c0d74429f0834474bf1152.1533312229.git.gustavo@embeddedor.com>
References: <cover.1533312229.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1533312229.git.gustavo@embeddedor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1222121 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/fsl/fsl_esai.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 8f43110..c1d1d06 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -249,6 +249,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 		break;
 	case ESAI_HCKT_EXTAL:
 		ecr |= ESAI_ECR_ETI;
+		/* fall through */
 	case ESAI_HCKR_EXTAL:
 		ecr |= ESAI_ECR_ERI;
 		break;
-- 
2.7.4
