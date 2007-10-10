Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 4FCC0DE034
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 04:50:04 +1000 (EST)
Received: from pd4mr4so.prod.shaw.ca
	(pd4mr4so-qfe3.prod.shaw.ca [10.0.141.215]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPP00M1CLKE9I10@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:48:14 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd4mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPP00D5ZLKEB990@pd4mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 10 Oct 2007 12:48:15 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPP00LY8LKDU2Y0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:48:14 -0600 (MDT)
Date: Wed, 10 Oct 2007 12:48:18 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/3] Only call ppc_md.setup_arch() if it is provided.
In-reply-to: <20071010184542.13609.70984.stgit@trillian.cg.shawcable.net>
To: paulus@samba.org, linuxppc-dev@ozlabs.org, galak@kernel.crashing.org,
	arnd@arndb.de, linas@austin.ibm.com, benh@kernel.crashing.org,
	geoffrey.levand@am.sony.com
Message-id: <20071010184818.13609.43721.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071010184542.13609.70984.stgit@trillian.cg.shawcable.net>
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
