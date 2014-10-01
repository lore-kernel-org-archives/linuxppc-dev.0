Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17B131A1800
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:19 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/20] powerpc: Support override of pm_power_off
Date: Wed,  1 Oct 2014 15:27:47 +0200
Message-Id: <1412170086-57971-2-git-send-email-agraf@suse.de>
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

The pm_power_off callback is what drivers are supposed to modify when they
implement power off support for the system.

Support a modified callback on powerpc. That way power off support code can
now either override ppc_md.power_off or pm_power_off.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/setup-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 1b0e260..5dfcb28 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -140,6 +140,8 @@ void machine_power_off(void)
 	machine_shutdown();
 	if (ppc_md.power_off)
 		ppc_md.power_off();
+	if (pm_power_off != machine_power_off)
+		pm_power_off();
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
-- 
1.8.1.4
