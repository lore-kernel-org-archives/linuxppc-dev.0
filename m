Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwGbs2ZMqzDr13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jun 2017 12:39:20 +1000 (AEST)
From: Scott Wood <oss@buserror.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>,
	Jurgen Schindele <schindele@nentec.de>
Date: Sat, 24 Jun 2017 21:39:05 -0500
Message-Id: <20170625023905.24649-1-oss@buserror.net>
Subject: [PATCH] powerpc/ipic: Support edge on IRQ0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

External IRQ0 has the same capabilities as the other IRQ1-7 and is
handled by the same register IPIC_SEPNR.  When this register is not
specified for "ack" in "ipic_info", you cannot configure this IRQ as
IRQ_TYPE_EDGE_FALLING.  This oversight was probably due to the
non-contiguous hwirq numbering of IRQ0 in the IPIC.

Signed-off-by: Jurgen Schindele <schindele@nentec.de>
[scottwood: Cleaned up commit message and posted as a proper patch]
Signed-off-by: Scott Wood <oss@buserror.net>
---
 arch/powerpc/sysdev/ipic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index f267ee0afc08..16f1edd78c40 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -315,6 +315,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[48] = {
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
-- 
2.11.0
