Return-Path: <esben.haabendal@gmail.com>
Received: from mail-la0-x235.google.com (mail-la0-x235.google.com
 [IPv6:2a00:1450:4010:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EE4B1A078E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 22:27:13 +1100 (AEDT)
Received: by mail-la0-f53.google.com with SMTP id gm9so19378622lab.40
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jan 2015 03:27:09 -0800 (PST)
Sender: Esben Haabendal <esbenhaabendal@gmail.com>
From: esben.haabendal@gmail.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/3] powerpc: ipic: Fix mcp status helper functions
Date: Tue,  6 Jan 2015 12:26:58 +0100
Message-Id: <1420543620-20658-1-git-send-email-esben.haabendal@gmail.com>
Cc: Esben Haabendal <eha@deif.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Esben Haabendal <eha@deif.com>

Read and write the SERSR (System Error Status Register) instead of the
SERMR (System Error Mask Register), to actually get and clear the status
bits.

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 arch/powerpc/sysdev/ipic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index b287337..2e41a73 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -843,12 +843,12 @@ void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq)
 
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
 
 /* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
-- 
2.1.4
