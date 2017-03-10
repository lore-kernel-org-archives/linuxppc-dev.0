Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfkGX6325zDqXx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 21:37:08 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: fix mpc8xx_get_irq() return on no irq
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 vitb@kernel.crashing.org
Message-Id: <20170310103701.850816799B@localhost.localdomain>
Date: Fri, 10 Mar 2017 11:37:01 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IRQ 0 is a valid HW interrupt. So get_irq() shall return 0 when
there is no irq, instead of returning irq_linear_revmap(... ,0)

Fixes: f2a0bd3753dad ("[POWERPC] 8xx: powerpc port of core CPM PIC")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/sysdev/mpc8xx_pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index 3e828b20c21e..2842f9d63d21 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -79,7 +79,7 @@ unsigned int mpc8xx_get_irq(void)
 	irq = in_be32(&siu_reg->sc_sivec) >> 26;
 
 	if (irq == PIC_VEC_SPURRIOUS)
-		irq = 0;
+		return 0;
 
         return irq_linear_revmap(mpc8xx_pic_host, irq);
 
-- 
2.12.0
