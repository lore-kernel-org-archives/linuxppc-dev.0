Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A42C1A185A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:22 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 20/20] powerpc: Remove ppc_md.power_off
Date: Wed,  1 Oct 2014 15:28:06 +0200
Message-Id: <1412170086-57971-21-git-send-email-agraf@suse.de>
In-Reply-To: <1412170086-57971-1-git-send-email-agraf@suse.de>
References: <1412170086-57971-1-git-send-email-agraf@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have all implementations of ppc_md.power_off converted to
pm_power_off we can remove the ppc_md variant.

While at it, also set the default for pm_power_off to NULL so that non
machine drivers can implement overrides.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/machdep.h | 1 -
 arch/powerpc/kernel/setup-common.c | 6 ++----
 arch/powerpc/xmon/xmon.c           | 2 --
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index b125cea..10dc008 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -144,7 +144,6 @@ struct machdep_calls {
 #endif
 
 	void		(*restart)(char *cmd);
-	void		(*power_off)(void);
 	void		(*halt)(void);
 	void		(*panic)(char *str);
 	void		(*cpu_die)(void);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 5dfcb28..58a260f 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -138,9 +138,7 @@ void machine_restart(char *cmd)
 void machine_power_off(void)
 {
 	machine_shutdown();
-	if (ppc_md.power_off)
-		ppc_md.power_off();
-	if (pm_power_off != machine_power_off)
+	if (pm_power_off)
 		pm_power_off();
 #ifdef CONFIG_SMP
 	smp_send_stop();
@@ -152,7 +150,7 @@ void machine_power_off(void)
 /* Used by the G5 thermal driver */
 EXPORT_SYMBOL_GPL(machine_power_off);
 
-void (*pm_power_off)(void) = machine_power_off;
+void (*pm_power_off)(void);
 EXPORT_SYMBOL_GPL(pm_power_off);
 
 void machine_halt(void)
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 531f649..506d256 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -981,8 +981,6 @@ static void bootcmds(void)
 	else if (cmd == 'h')
 		ppc_md.halt();
 	else if (cmd == 'p')
-		if (ppc_md.power_off)
-			ppc_md.power_off();
 		if (pm_power_off)
 			pm_power_off();
 }
-- 
1.8.1.4
