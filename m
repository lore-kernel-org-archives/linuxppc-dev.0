Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6C6C3DA4A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2024 10:13:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wb1rZ0rttz3dVK
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2024 20:13:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yuehaibing@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wb1r62pjzz3cRs
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2024 20:13:20 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wb1q23pTwzxVrb;
	Fri,  2 Aug 2024 18:12:30 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B5F0618005F;
	Fri,  2 Aug 2024 18:12:44 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 2 Aug
 2024 18:12:44 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jonathan.downing@nautel.com>, <piotr.wojtaszczyk@timesys.com>,
	<vz@mleia.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: fsl: lpc3xxx: Make some symbols static
Date: Fri, 2 Aug 2024 18:10:44 +0800
Message-ID: <20240802101044.3302251-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These symbols are not used outside of the files, make them static to fix
sparse warnings:

sound/soc/fsl/lpc3xxx-i2s.c:261:30: warning: symbol 'lpc3xxx_i2s_dai_ops' was not declared. Should it be static?
sound/soc/fsl/lpc3xxx-i2s.c:271:27: warning: symbol 'lpc3xxx_i2s_dai_driver' was not declared. Should it be static?
sound/soc/fsl/lpc3xxx-pcm.c:55:39: warning: symbol 'lpc3xxx_soc_platform_driver' was not declared. Should it be static?

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 sound/soc/fsl/lpc3xxx-i2s.c | 4 ++--
 sound/soc/fsl/lpc3xxx-pcm.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/lpc3xxx-i2s.c b/sound/soc/fsl/lpc3xxx-i2s.c
index 62ef624d6dd4..bdb320bb3719 100644
--- a/sound/soc/fsl/lpc3xxx-i2s.c
+++ b/sound/soc/fsl/lpc3xxx-i2s.c
@@ -258,7 +258,7 @@ static int lpc3xxx_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-const struct snd_soc_dai_ops lpc3xxx_i2s_dai_ops = {
+static const struct snd_soc_dai_ops lpc3xxx_i2s_dai_ops = {
 	.probe	= lpc3xxx_i2s_dai_probe,
 	.startup = lpc3xxx_i2s_startup,
 	.shutdown = lpc3xxx_i2s_shutdown,
@@ -268,7 +268,7 @@ const struct snd_soc_dai_ops lpc3xxx_i2s_dai_ops = {
 	.set_fmt = lpc3xxx_i2s_set_dai_fmt,
 };
 
-struct snd_soc_dai_driver lpc3xxx_i2s_dai_driver = {
+static struct snd_soc_dai_driver lpc3xxx_i2s_dai_driver = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
diff --git a/sound/soc/fsl/lpc3xxx-pcm.c b/sound/soc/fsl/lpc3xxx-pcm.c
index c0d499b9b8ba..e6abaf63895a 100644
--- a/sound/soc/fsl/lpc3xxx-pcm.c
+++ b/sound/soc/fsl/lpc3xxx-pcm.c
@@ -52,7 +52,7 @@ static const struct snd_dmaengine_pcm_config lpc3xxx_dmaengine_pcm_config = {
 	.prealloc_buffer_size = 128 * 1024,
 };
 
-const struct snd_soc_component_driver lpc3xxx_soc_platform_driver = {
+static const struct snd_soc_component_driver lpc3xxx_soc_platform_driver = {
 	.name = "lpc32xx-pcm",
 };
 
-- 
2.34.1

