Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7MmH3H8WzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 02:09:03 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] soc: fsl/qe: fix Oops on CPM1 (and likely CPM2)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Zhao Qiang <qiang.zhao@nxp.com>,
 David S. Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
Message-Id: <20160808160858.4B9251A2452@localhost.localdomain>
Date: Mon,  8 Aug 2016 18:08:58 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 0e6e01ff694ee ("CPM/QE: use genalloc to manage CPM/QE muram")
has changed the way muram is managed.
genalloc uses kmalloc(), hence requires the SLAB to be up and running.

On powerpc 8xx, cpm_reset() is called early during startup.
cpm_reset() then calls cpm_muram_init() before SLAB is available,
hence the following Oops.

cpm_reset() cannot be called during initcalls because the CPM is
needed for console

This patch splits cpm_muram_init() in two parts. The first part,
related to mappings, is kept as cpm_muram_init()
The second part is named cpm_muram_pool_init() and is called
the first time cpm_muram_alloc() is used

[    0.000000] Unable to handle kernel paging request for data at address 0x00000008
[    0.000000] Faulting instruction address: 0xc01acce0
[    0.000000] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.000000] PREEMPT CMPC885
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.4.14-g0886ed8 #5
[    0.000000] task: c05183e0 ti: c0536000 task.ti: c0536000
[    0.000000] NIP: c01acce0 LR: c0011068 CTR: 00000000
[    0.000000] REGS: c0537e50 TRAP: 0300   Not tainted (4.4.14-s3k-dev-g0886ed8-svn)
[    0.000000] MSR: 00001032 <ME,IR,DR,RI>  CR: 28044428  XER: 00000000
[    0.000000] DAR: 00000008 DSISR: c0000000
GPR00: c0011068 c0537f00 c05183e0 00000000 00009000 ffffffff 00000bc0 ffffffff
GPR08: ff003000 ff00b000 ff003bbf 00000000 22044422 100d43a8 00000000 07ff94e8
GPR16: 00000000 07bb5d70 00000000 07ff81f4 07ff81f4 07ff81f4 00000000 00000000
GPR24: 07ffb3a0 07fe7628 c0550000 c7ffa190 c0540000 ff003bbf 00000000 00000001
[    0.000000] NIP [c01acce0] gen_pool_add_virt+0x14/0xdc
[    0.000000] LR [c0011068] cpm_muram_init+0xd4/0x18c
[    0.000000] Call Trace:
[    0.000000] [c0537f00] [00000200] 0x200 (unreliable)
[    0.000000] [c0537f20] [c0011068] cpm_muram_init+0xd4/0x18c
[    0.000000] [c0537f70] [c0494684] cpm_reset+0xb4/0xc8
[    0.000000] [c0537f90] [c0494c64] cmpc885_setup_arch+0x10/0x30
[    0.000000] [c0537fa0] [c0493cd4] setup_arch+0x130/0x168
[    0.000000] [c0537fb0] [c04906bc] start_kernel+0x88/0x380
[    0.000000] [c0537ff0] [c0002224] start_here+0x38/0x98
[    0.000000] Instruction dump:
[    0.000000] 91430010 91430014 80010014 83e1000c 7c0803a6 38210010 4e800020 7c0802a6
[    0.000000] 9421ffe0 bf61000c 90010024 7c7e1b78 <80630008> 7c9c2378 7cc31c30 3863001f
[    0.000000] ---[ end trace dc8fa200cb88537f ]---

fixes: 0e6e01ff694ee ("CPM/QE: use genalloc to manage CPM/QE muram")
Cc: stable@vger.linux.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/soc/fsl/qe/qe_common.c | 58 ++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 41eff80..531cfcf 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -45,6 +45,44 @@ static LIST_HEAD(muram_block_list);
 #define OF_MAX_ADDR_CELLS	4
 #define GENPOOL_OFFSET		(4096 * 8)
 
+static int cpm_muram_pool_init(void)
+{
+	struct device_node *np;
+	struct resource r;
+	int i = 0;
+	int ret = 0;
+
+	if (muram_pool)
+		return 0;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm-muram-data");
+	if (!np) {
+		/* try legacy bindings */
+		np = of_find_node_by_name(NULL, "data-only");
+		if (!np) {
+			pr_err("Cannot find CPM muram data node");
+			ret = -ENODEV;
+			goto out;
+		}
+	}
+
+	muram_pool = gen_pool_create(0, -1);
+
+	while (of_address_to_resource(np, i++, &r) == 0) {
+		ret = gen_pool_add(muram_pool, r.start - muram_pbase +
+				   GENPOOL_OFFSET, resource_size(&r), -1);
+		if (ret) {
+			pr_err("QE: couldn't add muram to pool!\n");
+			gen_pool_destroy(muram_pool);
+			goto out;
+		}
+	}
+
+out:
+	of_node_put(np);
+	return ret;
+}
+
 int cpm_muram_init(void)
 {
 	struct device_node *np;
@@ -65,39 +103,28 @@ int cpm_muram_init(void)
 		if (!np) {
 			pr_err("Cannot find CPM muram data node");
 			ret = -ENODEV;
-			goto out_muram;
+			goto out;
 		}
 	}
 
-	muram_pool = gen_pool_create(0, -1);
 	muram_pbase = of_translate_address(np, zero);
 	if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
 		pr_err("Cannot translate zero through CPM muram node");
 		ret = -ENODEV;
-		goto out_pool;
+		goto out;
 	}
 
 	while (of_address_to_resource(np, i++, &r) == 0) {
 		if (r.end > max)
 			max = r.end;
-		ret = gen_pool_add(muram_pool, r.start - muram_pbase +
-				   GENPOOL_OFFSET, resource_size(&r), -1);
-		if (ret) {
-			pr_err("QE: couldn't add muram to pool!\n");
-			goto out_pool;
-		}
 	}
 
 	muram_vbase = ioremap(muram_pbase, max - muram_pbase + 1);
 	if (!muram_vbase) {
 		pr_err("Cannot map QE muram");
 		ret = -ENOMEM;
-		goto out_pool;
 	}
-	goto out_muram;
-out_pool:
-	gen_pool_destroy(muram_pool);
-out_muram:
+out:
 	of_node_put(np);
 	return ret;
 }
@@ -116,6 +143,9 @@ static unsigned long cpm_muram_alloc_common(unsigned long size,
 	struct muram_block *entry;
 	unsigned long start;
 
+	if (!muram_pool && cpm_muram_pool_init())
+		goto out2;
+
 	start = gen_pool_alloc_algo(muram_pool, size, algo, data);
 	if (!start)
 		goto out2;
-- 
2.1.0
