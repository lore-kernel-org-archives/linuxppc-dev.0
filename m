Return-Path: <eha@doredevelopment.dk>
Received: from zmta01.irigo.dk (zmta01.cabocomm.dk [193.200.44.52])
	by ozlabs.org (Postfix) with ESMTP id 8AF9BB7D78
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jun 2010 07:32:51 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zmta01.irigo.dk (Postfix) with ESMTP id 1ED2B142C1A90
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jun 2010 23:25:23 +0200 (CEST)
Received: from zmta01.irigo.dk ([127.0.0.1])
	by localhost (zmta01.irigo.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1MiS4YWakCtt for <linuxppc-dev@ozlabs.org>;
	Fri,  4 Jun 2010 23:25:18 +0200 (CEST)
Received: from [192.168.1.127] (0x55532124.adsl.cybercity.dk [85.83.33.36])
	by zmta01.irigo.dk (Postfix) with ESMTP id 09420142C1A89
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jun 2010 23:25:18 +0200 (CEST)
Subject: [PATCH 1/2] powerpc: ipic: use set_irq_chip to ensure irq_chip
	defaults are applied
From: Esben Haabendal <eha@doredevelopment.dk>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
In-Reply-To: <cover.1275686504.git.eha@doredevelopment.dk>
References: <cover.1275686504.git.eha@doredevelopment.dk>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Jun 2010 23:25:17 +0200
Message-ID: <1275686717.2970.13.camel@eha.doredevelopment.dk>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
---
 arch/powerpc/sysdev/ipic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index d7b9b9c..8464b86 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -630,10 +630,10 @@ static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
 	if (flow_type & IRQ_TYPE_LEVEL_LOW)  {
 		desc->status |= IRQ_LEVEL;
 		desc->handle_irq = handle_level_irq;
-		desc->chip = &ipic_level_irq_chip;
+		set_irq_chip(virq, &ipic_level_irq_chip);
 	} else {
 		desc->handle_irq = handle_edge_irq;
-		desc->chip = &ipic_edge_irq_chip;
+		set_irq_chip(virq, &ipic_edge_irq_chip);
 	}
 
 	/* only EXT IRQ senses are programmable on ipic
-- 
1.7.1
