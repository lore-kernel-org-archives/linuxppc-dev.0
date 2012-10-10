Return-Path: <srinivas.kandagatla@st.com>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
 [207.126.144.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 64B162C008B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 05:34:01 +1100 (EST)
From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
To: grant.likely@secretlab.ca
Subject: [PATCH 3.6.0- 2/2] powerpc/sysdev: use module_platform_driver macro
Date: Wed, 10 Oct 2012 19:32:30 +0100
Message-Id: <1349893950-7710-1-git-send-email-srinivas.kandagatla@st.com>
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
 arch/powerpc/sysdev/pmi.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/pmi.c b/arch/powerpc/sysdev/pmi.c
index 8f04654..5aaf86c 100644
--- a/arch/powerpc/sysdev/pmi.c
+++ b/arch/powerpc/sysdev/pmi.c
@@ -214,18 +214,7 @@ static struct platform_driver pmi_of_platform_driver = {
 		.of_match_table = pmi_match,
 	},
 };
-
-static int __init pmi_module_init(void)
-{
-	return platform_driver_register(&pmi_of_platform_driver);
-}
-module_init(pmi_module_init);
-
-static void __exit pmi_module_exit(void)
-{
-	platform_driver_unregister(&pmi_of_platform_driver);
-}
-module_exit(pmi_module_exit);
+module_platform_driver(pmi_of_platform_driver);
 
 int pmi_send_message(pmi_message_t msg)
 {
-- 
1.7.0.4
