Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6DD1DB6EF2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2012 14:50:45 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: dont include 8250 pre-setup if 8250 driver isn't
 enabled.
Date: Fri, 20 Jan 2012 22:50:28 -0500
Message-Id: <1327117828-27085-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The legacy_serial code was setting things up based on the assumption
that the main 8250 driver would be loaded shortly after.  But some
randconfigs exposed an issue where early debug (UDB) UART support was
enabled, yet the core UART 8250 support was disabled.

In theory a person could care about _really_ early UART output for
early debug, but not care about generic console output via UART on
embedded devices, so fix things so it is a valid combination.

While this might seem like a pointless randconfig change, there are
some existing default configs that actually reflect the above setup.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 3fea368..9a82a49 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -413,6 +413,14 @@ void __init find_legacy_serial_ports(void)
 	DBG(" <- find_legacy_serial_port()\n");
 }
 
+/*
+ * In theory, one could have the early debugging enabled, but yet not care
+ * about 8250 after that, i.e. PPC_UDBG_16550=y but "SERIAL_8250 is not set".
+ * Mostly appears in randconfig builds, but some defconfigs have this.
+ */
+
+#ifdef CONFIG_SERIAL_8250
+
 static struct platform_device serial_device = {
 	.name	= "serial8250",
 	.id	= PLAT8250_DEV_PLATFORM,
@@ -523,6 +531,7 @@ static int __init serial_dev_init(void)
 }
 device_initcall(serial_dev_init);
 
+#endif	/* CONFIG_SERIAL_8250 */
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 /*
-- 
1.7.7.2
