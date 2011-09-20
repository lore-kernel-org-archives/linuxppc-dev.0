Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11311B728A
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 13:45:29 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/20] of: Change logic to overwrite cmd_line with
	CONFIG_CMDLINE
Date: Tue, 20 Sep 2011 13:44:53 +1000
Message-Id: <1316490307-28030-6-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
References: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We used to overwrite with CONFIG_CMDLINE if we found a chosen
node but failed to get bootargs out of it or they were empty,
unless CONFIG_CMDLINE_FORCE is set.

Instead change that to overwrite if cmd_line is non empty after
the bootargs check. It allows arch code to have other mechanisms
to retrieve the command line prior to parsing the device-tree.

Note: CONFIG_CMDLINE_FORCE case should ideally be handled elsewhere
as it won't work as it-is if the device-tree has no /chosen node

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/of/fdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 65200af..d382163 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -683,7 +683,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
 #ifdef CONFIG_CMDLINE
 #ifndef CONFIG_CMDLINE_FORCE
-	if (p == NULL || l == 0 || (l == 1 && (*p) == 0))
+	if (!cmd_line[0])
 #endif
 		strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #endif /* CONFIG_CMDLINE */
-- 
1.7.4.1
