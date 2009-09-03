Return-Path: <thunderbird2k@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 913F7B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 23:27:52 +1000 (EST)
Received: from mx.utwente.nl (mx2.utsp.utwente.nl [130.89.2.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1B4DDDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Sep 2009 23:27:51 +1000 (EST)
Subject: Fix i8259 kernel crash on ML510
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 03 Sep 2009 15:14:01 +0200
Message-Id: <1251983641.30181.1.camel@CE202>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 11a2072b285c2eb0f19980ad729229d4ebf22291 Mon Sep 17 00:00:00 2001
From: Roderick Colenbrander <colenbrander@CE202.(none)>
Date: Thu, 3 Sep 2009 15:11:08 +0200
Subject: [PATCH] This patch fixes a null pointer exception caused by
removal of 'ack()' for level interrupts in the Xilinx interrupt driver.

---
 arch/powerpc/sysdev/xilinx_intc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/xilinx_intc.c
b/arch/powerpc/sysdev/xilinx_intc.c
index 3ee1fd3..40edad5 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -234,7 +234,6 @@ static void xilinx_i8259_cascade(unsigned int irq,
struct irq_desc *desc)
 		generic_handle_irq(cascade_irq);
 
 	/* Let xilinx_intc end the interrupt */
-	desc->chip->ack(irq);
 	desc->chip->unmask(irq);
 }
 
-- 
1.6.0.4
