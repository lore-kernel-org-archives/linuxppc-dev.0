Return-Path: <bethencourt@gmail.com>
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com
 [IPv6:2a00:1450:400c:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BF641A2C97
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 02:41:38 +1000 (AEST)
Received: by wicfx3 with SMTP id fx3so37252752wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 09:41:34 -0700 (PDT)
Sender: Luis de Bethencourt <bethencourt@gmail.com>
From: Luis de Bethencourt <luis@debethencourt.com>
Date: Tue, 15 Sep 2015 18:41:33 +0200
To: linux-kernel@vger.kernel.org
Cc: Olof Johansson <olof@lixom.net>, Matt Mackall <mpm@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Wolfram Sang <wsa@the-dreams.de>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Subject: [PATCH 1/2] char: hw_random: Fix module autoload for OF platform
 drivers
Message-ID: <20150915164133.GA5642@goodgumbo.baconseed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This platform drivers have a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/char/hw_random/pasemi-rng.c | 1 +
 drivers/char/hw_random/ppc4xx-rng.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/char/hw_random/pasemi-rng.c b/drivers/char/hw_random/pasemi-rng.c
index 3eb7bdd..20d6564 100644
--- a/drivers/char/hw_random/pasemi-rng.c
+++ b/drivers/char/hw_random/pasemi-rng.c
@@ -138,6 +138,7 @@ static struct of_device_id rng_match[] = {
 	{ .compatible      = "pasemi,pwrficient-rng", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, rng_match);
 
 static struct platform_driver rng_driver = {
 	.driver = {
diff --git a/drivers/char/hw_random/ppc4xx-rng.c b/drivers/char/hw_random/ppc4xx-rng.c
index c85d31a..145e273 100644
--- a/drivers/char/hw_random/ppc4xx-rng.c
+++ b/drivers/char/hw_random/ppc4xx-rng.c
@@ -129,6 +129,7 @@ static struct of_device_id ppc4xx_rng_match[] = {
 	{ .compatible = "amcc,ppc440epx-rng", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, ppc4xx_rng_match);
 
 static struct platform_driver ppc4xx_rng_driver = {
 	.driver = {
-- 
2.4.6
