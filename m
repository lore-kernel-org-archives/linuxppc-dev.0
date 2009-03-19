Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8CEDBDDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 14:08:54 +1100 (EST)
Date: Thu, 19 Mar 2009 14:08:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/pmi: irq handlers return irqreturn_t
Message-Id: <20090319140852.d7e60731.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Zijlstra <peterz@infradead.org>, ppc-dev <linuxppc-dev@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, Peter
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit bedd30d986a05e32dc3eab874e4b9ed8a38058bb ("genirq: make irqreturn_t
an enum") from the genirq tree in next-20090319 caused this new warning:

arch/powerpc/sysdev/pmi.c: In function 'pmi_of_probe':
arch/powerpc/sysdev/pmi.c:166: warning: passing argument 2 of 'request_irq' from incompatible pointer type

Change the return type of the handler from "int" to "irqreturn_t".

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/sysdev/pmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/pmi.c b/arch/powerpc/sysdev/pmi.c
index c858749..aaa9159 100644
--- a/arch/powerpc/sysdev/pmi.c
+++ b/arch/powerpc/sysdev/pmi.c
@@ -50,7 +50,7 @@ struct pmi_data {
 
 static struct pmi_data *data;
 
-static int pmi_irq_handler(int irq, void *dev_id)
+static irqreturn_t pmi_irq_handler(int irq, void *dev_id)
 {
 	u8 type;
 	int rc;
-- 
1.6.2.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
