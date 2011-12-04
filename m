Return-Path: <anton@samba.org>
Date: Mon, 5 Dec 2011 10:13:58 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, tony@bakeyournoodle.com
Subject: [PATCH] powerpc: Increase minimum RMO size from 64MB to 256MB
Message-ID: <20111205101358.502de2b5@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The minimum RMO size field in ibm,client-architecture is currently
ignored, but a future firmware version will rectify that. Since we
always get at least 128MB of RMO right now, asking for 64MB is
likely to result in boot failures.

We should bump it to at least 128MB, but considering all the boot
issues we have on 128MB RMO boxes and all new machines have virtual
RMO, we may as well set our minimum to 256MB.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/prom_init.c	2011-12-05 10:11:45.666351716 +1100
+++ linux-powerpc/arch/powerpc/kernel/prom_init.c	2011-12-05 10:11:52.798475491 +1100
@@ -742,7 +742,7 @@ static unsigned char ibm_architecture_ve
 	W(0xffffffff),			/* virt_base */
 	W(0xffffffff),			/* virt_size */
 	W(0xffffffff),			/* load_base */
-	W(64),				/* 64MB min RMA */
+	W(256),				/* 256MB min RMA */
 	W(0xffffffff),			/* full client load */
 	0,				/* min RMA percentage of total RAM */
 	48,				/* max log_2(hash table size) */
