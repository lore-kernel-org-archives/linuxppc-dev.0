Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ECD2DB790D
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Sep 2011 00:20:42 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/21] powerpc/powernv: Get kernel command line accross OPAL
	takeover
Date: Sat, 10 Sep 2011 11:19:57 -0300
Message-Id: <1315664408-16797-10-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
References: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We stash it in boot_command_line which isn't in BSS and so won't
be overwritten. We then use that as a default cmd_line before
we walk the device-tree.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom.c             |    7 +++++++
 arch/powerpc/kernel/prom_init.c        |    4 ++++
 arch/powerpc/kernel/prom_init_check.sh |    3 ++-
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 174e1e9..7b90c56 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -712,6 +712,13 @@ void __init early_init_devtree(void *params)
 	of_scan_flat_dt(early_init_dt_scan_phyp_dump, NULL);
 #endif
 
+	/* Pre-initialize the cmd_line with the content of boot_commmand_line,
+	 * which will be empty except when the content of the variable has
+	 * been overriden by a bootloading mechanism. This happens typically
+	 * with HAL takeover
+	 */
+	strlcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
+
 	/* Retrieve various informations from the /chosen node of the
 	 * device-tree, including the platform type, initrd location and
 	 * size, TCE reserve, and more ...
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 9369287..e3f3904 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1449,6 +1449,10 @@ static void prom_opal_takeover(void)
 		opal_addr = top_addr;
 	args->hal_addr = opal_addr;
 
+	/* Copy the command line to the kernel image */
+	strlcpy(RELOC(boot_command_line), RELOC(prom_cmd_line),
+		COMMAND_LINE_SIZE);
+
 	prom_debug("  k_image    = 0x%lx\n", args->k_image);
 	prom_debug("  k_size     = 0x%lx\n", args->k_size);
 	prom_debug("  k_entry    = 0x%lx\n", args->k_entry);
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 20af6aa..70f4286 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -21,7 +21,8 @@ _end enter_prom memcpy memset reloc_offset __secondary_hold
 __secondary_hold_acknowledge __secondary_hold_spinloop __start
 strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
 reloc_got2 kernstart_addr memstart_addr linux_banner _stext
-opal_query_takeover opal_do_takeover opal_enter_rtas opal_secondary_entry"
+opal_query_takeover opal_do_takeover opal_enter_rtas opal_secondary_entry
+boot_command_line"
 
 NM="$1"
 OBJ="$2"
-- 
1.7.4.1
