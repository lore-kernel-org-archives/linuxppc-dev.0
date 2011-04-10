Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
	by ozlabs.org (Postfix) with ESMTP id E1292B6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 10 Apr 2011 19:10:16 +1000 (EST)
Received: from brigitte.telenet-ops.be (unknown [195.130.137.66])
	by winston.telenet-ops.be (Postfix) with ESMTP id 7045F1BC5B5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 10 Apr 2011 10:59:09 +0200 (CEST)
Date: Sun, 10 Apr 2011 10:59:07 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Geoff Levand <geoff@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] powerpc: ps3 - Update debug message for
 irq_set_chip_data()
Message-ID: <alpine.DEB.2.00.1104101058010.13483@ayla.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>From 7193fcea7af93d57a0fea04efa28bcb5a7412e39 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 10 Apr 2011 10:45:35 +0200
Subject: [PATCH] powerpc: ps3 - Update debug message for irq_set_chip_data()

commit ec775d0e70eb6b7116406b3441cb8501c2849dd2 ("powerpc: Convert to new irq_*
function names") changed a call from set_irq_chip_data() to
irq_set_chip_data(), but forgot to update the corresponding debug message

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/powerpc/platforms/ps3/interrupt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index f2f6413..523bd0d 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -197,7 +197,7 @@ static int ps3_virq_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
 	result = irq_set_chip_data(*virq, pd);
 
 	if (result) {
-		pr_debug("%s:%d: set_irq_chip_data failed\n",
+		pr_debug("%s:%d: irq_set_chip_data failed\n",
 			__func__, __LINE__);
 		goto fail_set;
 	}
-- 
1.7.0.4


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
