Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 38A38B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Jul 2009 12:08:52 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <6c9c0889feaceeea55bd2b6fef0c19e408425ef5.1246846125.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/mpic: Fix MPIC_BROKEN_REGREAD on non broken MPICs
Date: Mon,  6 Jul 2009 12:08:52 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The workaround enabled by CONFIG_MPIC_BROKEN_REGREAD does not work
on non-broken MPICs. The symptom is no interrupts being received.

The fix is twofold. Firstly the code was broken for multiple isus,
we need to index into the shadow array with the src_no, not the idx.
Secondly, we always do the read, but only use the VECPRI_MASK and
VECPRI_ACTIVITY bits from the hardware, the rest of "val" comes
from the shadow.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/sysdev/mpic.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 82e8e88..e35ecf5 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -230,14 +230,16 @@ static inline u32 _mpic_irq_read(struct mpic *mpic, unsigned int src_no, unsigne
 {
 	unsigned int	isu = src_no >> mpic->isu_shift;
 	unsigned int	idx = src_no & mpic->isu_mask;
+	unsigned int	val;
 
+	val = _mpic_read(mpic->reg_type, &mpic->isus[isu],
+			 reg + (idx * MPIC_INFO(IRQ_STRIDE)));
 #ifdef CONFIG_MPIC_BROKEN_REGREAD
 	if (reg == 0)
-		return mpic->isu_reg0_shadow[idx];
-	else
+		val = (val & (MPIC_VECPRI_MASK | MPIC_VECPRI_ACTIVITY)) |
+			mpic->isu_reg0_shadow[src_no];
 #endif
-		return _mpic_read(mpic->reg_type, &mpic->isus[isu],
-				  reg + (idx * MPIC_INFO(IRQ_STRIDE)));
+	return val;
 }
 
 static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no,
@@ -251,7 +253,8 @@ static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no,
 
 #ifdef CONFIG_MPIC_BROKEN_REGREAD
 	if (reg == 0)
-		mpic->isu_reg0_shadow[idx] = value;
+		mpic->isu_reg0_shadow[src_no] =
+			value & ~(MPIC_VECPRI_MASK | MPIC_VECPRI_ACTIVITY);
 #endif
 }
 
-- 
1.6.2.1
