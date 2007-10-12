Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 60AFCDE04C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 16:03:08 +1000 (EST)
Received: from pd2mr1so.prod.shaw.ca
	(pd2mr1so-qfe3.prod.shaw.ca [10.0.141.110]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPS00FHCBF1M760@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 12 Oct 2007 00:01:49 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd2mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPS00C1LBF1QO80@pd2mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 12 Oct 2007 00:01:49 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPS00KH8BEQ1J10@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 12 Oct 2007 00:01:39 -0600 (MDT)
Date: Fri, 12 Oct 2007 00:01:38 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] Lite5200 shouldn't mess with ROOT_DEV
In-reply-to: <20071012055826.9718.2510.stgit@trillian.cg.shawcable.net>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Message-id: <20071012060138.9718.27029.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071012055826.9718.2510.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

There is no good reason for board platform code to mess with the ROOT_DEV.
Remove it from all in-tree platforms except powermac

This is a follow on to commit 745e1027751acbc1f14f8bbef378b491242b9c83.
The original patch had this change to lite5200.c, but it got dropped in
the psycho madness that is the 2.6.24 merge window.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/lite5200.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 0caa3d9..a0b4934 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -156,18 +156,6 @@ static void __init lite5200_setup_arch(void)
 		of_node_put(np);
 	}
 #endif
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		ROOT_DEV = Root_RAM0;
-	else
-#endif
-#ifdef  CONFIG_ROOT_NFS
-		ROOT_DEV = Root_NFS;
-#else
-		ROOT_DEV = Root_HDA1;
-#endif
-
 }
 
 /*
