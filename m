Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id A6952DDF70
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 06:59:02 +1000 (EST)
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPM000DW2AC6G60@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 14:59:00 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
	by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPM000H82AC2T00@pd3mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 08 Oct 2007 14:59:00 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.133.150])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPM00CYP2AB3R40@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 14:58:59 -0600 (MDT)
Date: Mon, 08 Oct 2007 14:58:59 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2] Only call ppc_md.setup_arch() if it is provided.
To: jwboyer@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	galak@kernel.crashing.org
Message-id: <20071008205859.12639.82863.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This allows platforms which don't have anything to do at setup_arch time
(like a bunch of the 4xx platforms) to eliminate an empty setup_arch hook.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/kernel/setup_32.c |    3 ++-
 arch/powerpc/kernel/setup_64.c |    3 ++-
 include/asm-powerpc/machdep.h  |    2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 7474502..cd870a8 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -290,7 +290,8 @@ void __init setup_arch(char **cmdline_p)
 	conswitchp = &dummy_con;
 #endif
 
-	ppc_md.setup_arch();
+	if (ppc_md.setup_arch)
+		ppc_md.setup_arch();
 	if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);
 
 	paging_init();
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 3089eae..008ab68 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -530,7 +530,8 @@ void __init setup_arch(char **cmdline_p)
 	conswitchp = &dummy_con;
 #endif
 
-	ppc_md.setup_arch();
+	if (ppc_md.setup_arch)
+		ppc_md.setup_arch();
 
 	paging_init();
 	ppc64_boot_msg(0x15, "Setup Done");
diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index 71c6e7e..cc7c17f 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -99,7 +99,7 @@ struct machdep_calls {
 #endif /* CONFIG_PPC64 */
 
 	int		(*probe)(void);
-	void		(*setup_arch)(void);
+	void		(*setup_arch)(void); /* Optional, may be NULL */
 	void		(*init_early)(void);
 	/* Optional, may be NULL. */
 	void		(*show_cpuinfo)(struct seq_file *m);
