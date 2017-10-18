Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH5zb0TTNzDrJj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 20:16:57 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: ipic - fix status get and status clear
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20171018091647.B9E9F6872C@po15668-vm-win7.idsi0.si.c-s.fr>
Date: Wed, 18 Oct 2017 11:16:47 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IPIC Status is provided by register IPIC_SERSR and not by IPIC_SERMR
which is the mask register.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/sysdev/ipic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 16f1edd78c40..535cf1f6941c 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -846,12 +846,12 @@ void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq)
 
 u32 ipic_get_mcp_status(void)
 {
-	return ipic_read(primary_ipic->regs, IPIC_SERMR);
+	return ipic_read(primary_ipic->regs, IPIC_SERSR);
 }
 
 void ipic_clear_mcp_status(u32 mask)
 {
-	ipic_write(primary_ipic->regs, IPIC_SERMR, mask);
+	ipic_write(primary_ipic->regs, IPIC_SERSR, mask);
 }
 
 /* Return an interrupt vector or 0 if no interrupt is pending. */
-- 
2.13.3
