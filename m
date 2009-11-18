Return-Path: <dmitch71@gmail.com>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id CE313B6EF5
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 11:57:36 +1100 (EST)
Received: by gxk28 with SMTP id 28so619414gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 16:57:34 -0800 (PST)
Sender: David Mitchell <dmitch71@gmail.com>
From: Dave Mitchell <dmitchell@appliedmicro.com>
To: netdev@vger.kernel.org
Subject: [PATCH] ibm_newemac: Fix EMACx_TRTR[TRT] bit shifts
Date: Tue, 17 Nov 2009 18:56:55 -0600
Message-Id: <1258505815-31261-1-git-send-email-dmitchell@appliedmicro.com>
Cc: linuxppc-dev@ozlabs.org, dmitchell@appliedmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The TRT bit shifts were reversed for EMAC4 and non-EMAC4 during the 
port from ibm_emac to ibm_newemac. This patch corrects that error.

Signed-off-by: Dave Mitchell <dmitchell@appliedmicro.com>
Acked-by: Feng Kan <fkan@appliedmicro.com>
Acked-by: Prodyut Hazarika <phazarika@appliedmicro.com>
---
 For those curious, these bits control the TX threshold.
 
 drivers/net/ibm_newemac/emac.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ibm_newemac/emac.h b/drivers/net/ibm_newemac/emac.h
index d34adf9..f2751cb 100644
--- a/drivers/net/ibm_newemac/emac.h
+++ b/drivers/net/ibm_newemac/emac.h
@@ -263,8 +263,8 @@ struct emac_regs {
 
 
 /* EMACx_TRTR */
-#define EMAC_TRTR_SHIFT_EMAC4		27
-#define EMAC_TRTR_SHIFT			24
+#define EMAC_TRTR_SHIFT_EMAC4		24
+#define EMAC_TRTR_SHIFT		27
 
 /* EMAC specific TX descriptor control fields (write access) */
 #define EMAC_TX_CTRL_GFCS		0x0200
-- 
1.6.3.2
