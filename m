Return-Path: <alistair.popple@gmail.com>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E331B2C0150
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Apr 2013 13:43:22 +1000 (EST)
Received: by mail-pd0-f174.google.com with SMTP id y13so3015035pdi.19
 for <linuxppc-dev@ozlabs.org>; Sun, 28 Apr 2013 20:43:20 -0700 (PDT)
Sender: Alistair Popple <alistair.popple@gmail.com>
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: Add a configuration option for early
 BootX/OpenFirmware debug
Date: Mon, 29 Apr 2013 13:42:43 +1000
Message-Id: <1367206964-6319-2-git-send-email-alistair@popple.id.au>
In-Reply-To: <1367206964-6319-1-git-send-email-alistair@popple.id.au>
References: <1367206964-6319-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/Kconfig.debug |    7 +++++++
 arch/powerpc/kernel/udbg.c |    2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 5416e28..e826853 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -147,6 +147,13 @@ choice
 	  enable debugging for the wrong type of machine your kernel
 	  _will not boot_.
 
+config PPC_EARLY_DEBUG_BOOTX
+	bool "BootX or OpenFirmware"
+	depends on BOOTX_TEXT
+	help
+	  Select this to enable early debugging for a machine using BootX
+	  or OpenFirmware.
+
 config PPC_EARLY_DEBUG_LPAR
 	bool "LPAR HV Console"
 	depends on PPC_PSERIES
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index f974849..9bbf07b 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -50,7 +50,7 @@ void __init udbg_early_init(void)
 	udbg_init_debug_beat();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE)
 	udbg_init_pas_realmode();
-#elif defined(CONFIG_BOOTX_TEXT)
+#elif defined(CONFIG_PPC_EARLY_DEBUG_BOOTX)
 	udbg_init_btext();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_44x)
 	/* PPC44x debug */
-- 
1.7.10.4
