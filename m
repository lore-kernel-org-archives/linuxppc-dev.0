Return-Path: <bethencourt@gmail.com>
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com
 [IPv6:2a00:1450:400c:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC4061A2C8C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 07:04:57 +1000 (AEST)
Received: by wicgb1 with SMTP id gb1so47556242wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 14:04:54 -0700 (PDT)
Sender: Luis de Bethencourt <bethencourt@gmail.com>
From: Luis de Bethencourt <luis@debethencourt.com>
Date: Fri, 18 Sep 2015 23:04:52 +0200
To: linux-kernel@vger.kernel.org
Cc: Anatolij Gustschin <agust@denx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: platforms: mpc52xx_lpbfifo: Fix module autoload
 for OF platform driver
Message-ID: <20150918210452.GA6724@goodgumbo.baconseed.org>
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

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
index 251dcb9..7bb42a0 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -568,6 +568,7 @@ static const struct of_device_id mpc52xx_lpbfifo_match[] = {
 	{ .compatible = "fsl,mpc5200-lpbfifo", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, mpc52xx_lpbfifo_match);
 
 static struct platform_driver mpc52xx_lpbfifo_driver = {
 	.driver = {
-- 
2.4.6
