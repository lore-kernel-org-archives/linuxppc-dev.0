Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3A84867A97
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jan 2005 11:28:44 +1100 (EST)
Date: Mon, 24 Jan 2005 15:51:42 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0501241548380.23263@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: waite@skycomputers.com, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: fix powersave with interrupts disabled
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It looks like the problem has to do with entering the powersave routine 
with irqs disabled. Here is a patch that will only enter powersave if irqs 
are enabled.

Entering powersave on PPC while irqs are disabled causes a hang. Only 
enter powersave if irqs are disabled.

Signed-off-by: Brian Waite <waite@skycomputers.com> 
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/kernel/idle.c b/arch/ppc/kernel/idle.c
--- a/arch/ppc/kernel/idle.c	2005-01-24 15:48:24 -06:00
+++ b/arch/ppc/kernel/idle.c	2005-01-24 15:48:24 -06:00
@@ -39,7 +39,7 @@
 	powersave = ppc_md.power_save;
 
 	if (!need_resched()) {
-		if (powersave != NULL)
+		if (powersave != NULL && !irqs_disabled())
 			powersave();
 		else {
 #ifdef CONFIG_SMP
