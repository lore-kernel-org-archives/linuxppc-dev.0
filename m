Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6BA37B71B4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 12:34:35 +1100 (EST)
Date: Tue, 20 Dec 2011 19:34:14 -0600
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>
Subject: [RFC PATCH 02/16] powerpc/e500: split
 CPU_FTRS_ALWAYS/CPU_FTRS_POSSIBLE
Message-ID: <20111221013414.GB8378@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20111221013340.GA8368@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Split e500 (v1/v2) and e500mc/e5500 to allow optimization of feature
checks that differ between the two.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/cputable.h |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 033ad30..a80be60 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -482,8 +482,10 @@ enum {
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
@@ -527,8 +529,10 @@ enum {
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
1.7.7.rc3.4.g8d714
