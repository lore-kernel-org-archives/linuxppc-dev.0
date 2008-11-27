Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 73699DDDEA
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 22:19:22 +1100 (EST)
Date: Thu, 27 Nov 2008 12:19:18 +0100
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: linux-ppc <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/ibmebus: Get rid of the IRQ mapping in
	ibmebus_free_irq()
Message-ID: <20081127121918.2cfa881e@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>,
	Will Schmidt <will_schmidt@vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  ibmebus_free_irq() frees the IRQ but does not remove its mapping which
results in stale entries in the map.

  Fix this by adding a call to irq_dispose_mapping() in ibmebus_free_irq().

Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/ibmebus.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 64299d2..7c65377 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -231,6 +231,7 @@ void ibmebus_free_irq(u32 ist, void *dev_id)
 	unsigned int irq = irq_find_mapping(NULL, ist);
 
 	free_irq(irq, dev_id);
+	irq_dispose_mapping(irq);
 }
 EXPORT_SYMBOL(ibmebus_free_irq);
 
-- 
1.6.0.1.308.gede4c
