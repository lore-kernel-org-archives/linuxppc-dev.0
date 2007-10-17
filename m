Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id ADB55DDECE
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 02:44:29 +1000 (EST)
Received: from pd2mr4so.prod.shaw.ca
	(pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQ200H98EH1IA60@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 17 Oct 2007 10:43:49 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd2mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQ2004JREH14670@pd2mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 17 Oct 2007 10:43:50 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQ200JLVEH0XRH1@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 17 Oct 2007 10:43:48 -0600 (MDT)
Date: Wed, 17 Oct 2007 10:36:27 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] bestcomm: Restrict disabling of bus prefetch to original
	mpc5200 silicon.
To: Sven Luther <sven@powerlinux.fr>, domen.puncer@telargo.com,
	linuxppc-dev@ozlabs.org
Message-id: <20071017163555.24992.40095.stgit@trillian.cg.shawcable.net>
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

Only the MPC5200 needs this bug fix.  MPC5200B is okay.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Sven, Domen;

Can you please test this patch?

Thanks,
g.

 arch/powerpc/sysdev/bestcomm/bestcomm.c |    9 ++++++---
 include/asm-powerpc/mpc52xx.h           |    5 +++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.c b/arch/powerpc/sysdev/bestcomm/bestcomm.c
index 48492a8..740ad73 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm.c
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm.c
@@ -269,6 +269,7 @@ bcom_engine_init(void)
 	int task;
 	phys_addr_t tdt_pa, ctx_pa, var_pa, fdt_pa;
 	unsigned int tdt_size, ctx_size, var_size, fdt_size;
+	u16 regval;
 
 	/* Allocate & clear SRAM zones for FDT, TDTs, contexts and vars/incs */
 	tdt_size = BCOM_MAX_TASKS * sizeof(struct bcom_tdt);
@@ -319,9 +320,11 @@ bcom_engine_init(void)
 	/* Init 'always' initiator */
 	out_8(&bcom_eng->regs->ipr[BCOM_INITIATOR_ALWAYS], BCOM_IPR_ALWAYS);
 
-	/* Disable COMM Bus Prefetch, apparently it's not reliable yet */
-	/* FIXME: This should be done on 5200 and not 5200B ... */
-	out_be16(&bcom_eng->regs->PtdCntrl, in_be16(&bcom_eng->regs->PtdCntrl) | 1);
+	/* Disable COMM Bus Prefetch on the original 5200; it's broken */
+	if ((mfspr(SPRN_SVR) & MPC5200_SVR_MASK) == MPC5200_SVR) {
+		regval = in_be16(&bcom_eng->regs->PtdCntrl);
+		out_be16(&bcom_eng->regs->PtdCntrl,  regval | 1);
+	}
 
 	/* Init lock */
 	spin_lock_init(&bcom_eng->lock);
diff --git a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
index 24751df..25b2e55 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -18,6 +18,11 @@
 #include <asm/prom.h>
 #endif /* __ASSEMBLY__ */
 
+/* Variants of the 5200(B) */
+#define MPC5200_SVR		0x80110010
+#define MPC5200_SVR_MASK	0xfffffff0
+#define MPC5200B_SVR		0x80110020
+#define MPC5200B_SVR_MASK	0xfffffff0
 
 /* ======================================================================== */
 /* Structures mapping of some unit register set                             */
