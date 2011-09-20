Return-Path: <benh@kernel.crashing.org>
Subject: [PATCH v2] of: Change logic to overwrite cmd_line with CONFIG_CMDLINE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Sep 2011 14:50:15 +1000
Message-ID: <1316494215.7975.29.camel@pasglop>
Mime-Version: 1.0
Cc: devicetree-discuss@lists.ozlabs.org
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

Instead change that to overwrite if "data" is non empty after
the bootargs check. It allows arch code to have other mechanisms
to retrieve the command line prior to parsing the device-tree.

Note: CONFIG_CMDLINE_FORCE case should ideally be handled elsewhere
as it won't work as it-is if the device-tree has no /chosen node

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: devicetree-discuss@lists-ozlabs.org
CC: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/of/fdt.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

v2. Use "data" instead of "cmd_line" so it works on archs like
mips who don't pass cmd_line to that function to start with, also
add a comment explaining the mechanism.

(resent with right list address as well while at it)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 65200af..323b722 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -681,9 +681,14 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 	if (p != NULL && l > 0)
 		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
 
+	/*
+	 * CONFIG_CMDLINE is meant to be a default in case nothing else
+	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
+	 * is set in which case we override whatever was found earlier.
+	 */
 #ifdef CONFIG_CMDLINE
 #ifndef CONFIG_CMDLINE_FORCE
-	if (p == NULL || l == 0 || (l == 1 && (*p) == 0))
+	if (!data[0])
 #endif
 		strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #endif /* CONFIG_CMDLINE */
-- 
1.7.4.1
