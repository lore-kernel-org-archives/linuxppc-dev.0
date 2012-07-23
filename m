Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5E99F2C0486
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 19:14:29 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <rob.herring@calxeda.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, cbe-oss-dev@lists.ozlabs.org
Subject: [PATCH 16/25] powerpc/celleb_pci: add a const qualifier
Date: Mon, 23 Jul 2012 11:13:21 +0200
Message-Id: <1343034810-3386-17-git-send-email-u.kleine-koenig@pengutronix.de>
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

	arch/powerpc/platforms/cell/celleb_pci.c: In function 'celleb_setup_phb':
	arch/powerpc/platforms/cell/celleb_pci.c:485:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/platforms/cell/celleb_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/celleb_pci.c b/arch/powerpc/platforms/cell/celleb_pci.c
index 5822141..abc8af4 100644
--- a/arch/powerpc/platforms/cell/celleb_pci.c
+++ b/arch/powerpc/platforms/cell/celleb_pci.c
@@ -472,7 +472,7 @@ int __init celleb_setup_phb(struct pci_controller *phb)
 {
 	struct device_node *dev = phb->dn;
 	const struct of_device_id *match;
-	struct celleb_phb_spec *phb_spec;
+	const struct celleb_phb_spec *phb_spec;
 	int rc;
 
 	match = of_match_node(celleb_phb_match, dev);
-- 
1.7.10.4
