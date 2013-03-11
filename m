Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews09.kpnxchange.com (cpsmtpb-ews09.kpnxchange.com
 [213.75.39.14]) by ozlabs.org (Postfix) with ESMTP id E114F2C02C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 10:45:09 +1100 (EST)
Message-ID: <1363045495.3137.126.camel@x61.thuisdomein>
Subject: [PATCH] powerpc: Remove last traces of POWER4_ONLY
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Tue, 12 Mar 2013 00:44:55 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Kconfig symbol POWER4_ONLY got removed in commit
694caf0255dcab506d1e174c96a65ab65d96e108 ("powerpc: Remove
CONFIG_POWER4_ONLY"). Remove its last traces.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/powerpc/platforms/Kconfig.cputype | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index cea2f09..18e3b76 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -124,9 +124,8 @@ config 6xx
 	select PPC_HAVE_PMU_SUPPORT
 
 config POWER3
-	bool
 	depends on PPC64 && PPC_BOOK3S
-	default y if !POWER4_ONLY
+	def_bool y
 
 config POWER4
 	depends on PPC64 && PPC_BOOK3S
@@ -145,8 +144,7 @@ config TUNE_CELL
 	  but somewhat slower on other machines. This option only changes
 	  the scheduling of instructions, not the selection of instructions
 	  itself, so the resulting kernel will keep running on all other
-	  machines. When building a kernel that is supposed to run only
-	  on Cell, you should also select the POWER4_ONLY option.
+	  machines.
 
 # this is temp to handle compat with arch=ppc
 config 8xx
-- 
1.7.11.7
