Return-Path: <xenidis@gmail.com>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C0C1EB6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 07:17:00 +1000 (EST)
Received: by qyk35 with SMTP id 35so3403298qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 08 Aug 2011 14:16:57 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: wsp: Fix Wire Speed Processor platform configs
Date: Mon,  8 Aug 2011 16:33:16 -0500
Message-Id: <1312839196-20782-1-git-send-email-jimix@pobox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some config selections were applied to the platform (reference board)
when they actuall apply to the chip.

Signed-off-by: Jimi Xenidis <jimix@pobox.com>
---
 arch/powerpc/platforms/wsp/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/wsp/Kconfig b/arch/powerpc/platforms/wsp/Kconfig
index c3c48eb..d051581 100644
--- a/arch/powerpc/platforms/wsp/Kconfig
+++ b/arch/powerpc/platforms/wsp/Kconfig
@@ -1,5 +1,9 @@
 config PPC_WSP
 	bool
+	select PPC_A2
+	select PPC_SCOM
+	select PPC_XICS
+	select PPC_ICP_NATIVE
 	default n
 
 menu "WSP platform selection"
@@ -7,13 +11,9 @@ menu "WSP platform selection"
 
 config PPC_PSR2
 	bool "PSR-2 platform"
-	select PPC_A2
 	select GENERIC_TBSYNC
-	select PPC_SCOM
 	select EPAPR_BOOT
 	select PPC_WSP
-	select PPC_XICS
-	select PPC_ICP_NATIVE
 	default y
 
 endmenu
-- 
1.7.0.4
