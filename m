Return-Path: <luisbg@osg.samsung.com>
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by lists.ozlabs.org (Postfix) with ESMTP id 5A3E81A01B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 02:04:15 +1100 (AEDT)
From: Luis de Bethencourt <luisbg@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, agust@denx.de, axboe@fb.com, jack@suse.cz,
 dan.j.williams@intel.com, matthew.r.wilcox@intel.com, neilb@suse.com,
 ross.zwisler@linux.intel.com, Luis de Bethencourt <luis@debethencourt.com>,
 Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [RESEND PATCH 1/2] powerpc: platforms: mpc52xx_lpbfifo: Fix module
 autoload for OF platform driver
Date: Tue, 20 Oct 2015 16:04:12 +0100
Message-Id: <1445353453-846-2-git-send-email-luisbg@osg.samsung.com>
In-Reply-To: <1445353453-846-1-git-send-email-luisbg@osg.samsung.com>
References: <1445353453-846-1-git-send-email-luisbg@osg.samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Luis de Bethencourt <luis@debethencourt.com>

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
2.5.3
