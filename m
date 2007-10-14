Return-Path: <grant.likely@secretlab.ca>
Date: Sat, 13 Oct 2007 22:13:27 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] Lite5200 shouldn't mess with ROOT_DEV
In-reply-to: <20071014040705.17867.42969.stgit@trillian.cg.shawcable.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-id: <20071014041327.17867.88446.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071014040705.17867.42969.stgit@trillian.cg.shawcable.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Al Viro <viro@ftp.linux.org.uk>
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
