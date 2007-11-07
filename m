Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 59C07DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 02:32:07 +1100 (EST)
Date: Wed, 7 Nov 2007 09:41:30 -0600
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] pasemi: Move cpus to hold loop before restart
Message-ID: <20071107154130.GB3187@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC] pasemi: Move cpus to hold loop before restart

Use smp_send_stop() to move all cpus besides the one executing reboot
into a hold loop, to keep them from being in powersavings mode at the
time of reboot.

Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index bd85853..14dace7 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -60,6 +60,9 @@ static int num_mce_regs;
 
 static void pas_restart(char *cmd)
 {
+	/* Need to put others cpu in hold loop so they're not sleeping */
+	smp_send_stop();
+	udelay(10000);
 	printk("Restarting...\n");
 	while (1)
 		out_le32(reset_reg, 0x6000000);
