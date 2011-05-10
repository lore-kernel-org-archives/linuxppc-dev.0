Return-Path: <anton@samba.org>
Date: Wed, 11 May 2011 09:34:03 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Print corrupt r3 in FWNMI code
Message-ID: <20110511093403.1f4b2fc7@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I have a report of an FWNMI with an r3 value that we think is
corrupt, but since we don't print r3 we have no idea what was
wrong with it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-net/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- linux-net.orig/arch/powerpc/platforms/pseries/ras.c	2011-05-11 09:26:16.646093026 +1000
+++ linux-net/arch/powerpc/platforms/pseries/ras.c	2011-05-11 09:26:49.836651728 +1000
@@ -227,7 +227,7 @@ static struct rtas_error_log *fwnmi_get_
 	struct rtas_error_log *h, *errhdr = NULL;
 
 	if (!VALID_FWNMI_BUFFER(regs->gpr[3])) {
-		printk(KERN_ERR "FWNMI: corrupt r3\n");
+		printk(KERN_ERR "FWNMI: corrupt r3 0x%016lx\n", regs->gpr[3]);
 		return NULL;
 	}
 
