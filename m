Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zQ445RjkzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 18:27:32 +1000 (AEST)
Message-Id: <c562b688661c64c0b58bfa689c60a6ed38fd82a8.1535358405.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/sysdev/ipic: check primary_ipic NULL pointer before
 using it
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 27 Aug 2018 08:27:27 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ipic_get_mcp_status() is used by targets implementing NMI
watchdog in target specific machine check handler in order
to known whether a machine check results from a watchdog
NMI reset.

In case of very early machine check, primary_ipic pointer
might not have been set yet, so ipic_get_mcp_status() needs
to check it for nullity before using it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/sysdev/ipic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 535cf1f6941c..6300123ce965 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -846,7 +846,7 @@ void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq)
 
 u32 ipic_get_mcp_status(void)
 {
-	return ipic_read(primary_ipic->regs, IPIC_SERSR);
+	return primary_ipic ? ipic_read(primary_ipic->regs, IPIC_SERSR) : 0;
 }
 
 void ipic_clear_mcp_status(u32 mask)
-- 
2.13.3
