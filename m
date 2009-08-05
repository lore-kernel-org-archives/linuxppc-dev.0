Return-Path: <bigeasy@www.tglx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 95C16B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 05:41:26 +1000 (EST)
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE547DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 05:41:25 +1000 (EST)
Date: Wed, 5 Aug 2009 21:41:12 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/ipic: unmask all interrupt sources
Message-ID: <20090805194112.GA18204@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

in case the interrupt controller was used in an earlier life then it is
possible it is that some of its sources were used and are still unmask.
If the (unmasked) device is active and is creating interrupts (or one
interrupts was pending since the interrupts were disabled) then the boot
process "ends" very soon. Once external interrupts are enabled, we land in
-> do_IRQ
  -> call ppc_md.get_irq()
     -> ipic_read() gets the source number
     -> irq_linear_revmap(source)
        -> revmap[source] == NO_IRQ
           -> irq_find_mapping(source) returns NO_IRQ because no source
              is registered
  -> source is NO_IRQ, ppc_spurious_interrupts gets incremented, no
     further action.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
This solves my kexec problem I had earlier. I could disable the device
in ->shutdown path but the device in question could been used in the
boot loader. Usually one gets the "nobody cared" message for unhandled
interrupts but in this (rare) case nothing happens and box stands still.

 arch/powerpc/sysdev/ipic.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 69e2630..ebb7e58 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -781,6 +781,9 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 	primary_ipic = ipic;
 	irq_set_default_host(primary_ipic->irqhost);
 
+	ipic_write(ipic->regs, IPIC_SIMSR_H, 0);
+	ipic_write(ipic->regs, IPIC_SIMSR_L, 0);
+
 	printk ("IPIC (%d IRQ sources) at %p\n", NR_IPIC_INTS,
 			primary_ipic->regs);
 
-- 
1.6.2.5
