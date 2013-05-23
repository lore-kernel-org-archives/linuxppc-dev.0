Return-Path: <B42378@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CA6D52C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 16:21:17 +1000 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: fsl: expand the size of the name in fsl_ssi_private
 struct
Date: Thu, 23 May 2013 14:26:36 +0800
Message-ID: <1369290396-21545-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: broonie@kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

strcpy(ssi_private->name, p) in probe() sets "name" by "p", gotten from dts,
while the length of "p", if the devicetree node name of SSI is commonly set,
would always be larger than 1 char size, so need a larger size for "name".

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 2f2d837..b6a5f94 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -152,5 +152,5 @@ struct fsl_ssi_private {
 	} stats;
 
-	char name[1];
+	char name[32];
 };
 
-- 
1.7.1
