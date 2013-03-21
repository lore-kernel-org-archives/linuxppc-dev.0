Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews05.kpnxchange.com (cpsmtpb-ews05.kpnxchange.com
 [213.75.39.8]) by ozlabs.org (Postfix) with ESMTP id 6F09E2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 22:10:15 +1100 (EST)
Message-ID: <1363864206.1390.117.camel@x61.thuisdomein>
Subject: [PATCH] powerpc: drop even more unused Kconfig symbols
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Thu, 21 Mar 2013 12:10:06 +0100
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

When I submitted commit 6805ab6daa2b589fe3242d05ddc47a9dbb0c4eb1
("powerpc: drop unused Kconfig symbols") I apparently failed to notice
that my patch also made PREP_RESIDUAL and PPC_A2_DD2 unused. Drop these
now.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Untested.

1) I investigated these Kconfig files a bit and discovered that PPC_PREP
is marked BROKEN since v2.6.15, see commit
5be396b00ca0f2f769c55cf69bbd7c77451c925e ("powerpc: Mark PREP and
embedded as broken for now"). Though it's not my problem, this does
suggest PReP support can be removed entirely.

 arch/powerpc/platforms/prep/Kconfig | 13 -------------
 arch/powerpc/platforms/wsp/Kconfig  |  4 ----
 2 files changed, 17 deletions(-)

diff --git a/arch/powerpc/platforms/prep/Kconfig b/arch/powerpc/platforms/prep/Kconfig
index 1547f66..2036e7e 100644
--- a/arch/powerpc/platforms/prep/Kconfig
+++ b/arch/powerpc/platforms/prep/Kconfig
@@ -8,16 +8,3 @@ config PPC_PREP
 	select PPC_UDBG_16550
 	select PPC_NATIVE
 	default n
-
-config PREP_RESIDUAL
-	bool "Support for PReP Residual Data"
-	depends on PPC_PREP
-	help
-	  Some PReP systems have residual data passed to the kernel by the
-	  firmware.  This allows detection of memory size, devices present and
-	  other useful pieces of information.  Sometimes this information is
-	  not present or incorrect, in which case it could lead to the machine 
-	  behaving incorrectly.  If this happens, either disable PREP_RESIDUAL
-	  or pass the 'noresidual' option to the kernel.
-
-	  If you are running a PReP system, say Y here, otherwise say N.
diff --git a/arch/powerpc/platforms/wsp/Kconfig b/arch/powerpc/platforms/wsp/Kconfig
index 79d2225..9eea710 100644
--- a/arch/powerpc/platforms/wsp/Kconfig
+++ b/arch/powerpc/platforms/wsp/Kconfig
@@ -29,7 +29,3 @@ config PPC_CHROMA
 	default y
 
 endmenu
-
-config PPC_A2_DD2
-	bool "Support for DD2 based A2/WSP systems"
-	depends on PPC_A2
-- 
1.7.11.7
