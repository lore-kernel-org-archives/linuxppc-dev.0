Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C17A7B72FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 18:01:27 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 171FBDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 18:01:26 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix mpic alloc warning
Date: Fri, 19 Jun 2009 03:01:20 -0500
Message-Id: <1245398480-29196-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since we can use kmalloc earlier we are getting the following since the
mpic_alloc() code calls alloc_bootmem().  Move to using kzalloc() to
remove the warning.

------------[ cut here ]------------
Badness at c0583248 [verbose debug info unavailable]
NIP: c0583248 LR: c0583210 CTR: 00000004
REGS: c0741de0 TRAP: 0700   Not tainted  (2.6.30-06736-g12a31df)
MSR: 00021000 <ME,CE>  CR: 22024024  XER: 00000000
TASK = c070d3b8[0] 'swapper' THREAD: c0740000 CPU: 0
<6>GPR00: 00000001 c0741e90 c070d3b8 00000001 00000210 00000020 3fffffff 00000000
<6>GPR08: 00000000 c0c85700 c04f8c40 0000002d 22044022 1004a388 7ffd9400 00000000
<6>GPR16: 00000000 7ffcd100 7ffcd100 7ffcd100 c04f8c40 00000000 c059f62c c075a0c0
<6>GPR24: c059f648 00000000 0000000f 00000210 00000020 00000000 3fffffff 00000210
NIP [c0583248] alloc_arch_preferred_bootmem+0x50/0x80
LR [c0583210] alloc_arch_preferred_bootmem+0x18/0x80
Call Trace:
[c0741e90] [c07343b0] devtree_lock+0x0/0x24 (unreliable)
[c0741ea0] [c0583b14] ___alloc_bootmem_nopanic+0x54/0x108
[c0741ee0] [c0583e18] ___alloc_bootmem+0x18/0x50
[c0741ef0] [c057b9cc] mpic_alloc+0x48/0x710
[c0741f40] [c057ecf4] mpc85xx_ds_pic_init+0x190/0x1b8
[c0741f90] [c057633c] init_IRQ+0x24/0x34
[c0741fa0] [c05738b8] start_kernel+0x260/0x3dc
[c0741ff0] [c00003c8] skpinv+0x2e0/0x31c
Instruction dump:
409e001c 7c030378 80010014 83e1000c 38210010 7c0803a6 4e800020 3d20c0c8
39295700 80090004 7c000034 5400d97e <0f000000> 2f800000 409e001c 38800000

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/mpic.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 9c3af50..9e81157 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1052,11 +1052,10 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	int		intvec_top;
 	u64		paddr = phys_addr;
 
-	mpic = alloc_bootmem(sizeof(struct mpic));
+	mpic = kzalloc(sizeof(struct mpic), GFP_NOWAIT);
 	if (mpic == NULL)
 		return NULL;
-	
-	memset(mpic, 0, sizeof(struct mpic));
+
 	mpic->name = name;
 
 	mpic->hc_irq = mpic_irq_chip;
-- 
1.6.0.6
