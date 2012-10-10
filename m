Return-Path: <srinivas.kandagatla@st.com>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
 [207.126.144.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 69A6D2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 05:34:01 +1100 (EST)
From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
To: grant.likely@secretlab.ca
Subject: [PATCH 3.6.0- 1/2] powerpc/mpc52xx: use module_platform_driver macro
Date: Wed, 10 Oct 2012 19:32:24 +0100
Message-Id: <1349893944-7675-1-git-send-email-srinivas.kandagatla@st.com>
Cc: krafft@de.ibm.com, agust@denx.de, linuxppc-dev@lists.ozlabs.org,
 srinivas.kandagatla@st.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
index 2351f9e..16150fa 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -578,18 +578,4 @@ static struct platform_driver mpc52xx_lpbfifo_driver = {
 	.probe = mpc52xx_lpbfifo_probe,
 	.remove = __devexit_p(mpc52xx_lpbfifo_remove),
 };
-
-/***********************************************************************
- * Module init/exit
- */
-static int __init mpc52xx_lpbfifo_init(void)
-{
-	return platform_driver_register(&mpc52xx_lpbfifo_driver);
-}
-module_init(mpc52xx_lpbfifo_init);
-
-static void __exit mpc52xx_lpbfifo_exit(void)
-{
-	platform_driver_unregister(&mpc52xx_lpbfifo_driver);
-}
-module_exit(mpc52xx_lpbfifo_exit);
+module_platform_driver(mpc52xx_lpbfifo_driver);
-- 
1.7.0.4
