Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6499C67A39
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Feb 2006 10:24:08 +1100 (EST)
Date: Fri, 24 Feb 2006 17:14:25 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH][UPDATE] powerpc: Fix mem= cmdline handling on arch/powerpc
	for !MULTIPLATFORM
In-Reply-To: <815A460C-BAB0-4770-8357-68136D31EDC3@kernel.crashing.org>
Message-ID: <Pine.LNX.4.44.0602241713380.11387-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mem= command line option was being ignored in arch/powerpc if we were not
a CONFIG_MULTIPLATFORM (which is handled via prom_init stub). The initial
command line extraction and parsing needed to be moved earlier in the boot
process and have code to actual parse mem= and do something about it.

Also, fixed a compile warning in the file.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit a49869ffbf01f3998523357c85f7b55a6d064cda
tree efd39700c07ac02cb6216ebf8d6d0d2adf7be36a
parent 820ac48b82821c6d38747ea49f98aeca05ca2e2b
author Kumar Gala <galak@kernel.crashing.org> Fri, 24 Feb 2006 17:08:54 -0600
committer Kumar Gala <galak@kernel.crashing.org> Fri, 24 Feb 2006 17:08:54 -0600

 arch/powerpc/kernel/prom.c |   42 ++++++++++++++++++++++++++----------------
 1 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 294832a..670654b 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -816,8 +816,6 @@ void __init unflatten_device_tree(void)
 {
 	unsigned long start, mem, size;
 	struct device_node **allnextp = &allnodes;
-	char *p = NULL;
-	int l = 0;
 
 	DBG(" -> unflatten_device_tree()\n");
 
@@ -857,19 +855,6 @@ void __init unflatten_device_tree(void)
 	if (of_chosen == NULL)
 		of_chosen = of_find_node_by_path("/chosen@0");
 
-	/* Retreive command line */
-	if (of_chosen != NULL) {
-		p = (char *)get_property(of_chosen, "bootargs", &l);
-		if (p != NULL && l > 0)
-			strlcpy(cmd_line, p, min(l, COMMAND_LINE_SIZE));
-	}
-#ifdef CONFIG_CMDLINE
-	if (l == 0 || (l == 1 && (*p) == 0))
-		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#endif /* CONFIG_CMDLINE */
-
-	DBG("Command line is: %s\n", cmd_line);
-
 	DBG(" <- unflatten_device_tree()\n");
 }
 
@@ -940,6 +925,8 @@ static int __init early_init_dt_scan_cho
 {
 	u32 *prop;
 	unsigned long *lprop;
+	unsigned long l;
+	char *p;
 
 	DBG("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
 
@@ -1004,6 +991,29 @@ static int __init early_init_dt_scan_cho
                crashk_res.end = crashk_res.start + *lprop - 1;
 #endif
 
+	/* Retreive command line */
+ 	p = of_get_flat_dt_prop(node, "bootargs", &l);
+	if (p != NULL && l > 0)
+		strlcpy(cmd_line, p, min((int)l, COMMAND_LINE_SIZE));
+
+#ifdef CONFIG_CMDLINE
+	if (l == 0 || (l == 1 && (*p) == 0))
+		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#endif /* CONFIG_CMDLINE */
+
+	DBG("Command line is: %s\n", cmd_line);
+
+	if (strstr(cmd_line, "mem=")) {
+		char *p, *q;
+
+		for (q = cmd_line; (p = strstr(q, "mem=")) != 0; ) {
+			q = p + 4;
+			if (p > cmd_line && p[-1] != ' ')
+				continue;
+			memory_limit = memparse(q, &q);
+		}
+	}
+
 	/* break now */
 	return 1;
 }
@@ -1124,7 +1134,7 @@ static void __init early_reserve_mem(voi
 			size_32 = *(reserve_map_32++);
 			if (size_32 == 0)
 				break;
-			DBG("reserving: %lx -> %lx\n", base_32, size_32);
+			DBG("reserving: %x -> %x\n", base_32, size_32);
 			lmb_reserve(base_32, size_32);
 		}
 		return;
