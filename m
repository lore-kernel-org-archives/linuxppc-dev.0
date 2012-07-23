Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 72DD22C0397
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 19:14:25 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <rob.herring@calxeda.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Timur Tabi <timur@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 15/25] powerpc/fsl_msi: add a const qualifier
Date: Mon, 23 Jul 2012 11:13:20 +0200
Message-Id: <1343034810-3386-16-git-send-email-u.kleine-koenig@pengutronix.de>
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

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	arch/powerpc/sysdev/fsl_msi.c: In function 'fsl_of_msi_probe':
	arch/powerpc/sysdev/fsl_msi.c:379:11: error: assignment discards 'const' qualifier from pointer target type [-Werror]

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/sysdev/fsl_msi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 6e097de..a40acd6 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -368,7 +368,7 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev)
 	int err, i, j, irq_index, count;
 	int rc;
 	const u32 *p;
-	struct fsl_msi_feature *features;
+	const struct fsl_msi_feature *features;
 	int len;
 	u32 offset;
 	static const u32 all_avail[] = { 0, NR_MSI_IRQS };
-- 
1.7.10.4
