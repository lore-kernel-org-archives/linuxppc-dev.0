Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id F28AFB6F0E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 10:04:51 +1100 (EST)
Date: Wed, 16 Dec 2009 01:58:09 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: Fix oops during MSI driver probe on
	MPC85xxMDS boards
Message-ID: <20091215225809.GA32140@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC85xx chips report the wrong value in feature reporting register,
and that causes the following oops:

 Unable to handle kernel paging request for data at address 0x00000c00
 Faulting instruction address: 0xc0019294
 Oops: Kernel access of bad area, sig: 11 [#1]
 MPC8569 MDS
 Modules linked in:
 [...]
 NIP [c0019294] mpic_set_irq_type+0x2f0/0x368
 LR [c0019124] mpic_set_irq_type+0x180/0x368
 Call Trace:
 [ef851d60] [c0019124] mpic_set_irq_type+0x180/0x368 (unreliable)
 [ef851d90] [c007958c] __irq_set_trigger+0x44/0xd4
 [ef851db0] [c007b550] set_irq_type+0x40/0x7c
 [ef851dc0] [c0004a60] irq_create_of_mapping+0xb4/0x114
 [ef851df0] [c0004af0] irq_of_parse_and_map+0x30/0x40
 [ef851e20] [c0405678] fsl_of_msi_probe+0x1a0/0x328
 [ef851e60] [c02e6438] of_platform_device_probe+0x5c/0x84
 [...]

This is because mpic_alloc() assigns wrong values to
mpic->isu_{size,shift,mask}, and things eventually break when
_mpic_irq_read() is trying to use them.

This patch fixes the issue by enabling MPIC_BROKEN_FRR_NIRQS quirk.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index c5028a2..6491f7c 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -338,7 +338,8 @@ static void __init mpc85xx_mds_pic_init(void)
 	}
 
 	mpic = mpic_alloc(np, r.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
+			MPIC_BROKEN_FRR_NIRQS,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 	of_node_put(np);
-- 
1.6.3.3
