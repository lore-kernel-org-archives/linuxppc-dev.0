Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 556131A0175
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 21:07:52 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/885: set SDCR to 0x40
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160204100749.095301A2446@localhost.localdomain>
Date: Thu,  4 Feb 2016 11:07:48 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MPC885 reference manual says that SDCR shall have value 0x40, but
most exemples set SDCR to 0x1
With 0x1 in SDCR, we observe TX underruns on SCC when using it in
QMC mode.
According the NXP technical support, this is a copy/paste error from
MPC860 reference manual, 0x40 being the only value supported
by the MPC885 HW.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/sysdev/cpm1.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 5e6ff38..8ed6536 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -228,7 +228,10 @@ void __init cpm_reset(void)
 	 * Bit 25, FAM can also be set to use FEC aggressive mode (860T).
 	 */
 	siu_conf = immr_map(im_siu_conf);
-	out_be32(&siu_conf->sc_sdcr, 1);
+	if ((mfspr(SPRN_IMMR) & 0xffff) == 0x0900) /* MPC885 */
+		out_be32(&siu_conf->sc_sdcr, 0x40);
+	else
+		out_be32(&siu_conf->sc_sdcr, 1);
 	immr_unmap(siu_conf);
 
 	cpm_muram_init();
-- 
2.1.0
