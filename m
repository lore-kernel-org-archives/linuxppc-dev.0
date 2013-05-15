Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews07.kpnxchange.com (cpsmtpb-ews07.kpnxchange.com
 [213.75.39.10]) by ozlabs.org (Postfix) with ESMTP id 0CEE92C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 19:34:20 +1000 (EST)
Message-ID: <1368609661.1350.185.camel@x61.thuisdomein>
Subject: [PATCH] powerpc: remove dependency on MV64360
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Wed, 15 May 2013 11:21:01 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Kconfig entry that allows to "Distribute interrupts on all CPUs by
default" has a (negative) dependency on MV64360. But that Kconfig symbol
was removed in v2.6.27, which means that this dependency has evaluated
to true ever since. It can be removed too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested by grepping the tree.

 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c33e3ad..9a822d9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -404,7 +404,7 @@ config FA_DUMP
 
 config IRQ_ALL_CPUS
 	bool "Distribute interrupts on all CPUs by default"
-	depends on SMP && !MV64360
+	depends on SMP
 	help
 	  This option gives the kernel permission to distribute IRQs across
 	  multiple CPUs.  Saying N here will route all IRQs to the first
-- 
1.7.11.7
