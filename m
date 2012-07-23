Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6352B2C0392
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 19:14:25 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <rob.herring@calxeda.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Timur Tabi <timur@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 21/25] powerpc/fsl_msi: drop unneeded cast to non-const pointer
Date: Mon, 23 Jul 2012 11:13:26 +0200
Message-Id: <1343034810-3386-22-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd@arndb.de>

This cast is unneeded since *of_device_id.data became const.

[ukl: split Arnd's patch by driver and add changelog]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/sysdev/fsl_msi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index a40acd6..51ffafa 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -502,15 +502,15 @@ static const struct fsl_msi_feature vmpic_msi_feature = {
 static const struct of_device_id fsl_of_msi_ids[] = {
 	{
 		.compatible = "fsl,mpic-msi",
-		.data = (void *)&mpic_msi_feature,
+		.data = &mpic_msi_feature,
 	},
 	{
 		.compatible = "fsl,ipic-msi",
-		.data = (void *)&ipic_msi_feature,
+		.data = &ipic_msi_feature,
 	},
 	{
 		.compatible = "fsl,vmpic-msi",
-		.data = (void *)&vmpic_msi_feature,
+		.data = &vmpic_msi_feature,
 	},
 	{}
 };
-- 
1.7.10.4
