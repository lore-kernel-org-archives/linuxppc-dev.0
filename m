Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01DC8DE2DB
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 21:53:15 +1000 (EST)
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/3] ASoC: Make OpenFirmware helper include file conditional
Date: Tue, 22 Jul 2008 12:53:07 +0100
Message-Id: <1216727589-19544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <20080722115205.GA12555@sirena.org.uk>
References: <20080722115205.GA12555@sirena.org.uk>
Cc: alsa-project.org@rakim.wolfsonmicro.main, linuxppc-dev@ozlabs.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	timur@freescale.com, liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The OpenFirmware API headers don't build on all platforms so ensure
that they are not included unless they are being used.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-of-simple.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-of-simple.h b/include/sound/soc-of-simple.h
index 696fc51..a064e19 100644
--- a/include/sound/soc-of-simple.h
+++ b/include/sound/soc-of-simple.h
@@ -7,6 +7,8 @@
 #ifndef _INCLUDE_SOC_OF_H_
 #define _INCLUDE_SOC_OF_H_
 
+#if defined(CONFIG_SND_SOC_OF_SIMPLE) || defined(CONFIG_SND_SOC_OF_SIMPLE_MODULE)
+
 #include <linux/of.h>
 #include <sound/soc.h>
 
@@ -18,4 +20,6 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
 				 struct device_node *node,
 				 struct snd_soc_dai *cpu_dai);
 
+#endif
+
 #endif /* _INCLUDE_SOC_OF_H_ */
-- 
1.5.6.3
