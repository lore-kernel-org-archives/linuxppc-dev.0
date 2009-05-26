Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 696DCDE118
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 01:23:27 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org,
	benh@kernel.crashing.org, jonsmirl@gmail.com, arnd@arndb.de,
	geert.uytterhoeven@sonycom.com
Subject: [PATCH 2/2] [PATCH 2/2 v2] qe: add polling timeout to qe_issue_cmd()
Date: Tue, 26 May 2009 10:21:42 -0500
Message-Id: <1243351302-32062-3-git-send-email-timur@freescale.com>
In-Reply-To: <1243351302-32062-2-git-send-email-timur@freescale.com>
References: <1243351302-32062-1-git-send-email-timur@freescale.com>
	<1243351302-32062-2-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The qe_issue_cmd() function (Freescale PowerPC QUICC Engine library) polls on
a register until a status bit changes, but does not include a timeout to
handle the situation if the bit never changes.  Change the code to use the new
spin_event_timeout() macro, which simplifies polling on a register without
a timeout.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch depends on my previous patch, "powerpc: introduce macro
spin_event_timeout()".

 arch/powerpc/sysdev/qe_lib/qe.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 01bce37..05bdd43 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -111,6 +111,7 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
 {
 	unsigned long flags;
 	u8 mcn_shift = 0, dev_shift = 0;
+	u32 ret;
 
 	spin_lock_irqsave(&qe_lock, flags);
 	if (cmd == QE_RESET) {
@@ -138,11 +139,13 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
 	}
 
 	/* wait for the QE_CR_FLG to clear */
-	while(in_be32(&qe_immr->cp.cecr) & QE_CR_FLG)
-		cpu_relax();
+	ret = spin_event_timeout((in_be32(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
+			   100, 0);
+	/* On timeout (e.g. failure), the expression will be false (ret == 0),
+	   otherwise it will be true (ret == 1). */
 	spin_unlock_irqrestore(&qe_lock, flags);
 
-	return 0;
+	return ret == 1;
 }
 EXPORT_SYMBOL(qe_issue_cmd);
 
-- 
1.6.0.6
