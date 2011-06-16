Return-Path: <monstr@monstr.eu>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C524EB7170
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2011 00:14:39 +1000 (EST)
Received: by fxm1 with SMTP id 1so1329371fxm.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 07:14:35 -0700 (PDT)
From: Michal Simek <monstr@monstr.eu>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 2/7] powerpc: Permit non-zero physical start address for
	PPC44x
Date: Thu, 16 Jun 2011 16:14:23 +0200
Message-Id: <1308233668-24166-3-git-send-email-monstr@monstr.eu>
In-Reply-To: <1308233668-24166-2-git-send-email-monstr@monstr.eu>
References: <1308233668-24166-1-git-send-email-monstr@monstr.eu>
	<1308233668-24166-2-git-send-email-monstr@monstr.eu>
Cc: arnd@arndb.de, tmarri@apm.com, suzuki@in.ibm.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: John Williams <john.williams@petalogix.com>

The initial TLB entry is 256M, meaning that the physical base address must be
256M aligned.

Signed-off-by: John Williams <john.williams@petalogix.com>
---
 arch/powerpc/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d00131c..45c9683 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -845,7 +845,7 @@ config KERNEL_START
 
 config PHYSICAL_START_BOOL
 	bool "Set physical address where the kernel is loaded"
-	depends on ADVANCED_OPTIONS && FLATMEM && FSL_BOOKE
+	depends on ADVANCED_OPTIONS && FLATMEM && (FSL_BOOKE || 44x)
 	help
 	  This gives the physical address where the kernel is loaded.
 
@@ -858,6 +858,7 @@ config PHYSICAL_START
 
 config PHYSICAL_ALIGN
 	hex
+	default "0x10000000" if 44x
 	default "0x04000000" if FSL_BOOKE
 	help
 	  This value puts the alignment restrictions on physical address
-- 
1.5.5.6
