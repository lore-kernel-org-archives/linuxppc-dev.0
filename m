Return-Path: <galak@freescale.com>
Date: Tue, 25 Oct 2005 23:02:59 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510252302310.22390@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: Add support for Book-E timer config to
 generic_calibrate_decr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to initialize some control SPRS for timers on Book-E before
we start taking decrementer interrupts.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit 34feb902f76428e507b305dd511496aa8d35d57e
tree 192923184852696d4bcb55ae41b02f39b68e38d2
parent 4e031e5142a4034f03f8fe223b9e2b9f47a125d4
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 25 Oct 2005 23:02:01 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 25 Oct 2005 23:02:01 -0500

 arch/powerpc/kernel/time.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -610,6 +610,17 @@ void __init generic_calibrate_decr(void)
 			ppc_proc_freq = *fp;
 		}
 	}
+#ifdef CONFIG_BOOKE
+	/* Set the time base to zero */
+	mtspr(SPRN_TBWL, 0);
+	mtspr(SPRN_TBWU, 0);
+
+	/* Clear any pending timer interrupts */
+	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
+
+	/* Enable decrementer interrupt */
+	mtspr(SPRN_TCR, TCR_DIE);
+#endif
 	if (!node_found)
 		printk(KERN_ERR "WARNING: Estimating processor frequency "
 				"(not found)\n");
