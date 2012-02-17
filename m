Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE76DB6FD1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 04:14:01 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 02/30] powerpc/e500: split CPU_FTRS_ALWAYS/CPU_FTRS_POSSIBLE
Date: Fri, 17 Feb 2012 18:13:29 +0100
Message-Id: <1329498837-11717-3-git-send-email-agraf@suse.de>
In-Reply-To: <1329498837-11717-1-git-send-email-agraf@suse.de>
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

Split e500 (v1/v2) and e500mc/e5500 to allow optimization of feature
checks that differ between the two.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/cputable.h |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 6a034a2..2022f2d 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -483,8 +483,10 @@ enum {
 	    CPU_FTRS_E200 |
 #endif
 #ifdef CONFIG_E500
-	    CPU_FTRS_E500 | CPU_FTRS_E500_2 | CPU_FTRS_E500MC |
-	    CPU_FTRS_E5500 |
+	    CPU_FTRS_E500 | CPU_FTRS_E500_2 |
+#endif
+#ifdef CONFIG_PPC_E500MC
+	    CPU_FTRS_E500MC | CPU_FTRS_E5500 |
 #endif
 	    0,
 };
@@ -528,8 +530,10 @@ enum {
 	    CPU_FTRS_E200 &
 #endif
 #ifdef CONFIG_E500
-	    CPU_FTRS_E500 & CPU_FTRS_E500_2 & CPU_FTRS_E500MC &
-	    CPU_FTRS_E5500 &
+	    CPU_FTRS_E500 & CPU_FTRS_E500_2 &
+#endif
+#ifdef CONFIG_PPC_E500MC
+	    CPU_FTRS_E500MC & CPU_FTRS_E5500 &
 #endif
 	    CPU_FTRS_POSSIBLE,
 };
-- 
1.6.0.2
