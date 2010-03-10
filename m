Return-Path: <jeffm@suse.com>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 70D57B7CF9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 08:03:10 +1100 (EST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 6F4B58655F
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 22:03:08 +0100 (CET)
Message-ID: <4B980909.7050501@suse.com>
Date: Wed, 10 Mar 2010 16:03:05 -0500
From: Jeff Mahoney <jeffm@suse.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Build fix for mpc52xx
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc52xx_gpt_wdt_setup is defined as 0, which causes the following build
failure with gcc 4.5, since it's built with -Werror.

arch/powerpc/platforms/52xx/mpc52xx_gpt.c:761:3: error: statement with no effect

Defining it as do { } while(0) fixes the problem.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -711,7 +711,7 @@ static int __devinit mpc52xx_gpt_wdt_ini
 	return 0;
 }
 
-#define mpc52xx_gpt_wdt_setup(x, y)		(0)
+#define mpc52xx_gpt_wdt_setup(x, y)		do { } while(0)
 
 #endif	/*  CONFIG_MPC5200_WDT	*/
 
-- 
Jeff Mahoney
SUSE Labs
