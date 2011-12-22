Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id B3DC7B71AD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Dec 2011 03:22:08 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/currituck: Fix up missing MPIC_PRIMARY flag
Date: Thu, 22 Dec 2011 11:21:21 -0500
Message-Id: <1324570881-11503-1-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 44x/currituck platform didn't get updated when the MPIC code
inverted the flag from MPIC_PRIMARY => !MPIC_SECONDARY.  Fix it up.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/platforms/44x/currituck.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/44x/currituck.c b/arch/powerpc/platforms/44x/currituck.c
index 1fdf569..3f6229b 100644
--- a/arch/powerpc/platforms/44x/currituck.c
+++ b/arch/powerpc/platforms/44x/currituck.c
@@ -83,7 +83,7 @@ static void __init ppc47x_init_irq(void)
 		 * device-tree, just pass 0 to all arguments
 		 */
 		struct mpic *mpic =
-			mpic_alloc(np, 0, MPIC_PRIMARY, 0, 0, " MPIC     ");
+			mpic_alloc(np, 0, 0, 0, 0, " MPIC     ");
 		BUG_ON(mpic == NULL);
 		mpic_init(mpic);
 		ppc_md.get_irq = mpic_get_irq;
-- 
1.7.7.3
