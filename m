Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 72A921A0048
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2015 02:48:34 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: handle error case in cpm_muram_alloc()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20150821164831.2C0661A241A@localhost.localdomain>
Date: Fri, 21 Aug 2015 18:48:31 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

rh_alloc() returns (unsigned long)-ERRxx on error, which may
result in overwriting memory outside the MURAM AREA.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/sysdev/cpm_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index e2ea519..e00a5ee 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -147,7 +147,8 @@ unsigned long cpm_muram_alloc(unsigned long size, unsigned long align)
 	spin_lock_irqsave(&cpm_muram_lock, flags);
 	cpm_muram_info.alignment = align;
 	start = rh_alloc(&cpm_muram_info, size, "commproc");
-	memset_io(cpm_muram_addr(start), 0, size);
+	if (!IS_ERR_VALUE(start))
+		memset_io(cpm_muram_addr(start), 0, size);
 	spin_unlock_irqrestore(&cpm_muram_lock, flags);
 
 	return start;
-- 
2.1.0
