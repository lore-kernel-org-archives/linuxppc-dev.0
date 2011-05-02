Return-Path: <bounces.tip@hpa.at.zytor.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5508B6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 May 2011 05:19:12 +1000 (EST)
Date: Mon, 2 May 2011 19:18:57 GMT
Sender: tip tree robot <bounces.tip@hpa.at.zytor.com>
From: tip-bot for Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <tip-94b2c363dcf732a4edab4ed66041cb36e7f28fbf@git.kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq: Fix typo CONFIG_GENIRC_IRQ_SHOW_LEVEL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de, mingo@redhat.com,
	geert@linux-m68k.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
	geert@linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
	tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  94b2c363dcf732a4edab4ed66041cb36e7f28fbf
Gitweb:     http://git.kernel.org/tip/94b2c363dcf732a4edab4ed66041cb36e7f28fbf
Author:     Geert Uytterhoeven <geert@linux-m68k.org>
AuthorDate: Sat, 30 Apr 2011 22:56:20 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 2 May 2011 21:16:37 +0200

genirq: Fix typo CONFIG_GENIRC_IRQ_SHOW_LEVEL

commit ab7798ffcf98b11a9525cf65bacdae3fd58d357f ("genirq: Expand generic
show_interrupts()") added the Kconfig option GENERIC_IRQ_SHOW_LEVEL to
accomodate PowerPC, but this doesn't actually enable the functionality due
to a typo in the #ifdef check.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>
Link: http://lkml.kernel.org/r/%3Calpine.DEB.2.00.1104302251370.19068%40ayla.of.borg%3E
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/proc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index dd201bd..834899f 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -419,7 +419,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	} else {
 		seq_printf(p, " %8s", "None");
 	}
-#ifdef CONFIG_GENIRC_IRQ_SHOW_LEVEL
+#ifdef CONFIG_GENERIC_IRQ_SHOW_LEVEL
 	seq_printf(p, " %-8s", irqd_is_level_type(&desc->irq_data) ? "Level" : "Edge");
 #endif
 	if (desc->name)
