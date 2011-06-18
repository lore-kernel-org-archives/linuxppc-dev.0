Return-Path: <dtcarroll@gmail.com>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9782DB6FF8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 19 Jun 2011 03:55:55 +1000 (EST)
Received: by pvg18 with SMTP id 18so1964879pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jun 2011 10:55:53 -0700 (PDT)
From: Dave Carroll <dtcarroll@gmail.com>
To: Milton Miller <miltonm@bga.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2][v2] powerpc: Add printk companion for ppc_md.progress
Date: Sat, 18 Jun 2011 11:36:40 -0600
Message-Id: <1308418600-9167-2-git-send-email-dcarroll@astekcorp.com>
In-Reply-To: <1308418600-9167-1-git-send-email-dcarroll@astekcorp.com>
References: <1308350584.32158.58.camel@pasglop>
	<1308418600-9167-1-git-send-email-dcarroll@astekcorp.com>
Cc: Dave Carroll <dcarroll@astekcorp.com>, LPPC <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dave Carroll <dcarroll@astekcorp.com>

This patch adds a printk companion to replace the udbg progress function
when initmem is freed.

Suggested-by: Milton Miller <miltonm@bga.com>
Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Dave Carroll <dcarroll@astekcorp.com>
---
 [v2] This is a rebase of the original patch to Linus' current tree
 
 arch/powerpc/include/asm/setup.h   |    2 ++
 arch/powerpc/kernel/setup-common.c |    5 +++++
 arch/powerpc/mm/mem.c              |    2 +-
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index dae1934..c77cb7a 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -3,4 +3,6 @@
 
 #include <asm-generic/setup.h>
 
+extern void ppc_printk_progress(char *s, unsigned short hex);
+
 #endif	/* _ASM_POWERPC_SETUP_H */
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 79fca26..e053b16 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -704,6 +704,11 @@ static int powerpc_debugfs_init(void)
 arch_initcall(powerpc_debugfs_init);
 #endif
 
+void ppc_printk_progress(char *s, unsigned short hex)
+{
+	pr_info("%s\n", s);
+}
+
 static int ppc_dflt_bus_notify(struct notifier_block *nb,
 				unsigned long action, void *data)
 {
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index f4e6408..e0d2aa0 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -386,7 +386,7 @@ void free_initmem(void)
 {
 	unsigned long addr;
 
-	ppc_md.progress = NULL;
+	ppc_md.progress = ppc_printk_progress;
 
 	addr = (unsigned long)__init_begin;
 	for (; addr < (unsigned long)__init_end; addr += PAGE_SIZE) {
-- 
1.7.5
