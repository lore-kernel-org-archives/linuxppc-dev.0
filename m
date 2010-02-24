Return-Path: <meissner@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 4FE75B7CBD
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 19:51:40 +1100 (EST)
Date: Wed, 24 Feb 2010 09:51:37 +0100
From: Marcus Meissner <meissner@suse.de>
To: linuxppc-dev@ozlabs.org, albrecht.dress@arcor.de, grant.likely@secretlab.ca
Subject: [PATCH] Fixed statement without effect by using a correct empty
	instruction
Message-ID: <20100224085137.GA25801@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes this build failure:
cc1: warnings being treated as errors
/usr/src/packages/BUILD/kernel-default-2.6.33/linux-2.6.32/arch/powerpc/platforms/52xx/mpc52xx_gpt.c: In function 'mpc52xx_gpt_probe':
/usr/src/packages/BUILD/kernel-default-2.6.33/linux-2.6.32/arch/powerpc/platforms/52xx/mpc52xx_gpt.c:761:3: error: statement with no effect

Signed-off-by: Marcus Meissner <meissner@suse.de>
---
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 6f8ebe1..88231d8 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -711,7 +711,7 @@ static int __devinit mpc52xx_gpt_wdt_init(void)
 	return 0;
 }
 
-#define mpc52xx_gpt_wdt_setup(x, y)		(0)
+#define mpc52xx_gpt_wdt_setup(x, y)		do { } while (0)
 
 #endif	/*  CONFIG_MPC5200_WDT	*/
 
-- 
1.6.6.1
