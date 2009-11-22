Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id 3970F100809
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:02:07 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 07/19] powerpc: gamecube/wii: declare as non-coherent
	platforms
Date: Sun, 22 Nov 2009 23:01:38 +0100
Message-Id: <1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The processors bundled in the Nintendo GameCube and Wii video game consoles
require explicit cache handling when DMA engines are used.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/platforms/Kconfig.cputype     |    2 +-
 arch/powerpc/platforms/embedded6xx/Kconfig |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index e382cae..80d934b 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -312,7 +312,7 @@ config NR_CPUS
 
 config NOT_COHERENT_CACHE
 	bool
-	depends on 4xx || 8xx || E200 || PPC_MPC512x
+	depends on 4xx || 8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
 	default y
 
 config CHECK_CACHE_COHERENCY
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 97a2dbc..31487e4 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -93,4 +93,5 @@ config MPC10X_STORE_GATHERING
 
 config GAMECUBE_COMMON
 	bool
+	select NOT_COHERENT_CACHE
 
-- 
1.6.3.3
