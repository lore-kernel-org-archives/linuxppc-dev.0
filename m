Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 589901A0549
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 01:01:36 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 02/20] powerpc/xmon: Support either ppc_md.power_off or
 pm_power_off
Date: Mon, 13 Oct 2014 16:01:10 +0200
Message-Id: <1413208888-49211-3-git-send-email-agraf@suse.de>
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

Xmon can manually turn off the machine. We now have 2 code paths for this:

  1) ppc_md.power_off
  2) pm_power_off

This patch allows xmon to support both and makes sure it graciously allows
a path to not be implemented.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/xmon/xmon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index b988b5a..531f649 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -981,7 +981,10 @@ static void bootcmds(void)
 	else if (cmd == 'h')
 		ppc_md.halt();
 	else if (cmd == 'p')
-		ppc_md.power_off();
+		if (ppc_md.power_off)
+			ppc_md.power_off();
+		if (pm_power_off)
+			pm_power_off();
 }
 
 static int cpu_cmd(void)
-- 
1.8.1.4
