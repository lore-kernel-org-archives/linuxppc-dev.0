Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 94040DDFEB
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 06:39:47 +1000 (EST)
Received: from pd2mr3so.prod.shaw.ca
	(pd2mr3so-qfe3.prod.shaw.ca [10.0.141.108]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPM00FQ21B72C40@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 14:37:55 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd2mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPM001C51B7T470@pd2mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 08 Oct 2007 14:37:55 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.133.150])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPM002IF1B6Y7L0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 14:37:54 -0600 (MDT)
Date: Mon, 08 Oct 2007 14:37:54 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] Only call ppc_md.setup_arch() if it is provided.
To: jwboyer@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
Message-id: <20071008203754.12243.1712.stgit@trillian.cg.shawcable.net>
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
 2 files changed, 4 insertions(+), 2 deletions(-)

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
