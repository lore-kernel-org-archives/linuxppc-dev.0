Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: grant.likely@secretlab.ca, Wolfram Sang <w.sang@pengutronix.de>
MIME-Version: 1.0
Subject: [PATCH] powerpc: Fix mpc52xx_gpt when sysfs is not configured
Date: Thu, 05 Mar 2009 17:03:59 +1100
Message-ID: <25409.1236233039@neuling.org>
Sender: mikey@neuling.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mpc52xx_gpt_create_attribs is missing a parameter name and shouldn't
return anything since it's void.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
This is against benh's testing tree

 arch/powerpc/platforms/52xx/mpc52xx_gpt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: clone1/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
===================================================================
--- clone1.orig/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ clone1/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -370,7 +370,7 @@ static void mpc52xx_gpt_create_attribs(s
 }
 
 #else /* defined(CONFIG_SYSFS) */
-static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *) { return 0; }
+static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *gpt) {}
 #endif /* defined(CONFIG_SYSFS) */
 
 /* ---------------------------------------------------------------------
