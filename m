Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 76FEDB6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 18:38:32 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q2E7cMv7008919
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 02:38:23 -0500
Message-ID: <1331710700.3105.112.camel@pasglop>
Subject: [PATCH] powerpc/hvc_udbg: Don't crash when udbg_putc is NULL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 14 Mar 2012 18:38:20 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also while at it, add some help text indicating why you shouldn't
enable that driver under normal circumstances

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/tty/hvc/Kconfig    |    4 ++++
 drivers/tty/hvc/hvc_udbg.c |    8 +++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 8ea7f07..48cb8d3 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -71,6 +71,10 @@ config HVC_UDBG
        depends on PPC && EXPERIMENTAL
        select HVC_DRIVER
        default n
+       help
+         This is meant to be used during HW bring up or debugging when
+	 no other console mechanism exist but udbg, to get you a quick
+	 console for userspace. Do NOT enable in production kernels. 
 
 config HVC_DCC
        bool "ARM JTAG DCC console"
diff --git a/drivers/tty/hvc/hvc_udbg.c b/drivers/tty/hvc/hvc_udbg.c
index b0957e6..2259c6e 100644
--- a/drivers/tty/hvc/hvc_udbg.c
+++ b/drivers/tty/hvc/hvc_udbg.c
@@ -36,7 +36,7 @@ static int hvc_udbg_put(uint32_t vtermno, const char *buf, int count)
 {
 	int i;
 
-	for (i = 0; i < count; i++)
+	for (i = 0; i < count && udbg_putc; i++)
 		udbg_putc(buf[i]);
 
 	return i;
@@ -67,6 +67,9 @@ static int __init hvc_udbg_init(void)
 {
 	struct hvc_struct *hp;
 
+	if (!udbg_putc)
+		return -ENODEV;
+
 	BUG_ON(hvc_udbg_dev);
 
 	hp = hvc_alloc(0, NO_IRQ, &hvc_udbg_ops, 16);
@@ -88,6 +91,9 @@ module_exit(hvc_udbg_exit);
 
 static int __init hvc_udbg_console_init(void)
 {
+	if (!udbg_putc)
+		return -ENODEV;
+
 	hvc_instantiate(0, 0, &hvc_udbg_ops);
 	add_preferred_console("hvc", 0, NULL);
 
-- 
1.7.9
