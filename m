Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE0DE1A06E9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 01:01:39 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 20/20] powerpc: Remove ppc_md.power_off
Date: Mon, 13 Oct 2014 16:01:28 +0200
Message-Id: <1413208888-49211-21-git-send-email-agraf@suse.de>
In-Reply-To: <1413208888-49211-1-git-send-email-agraf@suse.de>
References: <1413208888-49211-1-git-send-email-agraf@suse.de>
Cc: arnd@arndb.de, geoff@infradead.org, alistair@popple.id.au,
 scottwood@freescale.com, agust@denx.de, linux@roeck-us.net
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
index 307347f..f15f15c 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -142,7 +142,6 @@ struct machdep_calls {
 #endif
 
 	void		(*restart)(char *cmd);
-	void		(*power_off)(void);
 	void		(*halt)(void);
 	void		(*panic)(char *str);
 	void		(*cpu_die)(void);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 6398239..44c8d03 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -139,9 +139,7 @@ void machine_restart(char *cmd)
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
@@ -153,7 +151,7 @@ void machine_power_off(void)
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
