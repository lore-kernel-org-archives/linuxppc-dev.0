Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 084731A0976
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 09:57:06 +1100 (AEDT)
Received: by pabrc13 with SMTP id rc13so98523750pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 15:57:04 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com
Subject: [PATCH] ASoC: fsl: Use #ifdef instead of #if for CONFIG_PM_SLEEP
Date: Thu, 22 Oct 2015 15:56:40 -0700
Message-Id: <1445554600-43889-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change them to #ifdef as CONFIG_PM_SLEEP might not be defined at all.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_esai.c | 2 +-
 sound/soc/fsl/fsl_sai.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index aab675a..59f234e 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -900,7 +900,7 @@ static const struct of_device_id fsl_esai_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_esai_dt_ids);
 
-#if CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_SLEEP
 static int fsl_esai_suspend(struct device *dev)
 {
 	struct fsl_esai *esai = dev_get_drvdata(dev);
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index f652f2e..15173e9 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -807,7 +807,7 @@ static const struct of_device_id fsl_sai_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
 
-#if CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_SLEEP
 static int fsl_sai_suspend(struct device *dev)
 {
 	struct fsl_sai *sai = dev_get_drvdata(dev);
-- 
1.9.1
