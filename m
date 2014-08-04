Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8012D1A0227
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Aug 2014 14:17:28 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: fsl_asrc: Don't access members of config before
 checking it
Date: Mon, 4 Aug 2014 12:19:49 +0800
Message-ID: <31ec001e493008c1d6e55f1d9d0787028112c4dc.1407125653.git.nicoleotsuka@gmail.com>
In-Reply-To: <cover.1407125653.git.nicoleotsuka@gmail.com>
References: <cover.1407125653.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sound/soc/fsl/fsl_asrc.c:250 fsl_asrc_config_pair()
	warn: variable dereferenced before check 'config' (see line 243)

git remote add next git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git remote update next
git checkout 3117bb3109dc223e186302f5dc8ce9ed04adca90
vim +/config +250 sound/soc/fsl/fsl_asrc.c

  237   */
  238  static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
  239  {
  240   struct asrc_config *config = pair->config;
  241   struct fsl_asrc *asrc_priv = pair->asrc_priv;
  242   enum asrc_pair_index index = pair->index;
 @243   u32 inrate = config->input_sample_rate, indiv;
  244   u32 outrate = config->output_sample_rate, outdiv;
  245   bool ideal = config->inclk == INCLK_NONE;
  246   u32 clk_index[2], div[2];
  247   int in, out, channels;
  248   struct clk *clk;
  249
 @250   if (!config) {
  251           pair_err("invalid pair config\n");
  252           return -EINVAL;
  253   }

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 06a96f3..86f45a1 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -240,12 +240,11 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 	struct asrc_config *config = pair->config;
 	struct fsl_asrc *asrc_priv = pair->asrc_priv;
 	enum asrc_pair_index index = pair->index;
-	u32 inrate = config->input_sample_rate, indiv;
-	u32 outrate = config->output_sample_rate, outdiv;
-	bool ideal = config->inclk == INCLK_NONE;
+	u32 inrate, outrate, indiv, outdiv;
 	u32 clk_index[2], div[2];
 	int in, out, channels;
 	struct clk *clk;
+	bool ideal;
 
 	if (!config) {
 		pair_err("invalid pair config\n");
@@ -264,6 +263,10 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 		return -EINVAL;
 	}
 
+	inrate = config->input_sample_rate;
+	outrate = config->output_sample_rate;
+	ideal = config->inclk == INCLK_NONE;
+
 	/* Validate input and output sample rates */
 	for (in = 0; in < ARRAY_SIZE(supported_input_rate); in++)
 		if (inrate == supported_input_rate[in])
-- 
1.8.4
