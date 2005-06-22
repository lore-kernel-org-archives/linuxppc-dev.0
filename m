Return-Path: <galak@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 1951867AA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Jun 2005 06:10:15 +1000 (EST)
Date: Wed, 22 Jun 2005 15:10:02 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Linus Torvalds <torvalds@osdl.org>
Message-ID: <Pine.LNX.4.61.0506221509250.3138@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix building MPC8555 CDS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In adding support for MPC8548 w/o PCI support, broke building MPC8555 CDS
by trying to remove a loop variable that was used when PCI is enabled.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 3136970402c782e9a1fd5c39ddc88d05e7b7b086
tree fc975ccebd712d1898871cdbcde10b6faeba4603
parent 957e37cba892cf088b9326ca2aff0de88fc1e9b0
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 16:48:57 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 16:48:57 -0500

 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -149,6 +149,7 @@ void __init
 mpc85xx_cds_init_IRQ(void)
 {
 	bd_t *binfo = (bd_t *) __res;
+	int i;
 
 	/* Determine the Physical Address of the OpenPIC regs */
 	phys_addr_t OpenPIC_PAddr = binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
/
