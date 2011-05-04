Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
	by ozlabs.org (Postfix) with ESMTP id 13865B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 May 2011 00:29:37 +1000 (EST)
Received: from georges.telenet-ops.be (unknown [195.130.137.68])
	by winston.telenet-ops.be (Postfix) with ESMTP id 5CB811BC0A1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 16:29:33 +0200 (CEST)
Date: Wed, 4 May 2011 16:29:31 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/mpc8610_hpcd: Do not use "/" in interrupt names
Message-ID: <alpine.DEB.2.00.1105041627560.2601@ayla.of.borg>
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

It may trigger a warning in fs/proc/generic.c:__xlate_proc_name() when
trying to add an entry for the interrupt handler to sysfs.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 018cc67..efadd3b 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -66,7 +66,7 @@ static void __init mpc8610_suspend_init(void)
 		return;
 	}
 
-	ret = request_irq(irq, mpc8610_sw9_irq, 0, "sw9/wakeup", NULL);
+	ret = request_irq(irq, mpc8610_sw9_irq, 0, "sw9:wakeup", NULL);
 	if (ret) {
 		pr_err("%s: can't request pixis event IRQ: %d\n",
 		       __func__, ret);
-- 
1.7.0.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
