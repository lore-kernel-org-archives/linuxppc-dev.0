Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F1491A083A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 04:15:25 +1100 (AEDT)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/15] powerpc: don't export static symbol
Date: Wed, 11 Mar 2015 17:56:24 +0100
Message-Id: <1426092997-30605-3-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1426092997-30605-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1426092997-30605-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: daniel@iogearbox.net, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <Julia.Lawall@lip6.fr>

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
type T;
identifier f;
@@

static T f (...) { ... }

@@
identifier r.f;
declarer name EXPORT_SYMBOL;
@@

-EXPORT_SYMBOL(f);
// </smpl>

Furthermore, the function is never used, so its definition is dropped as
well.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/powerpc/sysdev/qe_lib/qe_io.c |   25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index d099941..7ea0174 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -190,28 +190,3 @@ int par_io_of_config(struct device_node *np)
 	return 0;
 }
 EXPORT_SYMBOL(par_io_of_config);
-
-#ifdef DEBUG
-static void dump_par_io(void)
-{
-	unsigned int i;
-
-	printk(KERN_INFO "%s: par_io=%p\n", __func__, par_io);
-	for (i = 0; i < num_par_io_ports; i++) {
-		printk(KERN_INFO "	cpodr[%u]=%08x\n", i,
-			in_be32(&par_io[i].cpodr));
-		printk(KERN_INFO "	cpdata[%u]=%08x\n", i,
-			in_be32(&par_io[i].cpdata));
-		printk(KERN_INFO "	cpdir1[%u]=%08x\n", i,
-			in_be32(&par_io[i].cpdir1));
-		printk(KERN_INFO "	cpdir2[%u]=%08x\n", i,
-			in_be32(&par_io[i].cpdir2));
-		printk(KERN_INFO "	cppar1[%u]=%08x\n", i,
-			in_be32(&par_io[i].cppar1));
-		printk(KERN_INFO "	cppar2[%u]=%08x\n", i,
-			in_be32(&par_io[i].cppar2));
-	}
-
-}
-EXPORT_SYMBOL(dump_par_io);
-#endif /* DEBUG */
