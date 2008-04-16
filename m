Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id A3187DE75D
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 03:52:36 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] mpc86xx_hpcn: Temporarily accept old dts node identifier.
Date: Wed, 16 Apr 2008 13:53:07 -0400
Message-Id: <a267e81e741560d8715ca4422179dcfe2ec467c6.1208364243.git.paul.gortmaker@windriver.com>
In-Reply-To: <ebd47a82600724a6a80f7fd6efacab22e778858d.1208364243.git.paul.gortmaker@windriver.com>
References: <80CCBF8C-FE21-4DD7-B1CF-0647D31655D9@kernel.crashing.org>
	<ebd47a82600724a6a80f7fd6efacab22e778858d.1208364243.git.paul.gortmaker@windriver.com>
In-Reply-To: <ebd47a82600724a6a80f7fd6efacab22e778858d.1208364243.git.paul.gortmaker@windriver.com>
References: <ebd47a82600724a6a80f7fd6efacab22e778858d.1208364243.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As suggested by Timur Tabi, we match on the old compat node ID for one
version and warn accordingly.  If we don't do this, we plunge people who
try to use an old DTB into silent boot death with no clear indication of
what the problem is.

This patch should be removed at the beginning of the 2.6.27 dev cycle.
It is only meant to ease the transition in the short term.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 0764032..f947f55 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -193,6 +193,12 @@ static int __init mpc86xx_hpcn_probe(void)
 	if (of_flat_dt_is_compatible(root, "fsl,mpc8641hpcn"))
 		return 1;	/* Looks good */
 
+	/* Be nice and don't give silent boot death.  Delete this in 2.6.27 */
+	if (of_flat_dt_is_compatible(root, "mpc86xx")) {
+		pr_warning("WARNING: your dts/dtb is old. You must update before the next kernel release\n");
+		return 1;
+	}
+
 	return 0;
 }
 
-- 
1.5.4.3
