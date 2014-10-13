Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B94281A06A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 01:01:39 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 01/20] powerpc: Support override of pm_power_off
Date: Mon, 13 Oct 2014 16:01:09 +0200
Message-Id: <1413208888-49211-2-git-send-email-agraf@suse.de>
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

The pm_power_off callback is what drivers are supposed to modify when they
implement power off support for the system.

Support a modified callback on powerpc. That way power off support code can
now either override ppc_md.power_off or pm_power_off.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/setup-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 1362cd6..6398239 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -141,6 +141,8 @@ void machine_power_off(void)
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
